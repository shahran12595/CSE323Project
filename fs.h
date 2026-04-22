// On-disk file system format.
// Both the kernel and user programs use this header file.

#ifndef FS_H
#define FS_H

#define ROOTINO 1  // root i-number
#define BSIZE 512  // block size

// File system magic number
#define FSMAGIC 0x10203040

// Disk layout:
// [ boot block | super block | log | Grp0 | Grp1 | ... ]
//
// Where each Group is:
// [ inode blocks | free bit map | data blocks ]

// mkfs computes the super block and builds an initial file system. The
// super block describes the disk layout:
struct superblock {
  uint magic;        // Must be FSMAGIC
  uint size;         // Size of file system image (blocks)
  uint nblocks;      // Number of data blocks
  uint ninodes;      // Number of inodes.
  uint nlog;         // Number of log blocks
  uint logstart;     // Block number of first log block
  uint inodestart;   // Block number of first inode block
  uint bmapstart;    // Block number of first free map block

  // FFS new fields (number of block groups)
  uint bpg;          // Blocks per group
  uint ipg;          // Inodes per group
  uint ngroups;      // Number of block groups
};

#define NDIRECT 12
#define NINDIRECT (BSIZE / sizeof(uint))
#define MAXFILE (NDIRECT + NINDIRECT)

// On-disk inode structure
struct dinode {
  short type;           // File type
  short major;          // Major device number (T_DEV only)
  short minor;          // Minor device number (T_DEV only)
  short nlink;          // Number of links to inode in file system
  uint size;            // Size of file (bytes)
  uint addrs[NDIRECT+1];   // Data block addresses
};

// Inodes per block.
#define IPB           (BSIZE / sizeof(struct dinode))

// Bitmap bits per block
#define BPB           (BSIZE*8)

// --- BLOCK GROUP MACROS ---

// Block containing inode i
// Logic: Global_Start + (Group_Num * BPG) + (Index_In_Group / IPB)
// We calculate the group number and the offset within that group.
#define IBLOCK(i, sb)  ((sb).logstart + (sb).nlog + \
                       (((i)/(sb).ipg) * (sb).bpg) + \
                       (((i)%(sb).ipg) / IPB))

// Block of free map containing bit for data block b
// Logic: Global_Start + (Group_Num * BPG) + (Inode_Blocks_Per_Group)
// The bitmap is always immediately after the inode blocks in a group.
#define BBLOCK(b, sb)  ((sb).logstart + (sb).nlog + \
                       (((b) - ((sb).logstart + (sb).nlog)) / (sb).bpg) * (sb).bpg + \
                       ((sb).ipg / IPB))

// Directory is a file containing a sequence of dirent structures.
#define DIRSIZ 14

struct dirent {
  ushort inum;
  char name[DIRSIZ];
};

#endif // FS_H