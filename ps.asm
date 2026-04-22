
_ps:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "user.h"

int main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 48             	sub    $0x48,%esp
  14:	8b 31                	mov    (%ecx),%esi
  16:	8b 79 04             	mov    0x4(%ecx),%edi
    int pid;
    int self;
    struct procinfo info;

    if (argc > 2)
  19:	83 fe 02             	cmp    $0x2,%esi
  1c:	7e 13                	jle    31 <main+0x31>
    {
        printf(1, "usage: ps [pid]\n");
  1e:	53                   	push   %ebx
  1f:	53                   	push   %ebx
  20:	68 28 08 00 00       	push   $0x828
  25:	6a 01                	push   $0x1
  27:	e8 94 04 00 00       	call   4c0 <printf>
        exit();
  2c:	e8 02 03 00 00       	call   333 <exit>
    }

    self = getpid();
  31:	e8 7d 03 00 00       	call   3b3 <getpid>
  36:	89 c3                	mov    %eax,%ebx
    if (argc == 2)
  38:	83 fe 02             	cmp    $0x2,%esi
  3b:	74 65                	je     a2 <main+0xa2>
        pid = atoi(argv[1]);
    else
        pid = self;

    if (pid <= 0)
  3d:	85 db                	test   %ebx,%ebx
  3f:	7e 3b                	jle    7c <main+0x7c>
    {
        printf(1, "ps: invalid pid %d\n", pid);
        exit();
    }

    if (getprocinfo(pid, &info) < 0)
  41:	8d 45 b0             	lea    -0x50(%ebp),%eax
  44:	52                   	push   %edx
  45:	52                   	push   %edx
  46:	50                   	push   %eax
  47:	53                   	push   %ebx
  48:	e8 86 03 00 00       	call   3d3 <getprocinfo>
  4d:	83 c4 10             	add    $0x10,%esp
  50:	85 c0                	test   %eax,%eax
  52:	78 3b                	js     8f <main+0x8f>
    {
        printf(1, "ps: cannot access pid %d (not in your process family or does not exist)\n", pid);
        exit();
    }

    printf(1, " pid=%d\n Parent pid=%d\n Current Process State=%s\n Memory size allocated=%d\n CPU ticks=%d\n Process Name=%s\n",
  54:	8d 45 d0             	lea    -0x30(%ebp),%eax
  57:	50                   	push   %eax
  58:	8d 45 b8             	lea    -0x48(%ebp),%eax
  5b:	ff 75 cc             	push   -0x34(%ebp)
  5e:	ff 75 c8             	push   -0x38(%ebp)
  61:	50                   	push   %eax
  62:	ff 75 b4             	push   -0x4c(%ebp)
  65:	ff 75 b0             	push   -0x50(%ebp)
  68:	68 a0 08 00 00       	push   $0x8a0
  6d:	6a 01                	push   $0x1
  6f:	e8 4c 04 00 00       	call   4c0 <printf>
           info.pid, info.ppid, info.state, info.sz, info.cputicks, info.name);
    exit();
  74:	83 c4 20             	add    $0x20,%esp
  77:	e8 b7 02 00 00       	call   333 <exit>
        printf(1, "ps: invalid pid %d\n", pid);
  7c:	51                   	push   %ecx
  7d:	53                   	push   %ebx
  7e:	68 39 08 00 00       	push   $0x839
  83:	6a 01                	push   $0x1
  85:	e8 36 04 00 00       	call   4c0 <printf>
        exit();
  8a:	e8 a4 02 00 00       	call   333 <exit>
        printf(1, "ps: cannot access pid %d (not in your process family or does not exist)\n", pid);
  8f:	50                   	push   %eax
  90:	53                   	push   %ebx
  91:	68 54 08 00 00       	push   $0x854
  96:	6a 01                	push   $0x1
  98:	e8 23 04 00 00       	call   4c0 <printf>
        exit();
  9d:	e8 91 02 00 00       	call   333 <exit>
        pid = atoi(argv[1]);
  a2:	83 ec 0c             	sub    $0xc,%esp
  a5:	ff 77 04             	push   0x4(%edi)
  a8:	e8 03 02 00 00       	call   2b0 <atoi>
  ad:	83 c4 10             	add    $0x10,%esp
  b0:	89 c3                	mov    %eax,%ebx
  b2:	eb 89                	jmp    3d <main+0x3d>
  b4:	66 90                	xchg   %ax,%ax
  b6:	66 90                	xchg   %ax,%ax
  b8:	66 90                	xchg   %ax,%ax
  ba:	66 90                	xchg   %ax,%ax
  bc:	66 90                	xchg   %ax,%ax
  be:	66 90                	xchg   %ax,%ax

000000c0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  c0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  c1:	31 c0                	xor    %eax,%eax
{
  c3:	89 e5                	mov    %esp,%ebp
  c5:	53                   	push   %ebx
  c6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  c9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  d0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  d4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  d7:	83 c0 01             	add    $0x1,%eax
  da:	84 d2                	test   %dl,%dl
  dc:	75 f2                	jne    d0 <strcpy+0x10>
    ;
  return os;
}
  de:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  e1:	89 c8                	mov    %ecx,%eax
  e3:	c9                   	leave
  e4:	c3                   	ret
  e5:	8d 76 00             	lea    0x0(%esi),%esi
  e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  ef:	00 

000000f0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	53                   	push   %ebx
  f4:	8b 55 08             	mov    0x8(%ebp),%edx
  f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  fa:	0f b6 02             	movzbl (%edx),%eax
  fd:	84 c0                	test   %al,%al
  ff:	75 2d                	jne    12e <strcmp+0x3e>
 101:	eb 4a                	jmp    14d <strcmp+0x5d>
 103:	eb 1b                	jmp    120 <strcmp+0x30>
 105:	8d 76 00             	lea    0x0(%esi),%esi
 108:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 10f:	00 
 110:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 117:	00 
 118:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 11f:	00 
 120:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 124:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 127:	84 c0                	test   %al,%al
 129:	74 15                	je     140 <strcmp+0x50>
 12b:	83 c1 01             	add    $0x1,%ecx
 12e:	0f b6 19             	movzbl (%ecx),%ebx
 131:	38 c3                	cmp    %al,%bl
 133:	74 eb                	je     120 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
 135:	29 d8                	sub    %ebx,%eax
}
 137:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 13a:	c9                   	leave
 13b:	c3                   	ret
 13c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return (uchar)*p - (uchar)*q;
 140:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 144:	31 c0                	xor    %eax,%eax
 146:	29 d8                	sub    %ebx,%eax
}
 148:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 14b:	c9                   	leave
 14c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 14d:	0f b6 19             	movzbl (%ecx),%ebx
 150:	31 c0                	xor    %eax,%eax
 152:	eb e1                	jmp    135 <strcmp+0x45>
 154:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 158:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 15f:	00 

00000160 <strlen>:

uint
strlen(const char *s)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 166:	80 3a 00             	cmpb   $0x0,(%edx)
 169:	74 15                	je     180 <strlen+0x20>
 16b:	31 c0                	xor    %eax,%eax
 16d:	8d 76 00             	lea    0x0(%esi),%esi
 170:	83 c0 01             	add    $0x1,%eax
 173:	89 c1                	mov    %eax,%ecx
 175:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 179:	75 f5                	jne    170 <strlen+0x10>
    ;
  return n;
}
 17b:	89 c8                	mov    %ecx,%eax
 17d:	5d                   	pop    %ebp
 17e:	c3                   	ret
 17f:	90                   	nop
  for(n = 0; s[n]; n++)
 180:	31 c9                	xor    %ecx,%ecx
}
 182:	5d                   	pop    %ebp
 183:	89 c8                	mov    %ecx,%eax
 185:	c3                   	ret
 186:	66 90                	xchg   %ax,%ax
 188:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 18f:	00 

00000190 <memset>:

void*
memset(void *dst, int c, uint n)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 194:	8b 4d 10             	mov    0x10(%ebp),%ecx
 197:	8b 45 0c             	mov    0xc(%ebp),%eax
 19a:	8b 7d 08             	mov    0x8(%ebp),%edi
 19d:	fc                   	cld
 19e:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1a0:	8b 45 08             	mov    0x8(%ebp),%eax
 1a3:	8b 7d fc             	mov    -0x4(%ebp),%edi
 1a6:	c9                   	leave
 1a7:	c3                   	ret
 1a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1af:	00 

000001b0 <strchr>:

char*
strchr(const char *s, char c)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	8b 45 08             	mov    0x8(%ebp),%eax
 1b6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1ba:	0f b6 10             	movzbl (%eax),%edx
 1bd:	84 d2                	test   %dl,%dl
 1bf:	75 1a                	jne    1db <strchr+0x2b>
 1c1:	eb 25                	jmp    1e8 <strchr+0x38>
 1c3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 1c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1cf:	00 
 1d0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 1d4:	83 c0 01             	add    $0x1,%eax
 1d7:	84 d2                	test   %dl,%dl
 1d9:	74 0d                	je     1e8 <strchr+0x38>
    if(*s == c)
 1db:	38 d1                	cmp    %dl,%cl
 1dd:	75 f1                	jne    1d0 <strchr+0x20>
      return (char*)s;
  return 0;
}
 1df:	5d                   	pop    %ebp
 1e0:	c3                   	ret
 1e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 1e8:	31 c0                	xor    %eax,%eax
}
 1ea:	5d                   	pop    %ebp
 1eb:	c3                   	ret
 1ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001f0 <gets>:

char*
gets(char *buf, int max)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	57                   	push   %edi
 1f4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 1f5:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 1f8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 1f9:	31 db                	xor    %ebx,%ebx
{
 1fb:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 1fe:	eb 27                	jmp    227 <gets+0x37>
    cc = read(0, &c, 1);
 200:	83 ec 04             	sub    $0x4,%esp
 203:	6a 01                	push   $0x1
 205:	57                   	push   %edi
 206:	6a 00                	push   $0x0
 208:	e8 3e 01 00 00       	call   34b <read>
    if(cc < 1)
 20d:	83 c4 10             	add    $0x10,%esp
 210:	85 c0                	test   %eax,%eax
 212:	7e 1d                	jle    231 <gets+0x41>
      break;
    buf[i++] = c;
 214:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 218:	8b 55 08             	mov    0x8(%ebp),%edx
 21b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 21f:	3c 0a                	cmp    $0xa,%al
 221:	74 1d                	je     240 <gets+0x50>
 223:	3c 0d                	cmp    $0xd,%al
 225:	74 19                	je     240 <gets+0x50>
  for(i=0; i+1 < max; ){
 227:	89 de                	mov    %ebx,%esi
 229:	83 c3 01             	add    $0x1,%ebx
 22c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 22f:	7c cf                	jl     200 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 231:	8b 45 08             	mov    0x8(%ebp),%eax
 234:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 238:	8d 65 f4             	lea    -0xc(%ebp),%esp
 23b:	5b                   	pop    %ebx
 23c:	5e                   	pop    %esi
 23d:	5f                   	pop    %edi
 23e:	5d                   	pop    %ebp
 23f:	c3                   	ret
  buf[i] = '\0';
 240:	8b 45 08             	mov    0x8(%ebp),%eax
    buf[i++] = c;
 243:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 245:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 249:	8d 65 f4             	lea    -0xc(%ebp),%esp
 24c:	5b                   	pop    %ebx
 24d:	5e                   	pop    %esi
 24e:	5f                   	pop    %edi
 24f:	5d                   	pop    %ebp
 250:	c3                   	ret
 251:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 258:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 25f:	00 

00000260 <stat>:

int
stat(const char *n, struct stat *st)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	56                   	push   %esi
 264:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 265:	83 ec 08             	sub    $0x8,%esp
 268:	6a 00                	push   $0x0
 26a:	ff 75 08             	push   0x8(%ebp)
 26d:	e8 01 01 00 00       	call   373 <open>
  if(fd < 0)
 272:	83 c4 10             	add    $0x10,%esp
 275:	85 c0                	test   %eax,%eax
 277:	78 27                	js     2a0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 279:	83 ec 08             	sub    $0x8,%esp
 27c:	ff 75 0c             	push   0xc(%ebp)
 27f:	89 c3                	mov    %eax,%ebx
 281:	50                   	push   %eax
 282:	e8 04 01 00 00       	call   38b <fstat>
  close(fd);
 287:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 28a:	89 c6                	mov    %eax,%esi
  close(fd);
 28c:	e8 ca 00 00 00       	call   35b <close>
  return r;
 291:	83 c4 10             	add    $0x10,%esp
}
 294:	8d 65 f8             	lea    -0x8(%ebp),%esp
 297:	89 f0                	mov    %esi,%eax
 299:	5b                   	pop    %ebx
 29a:	5e                   	pop    %esi
 29b:	5d                   	pop    %ebp
 29c:	c3                   	ret
 29d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 2a0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2a5:	eb ed                	jmp    294 <stat+0x34>
 2a7:	90                   	nop
 2a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2af:	00 

000002b0 <atoi>:

int
atoi(const char *s)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	53                   	push   %ebx
 2b4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2b7:	0f be 02             	movsbl (%edx),%eax
 2ba:	8d 48 d0             	lea    -0x30(%eax),%ecx
 2bd:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 2c0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 2c5:	77 2e                	ja     2f5 <atoi+0x45>
 2c7:	eb 17                	jmp    2e0 <atoi+0x30>
 2c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2d0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2d7:	00 
 2d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2df:	00 
    n = n*10 + *s++ - '0';
 2e0:	83 c2 01             	add    $0x1,%edx
 2e3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 2e6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 2ea:	0f be 02             	movsbl (%edx),%eax
 2ed:	8d 58 d0             	lea    -0x30(%eax),%ebx
 2f0:	80 fb 09             	cmp    $0x9,%bl
 2f3:	76 eb                	jbe    2e0 <atoi+0x30>
  return n;
}
 2f5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 2f8:	89 c8                	mov    %ecx,%eax
 2fa:	c9                   	leave
 2fb:	c3                   	ret
 2fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000300 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	57                   	push   %edi
 304:	8b 45 10             	mov    0x10(%ebp),%eax
 307:	8b 55 08             	mov    0x8(%ebp),%edx
 30a:	56                   	push   %esi
 30b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 30e:	85 c0                	test   %eax,%eax
 310:	7e 13                	jle    325 <memmove+0x25>
 312:	01 d0                	add    %edx,%eax
  dst = vdst;
 314:	89 d7                	mov    %edx,%edi
 316:	66 90                	xchg   %ax,%ax
 318:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 31f:	00 
    *dst++ = *src++;
 320:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 321:	39 f8                	cmp    %edi,%eax
 323:	75 fb                	jne    320 <memmove+0x20>
  return vdst;
}
 325:	5e                   	pop    %esi
 326:	89 d0                	mov    %edx,%eax
 328:	5f                   	pop    %edi
 329:	5d                   	pop    %ebp
 32a:	c3                   	ret

0000032b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 32b:	b8 01 00 00 00       	mov    $0x1,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret

00000333 <exit>:
SYSCALL(exit)
 333:	b8 02 00 00 00       	mov    $0x2,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret

0000033b <wait>:
SYSCALL(wait)
 33b:	b8 03 00 00 00       	mov    $0x3,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret

00000343 <pipe>:
SYSCALL(pipe)
 343:	b8 04 00 00 00       	mov    $0x4,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret

0000034b <read>:
SYSCALL(read)
 34b:	b8 05 00 00 00       	mov    $0x5,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret

00000353 <write>:
SYSCALL(write)
 353:	b8 10 00 00 00       	mov    $0x10,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret

0000035b <close>:
SYSCALL(close)
 35b:	b8 15 00 00 00       	mov    $0x15,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret

00000363 <kill>:
SYSCALL(kill)
 363:	b8 06 00 00 00       	mov    $0x6,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret

0000036b <exec>:
SYSCALL(exec)
 36b:	b8 07 00 00 00       	mov    $0x7,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret

00000373 <open>:
SYSCALL(open)
 373:	b8 0f 00 00 00       	mov    $0xf,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret

0000037b <mknod>:
SYSCALL(mknod)
 37b:	b8 11 00 00 00       	mov    $0x11,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret

00000383 <unlink>:
SYSCALL(unlink)
 383:	b8 12 00 00 00       	mov    $0x12,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret

0000038b <fstat>:
SYSCALL(fstat)
 38b:	b8 08 00 00 00       	mov    $0x8,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret

00000393 <link>:
SYSCALL(link)
 393:	b8 13 00 00 00       	mov    $0x13,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret

0000039b <mkdir>:
SYSCALL(mkdir)
 39b:	b8 14 00 00 00       	mov    $0x14,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret

000003a3 <chdir>:
SYSCALL(chdir)
 3a3:	b8 09 00 00 00       	mov    $0x9,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret

000003ab <dup>:
SYSCALL(dup)
 3ab:	b8 0a 00 00 00       	mov    $0xa,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret

000003b3 <getpid>:
SYSCALL(getpid)
 3b3:	b8 0b 00 00 00       	mov    $0xb,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret

000003bb <sbrk>:
SYSCALL(sbrk)
 3bb:	b8 0c 00 00 00       	mov    $0xc,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret

000003c3 <sleep>:
SYSCALL(sleep)
 3c3:	b8 0d 00 00 00       	mov    $0xd,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret

000003cb <uptime>:
SYSCALL(uptime)
 3cb:	b8 0e 00 00 00       	mov    $0xe,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret

000003d3 <getprocinfo>:
SYSCALL(getprocinfo)
 3d3:	b8 16 00 00 00       	mov    $0x16,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret

000003db <nice>:
SYSCALL(nice)
 3db:	b8 17 00 00 00       	mov    $0x17,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret
 3e3:	66 90                	xchg   %ax,%ax
 3e5:	66 90                	xchg   %ax,%ax
 3e7:	66 90                	xchg   %ax,%ax
 3e9:	66 90                	xchg   %ax,%ax
 3eb:	66 90                	xchg   %ax,%ax
 3ed:	66 90                	xchg   %ax,%ax
 3ef:	66 90                	xchg   %ax,%ax
 3f1:	66 90                	xchg   %ax,%ax
 3f3:	66 90                	xchg   %ax,%ax
 3f5:	66 90                	xchg   %ax,%ax
 3f7:	66 90                	xchg   %ax,%ax
 3f9:	66 90                	xchg   %ax,%ax
 3fb:	66 90                	xchg   %ax,%ax
 3fd:	66 90                	xchg   %ax,%ax
 3ff:	90                   	nop

00000400 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	57                   	push   %edi
 404:	56                   	push   %esi
 405:	53                   	push   %ebx
 406:	89 cb                	mov    %ecx,%ebx
 408:	83 ec 3c             	sub    $0x3c,%esp
 40b:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 40e:	85 d2                	test   %edx,%edx
 410:	0f 89 9a 00 00 00    	jns    4b0 <printint+0xb0>
 416:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 41a:	0f 84 90 00 00 00    	je     4b0 <printint+0xb0>
    neg = 1;
    x = -xx;
 420:	f7 da                	neg    %edx
    neg = 1;
 422:	b8 01 00 00 00       	mov    $0x1,%eax
 427:	89 45 c0             	mov    %eax,-0x40(%ebp)
 42a:	89 d1                	mov    %edx,%ecx
  } else {
    x = xx;
  }

  i = 0;
 42c:	31 f6                	xor    %esi,%esi
 42e:	66 90                	xchg   %ax,%ax
 430:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 437:	00 
 438:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 43f:	00 
  do{
    buf[i++] = digits[x % base];
 440:	89 c8                	mov    %ecx,%eax
 442:	31 d2                	xor    %edx,%edx
 444:	89 f7                	mov    %esi,%edi
 446:	f7 f3                	div    %ebx
 448:	8d 76 01             	lea    0x1(%esi),%esi
  }while((x /= base) != 0);
 44b:	39 d9                	cmp    %ebx,%ecx
    buf[i++] = digits[x % base];
 44d:	0f b6 92 64 09 00 00 	movzbl 0x964(%edx),%edx
  }while((x /= base) != 0);
 454:	89 c1                	mov    %eax,%ecx
    buf[i++] = digits[x % base];
 456:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 45a:	73 e4                	jae    440 <printint+0x40>
  if(neg)
 45c:	8b 45 c0             	mov    -0x40(%ebp),%eax
 45f:	85 c0                	test   %eax,%eax
 461:	74 07                	je     46a <printint+0x6a>
    buf[i++] = '-';
 463:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 468:	89 f7                	mov    %esi,%edi

  while(--i >= 0)
 46a:	8d 74 3d d8          	lea    -0x28(%ebp,%edi,1),%esi
 46e:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 471:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 478:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 47f:	00 
    putc(fd, buf[i]);
 480:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 483:	83 ec 04             	sub    $0x4,%esp
  while(--i >= 0)
 486:	83 ee 01             	sub    $0x1,%esi
 489:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 48c:	8d 45 d7             	lea    -0x29(%ebp),%eax
 48f:	6a 01                	push   $0x1
 491:	50                   	push   %eax
 492:	57                   	push   %edi
 493:	e8 bb fe ff ff       	call   353 <write>
  while(--i >= 0)
 498:	83 c4 10             	add    $0x10,%esp
 49b:	39 f3                	cmp    %esi,%ebx
 49d:	75 e1                	jne    480 <printint+0x80>
}
 49f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4a2:	5b                   	pop    %ebx
 4a3:	5e                   	pop    %esi
 4a4:	5f                   	pop    %edi
 4a5:	5d                   	pop    %ebp
 4a6:	c3                   	ret
 4a7:	90                   	nop
 4a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4af:	00 
  neg = 0;
 4b0:	31 c0                	xor    %eax,%eax
 4b2:	e9 70 ff ff ff       	jmp    427 <printint+0x27>
 4b7:	90                   	nop
 4b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4bf:	00 

000004c0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	57                   	push   %edi
 4c4:	56                   	push   %esi
 4c5:	53                   	push   %ebx
 4c6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4c9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 4cc:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 4cf:	0f b6 13             	movzbl (%ebx),%edx
 4d2:	83 c3 01             	add    $0x1,%ebx
 4d5:	84 d2                	test   %dl,%dl
 4d7:	0f 84 a0 00 00 00    	je     57d <printf+0xbd>
 4dd:	8d 45 10             	lea    0x10(%ebp),%eax
 4e0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    c = fmt[i] & 0xff;
 4e3:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 4e6:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 4e9:	eb 28                	jmp    513 <printf+0x53>
 4eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 4f0:	83 ec 04             	sub    $0x4,%esp
 4f3:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4f6:	88 55 e7             	mov    %dl,-0x19(%ebp)
  for(i = 0; fmt[i]; i++){
 4f9:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 4fc:	6a 01                	push   $0x1
 4fe:	50                   	push   %eax
 4ff:	56                   	push   %esi
 500:	e8 4e fe ff ff       	call   353 <write>
  for(i = 0; fmt[i]; i++){
 505:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 509:	83 c4 10             	add    $0x10,%esp
 50c:	84 d2                	test   %dl,%dl
 50e:	74 6d                	je     57d <printf+0xbd>
    c = fmt[i] & 0xff;
 510:	0f b6 c2             	movzbl %dl,%eax
      if(c == '%'){
 513:	83 f8 25             	cmp    $0x25,%eax
 516:	75 d8                	jne    4f0 <printf+0x30>
  for(i = 0; fmt[i]; i++){
 518:	0f b6 13             	movzbl (%ebx),%edx
 51b:	84 d2                	test   %dl,%dl
 51d:	74 5e                	je     57d <printf+0xbd>
    c = fmt[i] & 0xff;
 51f:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 522:	80 fa 25             	cmp    $0x25,%dl
 525:	0f 84 25 01 00 00    	je     650 <printf+0x190>
 52b:	83 e8 63             	sub    $0x63,%eax
 52e:	83 f8 15             	cmp    $0x15,%eax
 531:	77 0d                	ja     540 <printf+0x80>
 533:	ff 24 85 0c 09 00 00 	jmp    *0x90c(,%eax,4)
 53a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 540:	83 ec 04             	sub    $0x4,%esp
 543:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 546:	88 55 d0             	mov    %dl,-0x30(%ebp)
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 549:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 54d:	6a 01                	push   $0x1
 54f:	51                   	push   %ecx
 550:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 553:	56                   	push   %esi
 554:	e8 fa fd ff ff       	call   353 <write>
        putc(fd, c);
 559:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
  write(fd, &c, 1);
 55d:	83 c4 0c             	add    $0xc,%esp
 560:	88 55 e7             	mov    %dl,-0x19(%ebp)
 563:	6a 01                	push   $0x1
 565:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 568:	51                   	push   %ecx
  for(i = 0; fmt[i]; i++){
 569:	83 c3 02             	add    $0x2,%ebx
  write(fd, &c, 1);
 56c:	56                   	push   %esi
 56d:	e8 e1 fd ff ff       	call   353 <write>
  for(i = 0; fmt[i]; i++){
 572:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 576:	83 c4 10             	add    $0x10,%esp
 579:	84 d2                	test   %dl,%dl
 57b:	75 93                	jne    510 <printf+0x50>
      }
      state = 0;
    }
  }
}
 57d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 580:	5b                   	pop    %ebx
 581:	5e                   	pop    %esi
 582:	5f                   	pop    %edi
 583:	5d                   	pop    %ebp
 584:	c3                   	ret
 585:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 588:	83 ec 0c             	sub    $0xc,%esp
 58b:	8b 17                	mov    (%edi),%edx
 58d:	b9 10 00 00 00       	mov    $0x10,%ecx
 592:	89 f0                	mov    %esi,%eax
 594:	6a 00                	push   $0x0
 596:	e8 65 fe ff ff       	call   400 <printint>
  for(i = 0; fmt[i]; i++){
 59b:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 59f:	83 c3 02             	add    $0x2,%ebx
 5a2:	83 c4 10             	add    $0x10,%esp
 5a5:	84 d2                	test   %dl,%dl
 5a7:	74 d4                	je     57d <printf+0xbd>
        ap++;
 5a9:	83 c7 04             	add    $0x4,%edi
 5ac:	e9 5f ff ff ff       	jmp    510 <printf+0x50>
 5b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 5b8:	8b 07                	mov    (%edi),%eax
        ap++;
 5ba:	83 c7 04             	add    $0x4,%edi
        if(s == 0)
 5bd:	85 c0                	test   %eax,%eax
 5bf:	0f 84 9b 00 00 00    	je     660 <printf+0x1a0>
        while(*s != 0){
 5c5:	0f b6 10             	movzbl (%eax),%edx
 5c8:	84 d2                	test   %dl,%dl
 5ca:	0f 84 a2 00 00 00    	je     672 <printf+0x1b2>
 5d0:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 5d3:	89 c7                	mov    %eax,%edi
 5d5:	89 d0                	mov    %edx,%eax
 5d7:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5da:	89 fb                	mov    %edi,%ebx
 5dc:	8d 7d e7             	lea    -0x19(%ebp),%edi
 5df:	90                   	nop
  write(fd, &c, 1);
 5e0:	83 ec 04             	sub    $0x4,%esp
 5e3:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 5e6:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 5e9:	6a 01                	push   $0x1
 5eb:	57                   	push   %edi
 5ec:	56                   	push   %esi
 5ed:	e8 61 fd ff ff       	call   353 <write>
        while(*s != 0){
 5f2:	0f b6 03             	movzbl (%ebx),%eax
 5f5:	83 c4 10             	add    $0x10,%esp
 5f8:	84 c0                	test   %al,%al
 5fa:	75 e4                	jne    5e0 <printf+0x120>
 5fc:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 5ff:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 603:	83 c3 02             	add    $0x2,%ebx
 606:	84 d2                	test   %dl,%dl
 608:	0f 85 d5 fe ff ff    	jne    4e3 <printf+0x23>
 60e:	e9 6a ff ff ff       	jmp    57d <printf+0xbd>
 613:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 618:	83 ec 0c             	sub    $0xc,%esp
 61b:	8b 17                	mov    (%edi),%edx
 61d:	b9 0a 00 00 00       	mov    $0xa,%ecx
 622:	89 f0                	mov    %esi,%eax
 624:	6a 01                	push   $0x1
 626:	e8 d5 fd ff ff       	call   400 <printint>
  for(i = 0; fmt[i]; i++){
 62b:	e9 6b ff ff ff       	jmp    59b <printf+0xdb>
        putc(fd, *ap);
 630:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 632:	83 ec 04             	sub    $0x4,%esp
 635:	8d 4d e7             	lea    -0x19(%ebp),%ecx
        putc(fd, *ap);
 638:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 63b:	6a 01                	push   $0x1
 63d:	51                   	push   %ecx
 63e:	56                   	push   %esi
 63f:	e8 0f fd ff ff       	call   353 <write>
 644:	e9 52 ff ff ff       	jmp    59b <printf+0xdb>
 649:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 650:	83 ec 04             	sub    $0x4,%esp
 653:	88 55 e7             	mov    %dl,-0x19(%ebp)
 656:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 659:	6a 01                	push   $0x1
 65b:	e9 08 ff ff ff       	jmp    568 <printf+0xa8>
          s = "(null)";
 660:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 663:	b8 28 00 00 00       	mov    $0x28,%eax
 668:	bf 4d 08 00 00       	mov    $0x84d,%edi
 66d:	e9 65 ff ff ff       	jmp    5d7 <printf+0x117>
  for(i = 0; fmt[i]; i++){
 672:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 676:	83 c3 02             	add    $0x2,%ebx
 679:	84 d2                	test   %dl,%dl
 67b:	0f 85 8f fe ff ff    	jne    510 <printf+0x50>
 681:	e9 f7 fe ff ff       	jmp    57d <printf+0xbd>
 686:	66 90                	xchg   %ax,%ax
 688:	66 90                	xchg   %ax,%ax
 68a:	66 90                	xchg   %ax,%ax
 68c:	66 90                	xchg   %ax,%ax
 68e:	66 90                	xchg   %ax,%ax
 690:	66 90                	xchg   %ax,%ax
 692:	66 90                	xchg   %ax,%ax
 694:	66 90                	xchg   %ax,%ax
 696:	66 90                	xchg   %ax,%ax
 698:	66 90                	xchg   %ax,%ax
 69a:	66 90                	xchg   %ax,%ax
 69c:	66 90                	xchg   %ax,%ax
 69e:	66 90                	xchg   %ax,%ax

000006a0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6a0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a1:	a1 78 09 00 00       	mov    0x978,%eax
{
 6a6:	89 e5                	mov    %esp,%ebp
 6a8:	57                   	push   %edi
 6a9:	56                   	push   %esi
 6aa:	53                   	push   %ebx
 6ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 6ae:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6bf:	00 
 6c0:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6c2:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c4:	39 ca                	cmp    %ecx,%edx
 6c6:	73 30                	jae    6f8 <free+0x58>
 6c8:	39 c1                	cmp    %eax,%ecx
 6ca:	72 04                	jb     6d0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6cc:	39 c2                	cmp    %eax,%edx
 6ce:	72 f0                	jb     6c0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6d0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6d3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6d6:	39 f8                	cmp    %edi,%eax
 6d8:	74 36                	je     710 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 6da:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6dd:	8b 42 04             	mov    0x4(%edx),%eax
 6e0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 6e3:	39 f1                	cmp    %esi,%ecx
 6e5:	74 40                	je     727 <free+0x87>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 6e7:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 6e9:	5b                   	pop    %ebx
  freep = p;
 6ea:	89 15 78 09 00 00    	mov    %edx,0x978
}
 6f0:	5e                   	pop    %esi
 6f1:	5f                   	pop    %edi
 6f2:	5d                   	pop    %ebp
 6f3:	c3                   	ret
 6f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6f8:	39 c2                	cmp    %eax,%edx
 6fa:	72 c4                	jb     6c0 <free+0x20>
 6fc:	39 c1                	cmp    %eax,%ecx
 6fe:	73 c0                	jae    6c0 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 700:	8b 73 fc             	mov    -0x4(%ebx),%esi
 703:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 706:	39 f8                	cmp    %edi,%eax
 708:	75 d0                	jne    6da <free+0x3a>
 70a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 710:	03 70 04             	add    0x4(%eax),%esi
 713:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 716:	8b 02                	mov    (%edx),%eax
 718:	8b 00                	mov    (%eax),%eax
 71a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 71d:	8b 42 04             	mov    0x4(%edx),%eax
 720:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 723:	39 f1                	cmp    %esi,%ecx
 725:	75 c0                	jne    6e7 <free+0x47>
    p->s.size += bp->s.size;
 727:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 72a:	89 15 78 09 00 00    	mov    %edx,0x978
    p->s.size += bp->s.size;
 730:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 733:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 736:	89 0a                	mov    %ecx,(%edx)
}
 738:	5b                   	pop    %ebx
 739:	5e                   	pop    %esi
 73a:	5f                   	pop    %edi
 73b:	5d                   	pop    %ebp
 73c:	c3                   	ret
 73d:	8d 76 00             	lea    0x0(%esi),%esi

00000740 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 740:	55                   	push   %ebp
 741:	89 e5                	mov    %esp,%ebp
 743:	57                   	push   %edi
 744:	56                   	push   %esi
 745:	53                   	push   %ebx
 746:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 749:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 74c:	8b 15 78 09 00 00    	mov    0x978,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 752:	8d 78 07             	lea    0x7(%eax),%edi
 755:	c1 ef 03             	shr    $0x3,%edi
 758:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 75b:	85 d2                	test   %edx,%edx
 75d:	0f 84 8d 00 00 00    	je     7f0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 763:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 765:	8b 48 04             	mov    0x4(%eax),%ecx
 768:	39 f9                	cmp    %edi,%ecx
 76a:	73 64                	jae    7d0 <malloc+0x90>
  if(nu < 4096)
 76c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 771:	39 df                	cmp    %ebx,%edi
 773:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 776:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 77d:	eb 0a                	jmp    789 <malloc+0x49>
 77f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 780:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 782:	8b 48 04             	mov    0x4(%eax),%ecx
 785:	39 f9                	cmp    %edi,%ecx
 787:	73 47                	jae    7d0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 789:	89 c2                	mov    %eax,%edx
 78b:	39 05 78 09 00 00    	cmp    %eax,0x978
 791:	75 ed                	jne    780 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 793:	83 ec 0c             	sub    $0xc,%esp
 796:	56                   	push   %esi
 797:	e8 1f fc ff ff       	call   3bb <sbrk>
  if(p == (char*)-1)
 79c:	83 c4 10             	add    $0x10,%esp
 79f:	83 f8 ff             	cmp    $0xffffffff,%eax
 7a2:	74 1c                	je     7c0 <malloc+0x80>
  hp->s.size = nu;
 7a4:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 7a7:	83 ec 0c             	sub    $0xc,%esp
 7aa:	83 c0 08             	add    $0x8,%eax
 7ad:	50                   	push   %eax
 7ae:	e8 ed fe ff ff       	call   6a0 <free>
  return freep;
 7b3:	8b 15 78 09 00 00    	mov    0x978,%edx
      if((p = morecore(nunits)) == 0)
 7b9:	83 c4 10             	add    $0x10,%esp
 7bc:	85 d2                	test   %edx,%edx
 7be:	75 c0                	jne    780 <malloc+0x40>
        return 0;
  }
}
 7c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 7c3:	31 c0                	xor    %eax,%eax
}
 7c5:	5b                   	pop    %ebx
 7c6:	5e                   	pop    %esi
 7c7:	5f                   	pop    %edi
 7c8:	5d                   	pop    %ebp
 7c9:	c3                   	ret
 7ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 7d0:	39 cf                	cmp    %ecx,%edi
 7d2:	74 4c                	je     820 <malloc+0xe0>
        p->s.size -= nunits;
 7d4:	29 f9                	sub    %edi,%ecx
 7d6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7d9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7dc:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 7df:	89 15 78 09 00 00    	mov    %edx,0x978
}
 7e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 7e8:	83 c0 08             	add    $0x8,%eax
}
 7eb:	5b                   	pop    %ebx
 7ec:	5e                   	pop    %esi
 7ed:	5f                   	pop    %edi
 7ee:	5d                   	pop    %ebp
 7ef:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 7f0:	c7 05 78 09 00 00 7c 	movl   $0x97c,0x978
 7f7:	09 00 00 
    base.s.size = 0;
 7fa:	b8 7c 09 00 00       	mov    $0x97c,%eax
    base.s.ptr = freep = prevp = &base;
 7ff:	c7 05 7c 09 00 00 7c 	movl   $0x97c,0x97c
 806:	09 00 00 
    base.s.size = 0;
 809:	c7 05 80 09 00 00 00 	movl   $0x0,0x980
 810:	00 00 00 
    if(p->s.size >= nunits){
 813:	e9 54 ff ff ff       	jmp    76c <malloc+0x2c>
 818:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 81f:	00 
        prevp->s.ptr = p->s.ptr;
 820:	8b 08                	mov    (%eax),%ecx
 822:	89 0a                	mov    %ecx,(%edx)
 824:	eb b9                	jmp    7df <malloc+0x9f>
