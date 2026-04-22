#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <assert.h>

#define stat xv6_stat  // avoid clash with host struct stat
#include "types.h"
#include "fs.h"
#include "stat.h"
#include "param.h"

#ifndef static_assert
#define static_assert(a, b) do { switch (0) case 0: case (a): ; } while (0)
#endif

// --- Configuration Macros ---
#define NINODES 200      
#define BPG 200         // blocks per group
#define IPG 32           // inodes per group

// Disk Layout:
// [ boot | sb | log | Grp0 | Grp1 | ... | GrpN ]
// Group Format: [ inode blocks | free bit map | data blocks ]

int nlog = LOGSIZE;
int nmeta;    
int nblocks;  

// --- Global Variables (Needed for alloc_block helper) ---
int global_start;    // Block number where Group 0 starts (after log)
int meta_per_group;  // Number of metadata blocks (Inode + Bitmap) per group

int fsfd;
struct superblock sb;
char zeroes[BSIZE];
uint freeinode = 1;
uint freeblock;

void balloc(int);
void wsect(uint, void*);
void winode(uint, struct dinode*);
void rinode(uint inum, struct dinode *ip);
void rsect(uint sec, void *buf);
uint ialloc(ushort type);
void iappend(uint inum, void *p, int n);

// --- [CHANGE 1] New Allocation Helper ---
// Replaces freeblock++ to skip metadata holes between groups
uint alloc_block()
{
  uint b = freeblock;
  freeblock++;

  // Calculate relative position from the start of the managed area
  uint relative = freeblock - global_start;

  // If we wrapped around to the start of a new group (index 0 relative to group),
  // we must skip the metadata blocks of this new group.
  if(relative % BPG == 0){
    freeblock += meta_per_group; 
  }
  return b;
}

// convert to intel byte order
ushort
xshort(ushort x)
{
  ushort y;
  uchar *a = (uchar*)&y;
  a[0] = x;
  a[1] = x >> 8;
  return y;
}

uint
xint(uint x)
{
  uint y;
  uchar *a = (uchar*)&y;
  a[0] = x;
  a[1] = x >> 8;
  a[2] = x >> 16;
  a[3] = x >> 24;
  return y;
}

int
main(int argc, char *argv[])
{
  int i, cc, fd;
  uint rootino, inum, off;
  struct dirent de;
  char buf[BSIZE];
  struct dinode din;

  static_assert(sizeof(int) == 4, "Integers must be 4 bytes!");

  if(argc < 2){
    fprintf(stderr, "Usage: mkfs fs.img files...\n");
    exit(1);
  }

  assert((BSIZE % sizeof(struct dinode)) == 0);
  assert((BSIZE % sizeof(struct dirent)) == 0);

  fsfd = open(argv[1], O_RDWR|O_CREAT|O_TRUNC, 0666);
  if(fsfd < 0){
    perror(argv[1]);
    exit(1);
  }

  // --- [CHANGE 2] Initialize Geometry ---

  // 1. Define global metadata end (Boot + SB + Log)
  global_start = 2 + nlog; 

  // 2. Define group metadata size
  int inode_blocks_per_group = IPG/IPB;
  meta_per_group = inode_blocks_per_group + 1; // +1 for bitmap block

  // 3. Calculate number of groups
  int ngroups = (FSSIZE - global_start)/BPG;

  // 4. Fill Superblock
  sb.magic = FSMAGIC;
  sb.size = xint(FSSIZE);
  sb.nblocks = xint(ngroups * BPG); // Total managed blocks
  sb.ninodes = xint(ngroups * IPG); 
  sb.nlog = xint(nlog);
  sb.logstart = xint(2);

  // Legacy pointers (point to Group 0)
  sb.inodestart = xint(global_start);
  sb.bmapstart = xint(global_start + inode_blocks_per_group);

  // NEW Superblock fields
  sb.bpg = xint(BPG);
  sb.ipg = xint(IPG);
  sb.ngroups = xint(ngroups);

  printf("ngroups %d\n", ngroups);
  printf("inode blocks per group %d\n", IPG);
  printf("blocks per group %d\n", BPG);

  // 5. Initialize Allocator
  // Start at the first DATA block of Group 0 (Skip Group 0's metadata)
  freeblock = global_start + meta_per_group; 

  // --- [CHANGE 3] Write File System Skeleton ---

  // Zero out the whole disk first
  for (i = 0; i < FSSIZE; i++) {
    wsect(i, zeroes);
  }

  // Write Superblock
  memset(buf, 0, sizeof(buf));
  memmove(buf, &sb, sizeof(sb));
  wsect(1, buf);

  // Allocate Root Inode
  rootino = ialloc(T_DIR);
  assert(rootino == ROOTINO);

  // Write '.' directory entry
  bzero(&de, sizeof(de));
  de.inum = xshort(rootino);
  strcpy(de.name, ".");
  iappend(rootino, &de, sizeof(de));  

  // Write '..' directory entry
  bzero(&de, sizeof(de));
  de.inum = xshort(rootino);
  strcpy(de.name, "..");
  iappend(rootino, &de, sizeof(de));  

  // --- [CHANGE 4] Write User Files (Restored Logic) ---
  // This loop was commented out in your upload, but it is required 
  // to actually put the files (sh, ls, etc.) into the image.
  for(i = 2; i < argc; i++) {
    assert(index(argv[i], '/') == 0);

    if ((fd = open(argv[i], 0)) < 0) {
      perror(argv[i]);
      exit(1);
    }

    if (argv[i][0] == '_')
      ++argv[i];

    inum = ialloc(T_FILE);

    bzero(&de, sizeof(de));
    de.inum = xshort(inum);
    strncpy(de.name, argv[i], DIRSIZ);
    iappend(rootino, &de, sizeof(de));

    while ((cc = read(fd, buf, sizeof(buf))) > 0)
      iappend(inum, buf, cc);

    close(fd);
  }

  // Fix size of root inode dir
  rinode(rootino, &din);
  off = xint(din.size);
  off = ((off / BSIZE) + 1) * BSIZE;
  din.size = xint(off);
  winode(rootino, &din);

  // Write Bitmaps
  balloc(freeblock);

  exit(0);
}

void
wsect(uint sec, void *buf)
{
  if(lseek(fsfd, sec * BSIZE, 0) != sec * BSIZE){
    perror("lseek");
    exit(1);
  }
  if(write(fsfd, buf, BSIZE) != BSIZE){
    perror("write");
    exit(1);
  }
}

void
winode(uint inum, struct dinode *ip)
{
  char buf[BSIZE];
  uint bn;
  struct dinode *dip;

  bn = IBLOCK(inum, sb);
  rsect(bn, buf);
  dip = ((struct dinode*)buf) + (inum % IPB);
  *dip = *ip;
  wsect(bn, buf);
}

void
rinode(uint inum, struct dinode *ip)
{
  char buf[BSIZE];
  uint bn;
  struct dinode *dip;

  bn = IBLOCK(inum, sb);
  rsect(bn, buf);
  dip = ((struct dinode*)buf) + (inum % IPB);
  *ip = *dip;
}

void
rsect(uint sec, void *buf)
{
  if(lseek(fsfd, sec * BSIZE, 0) != sec * BSIZE){
    perror("lseek");
    exit(1);
  }
  if(read(fsfd, buf, BSIZE) != BSIZE){
    perror("read");
    exit(1);
  }
}

uint
ialloc(ushort type)
{
  uint inum = freeinode++;
  struct dinode din;

  bzero(&din, sizeof(din));
  din.type = xshort(type);
  din.nlink = xshort(1);
  din.size = xint(0);
  winode(inum, &din);
  return inum;
}

// --- [CHANGE 5] New Group-Aware Bitmap Writer ---
void
balloc(int used)
{
  uchar buf[BSIZE];
  int i, g;
  int ngroups = xint(sb.ngroups);

  printf("balloc: writing bitmaps for %d groups \n", ngroups);

  for(g = 0; g < ngroups; g++) {
     bzero(buf, BSIZE);
     
     // Calculate absolute start of this group
     uint grp_start = global_start + g * BPG;
     
     // Calculate where the bitmap is stored for this group
     uint bmap_loc  = grp_start + (IPG / IPB); 

     // 1. Mark Metadata (Inodes + Bitmap) as USED
     for(i = 0; i < meta_per_group; i++){
        buf[i/8] |= (1 << (i%8)); 
     } 

     // 2. Mark Data Blocks as USED
     // We scan from the end of metadata up to the end of the group
     for(i = meta_per_group; i < BPG; i++) {
        uint abs_block = grp_start + i; 

        // 'used' (freeblock) points to the next FREE block.
        // If the current absolute block is less than 'used', it has been allocated.
        if(abs_block < used) {
          buf[i/8] |= (1 << (i%8)); 
        }
     }
     wsect(bmap_loc, buf);
  }
}

#define min(a, b) ((a) < (b) ? (a) : (b))

void
iappend(uint inum, void *xp, int n)
{
  char *p = (char*)xp;
  uint fbn, off, n1;
  struct dinode din;
  char buf[BSIZE];
  uint indirect[NINDIRECT];
  uint x;

  rinode(inum, &din);
  off = xint(din.size);
  
  while(n > 0){
    fbn = off / BSIZE;
    assert(fbn < MAXFILE);
    if(fbn < NDIRECT){
      if(xint(din.addrs[fbn]) == 0){
        // --- [CHANGE 6] Use alloc_block ---
        din.addrs[fbn] = xint(alloc_block());
      }
      x = xint(din.addrs[fbn]);
    } else {
      if(xint(din.addrs[NDIRECT]) == 0){
        // --- [CHANGE 6] Use alloc_block ---
        din.addrs[NDIRECT] = xint(alloc_block());
      }
      rsect(xint(din.addrs[NDIRECT]), (char*)indirect);
      if(indirect[fbn - NDIRECT] == 0){
        // --- [CHANGE 6] Use alloc_block ---
        indirect[fbn - NDIRECT] = xint(alloc_block());
        wsect(xint(din.addrs[NDIRECT]), (char*)indirect); 
      }
      x = xint(indirect[fbn-NDIRECT]);
    }
    n1 = min(n, (fbn + 1) * BSIZE - off);
    rsect(x, buf);
    bcopy(p, buf + off - (fbn * BSIZE), n1);
    wsect(x, buf);
    n -= n1;
    off += n1;
    p += n1;
  }
  din.size = xint(off);
  winode(inum, &din);
}