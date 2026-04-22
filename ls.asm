
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  close(fd);
}

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	bb 01 00 00 00       	mov    $0x1,%ebx
  15:	51                   	push   %ecx
  16:	83 ec 08             	sub    $0x8,%esp
  19:	8b 31                	mov    (%ecx),%esi
  1b:	8b 79 04             	mov    0x4(%ecx),%edi
  int i;

  if(argc < 2){
  1e:	83 fe 01             	cmp    $0x1,%esi
  21:	7e 27                	jle    4a <main+0x4a>
  23:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  28:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  2f:	00 
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
  30:	83 ec 0c             	sub    $0xc,%esp
  33:	ff 34 9f             	push   (%edi,%ebx,4)
  for(i=1; i<argc; i++)
  36:	83 c3 01             	add    $0x1,%ebx
    ls(argv[i]);
  39:	e8 c2 00 00 00       	call   100 <ls>
  for(i=1; i<argc; i++)
  3e:	83 c4 10             	add    $0x10,%esp
  41:	39 de                	cmp    %ebx,%esi
  43:	75 eb                	jne    30 <main+0x30>
  exit();
  45:	e8 69 05 00 00       	call   5b3 <exit>
    ls(".");
  4a:	83 ec 0c             	sub    $0xc,%esp
  4d:	68 f0 0a 00 00       	push   $0xaf0
  52:	e8 a9 00 00 00       	call   100 <ls>
    exit();
  57:	e8 57 05 00 00       	call   5b3 <exit>
  5c:	66 90                	xchg   %ax,%ax
  5e:	66 90                	xchg   %ax,%ax

00000060 <fmtname>:
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	56                   	push   %esi
  64:	53                   	push   %ebx
  65:	8b 75 08             	mov    0x8(%ebp),%esi
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  68:	83 ec 0c             	sub    $0xc,%esp
  6b:	56                   	push   %esi
  6c:	e8 6f 03 00 00       	call   3e0 <strlen>
  71:	83 c4 10             	add    $0x10,%esp
  74:	01 f0                	add    %esi,%eax
  76:	89 c3                	mov    %eax,%ebx
  78:	73 0f                	jae    89 <fmtname+0x29>
  7a:	eb 12                	jmp    8e <fmtname+0x2e>
  7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  80:	8d 43 ff             	lea    -0x1(%ebx),%eax
  83:	39 f0                	cmp    %esi,%eax
  85:	72 0a                	jb     91 <fmtname+0x31>
  87:	89 c3                	mov    %eax,%ebx
  89:	80 3b 2f             	cmpb   $0x2f,(%ebx)
  8c:	75 f2                	jne    80 <fmtname+0x20>
  p++;
  8e:	83 c3 01             	add    $0x1,%ebx
  if(strlen(p) >= DIRSIZ)
  91:	83 ec 0c             	sub    $0xc,%esp
  94:	53                   	push   %ebx
  95:	e8 46 03 00 00       	call   3e0 <strlen>
  9a:	83 c4 10             	add    $0x10,%esp
  9d:	83 f8 0d             	cmp    $0xd,%eax
  a0:	77 4a                	ja     ec <fmtname+0x8c>
  memmove(buf, p, strlen(p));
  a2:	83 ec 0c             	sub    $0xc,%esp
  a5:	53                   	push   %ebx
  a6:	e8 35 03 00 00       	call   3e0 <strlen>
  ab:	83 c4 0c             	add    $0xc,%esp
  ae:	50                   	push   %eax
  af:	53                   	push   %ebx
  b0:	68 68 0b 00 00       	push   $0xb68
  b5:	e8 c6 04 00 00       	call   580 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  ba:	89 1c 24             	mov    %ebx,(%esp)
  bd:	e8 1e 03 00 00       	call   3e0 <strlen>
  c2:	89 1c 24             	mov    %ebx,(%esp)
  return buf;
  c5:	bb 68 0b 00 00       	mov    $0xb68,%ebx
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  ca:	89 c6                	mov    %eax,%esi
  cc:	e8 0f 03 00 00       	call   3e0 <strlen>
  d1:	ba 0e 00 00 00       	mov    $0xe,%edx
  d6:	83 c4 0c             	add    $0xc,%esp
  d9:	29 f2                	sub    %esi,%edx
  db:	05 68 0b 00 00       	add    $0xb68,%eax
  e0:	52                   	push   %edx
  e1:	6a 20                	push   $0x20
  e3:	50                   	push   %eax
  e4:	e8 27 03 00 00       	call   410 <memset>
  return buf;
  e9:	83 c4 10             	add    $0x10,%esp
}
  ec:	8d 65 f8             	lea    -0x8(%ebp),%esp
  ef:	89 d8                	mov    %ebx,%eax
  f1:	5b                   	pop    %ebx
  f2:	5e                   	pop    %esi
  f3:	5d                   	pop    %ebp
  f4:	c3                   	ret
  f5:	8d 76 00             	lea    0x0(%esi),%esi
  f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  ff:	00 

00000100 <ls>:
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	57                   	push   %edi
 104:	56                   	push   %esi
 105:	53                   	push   %ebx
 106:	81 ec 64 02 00 00    	sub    $0x264,%esp
 10c:	8b 7d 08             	mov    0x8(%ebp),%edi
  if((fd = open(path, 0)) < 0){
 10f:	6a 00                	push   $0x0
 111:	57                   	push   %edi
 112:	e8 dc 04 00 00       	call   5f3 <open>
 117:	83 c4 10             	add    $0x10,%esp
 11a:	85 c0                	test   %eax,%eax
 11c:	0f 88 8e 01 00 00    	js     2b0 <ls+0x1b0>
  if(fstat(fd, &st) < 0){
 122:	83 ec 08             	sub    $0x8,%esp
 125:	8d b5 d4 fd ff ff    	lea    -0x22c(%ebp),%esi
 12b:	89 c3                	mov    %eax,%ebx
 12d:	56                   	push   %esi
 12e:	50                   	push   %eax
 12f:	e8 d7 04 00 00       	call   60b <fstat>
 134:	83 c4 10             	add    $0x10,%esp
 137:	85 c0                	test   %eax,%eax
 139:	0f 88 b1 01 00 00    	js     2f0 <ls+0x1f0>
  switch(st.type){
 13f:	0f b7 85 d4 fd ff ff 	movzwl -0x22c(%ebp),%eax
 146:	66 83 f8 01          	cmp    $0x1,%ax
 14a:	74 54                	je     1a0 <ls+0xa0>
 14c:	66 83 f8 02          	cmp    $0x2,%ax
 150:	75 37                	jne    189 <ls+0x89>
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 152:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 158:	83 ec 0c             	sub    $0xc,%esp
 15b:	8b b5 dc fd ff ff    	mov    -0x224(%ebp),%esi
 161:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 167:	57                   	push   %edi
 168:	e8 f3 fe ff ff       	call   60 <fmtname>
 16d:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 173:	59                   	pop    %ecx
 174:	5f                   	pop    %edi
 175:	52                   	push   %edx
 176:	56                   	push   %esi
 177:	6a 02                	push   $0x2
 179:	50                   	push   %eax
 17a:	68 d0 0a 00 00       	push   $0xad0
 17f:	6a 01                	push   $0x1
 181:	e8 ba 05 00 00       	call   740 <printf>
    break;
 186:	83 c4 20             	add    $0x20,%esp
  close(fd);
 189:	83 ec 0c             	sub    $0xc,%esp
 18c:	53                   	push   %ebx
 18d:	e8 49 04 00 00       	call   5db <close>
 192:	83 c4 10             	add    $0x10,%esp
}
 195:	8d 65 f4             	lea    -0xc(%ebp),%esp
 198:	5b                   	pop    %ebx
 199:	5e                   	pop    %esi
 19a:	5f                   	pop    %edi
 19b:	5d                   	pop    %ebp
 19c:	c3                   	ret
 19d:	8d 76 00             	lea    0x0(%esi),%esi
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 1a0:	83 ec 0c             	sub    $0xc,%esp
 1a3:	57                   	push   %edi
 1a4:	e8 37 02 00 00       	call   3e0 <strlen>
 1a9:	83 c4 10             	add    $0x10,%esp
 1ac:	83 c0 10             	add    $0x10,%eax
 1af:	3d 00 02 00 00       	cmp    $0x200,%eax
 1b4:	0f 87 16 01 00 00    	ja     2d0 <ls+0x1d0>
    strcpy(buf, path);
 1ba:	83 ec 08             	sub    $0x8,%esp
 1bd:	57                   	push   %edi
 1be:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
 1c4:	57                   	push   %edi
 1c5:	e8 76 01 00 00       	call   340 <strcpy>
    p = buf+strlen(buf);
 1ca:	89 3c 24             	mov    %edi,(%esp)
 1cd:	e8 0e 02 00 00       	call   3e0 <strlen>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1d2:	83 c4 10             	add    $0x10,%esp
    p = buf+strlen(buf);
 1d5:	01 f8                	add    %edi,%eax
    *p++ = '/';
 1d7:	8d 48 01             	lea    0x1(%eax),%ecx
    p = buf+strlen(buf);
 1da:	89 85 a8 fd ff ff    	mov    %eax,-0x258(%ebp)
    *p++ = '/';
 1e0:	89 8d a4 fd ff ff    	mov    %ecx,-0x25c(%ebp)
 1e6:	c6 00 2f             	movb   $0x2f,(%eax)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1f0:	83 ec 04             	sub    $0x4,%esp
 1f3:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
 1f9:	6a 10                	push   $0x10
 1fb:	50                   	push   %eax
 1fc:	53                   	push   %ebx
 1fd:	e8 c9 03 00 00       	call   5cb <read>
 202:	83 c4 10             	add    $0x10,%esp
 205:	83 f8 10             	cmp    $0x10,%eax
 208:	0f 85 7b ff ff ff    	jne    189 <ls+0x89>
      if(de.inum == 0)
 20e:	66 83 bd c4 fd ff ff 	cmpw   $0x0,-0x23c(%ebp)
 215:	00 
 216:	74 d8                	je     1f0 <ls+0xf0>
      memmove(p, de.name, DIRSIZ);
 218:	83 ec 04             	sub    $0x4,%esp
 21b:	8d 85 c6 fd ff ff    	lea    -0x23a(%ebp),%eax
 221:	6a 0e                	push   $0xe
 223:	50                   	push   %eax
 224:	ff b5 a4 fd ff ff    	push   -0x25c(%ebp)
 22a:	e8 51 03 00 00       	call   580 <memmove>
      p[DIRSIZ] = 0;
 22f:	8b 85 a8 fd ff ff    	mov    -0x258(%ebp),%eax
 235:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
 239:	58                   	pop    %eax
 23a:	5a                   	pop    %edx
 23b:	56                   	push   %esi
 23c:	57                   	push   %edi
 23d:	e8 9e 02 00 00       	call   4e0 <stat>
 242:	83 c4 10             	add    $0x10,%esp
 245:	85 c0                	test   %eax,%eax
 247:	0f 88 cb 00 00 00    	js     318 <ls+0x218>
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 24d:	8b 8d e4 fd ff ff    	mov    -0x21c(%ebp),%ecx
 253:	8b 95 dc fd ff ff    	mov    -0x224(%ebp),%edx
 259:	83 ec 0c             	sub    $0xc,%esp
 25c:	0f bf 85 d4 fd ff ff 	movswl -0x22c(%ebp),%eax
 263:	89 8d ac fd ff ff    	mov    %ecx,-0x254(%ebp)
 269:	89 95 b0 fd ff ff    	mov    %edx,-0x250(%ebp)
 26f:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
 275:	57                   	push   %edi
 276:	e8 e5 fd ff ff       	call   60 <fmtname>
 27b:	5a                   	pop    %edx
 27c:	59                   	pop    %ecx
 27d:	8b 8d ac fd ff ff    	mov    -0x254(%ebp),%ecx
 283:	51                   	push   %ecx
 284:	8b 95 b0 fd ff ff    	mov    -0x250(%ebp),%edx
 28a:	52                   	push   %edx
 28b:	ff b5 b4 fd ff ff    	push   -0x24c(%ebp)
 291:	50                   	push   %eax
 292:	68 d0 0a 00 00       	push   $0xad0
 297:	6a 01                	push   $0x1
 299:	e8 a2 04 00 00       	call   740 <printf>
 29e:	83 c4 20             	add    $0x20,%esp
 2a1:	e9 4a ff ff ff       	jmp    1f0 <ls+0xf0>
 2a6:	66 90                	xchg   %ax,%ax
 2a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2af:	00 
    printf(2, "ls: cannot open %s\n", path);
 2b0:	83 ec 04             	sub    $0x4,%esp
 2b3:	57                   	push   %edi
 2b4:	68 a8 0a 00 00       	push   $0xaa8
 2b9:	6a 02                	push   $0x2
 2bb:	e8 80 04 00 00       	call   740 <printf>
    return;
 2c0:	83 c4 10             	add    $0x10,%esp
}
 2c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2c6:	5b                   	pop    %ebx
 2c7:	5e                   	pop    %esi
 2c8:	5f                   	pop    %edi
 2c9:	5d                   	pop    %ebp
 2ca:	c3                   	ret
 2cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      printf(1, "ls: path too long\n");
 2d0:	83 ec 08             	sub    $0x8,%esp
 2d3:	68 dd 0a 00 00       	push   $0xadd
 2d8:	6a 01                	push   $0x1
 2da:	e8 61 04 00 00       	call   740 <printf>
      break;
 2df:	83 c4 10             	add    $0x10,%esp
 2e2:	e9 a2 fe ff ff       	jmp    189 <ls+0x89>
 2e7:	90                   	nop
 2e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2ef:	00 
    printf(2, "ls: cannot stat %s\n", path);
 2f0:	83 ec 04             	sub    $0x4,%esp
 2f3:	57                   	push   %edi
 2f4:	68 bc 0a 00 00       	push   $0xabc
 2f9:	6a 02                	push   $0x2
 2fb:	e8 40 04 00 00       	call   740 <printf>
    close(fd);
 300:	89 1c 24             	mov    %ebx,(%esp)
 303:	e8 d3 02 00 00       	call   5db <close>
    return;
 308:	83 c4 10             	add    $0x10,%esp
}
 30b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 30e:	5b                   	pop    %ebx
 30f:	5e                   	pop    %esi
 310:	5f                   	pop    %edi
 311:	5d                   	pop    %ebp
 312:	c3                   	ret
 313:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printf(1, "ls: cannot stat %s\n", buf);
 318:	83 ec 04             	sub    $0x4,%esp
 31b:	57                   	push   %edi
 31c:	68 bc 0a 00 00       	push   $0xabc
 321:	6a 01                	push   $0x1
 323:	e8 18 04 00 00       	call   740 <printf>
        continue;
 328:	83 c4 10             	add    $0x10,%esp
 32b:	e9 c0 fe ff ff       	jmp    1f0 <ls+0xf0>
 330:	66 90                	xchg   %ax,%ax
 332:	66 90                	xchg   %ax,%ax
 334:	66 90                	xchg   %ax,%ax
 336:	66 90                	xchg   %ax,%ax
 338:	66 90                	xchg   %ax,%ax
 33a:	66 90                	xchg   %ax,%ax
 33c:	66 90                	xchg   %ax,%ax
 33e:	66 90                	xchg   %ax,%ax

00000340 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 340:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 341:	31 c0                	xor    %eax,%eax
{
 343:	89 e5                	mov    %esp,%ebp
 345:	53                   	push   %ebx
 346:	8b 4d 08             	mov    0x8(%ebp),%ecx
 349:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 34c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 350:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 354:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 357:	83 c0 01             	add    $0x1,%eax
 35a:	84 d2                	test   %dl,%dl
 35c:	75 f2                	jne    350 <strcpy+0x10>
    ;
  return os;
}
 35e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 361:	89 c8                	mov    %ecx,%eax
 363:	c9                   	leave
 364:	c3                   	ret
 365:	8d 76 00             	lea    0x0(%esi),%esi
 368:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 36f:	00 

00000370 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	53                   	push   %ebx
 374:	8b 55 08             	mov    0x8(%ebp),%edx
 377:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 37a:	0f b6 02             	movzbl (%edx),%eax
 37d:	84 c0                	test   %al,%al
 37f:	75 2d                	jne    3ae <strcmp+0x3e>
 381:	eb 4a                	jmp    3cd <strcmp+0x5d>
 383:	eb 1b                	jmp    3a0 <strcmp+0x30>
 385:	8d 76 00             	lea    0x0(%esi),%esi
 388:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 38f:	00 
 390:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 397:	00 
 398:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 39f:	00 
 3a0:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 3a4:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 3a7:	84 c0                	test   %al,%al
 3a9:	74 15                	je     3c0 <strcmp+0x50>
 3ab:	83 c1 01             	add    $0x1,%ecx
 3ae:	0f b6 19             	movzbl (%ecx),%ebx
 3b1:	38 c3                	cmp    %al,%bl
 3b3:	74 eb                	je     3a0 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
 3b5:	29 d8                	sub    %ebx,%eax
}
 3b7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3ba:	c9                   	leave
 3bb:	c3                   	ret
 3bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return (uchar)*p - (uchar)*q;
 3c0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 3c4:	31 c0                	xor    %eax,%eax
 3c6:	29 d8                	sub    %ebx,%eax
}
 3c8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3cb:	c9                   	leave
 3cc:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 3cd:	0f b6 19             	movzbl (%ecx),%ebx
 3d0:	31 c0                	xor    %eax,%eax
 3d2:	eb e1                	jmp    3b5 <strcmp+0x45>
 3d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3df:	00 

000003e0 <strlen>:

uint
strlen(const char *s)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 3e6:	80 3a 00             	cmpb   $0x0,(%edx)
 3e9:	74 15                	je     400 <strlen+0x20>
 3eb:	31 c0                	xor    %eax,%eax
 3ed:	8d 76 00             	lea    0x0(%esi),%esi
 3f0:	83 c0 01             	add    $0x1,%eax
 3f3:	89 c1                	mov    %eax,%ecx
 3f5:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 3f9:	75 f5                	jne    3f0 <strlen+0x10>
    ;
  return n;
}
 3fb:	89 c8                	mov    %ecx,%eax
 3fd:	5d                   	pop    %ebp
 3fe:	c3                   	ret
 3ff:	90                   	nop
  for(n = 0; s[n]; n++)
 400:	31 c9                	xor    %ecx,%ecx
}
 402:	5d                   	pop    %ebp
 403:	89 c8                	mov    %ecx,%eax
 405:	c3                   	ret
 406:	66 90                	xchg   %ax,%ax
 408:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 40f:	00 

00000410 <memset>:

void*
memset(void *dst, int c, uint n)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 414:	8b 4d 10             	mov    0x10(%ebp),%ecx
 417:	8b 45 0c             	mov    0xc(%ebp),%eax
 41a:	8b 7d 08             	mov    0x8(%ebp),%edi
 41d:	fc                   	cld
 41e:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 420:	8b 45 08             	mov    0x8(%ebp),%eax
 423:	8b 7d fc             	mov    -0x4(%ebp),%edi
 426:	c9                   	leave
 427:	c3                   	ret
 428:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 42f:	00 

00000430 <strchr>:

char*
strchr(const char *s, char c)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	8b 45 08             	mov    0x8(%ebp),%eax
 436:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 43a:	0f b6 10             	movzbl (%eax),%edx
 43d:	84 d2                	test   %dl,%dl
 43f:	75 1a                	jne    45b <strchr+0x2b>
 441:	eb 25                	jmp    468 <strchr+0x38>
 443:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 448:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 44f:	00 
 450:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 454:	83 c0 01             	add    $0x1,%eax
 457:	84 d2                	test   %dl,%dl
 459:	74 0d                	je     468 <strchr+0x38>
    if(*s == c)
 45b:	38 d1                	cmp    %dl,%cl
 45d:	75 f1                	jne    450 <strchr+0x20>
      return (char*)s;
  return 0;
}
 45f:	5d                   	pop    %ebp
 460:	c3                   	ret
 461:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 468:	31 c0                	xor    %eax,%eax
}
 46a:	5d                   	pop    %ebp
 46b:	c3                   	ret
 46c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000470 <gets>:

char*
gets(char *buf, int max)
{
 470:	55                   	push   %ebp
 471:	89 e5                	mov    %esp,%ebp
 473:	57                   	push   %edi
 474:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 475:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 478:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 479:	31 db                	xor    %ebx,%ebx
{
 47b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 47e:	eb 27                	jmp    4a7 <gets+0x37>
    cc = read(0, &c, 1);
 480:	83 ec 04             	sub    $0x4,%esp
 483:	6a 01                	push   $0x1
 485:	57                   	push   %edi
 486:	6a 00                	push   $0x0
 488:	e8 3e 01 00 00       	call   5cb <read>
    if(cc < 1)
 48d:	83 c4 10             	add    $0x10,%esp
 490:	85 c0                	test   %eax,%eax
 492:	7e 1d                	jle    4b1 <gets+0x41>
      break;
    buf[i++] = c;
 494:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 498:	8b 55 08             	mov    0x8(%ebp),%edx
 49b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 49f:	3c 0a                	cmp    $0xa,%al
 4a1:	74 1d                	je     4c0 <gets+0x50>
 4a3:	3c 0d                	cmp    $0xd,%al
 4a5:	74 19                	je     4c0 <gets+0x50>
  for(i=0; i+1 < max; ){
 4a7:	89 de                	mov    %ebx,%esi
 4a9:	83 c3 01             	add    $0x1,%ebx
 4ac:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 4af:	7c cf                	jl     480 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 4b1:	8b 45 08             	mov    0x8(%ebp),%eax
 4b4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 4b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4bb:	5b                   	pop    %ebx
 4bc:	5e                   	pop    %esi
 4bd:	5f                   	pop    %edi
 4be:	5d                   	pop    %ebp
 4bf:	c3                   	ret
  buf[i] = '\0';
 4c0:	8b 45 08             	mov    0x8(%ebp),%eax
    buf[i++] = c;
 4c3:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 4c5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 4c9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4cc:	5b                   	pop    %ebx
 4cd:	5e                   	pop    %esi
 4ce:	5f                   	pop    %edi
 4cf:	5d                   	pop    %ebp
 4d0:	c3                   	ret
 4d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4df:	00 

000004e0 <stat>:

int
stat(const char *n, struct stat *st)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	56                   	push   %esi
 4e4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4e5:	83 ec 08             	sub    $0x8,%esp
 4e8:	6a 00                	push   $0x0
 4ea:	ff 75 08             	push   0x8(%ebp)
 4ed:	e8 01 01 00 00       	call   5f3 <open>
  if(fd < 0)
 4f2:	83 c4 10             	add    $0x10,%esp
 4f5:	85 c0                	test   %eax,%eax
 4f7:	78 27                	js     520 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 4f9:	83 ec 08             	sub    $0x8,%esp
 4fc:	ff 75 0c             	push   0xc(%ebp)
 4ff:	89 c3                	mov    %eax,%ebx
 501:	50                   	push   %eax
 502:	e8 04 01 00 00       	call   60b <fstat>
  close(fd);
 507:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 50a:	89 c6                	mov    %eax,%esi
  close(fd);
 50c:	e8 ca 00 00 00       	call   5db <close>
  return r;
 511:	83 c4 10             	add    $0x10,%esp
}
 514:	8d 65 f8             	lea    -0x8(%ebp),%esp
 517:	89 f0                	mov    %esi,%eax
 519:	5b                   	pop    %ebx
 51a:	5e                   	pop    %esi
 51b:	5d                   	pop    %ebp
 51c:	c3                   	ret
 51d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 520:	be ff ff ff ff       	mov    $0xffffffff,%esi
 525:	eb ed                	jmp    514 <stat+0x34>
 527:	90                   	nop
 528:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 52f:	00 

00000530 <atoi>:

int
atoi(const char *s)
{
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	53                   	push   %ebx
 534:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 537:	0f be 02             	movsbl (%edx),%eax
 53a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 53d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 540:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 545:	77 2e                	ja     575 <atoi+0x45>
 547:	eb 17                	jmp    560 <atoi+0x30>
 549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 550:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 557:	00 
 558:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 55f:	00 
    n = n*10 + *s++ - '0';
 560:	83 c2 01             	add    $0x1,%edx
 563:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 566:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 56a:	0f be 02             	movsbl (%edx),%eax
 56d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 570:	80 fb 09             	cmp    $0x9,%bl
 573:	76 eb                	jbe    560 <atoi+0x30>
  return n;
}
 575:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 578:	89 c8                	mov    %ecx,%eax
 57a:	c9                   	leave
 57b:	c3                   	ret
 57c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000580 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	57                   	push   %edi
 584:	8b 45 10             	mov    0x10(%ebp),%eax
 587:	8b 55 08             	mov    0x8(%ebp),%edx
 58a:	56                   	push   %esi
 58b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 58e:	85 c0                	test   %eax,%eax
 590:	7e 13                	jle    5a5 <memmove+0x25>
 592:	01 d0                	add    %edx,%eax
  dst = vdst;
 594:	89 d7                	mov    %edx,%edi
 596:	66 90                	xchg   %ax,%ax
 598:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 59f:	00 
    *dst++ = *src++;
 5a0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 5a1:	39 f8                	cmp    %edi,%eax
 5a3:	75 fb                	jne    5a0 <memmove+0x20>
  return vdst;
}
 5a5:	5e                   	pop    %esi
 5a6:	89 d0                	mov    %edx,%eax
 5a8:	5f                   	pop    %edi
 5a9:	5d                   	pop    %ebp
 5aa:	c3                   	ret

000005ab <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 5ab:	b8 01 00 00 00       	mov    $0x1,%eax
 5b0:	cd 40                	int    $0x40
 5b2:	c3                   	ret

000005b3 <exit>:
SYSCALL(exit)
 5b3:	b8 02 00 00 00       	mov    $0x2,%eax
 5b8:	cd 40                	int    $0x40
 5ba:	c3                   	ret

000005bb <wait>:
SYSCALL(wait)
 5bb:	b8 03 00 00 00       	mov    $0x3,%eax
 5c0:	cd 40                	int    $0x40
 5c2:	c3                   	ret

000005c3 <pipe>:
SYSCALL(pipe)
 5c3:	b8 04 00 00 00       	mov    $0x4,%eax
 5c8:	cd 40                	int    $0x40
 5ca:	c3                   	ret

000005cb <read>:
SYSCALL(read)
 5cb:	b8 05 00 00 00       	mov    $0x5,%eax
 5d0:	cd 40                	int    $0x40
 5d2:	c3                   	ret

000005d3 <write>:
SYSCALL(write)
 5d3:	b8 10 00 00 00       	mov    $0x10,%eax
 5d8:	cd 40                	int    $0x40
 5da:	c3                   	ret

000005db <close>:
SYSCALL(close)
 5db:	b8 15 00 00 00       	mov    $0x15,%eax
 5e0:	cd 40                	int    $0x40
 5e2:	c3                   	ret

000005e3 <kill>:
SYSCALL(kill)
 5e3:	b8 06 00 00 00       	mov    $0x6,%eax
 5e8:	cd 40                	int    $0x40
 5ea:	c3                   	ret

000005eb <exec>:
SYSCALL(exec)
 5eb:	b8 07 00 00 00       	mov    $0x7,%eax
 5f0:	cd 40                	int    $0x40
 5f2:	c3                   	ret

000005f3 <open>:
SYSCALL(open)
 5f3:	b8 0f 00 00 00       	mov    $0xf,%eax
 5f8:	cd 40                	int    $0x40
 5fa:	c3                   	ret

000005fb <mknod>:
SYSCALL(mknod)
 5fb:	b8 11 00 00 00       	mov    $0x11,%eax
 600:	cd 40                	int    $0x40
 602:	c3                   	ret

00000603 <unlink>:
SYSCALL(unlink)
 603:	b8 12 00 00 00       	mov    $0x12,%eax
 608:	cd 40                	int    $0x40
 60a:	c3                   	ret

0000060b <fstat>:
SYSCALL(fstat)
 60b:	b8 08 00 00 00       	mov    $0x8,%eax
 610:	cd 40                	int    $0x40
 612:	c3                   	ret

00000613 <link>:
SYSCALL(link)
 613:	b8 13 00 00 00       	mov    $0x13,%eax
 618:	cd 40                	int    $0x40
 61a:	c3                   	ret

0000061b <mkdir>:
SYSCALL(mkdir)
 61b:	b8 14 00 00 00       	mov    $0x14,%eax
 620:	cd 40                	int    $0x40
 622:	c3                   	ret

00000623 <chdir>:
SYSCALL(chdir)
 623:	b8 09 00 00 00       	mov    $0x9,%eax
 628:	cd 40                	int    $0x40
 62a:	c3                   	ret

0000062b <dup>:
SYSCALL(dup)
 62b:	b8 0a 00 00 00       	mov    $0xa,%eax
 630:	cd 40                	int    $0x40
 632:	c3                   	ret

00000633 <getpid>:
SYSCALL(getpid)
 633:	b8 0b 00 00 00       	mov    $0xb,%eax
 638:	cd 40                	int    $0x40
 63a:	c3                   	ret

0000063b <sbrk>:
SYSCALL(sbrk)
 63b:	b8 0c 00 00 00       	mov    $0xc,%eax
 640:	cd 40                	int    $0x40
 642:	c3                   	ret

00000643 <sleep>:
SYSCALL(sleep)
 643:	b8 0d 00 00 00       	mov    $0xd,%eax
 648:	cd 40                	int    $0x40
 64a:	c3                   	ret

0000064b <uptime>:
SYSCALL(uptime)
 64b:	b8 0e 00 00 00       	mov    $0xe,%eax
 650:	cd 40                	int    $0x40
 652:	c3                   	ret

00000653 <getprocinfo>:
SYSCALL(getprocinfo)
 653:	b8 16 00 00 00       	mov    $0x16,%eax
 658:	cd 40                	int    $0x40
 65a:	c3                   	ret

0000065b <nice>:
SYSCALL(nice)
 65b:	b8 17 00 00 00       	mov    $0x17,%eax
 660:	cd 40                	int    $0x40
 662:	c3                   	ret
 663:	66 90                	xchg   %ax,%ax
 665:	66 90                	xchg   %ax,%ax
 667:	66 90                	xchg   %ax,%ax
 669:	66 90                	xchg   %ax,%ax
 66b:	66 90                	xchg   %ax,%ax
 66d:	66 90                	xchg   %ax,%ax
 66f:	66 90                	xchg   %ax,%ax
 671:	66 90                	xchg   %ax,%ax
 673:	66 90                	xchg   %ax,%ax
 675:	66 90                	xchg   %ax,%ax
 677:	66 90                	xchg   %ax,%ax
 679:	66 90                	xchg   %ax,%ax
 67b:	66 90                	xchg   %ax,%ax
 67d:	66 90                	xchg   %ax,%ax
 67f:	90                   	nop

00000680 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 680:	55                   	push   %ebp
 681:	89 e5                	mov    %esp,%ebp
 683:	57                   	push   %edi
 684:	56                   	push   %esi
 685:	53                   	push   %ebx
 686:	89 cb                	mov    %ecx,%ebx
 688:	83 ec 3c             	sub    $0x3c,%esp
 68b:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 68e:	85 d2                	test   %edx,%edx
 690:	0f 89 9a 00 00 00    	jns    730 <printint+0xb0>
 696:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 69a:	0f 84 90 00 00 00    	je     730 <printint+0xb0>
    neg = 1;
    x = -xx;
 6a0:	f7 da                	neg    %edx
    neg = 1;
 6a2:	b8 01 00 00 00       	mov    $0x1,%eax
 6a7:	89 45 c0             	mov    %eax,-0x40(%ebp)
 6aa:	89 d1                	mov    %edx,%ecx
  } else {
    x = xx;
  }

  i = 0;
 6ac:	31 f6                	xor    %esi,%esi
 6ae:	66 90                	xchg   %ax,%ax
 6b0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6b7:	00 
 6b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6bf:	00 
  do{
    buf[i++] = digits[x % base];
 6c0:	89 c8                	mov    %ecx,%eax
 6c2:	31 d2                	xor    %edx,%edx
 6c4:	89 f7                	mov    %esi,%edi
 6c6:	f7 f3                	div    %ebx
 6c8:	8d 76 01             	lea    0x1(%esi),%esi
  }while((x /= base) != 0);
 6cb:	39 d9                	cmp    %ebx,%ecx
    buf[i++] = digits[x % base];
 6cd:	0f b6 92 54 0b 00 00 	movzbl 0xb54(%edx),%edx
  }while((x /= base) != 0);
 6d4:	89 c1                	mov    %eax,%ecx
    buf[i++] = digits[x % base];
 6d6:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 6da:	73 e4                	jae    6c0 <printint+0x40>
  if(neg)
 6dc:	8b 45 c0             	mov    -0x40(%ebp),%eax
 6df:	85 c0                	test   %eax,%eax
 6e1:	74 07                	je     6ea <printint+0x6a>
    buf[i++] = '-';
 6e3:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 6e8:	89 f7                	mov    %esi,%edi

  while(--i >= 0)
 6ea:	8d 74 3d d8          	lea    -0x28(%ebp,%edi,1),%esi
 6ee:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 6f1:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 6f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6ff:	00 
    putc(fd, buf[i]);
 700:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 703:	83 ec 04             	sub    $0x4,%esp
  while(--i >= 0)
 706:	83 ee 01             	sub    $0x1,%esi
 709:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 70c:	8d 45 d7             	lea    -0x29(%ebp),%eax
 70f:	6a 01                	push   $0x1
 711:	50                   	push   %eax
 712:	57                   	push   %edi
 713:	e8 bb fe ff ff       	call   5d3 <write>
  while(--i >= 0)
 718:	83 c4 10             	add    $0x10,%esp
 71b:	39 f3                	cmp    %esi,%ebx
 71d:	75 e1                	jne    700 <printint+0x80>
}
 71f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 722:	5b                   	pop    %ebx
 723:	5e                   	pop    %esi
 724:	5f                   	pop    %edi
 725:	5d                   	pop    %ebp
 726:	c3                   	ret
 727:	90                   	nop
 728:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 72f:	00 
  neg = 0;
 730:	31 c0                	xor    %eax,%eax
 732:	e9 70 ff ff ff       	jmp    6a7 <printint+0x27>
 737:	90                   	nop
 738:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 73f:	00 

00000740 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 740:	55                   	push   %ebp
 741:	89 e5                	mov    %esp,%ebp
 743:	57                   	push   %edi
 744:	56                   	push   %esi
 745:	53                   	push   %ebx
 746:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 749:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 74c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 74f:	0f b6 13             	movzbl (%ebx),%edx
 752:	83 c3 01             	add    $0x1,%ebx
 755:	84 d2                	test   %dl,%dl
 757:	0f 84 a0 00 00 00    	je     7fd <printf+0xbd>
 75d:	8d 45 10             	lea    0x10(%ebp),%eax
 760:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    c = fmt[i] & 0xff;
 763:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 766:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 769:	eb 28                	jmp    793 <printf+0x53>
 76b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 770:	83 ec 04             	sub    $0x4,%esp
 773:	8d 45 e7             	lea    -0x19(%ebp),%eax
 776:	88 55 e7             	mov    %dl,-0x19(%ebp)
  for(i = 0; fmt[i]; i++){
 779:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 77c:	6a 01                	push   $0x1
 77e:	50                   	push   %eax
 77f:	56                   	push   %esi
 780:	e8 4e fe ff ff       	call   5d3 <write>
  for(i = 0; fmt[i]; i++){
 785:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 789:	83 c4 10             	add    $0x10,%esp
 78c:	84 d2                	test   %dl,%dl
 78e:	74 6d                	je     7fd <printf+0xbd>
    c = fmt[i] & 0xff;
 790:	0f b6 c2             	movzbl %dl,%eax
      if(c == '%'){
 793:	83 f8 25             	cmp    $0x25,%eax
 796:	75 d8                	jne    770 <printf+0x30>
  for(i = 0; fmt[i]; i++){
 798:	0f b6 13             	movzbl (%ebx),%edx
 79b:	84 d2                	test   %dl,%dl
 79d:	74 5e                	je     7fd <printf+0xbd>
    c = fmt[i] & 0xff;
 79f:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 7a2:	80 fa 25             	cmp    $0x25,%dl
 7a5:	0f 84 25 01 00 00    	je     8d0 <printf+0x190>
 7ab:	83 e8 63             	sub    $0x63,%eax
 7ae:	83 f8 15             	cmp    $0x15,%eax
 7b1:	77 0d                	ja     7c0 <printf+0x80>
 7b3:	ff 24 85 fc 0a 00 00 	jmp    *0xafc(,%eax,4)
 7ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 7c0:	83 ec 04             	sub    $0x4,%esp
 7c3:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 7c6:	88 55 d0             	mov    %dl,-0x30(%ebp)
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7c9:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 7cd:	6a 01                	push   $0x1
 7cf:	51                   	push   %ecx
 7d0:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 7d3:	56                   	push   %esi
 7d4:	e8 fa fd ff ff       	call   5d3 <write>
        putc(fd, c);
 7d9:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
  write(fd, &c, 1);
 7dd:	83 c4 0c             	add    $0xc,%esp
 7e0:	88 55 e7             	mov    %dl,-0x19(%ebp)
 7e3:	6a 01                	push   $0x1
 7e5:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 7e8:	51                   	push   %ecx
  for(i = 0; fmt[i]; i++){
 7e9:	83 c3 02             	add    $0x2,%ebx
  write(fd, &c, 1);
 7ec:	56                   	push   %esi
 7ed:	e8 e1 fd ff ff       	call   5d3 <write>
  for(i = 0; fmt[i]; i++){
 7f2:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 7f6:	83 c4 10             	add    $0x10,%esp
 7f9:	84 d2                	test   %dl,%dl
 7fb:	75 93                	jne    790 <printf+0x50>
      }
      state = 0;
    }
  }
}
 7fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 800:	5b                   	pop    %ebx
 801:	5e                   	pop    %esi
 802:	5f                   	pop    %edi
 803:	5d                   	pop    %ebp
 804:	c3                   	ret
 805:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 808:	83 ec 0c             	sub    $0xc,%esp
 80b:	8b 17                	mov    (%edi),%edx
 80d:	b9 10 00 00 00       	mov    $0x10,%ecx
 812:	89 f0                	mov    %esi,%eax
 814:	6a 00                	push   $0x0
 816:	e8 65 fe ff ff       	call   680 <printint>
  for(i = 0; fmt[i]; i++){
 81b:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 81f:	83 c3 02             	add    $0x2,%ebx
 822:	83 c4 10             	add    $0x10,%esp
 825:	84 d2                	test   %dl,%dl
 827:	74 d4                	je     7fd <printf+0xbd>
        ap++;
 829:	83 c7 04             	add    $0x4,%edi
 82c:	e9 5f ff ff ff       	jmp    790 <printf+0x50>
 831:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 838:	8b 07                	mov    (%edi),%eax
        ap++;
 83a:	83 c7 04             	add    $0x4,%edi
        if(s == 0)
 83d:	85 c0                	test   %eax,%eax
 83f:	0f 84 9b 00 00 00    	je     8e0 <printf+0x1a0>
        while(*s != 0){
 845:	0f b6 10             	movzbl (%eax),%edx
 848:	84 d2                	test   %dl,%dl
 84a:	0f 84 a2 00 00 00    	je     8f2 <printf+0x1b2>
 850:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 853:	89 c7                	mov    %eax,%edi
 855:	89 d0                	mov    %edx,%eax
 857:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 85a:	89 fb                	mov    %edi,%ebx
 85c:	8d 7d e7             	lea    -0x19(%ebp),%edi
 85f:	90                   	nop
  write(fd, &c, 1);
 860:	83 ec 04             	sub    $0x4,%esp
 863:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 866:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 869:	6a 01                	push   $0x1
 86b:	57                   	push   %edi
 86c:	56                   	push   %esi
 86d:	e8 61 fd ff ff       	call   5d3 <write>
        while(*s != 0){
 872:	0f b6 03             	movzbl (%ebx),%eax
 875:	83 c4 10             	add    $0x10,%esp
 878:	84 c0                	test   %al,%al
 87a:	75 e4                	jne    860 <printf+0x120>
 87c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 87f:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 883:	83 c3 02             	add    $0x2,%ebx
 886:	84 d2                	test   %dl,%dl
 888:	0f 85 d5 fe ff ff    	jne    763 <printf+0x23>
 88e:	e9 6a ff ff ff       	jmp    7fd <printf+0xbd>
 893:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 898:	83 ec 0c             	sub    $0xc,%esp
 89b:	8b 17                	mov    (%edi),%edx
 89d:	b9 0a 00 00 00       	mov    $0xa,%ecx
 8a2:	89 f0                	mov    %esi,%eax
 8a4:	6a 01                	push   $0x1
 8a6:	e8 d5 fd ff ff       	call   680 <printint>
  for(i = 0; fmt[i]; i++){
 8ab:	e9 6b ff ff ff       	jmp    81b <printf+0xdb>
        putc(fd, *ap);
 8b0:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 8b2:	83 ec 04             	sub    $0x4,%esp
 8b5:	8d 4d e7             	lea    -0x19(%ebp),%ecx
        putc(fd, *ap);
 8b8:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 8bb:	6a 01                	push   $0x1
 8bd:	51                   	push   %ecx
 8be:	56                   	push   %esi
 8bf:	e8 0f fd ff ff       	call   5d3 <write>
 8c4:	e9 52 ff ff ff       	jmp    81b <printf+0xdb>
 8c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8d0:	83 ec 04             	sub    $0x4,%esp
 8d3:	88 55 e7             	mov    %dl,-0x19(%ebp)
 8d6:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 8d9:	6a 01                	push   $0x1
 8db:	e9 08 ff ff ff       	jmp    7e8 <printf+0xa8>
          s = "(null)";
 8e0:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 8e3:	b8 28 00 00 00       	mov    $0x28,%eax
 8e8:	bf f2 0a 00 00       	mov    $0xaf2,%edi
 8ed:	e9 65 ff ff ff       	jmp    857 <printf+0x117>
  for(i = 0; fmt[i]; i++){
 8f2:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 8f6:	83 c3 02             	add    $0x2,%ebx
 8f9:	84 d2                	test   %dl,%dl
 8fb:	0f 85 8f fe ff ff    	jne    790 <printf+0x50>
 901:	e9 f7 fe ff ff       	jmp    7fd <printf+0xbd>
 906:	66 90                	xchg   %ax,%ax
 908:	66 90                	xchg   %ax,%ax
 90a:	66 90                	xchg   %ax,%ax
 90c:	66 90                	xchg   %ax,%ax
 90e:	66 90                	xchg   %ax,%ax
 910:	66 90                	xchg   %ax,%ax
 912:	66 90                	xchg   %ax,%ax
 914:	66 90                	xchg   %ax,%ax
 916:	66 90                	xchg   %ax,%ax
 918:	66 90                	xchg   %ax,%ax
 91a:	66 90                	xchg   %ax,%ax
 91c:	66 90                	xchg   %ax,%ax
 91e:	66 90                	xchg   %ax,%ax

00000920 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 920:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 921:	a1 78 0b 00 00       	mov    0xb78,%eax
{
 926:	89 e5                	mov    %esp,%ebp
 928:	57                   	push   %edi
 929:	56                   	push   %esi
 92a:	53                   	push   %ebx
 92b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 92e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 931:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 938:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 93f:	00 
 940:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 942:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 944:	39 ca                	cmp    %ecx,%edx
 946:	73 30                	jae    978 <free+0x58>
 948:	39 c1                	cmp    %eax,%ecx
 94a:	72 04                	jb     950 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 94c:	39 c2                	cmp    %eax,%edx
 94e:	72 f0                	jb     940 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 950:	8b 73 fc             	mov    -0x4(%ebx),%esi
 953:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 956:	39 f8                	cmp    %edi,%eax
 958:	74 36                	je     990 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 95a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 95d:	8b 42 04             	mov    0x4(%edx),%eax
 960:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 963:	39 f1                	cmp    %esi,%ecx
 965:	74 40                	je     9a7 <free+0x87>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 967:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 969:	5b                   	pop    %ebx
  freep = p;
 96a:	89 15 78 0b 00 00    	mov    %edx,0xb78
}
 970:	5e                   	pop    %esi
 971:	5f                   	pop    %edi
 972:	5d                   	pop    %ebp
 973:	c3                   	ret
 974:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 978:	39 c2                	cmp    %eax,%edx
 97a:	72 c4                	jb     940 <free+0x20>
 97c:	39 c1                	cmp    %eax,%ecx
 97e:	73 c0                	jae    940 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 980:	8b 73 fc             	mov    -0x4(%ebx),%esi
 983:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 986:	39 f8                	cmp    %edi,%eax
 988:	75 d0                	jne    95a <free+0x3a>
 98a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 990:	03 70 04             	add    0x4(%eax),%esi
 993:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 996:	8b 02                	mov    (%edx),%eax
 998:	8b 00                	mov    (%eax),%eax
 99a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 99d:	8b 42 04             	mov    0x4(%edx),%eax
 9a0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 9a3:	39 f1                	cmp    %esi,%ecx
 9a5:	75 c0                	jne    967 <free+0x47>
    p->s.size += bp->s.size;
 9a7:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 9aa:	89 15 78 0b 00 00    	mov    %edx,0xb78
    p->s.size += bp->s.size;
 9b0:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 9b3:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 9b6:	89 0a                	mov    %ecx,(%edx)
}
 9b8:	5b                   	pop    %ebx
 9b9:	5e                   	pop    %esi
 9ba:	5f                   	pop    %edi
 9bb:	5d                   	pop    %ebp
 9bc:	c3                   	ret
 9bd:	8d 76 00             	lea    0x0(%esi),%esi

000009c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9c0:	55                   	push   %ebp
 9c1:	89 e5                	mov    %esp,%ebp
 9c3:	57                   	push   %edi
 9c4:	56                   	push   %esi
 9c5:	53                   	push   %ebx
 9c6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9c9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 9cc:	8b 15 78 0b 00 00    	mov    0xb78,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9d2:	8d 78 07             	lea    0x7(%eax),%edi
 9d5:	c1 ef 03             	shr    $0x3,%edi
 9d8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 9db:	85 d2                	test   %edx,%edx
 9dd:	0f 84 8d 00 00 00    	je     a70 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9e3:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 9e5:	8b 48 04             	mov    0x4(%eax),%ecx
 9e8:	39 f9                	cmp    %edi,%ecx
 9ea:	73 64                	jae    a50 <malloc+0x90>
  if(nu < 4096)
 9ec:	bb 00 10 00 00       	mov    $0x1000,%ebx
 9f1:	39 df                	cmp    %ebx,%edi
 9f3:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 9f6:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 9fd:	eb 0a                	jmp    a09 <malloc+0x49>
 9ff:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a00:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 a02:	8b 48 04             	mov    0x4(%eax),%ecx
 a05:	39 f9                	cmp    %edi,%ecx
 a07:	73 47                	jae    a50 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a09:	89 c2                	mov    %eax,%edx
 a0b:	39 05 78 0b 00 00    	cmp    %eax,0xb78
 a11:	75 ed                	jne    a00 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 a13:	83 ec 0c             	sub    $0xc,%esp
 a16:	56                   	push   %esi
 a17:	e8 1f fc ff ff       	call   63b <sbrk>
  if(p == (char*)-1)
 a1c:	83 c4 10             	add    $0x10,%esp
 a1f:	83 f8 ff             	cmp    $0xffffffff,%eax
 a22:	74 1c                	je     a40 <malloc+0x80>
  hp->s.size = nu;
 a24:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 a27:	83 ec 0c             	sub    $0xc,%esp
 a2a:	83 c0 08             	add    $0x8,%eax
 a2d:	50                   	push   %eax
 a2e:	e8 ed fe ff ff       	call   920 <free>
  return freep;
 a33:	8b 15 78 0b 00 00    	mov    0xb78,%edx
      if((p = morecore(nunits)) == 0)
 a39:	83 c4 10             	add    $0x10,%esp
 a3c:	85 d2                	test   %edx,%edx
 a3e:	75 c0                	jne    a00 <malloc+0x40>
        return 0;
  }
}
 a40:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 a43:	31 c0                	xor    %eax,%eax
}
 a45:	5b                   	pop    %ebx
 a46:	5e                   	pop    %esi
 a47:	5f                   	pop    %edi
 a48:	5d                   	pop    %ebp
 a49:	c3                   	ret
 a4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 a50:	39 cf                	cmp    %ecx,%edi
 a52:	74 4c                	je     aa0 <malloc+0xe0>
        p->s.size -= nunits;
 a54:	29 f9                	sub    %edi,%ecx
 a56:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 a59:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 a5c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 a5f:	89 15 78 0b 00 00    	mov    %edx,0xb78
}
 a65:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 a68:	83 c0 08             	add    $0x8,%eax
}
 a6b:	5b                   	pop    %ebx
 a6c:	5e                   	pop    %esi
 a6d:	5f                   	pop    %edi
 a6e:	5d                   	pop    %ebp
 a6f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 a70:	c7 05 78 0b 00 00 7c 	movl   $0xb7c,0xb78
 a77:	0b 00 00 
    base.s.size = 0;
 a7a:	b8 7c 0b 00 00       	mov    $0xb7c,%eax
    base.s.ptr = freep = prevp = &base;
 a7f:	c7 05 7c 0b 00 00 7c 	movl   $0xb7c,0xb7c
 a86:	0b 00 00 
    base.s.size = 0;
 a89:	c7 05 80 0b 00 00 00 	movl   $0x0,0xb80
 a90:	00 00 00 
    if(p->s.size >= nunits){
 a93:	e9 54 ff ff ff       	jmp    9ec <malloc+0x2c>
 a98:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 a9f:	00 
        prevp->s.ptr = p->s.ptr;
 aa0:	8b 08                	mov    (%eax),%ecx
 aa2:	89 0a                	mov    %ecx,(%edx)
 aa4:	eb b9                	jmp    a5f <malloc+0x9f>
