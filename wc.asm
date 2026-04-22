
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "%d %d %d %s\n", l, w, c, name);
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
   e:	bf 01 00 00 00       	mov    $0x1,%edi
  13:	56                   	push   %esi
  14:	53                   	push   %ebx
  15:	51                   	push   %ecx
  16:	83 ec 18             	sub    $0x18,%esp
  19:	8b 01                	mov    (%ecx),%eax
  1b:	8b 71 04             	mov    0x4(%ecx),%esi
  1e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int fd, i;

  if(argc <= 1){
  21:	83 f8 01             	cmp    $0x1,%eax
  24:	7e 58                	jle    7e <main+0x7e>
  26:	66 90                	xchg   %ax,%ax
  28:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  2f:	00 
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  30:	83 ec 08             	sub    $0x8,%esp
  33:	6a 00                	push   $0x0
  35:	ff 34 be             	push   (%esi,%edi,4)
  38:	e8 f6 03 00 00       	call   433 <open>
  3d:	83 c4 10             	add    $0x10,%esp
  40:	89 c3                	mov    %eax,%ebx
      printf(1, "wc: cannot open %s\n", argv[i]);
  42:	8b 04 be             	mov    (%esi,%edi,4),%eax
    if((fd = open(argv[i], 0)) < 0){
  45:	85 db                	test   %ebx,%ebx
  47:	78 22                	js     6b <main+0x6b>
      exit();
    }
    wc(fd, argv[i]);
  49:	83 ec 08             	sub    $0x8,%esp
  for(i = 1; i < argc; i++){
  4c:	83 c7 01             	add    $0x1,%edi
    wc(fd, argv[i]);
  4f:	50                   	push   %eax
  50:	53                   	push   %ebx
  51:	e8 4a 00 00 00       	call   a0 <wc>
    close(fd);
  56:	89 1c 24             	mov    %ebx,(%esp)
  59:	e8 bd 03 00 00       	call   41b <close>
  for(i = 1; i < argc; i++){
  5e:	83 c4 10             	add    $0x10,%esp
  61:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
  64:	75 ca                	jne    30 <main+0x30>
  }
  exit();
  66:	e8 88 03 00 00       	call   3f3 <exit>
      printf(1, "wc: cannot open %s\n", argv[i]);
  6b:	52                   	push   %edx
  6c:	50                   	push   %eax
  6d:	68 0b 09 00 00       	push   $0x90b
  72:	6a 01                	push   $0x1
  74:	e8 07 05 00 00       	call   580 <printf>
      exit();
  79:	e8 75 03 00 00       	call   3f3 <exit>
    wc(0, "");
  7e:	51                   	push   %ecx
  7f:	51                   	push   %ecx
  80:	68 fd 08 00 00       	push   $0x8fd
  85:	6a 00                	push   $0x0
  87:	e8 14 00 00 00       	call   a0 <wc>
    exit();
  8c:	e8 62 03 00 00       	call   3f3 <exit>
  91:	66 90                	xchg   %ax,%ax
  93:	66 90                	xchg   %ax,%ax
  95:	66 90                	xchg   %ax,%ax
  97:	66 90                	xchg   %ax,%ax
  99:	66 90                	xchg   %ax,%ax
  9b:	66 90                	xchg   %ax,%ax
  9d:	66 90                	xchg   %ax,%ax
  9f:	90                   	nop

000000a0 <wc>:
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	57                   	push   %edi
  a4:	56                   	push   %esi
  inword = 0;
  a5:	31 f6                	xor    %esi,%esi
{
  a7:	53                   	push   %ebx
  l = w = c = 0;
  a8:	31 db                	xor    %ebx,%ebx
{
  aa:	83 ec 1c             	sub    $0x1c,%esp
  l = w = c = 0;
  ad:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  b4:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  while((n = read(fd, buf, sizeof(buf))) > 0){
  c0:	83 ec 04             	sub    $0x4,%esp
  c3:	68 00 02 00 00       	push   $0x200
  c8:	68 a0 09 00 00       	push   $0x9a0
  cd:	ff 75 08             	push   0x8(%ebp)
  d0:	e8 36 03 00 00       	call   40b <read>
  d5:	83 c4 10             	add    $0x10,%esp
  d8:	85 c0                	test   %eax,%eax
  da:	7e 64                	jle    140 <wc+0xa0>
    for(i=0; i<n; i++){
  dc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  df:	31 ff                	xor    %edi,%edi
  e1:	eb 0f                	jmp    f2 <wc+0x52>
  e3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        inword = 0;
  e8:	31 f6                	xor    %esi,%esi
    for(i=0; i<n; i++){
  ea:	83 c7 01             	add    $0x1,%edi
  ed:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
  f0:	74 43                	je     135 <wc+0x95>
      if(buf[i] == '\n')
  f2:	0f be 87 a0 09 00 00 	movsbl 0x9a0(%edi),%eax
        l++;
  f9:	31 c9                	xor    %ecx,%ecx
  fb:	3c 0a                	cmp    $0xa,%al
  fd:	0f 94 c1             	sete   %cl
      if(strchr(" \r\t\n\v", buf[i]))
 100:	83 ec 08             	sub    $0x8,%esp
 103:	50                   	push   %eax
        l++;
 104:	01 cb                	add    %ecx,%ebx
      if(strchr(" \r\t\n\v", buf[i]))
 106:	68 e8 08 00 00       	push   $0x8e8
 10b:	e8 60 01 00 00       	call   270 <strchr>
 110:	83 c4 10             	add    $0x10,%esp
 113:	85 c0                	test   %eax,%eax
 115:	75 d1                	jne    e8 <wc+0x48>
        inword = 1;
 117:	8b 55 e0             	mov    -0x20(%ebp),%edx
 11a:	85 f6                	test   %esi,%esi
 11c:	8d 42 01             	lea    0x1(%edx),%eax
 11f:	0f 45 c2             	cmovne %edx,%eax
 122:	89 45 e0             	mov    %eax,-0x20(%ebp)
 125:	b8 01 00 00 00       	mov    $0x1,%eax
 12a:	0f 44 f0             	cmove  %eax,%esi
    for(i=0; i<n; i++){
 12d:	83 c7 01             	add    $0x1,%edi
 130:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
 133:	75 bd                	jne    f2 <wc+0x52>
 135:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
 138:	01 4d dc             	add    %ecx,-0x24(%ebp)
 13b:	eb 83                	jmp    c0 <wc+0x20>
 13d:	8d 76 00             	lea    0x0(%esi),%esi
  if(n < 0){
 140:	8b 55 dc             	mov    -0x24(%ebp),%edx
 143:	75 22                	jne    167 <wc+0xc7>
  printf(1, "%d %d %d %s\n", l, w, c, name);
 145:	83 ec 08             	sub    $0x8,%esp
 148:	ff 75 0c             	push   0xc(%ebp)
 14b:	52                   	push   %edx
 14c:	ff 75 e0             	push   -0x20(%ebp)
 14f:	53                   	push   %ebx
 150:	68 fe 08 00 00       	push   $0x8fe
 155:	6a 01                	push   $0x1
 157:	e8 24 04 00 00       	call   580 <printf>
}
 15c:	83 c4 20             	add    $0x20,%esp
 15f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 162:	5b                   	pop    %ebx
 163:	5e                   	pop    %esi
 164:	5f                   	pop    %edi
 165:	5d                   	pop    %ebp
 166:	c3                   	ret
    printf(1, "wc: read error\n");
 167:	50                   	push   %eax
 168:	50                   	push   %eax
 169:	68 ee 08 00 00       	push   $0x8ee
 16e:	6a 01                	push   $0x1
 170:	e8 0b 04 00 00       	call   580 <printf>
    exit();
 175:	e8 79 02 00 00       	call   3f3 <exit>
 17a:	66 90                	xchg   %ax,%ax
 17c:	66 90                	xchg   %ax,%ax
 17e:	66 90                	xchg   %ax,%ax

00000180 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 180:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 181:	31 c0                	xor    %eax,%eax
{
 183:	89 e5                	mov    %esp,%ebp
 185:	53                   	push   %ebx
 186:	8b 4d 08             	mov    0x8(%ebp),%ecx
 189:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 190:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 194:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 197:	83 c0 01             	add    $0x1,%eax
 19a:	84 d2                	test   %dl,%dl
 19c:	75 f2                	jne    190 <strcpy+0x10>
    ;
  return os;
}
 19e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1a1:	89 c8                	mov    %ecx,%eax
 1a3:	c9                   	leave
 1a4:	c3                   	ret
 1a5:	8d 76 00             	lea    0x0(%esi),%esi
 1a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1af:	00 

000001b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	53                   	push   %ebx
 1b4:	8b 55 08             	mov    0x8(%ebp),%edx
 1b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 1ba:	0f b6 02             	movzbl (%edx),%eax
 1bd:	84 c0                	test   %al,%al
 1bf:	75 2d                	jne    1ee <strcmp+0x3e>
 1c1:	eb 4a                	jmp    20d <strcmp+0x5d>
 1c3:	eb 1b                	jmp    1e0 <strcmp+0x30>
 1c5:	8d 76 00             	lea    0x0(%esi),%esi
 1c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1cf:	00 
 1d0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1d7:	00 
 1d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1df:	00 
 1e0:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 1e4:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 1e7:	84 c0                	test   %al,%al
 1e9:	74 15                	je     200 <strcmp+0x50>
 1eb:	83 c1 01             	add    $0x1,%ecx
 1ee:	0f b6 19             	movzbl (%ecx),%ebx
 1f1:	38 c3                	cmp    %al,%bl
 1f3:	74 eb                	je     1e0 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
 1f5:	29 d8                	sub    %ebx,%eax
}
 1f7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1fa:	c9                   	leave
 1fb:	c3                   	ret
 1fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return (uchar)*p - (uchar)*q;
 200:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 204:	31 c0                	xor    %eax,%eax
 206:	29 d8                	sub    %ebx,%eax
}
 208:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 20b:	c9                   	leave
 20c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 20d:	0f b6 19             	movzbl (%ecx),%ebx
 210:	31 c0                	xor    %eax,%eax
 212:	eb e1                	jmp    1f5 <strcmp+0x45>
 214:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 218:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 21f:	00 

00000220 <strlen>:

uint
strlen(const char *s)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 226:	80 3a 00             	cmpb   $0x0,(%edx)
 229:	74 15                	je     240 <strlen+0x20>
 22b:	31 c0                	xor    %eax,%eax
 22d:	8d 76 00             	lea    0x0(%esi),%esi
 230:	83 c0 01             	add    $0x1,%eax
 233:	89 c1                	mov    %eax,%ecx
 235:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 239:	75 f5                	jne    230 <strlen+0x10>
    ;
  return n;
}
 23b:	89 c8                	mov    %ecx,%eax
 23d:	5d                   	pop    %ebp
 23e:	c3                   	ret
 23f:	90                   	nop
  for(n = 0; s[n]; n++)
 240:	31 c9                	xor    %ecx,%ecx
}
 242:	5d                   	pop    %ebp
 243:	89 c8                	mov    %ecx,%eax
 245:	c3                   	ret
 246:	66 90                	xchg   %ax,%ax
 248:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 24f:	00 

00000250 <memset>:

void*
memset(void *dst, int c, uint n)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 254:	8b 4d 10             	mov    0x10(%ebp),%ecx
 257:	8b 45 0c             	mov    0xc(%ebp),%eax
 25a:	8b 7d 08             	mov    0x8(%ebp),%edi
 25d:	fc                   	cld
 25e:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 260:	8b 45 08             	mov    0x8(%ebp),%eax
 263:	8b 7d fc             	mov    -0x4(%ebp),%edi
 266:	c9                   	leave
 267:	c3                   	ret
 268:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 26f:	00 

00000270 <strchr>:

char*
strchr(const char *s, char c)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	8b 45 08             	mov    0x8(%ebp),%eax
 276:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 27a:	0f b6 10             	movzbl (%eax),%edx
 27d:	84 d2                	test   %dl,%dl
 27f:	75 1a                	jne    29b <strchr+0x2b>
 281:	eb 25                	jmp    2a8 <strchr+0x38>
 283:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 288:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 28f:	00 
 290:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 294:	83 c0 01             	add    $0x1,%eax
 297:	84 d2                	test   %dl,%dl
 299:	74 0d                	je     2a8 <strchr+0x38>
    if(*s == c)
 29b:	38 d1                	cmp    %dl,%cl
 29d:	75 f1                	jne    290 <strchr+0x20>
      return (char*)s;
  return 0;
}
 29f:	5d                   	pop    %ebp
 2a0:	c3                   	ret
 2a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 2a8:	31 c0                	xor    %eax,%eax
}
 2aa:	5d                   	pop    %ebp
 2ab:	c3                   	ret
 2ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002b0 <gets>:

char*
gets(char *buf, int max)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	57                   	push   %edi
 2b4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 2b5:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 2b8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 2b9:	31 db                	xor    %ebx,%ebx
{
 2bb:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 2be:	eb 27                	jmp    2e7 <gets+0x37>
    cc = read(0, &c, 1);
 2c0:	83 ec 04             	sub    $0x4,%esp
 2c3:	6a 01                	push   $0x1
 2c5:	57                   	push   %edi
 2c6:	6a 00                	push   $0x0
 2c8:	e8 3e 01 00 00       	call   40b <read>
    if(cc < 1)
 2cd:	83 c4 10             	add    $0x10,%esp
 2d0:	85 c0                	test   %eax,%eax
 2d2:	7e 1d                	jle    2f1 <gets+0x41>
      break;
    buf[i++] = c;
 2d4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2d8:	8b 55 08             	mov    0x8(%ebp),%edx
 2db:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 2df:	3c 0a                	cmp    $0xa,%al
 2e1:	74 1d                	je     300 <gets+0x50>
 2e3:	3c 0d                	cmp    $0xd,%al
 2e5:	74 19                	je     300 <gets+0x50>
  for(i=0; i+1 < max; ){
 2e7:	89 de                	mov    %ebx,%esi
 2e9:	83 c3 01             	add    $0x1,%ebx
 2ec:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2ef:	7c cf                	jl     2c0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 2f1:	8b 45 08             	mov    0x8(%ebp),%eax
 2f4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 2f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2fb:	5b                   	pop    %ebx
 2fc:	5e                   	pop    %esi
 2fd:	5f                   	pop    %edi
 2fe:	5d                   	pop    %ebp
 2ff:	c3                   	ret
  buf[i] = '\0';
 300:	8b 45 08             	mov    0x8(%ebp),%eax
    buf[i++] = c;
 303:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 305:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 309:	8d 65 f4             	lea    -0xc(%ebp),%esp
 30c:	5b                   	pop    %ebx
 30d:	5e                   	pop    %esi
 30e:	5f                   	pop    %edi
 30f:	5d                   	pop    %ebp
 310:	c3                   	ret
 311:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 318:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 31f:	00 

00000320 <stat>:

int
stat(const char *n, struct stat *st)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	56                   	push   %esi
 324:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 325:	83 ec 08             	sub    $0x8,%esp
 328:	6a 00                	push   $0x0
 32a:	ff 75 08             	push   0x8(%ebp)
 32d:	e8 01 01 00 00       	call   433 <open>
  if(fd < 0)
 332:	83 c4 10             	add    $0x10,%esp
 335:	85 c0                	test   %eax,%eax
 337:	78 27                	js     360 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 339:	83 ec 08             	sub    $0x8,%esp
 33c:	ff 75 0c             	push   0xc(%ebp)
 33f:	89 c3                	mov    %eax,%ebx
 341:	50                   	push   %eax
 342:	e8 04 01 00 00       	call   44b <fstat>
  close(fd);
 347:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 34a:	89 c6                	mov    %eax,%esi
  close(fd);
 34c:	e8 ca 00 00 00       	call   41b <close>
  return r;
 351:	83 c4 10             	add    $0x10,%esp
}
 354:	8d 65 f8             	lea    -0x8(%ebp),%esp
 357:	89 f0                	mov    %esi,%eax
 359:	5b                   	pop    %ebx
 35a:	5e                   	pop    %esi
 35b:	5d                   	pop    %ebp
 35c:	c3                   	ret
 35d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 360:	be ff ff ff ff       	mov    $0xffffffff,%esi
 365:	eb ed                	jmp    354 <stat+0x34>
 367:	90                   	nop
 368:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 36f:	00 

00000370 <atoi>:

int
atoi(const char *s)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	53                   	push   %ebx
 374:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 377:	0f be 02             	movsbl (%edx),%eax
 37a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 37d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 380:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 385:	77 2e                	ja     3b5 <atoi+0x45>
 387:	eb 17                	jmp    3a0 <atoi+0x30>
 389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 390:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 397:	00 
 398:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 39f:	00 
    n = n*10 + *s++ - '0';
 3a0:	83 c2 01             	add    $0x1,%edx
 3a3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 3a6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 3aa:	0f be 02             	movsbl (%edx),%eax
 3ad:	8d 58 d0             	lea    -0x30(%eax),%ebx
 3b0:	80 fb 09             	cmp    $0x9,%bl
 3b3:	76 eb                	jbe    3a0 <atoi+0x30>
  return n;
}
 3b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3b8:	89 c8                	mov    %ecx,%eax
 3ba:	c9                   	leave
 3bb:	c3                   	ret
 3bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003c0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	57                   	push   %edi
 3c4:	8b 45 10             	mov    0x10(%ebp),%eax
 3c7:	8b 55 08             	mov    0x8(%ebp),%edx
 3ca:	56                   	push   %esi
 3cb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3ce:	85 c0                	test   %eax,%eax
 3d0:	7e 13                	jle    3e5 <memmove+0x25>
 3d2:	01 d0                	add    %edx,%eax
  dst = vdst;
 3d4:	89 d7                	mov    %edx,%edi
 3d6:	66 90                	xchg   %ax,%ax
 3d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3df:	00 
    *dst++ = *src++;
 3e0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 3e1:	39 f8                	cmp    %edi,%eax
 3e3:	75 fb                	jne    3e0 <memmove+0x20>
  return vdst;
}
 3e5:	5e                   	pop    %esi
 3e6:	89 d0                	mov    %edx,%eax
 3e8:	5f                   	pop    %edi
 3e9:	5d                   	pop    %ebp
 3ea:	c3                   	ret

000003eb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3eb:	b8 01 00 00 00       	mov    $0x1,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret

000003f3 <exit>:
SYSCALL(exit)
 3f3:	b8 02 00 00 00       	mov    $0x2,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret

000003fb <wait>:
SYSCALL(wait)
 3fb:	b8 03 00 00 00       	mov    $0x3,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret

00000403 <pipe>:
SYSCALL(pipe)
 403:	b8 04 00 00 00       	mov    $0x4,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret

0000040b <read>:
SYSCALL(read)
 40b:	b8 05 00 00 00       	mov    $0x5,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret

00000413 <write>:
SYSCALL(write)
 413:	b8 10 00 00 00       	mov    $0x10,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret

0000041b <close>:
SYSCALL(close)
 41b:	b8 15 00 00 00       	mov    $0x15,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret

00000423 <kill>:
SYSCALL(kill)
 423:	b8 06 00 00 00       	mov    $0x6,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret

0000042b <exec>:
SYSCALL(exec)
 42b:	b8 07 00 00 00       	mov    $0x7,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret

00000433 <open>:
SYSCALL(open)
 433:	b8 0f 00 00 00       	mov    $0xf,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret

0000043b <mknod>:
SYSCALL(mknod)
 43b:	b8 11 00 00 00       	mov    $0x11,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret

00000443 <unlink>:
SYSCALL(unlink)
 443:	b8 12 00 00 00       	mov    $0x12,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret

0000044b <fstat>:
SYSCALL(fstat)
 44b:	b8 08 00 00 00       	mov    $0x8,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret

00000453 <link>:
SYSCALL(link)
 453:	b8 13 00 00 00       	mov    $0x13,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret

0000045b <mkdir>:
SYSCALL(mkdir)
 45b:	b8 14 00 00 00       	mov    $0x14,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret

00000463 <chdir>:
SYSCALL(chdir)
 463:	b8 09 00 00 00       	mov    $0x9,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret

0000046b <dup>:
SYSCALL(dup)
 46b:	b8 0a 00 00 00       	mov    $0xa,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret

00000473 <getpid>:
SYSCALL(getpid)
 473:	b8 0b 00 00 00       	mov    $0xb,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret

0000047b <sbrk>:
SYSCALL(sbrk)
 47b:	b8 0c 00 00 00       	mov    $0xc,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret

00000483 <sleep>:
SYSCALL(sleep)
 483:	b8 0d 00 00 00       	mov    $0xd,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret

0000048b <uptime>:
SYSCALL(uptime)
 48b:	b8 0e 00 00 00       	mov    $0xe,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret

00000493 <getprocinfo>:
SYSCALL(getprocinfo)
 493:	b8 16 00 00 00       	mov    $0x16,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret

0000049b <nice>:
SYSCALL(nice)
 49b:	b8 17 00 00 00       	mov    $0x17,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret
 4a3:	66 90                	xchg   %ax,%ax
 4a5:	66 90                	xchg   %ax,%ax
 4a7:	66 90                	xchg   %ax,%ax
 4a9:	66 90                	xchg   %ax,%ax
 4ab:	66 90                	xchg   %ax,%ax
 4ad:	66 90                	xchg   %ax,%ax
 4af:	66 90                	xchg   %ax,%ax
 4b1:	66 90                	xchg   %ax,%ax
 4b3:	66 90                	xchg   %ax,%ax
 4b5:	66 90                	xchg   %ax,%ax
 4b7:	66 90                	xchg   %ax,%ax
 4b9:	66 90                	xchg   %ax,%ax
 4bb:	66 90                	xchg   %ax,%ax
 4bd:	66 90                	xchg   %ax,%ax
 4bf:	90                   	nop

000004c0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	57                   	push   %edi
 4c4:	56                   	push   %esi
 4c5:	53                   	push   %ebx
 4c6:	89 cb                	mov    %ecx,%ebx
 4c8:	83 ec 3c             	sub    $0x3c,%esp
 4cb:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4ce:	85 d2                	test   %edx,%edx
 4d0:	0f 89 9a 00 00 00    	jns    570 <printint+0xb0>
 4d6:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 4da:	0f 84 90 00 00 00    	je     570 <printint+0xb0>
    neg = 1;
    x = -xx;
 4e0:	f7 da                	neg    %edx
    neg = 1;
 4e2:	b8 01 00 00 00       	mov    $0x1,%eax
 4e7:	89 45 c0             	mov    %eax,-0x40(%ebp)
 4ea:	89 d1                	mov    %edx,%ecx
  } else {
    x = xx;
  }

  i = 0;
 4ec:	31 f6                	xor    %esi,%esi
 4ee:	66 90                	xchg   %ax,%ax
 4f0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4f7:	00 
 4f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4ff:	00 
  do{
    buf[i++] = digits[x % base];
 500:	89 c8                	mov    %ecx,%eax
 502:	31 d2                	xor    %edx,%edx
 504:	89 f7                	mov    %esi,%edi
 506:	f7 f3                	div    %ebx
 508:	8d 76 01             	lea    0x1(%esi),%esi
  }while((x /= base) != 0);
 50b:	39 d9                	cmp    %ebx,%ecx
    buf[i++] = digits[x % base];
 50d:	0f b6 92 80 09 00 00 	movzbl 0x980(%edx),%edx
  }while((x /= base) != 0);
 514:	89 c1                	mov    %eax,%ecx
    buf[i++] = digits[x % base];
 516:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 51a:	73 e4                	jae    500 <printint+0x40>
  if(neg)
 51c:	8b 45 c0             	mov    -0x40(%ebp),%eax
 51f:	85 c0                	test   %eax,%eax
 521:	74 07                	je     52a <printint+0x6a>
    buf[i++] = '-';
 523:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 528:	89 f7                	mov    %esi,%edi

  while(--i >= 0)
 52a:	8d 74 3d d8          	lea    -0x28(%ebp,%edi,1),%esi
 52e:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 531:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 534:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 538:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 53f:	00 
    putc(fd, buf[i]);
 540:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 543:	83 ec 04             	sub    $0x4,%esp
  while(--i >= 0)
 546:	83 ee 01             	sub    $0x1,%esi
 549:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 54c:	8d 45 d7             	lea    -0x29(%ebp),%eax
 54f:	6a 01                	push   $0x1
 551:	50                   	push   %eax
 552:	57                   	push   %edi
 553:	e8 bb fe ff ff       	call   413 <write>
  while(--i >= 0)
 558:	83 c4 10             	add    $0x10,%esp
 55b:	39 f3                	cmp    %esi,%ebx
 55d:	75 e1                	jne    540 <printint+0x80>
}
 55f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 562:	5b                   	pop    %ebx
 563:	5e                   	pop    %esi
 564:	5f                   	pop    %edi
 565:	5d                   	pop    %ebp
 566:	c3                   	ret
 567:	90                   	nop
 568:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 56f:	00 
  neg = 0;
 570:	31 c0                	xor    %eax,%eax
 572:	e9 70 ff ff ff       	jmp    4e7 <printint+0x27>
 577:	90                   	nop
 578:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 57f:	00 

00000580 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	57                   	push   %edi
 584:	56                   	push   %esi
 585:	53                   	push   %ebx
 586:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 589:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 58c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 58f:	0f b6 13             	movzbl (%ebx),%edx
 592:	83 c3 01             	add    $0x1,%ebx
 595:	84 d2                	test   %dl,%dl
 597:	0f 84 a0 00 00 00    	je     63d <printf+0xbd>
 59d:	8d 45 10             	lea    0x10(%ebp),%eax
 5a0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    c = fmt[i] & 0xff;
 5a3:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 5a6:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 5a9:	eb 28                	jmp    5d3 <printf+0x53>
 5ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 5b0:	83 ec 04             	sub    $0x4,%esp
 5b3:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5b6:	88 55 e7             	mov    %dl,-0x19(%ebp)
  for(i = 0; fmt[i]; i++){
 5b9:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 5bc:	6a 01                	push   $0x1
 5be:	50                   	push   %eax
 5bf:	56                   	push   %esi
 5c0:	e8 4e fe ff ff       	call   413 <write>
  for(i = 0; fmt[i]; i++){
 5c5:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 5c9:	83 c4 10             	add    $0x10,%esp
 5cc:	84 d2                	test   %dl,%dl
 5ce:	74 6d                	je     63d <printf+0xbd>
    c = fmt[i] & 0xff;
 5d0:	0f b6 c2             	movzbl %dl,%eax
      if(c == '%'){
 5d3:	83 f8 25             	cmp    $0x25,%eax
 5d6:	75 d8                	jne    5b0 <printf+0x30>
  for(i = 0; fmt[i]; i++){
 5d8:	0f b6 13             	movzbl (%ebx),%edx
 5db:	84 d2                	test   %dl,%dl
 5dd:	74 5e                	je     63d <printf+0xbd>
    c = fmt[i] & 0xff;
 5df:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 5e2:	80 fa 25             	cmp    $0x25,%dl
 5e5:	0f 84 25 01 00 00    	je     710 <printf+0x190>
 5eb:	83 e8 63             	sub    $0x63,%eax
 5ee:	83 f8 15             	cmp    $0x15,%eax
 5f1:	77 0d                	ja     600 <printf+0x80>
 5f3:	ff 24 85 28 09 00 00 	jmp    *0x928(,%eax,4)
 5fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 600:	83 ec 04             	sub    $0x4,%esp
 603:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 606:	88 55 d0             	mov    %dl,-0x30(%ebp)
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 609:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 60d:	6a 01                	push   $0x1
 60f:	51                   	push   %ecx
 610:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 613:	56                   	push   %esi
 614:	e8 fa fd ff ff       	call   413 <write>
        putc(fd, c);
 619:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
  write(fd, &c, 1);
 61d:	83 c4 0c             	add    $0xc,%esp
 620:	88 55 e7             	mov    %dl,-0x19(%ebp)
 623:	6a 01                	push   $0x1
 625:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 628:	51                   	push   %ecx
  for(i = 0; fmt[i]; i++){
 629:	83 c3 02             	add    $0x2,%ebx
  write(fd, &c, 1);
 62c:	56                   	push   %esi
 62d:	e8 e1 fd ff ff       	call   413 <write>
  for(i = 0; fmt[i]; i++){
 632:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 636:	83 c4 10             	add    $0x10,%esp
 639:	84 d2                	test   %dl,%dl
 63b:	75 93                	jne    5d0 <printf+0x50>
      }
      state = 0;
    }
  }
}
 63d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 640:	5b                   	pop    %ebx
 641:	5e                   	pop    %esi
 642:	5f                   	pop    %edi
 643:	5d                   	pop    %ebp
 644:	c3                   	ret
 645:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 648:	83 ec 0c             	sub    $0xc,%esp
 64b:	8b 17                	mov    (%edi),%edx
 64d:	b9 10 00 00 00       	mov    $0x10,%ecx
 652:	89 f0                	mov    %esi,%eax
 654:	6a 00                	push   $0x0
 656:	e8 65 fe ff ff       	call   4c0 <printint>
  for(i = 0; fmt[i]; i++){
 65b:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 65f:	83 c3 02             	add    $0x2,%ebx
 662:	83 c4 10             	add    $0x10,%esp
 665:	84 d2                	test   %dl,%dl
 667:	74 d4                	je     63d <printf+0xbd>
        ap++;
 669:	83 c7 04             	add    $0x4,%edi
 66c:	e9 5f ff ff ff       	jmp    5d0 <printf+0x50>
 671:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 678:	8b 07                	mov    (%edi),%eax
        ap++;
 67a:	83 c7 04             	add    $0x4,%edi
        if(s == 0)
 67d:	85 c0                	test   %eax,%eax
 67f:	0f 84 9b 00 00 00    	je     720 <printf+0x1a0>
        while(*s != 0){
 685:	0f b6 10             	movzbl (%eax),%edx
 688:	84 d2                	test   %dl,%dl
 68a:	0f 84 a2 00 00 00    	je     732 <printf+0x1b2>
 690:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 693:	89 c7                	mov    %eax,%edi
 695:	89 d0                	mov    %edx,%eax
 697:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 69a:	89 fb                	mov    %edi,%ebx
 69c:	8d 7d e7             	lea    -0x19(%ebp),%edi
 69f:	90                   	nop
  write(fd, &c, 1);
 6a0:	83 ec 04             	sub    $0x4,%esp
 6a3:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 6a6:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 6a9:	6a 01                	push   $0x1
 6ab:	57                   	push   %edi
 6ac:	56                   	push   %esi
 6ad:	e8 61 fd ff ff       	call   413 <write>
        while(*s != 0){
 6b2:	0f b6 03             	movzbl (%ebx),%eax
 6b5:	83 c4 10             	add    $0x10,%esp
 6b8:	84 c0                	test   %al,%al
 6ba:	75 e4                	jne    6a0 <printf+0x120>
 6bc:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 6bf:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 6c3:	83 c3 02             	add    $0x2,%ebx
 6c6:	84 d2                	test   %dl,%dl
 6c8:	0f 85 d5 fe ff ff    	jne    5a3 <printf+0x23>
 6ce:	e9 6a ff ff ff       	jmp    63d <printf+0xbd>
 6d3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 6d8:	83 ec 0c             	sub    $0xc,%esp
 6db:	8b 17                	mov    (%edi),%edx
 6dd:	b9 0a 00 00 00       	mov    $0xa,%ecx
 6e2:	89 f0                	mov    %esi,%eax
 6e4:	6a 01                	push   $0x1
 6e6:	e8 d5 fd ff ff       	call   4c0 <printint>
  for(i = 0; fmt[i]; i++){
 6eb:	e9 6b ff ff ff       	jmp    65b <printf+0xdb>
        putc(fd, *ap);
 6f0:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 6f2:	83 ec 04             	sub    $0x4,%esp
 6f5:	8d 4d e7             	lea    -0x19(%ebp),%ecx
        putc(fd, *ap);
 6f8:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6fb:	6a 01                	push   $0x1
 6fd:	51                   	push   %ecx
 6fe:	56                   	push   %esi
 6ff:	e8 0f fd ff ff       	call   413 <write>
 704:	e9 52 ff ff ff       	jmp    65b <printf+0xdb>
 709:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 710:	83 ec 04             	sub    $0x4,%esp
 713:	88 55 e7             	mov    %dl,-0x19(%ebp)
 716:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 719:	6a 01                	push   $0x1
 71b:	e9 08 ff ff ff       	jmp    628 <printf+0xa8>
          s = "(null)";
 720:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 723:	b8 28 00 00 00       	mov    $0x28,%eax
 728:	bf 1f 09 00 00       	mov    $0x91f,%edi
 72d:	e9 65 ff ff ff       	jmp    697 <printf+0x117>
  for(i = 0; fmt[i]; i++){
 732:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 736:	83 c3 02             	add    $0x2,%ebx
 739:	84 d2                	test   %dl,%dl
 73b:	0f 85 8f fe ff ff    	jne    5d0 <printf+0x50>
 741:	e9 f7 fe ff ff       	jmp    63d <printf+0xbd>
 746:	66 90                	xchg   %ax,%ax
 748:	66 90                	xchg   %ax,%ax
 74a:	66 90                	xchg   %ax,%ax
 74c:	66 90                	xchg   %ax,%ax
 74e:	66 90                	xchg   %ax,%ax
 750:	66 90                	xchg   %ax,%ax
 752:	66 90                	xchg   %ax,%ax
 754:	66 90                	xchg   %ax,%ax
 756:	66 90                	xchg   %ax,%ax
 758:	66 90                	xchg   %ax,%ax
 75a:	66 90                	xchg   %ax,%ax
 75c:	66 90                	xchg   %ax,%ax
 75e:	66 90                	xchg   %ax,%ax

00000760 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 760:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 761:	a1 a0 0b 00 00       	mov    0xba0,%eax
{
 766:	89 e5                	mov    %esp,%ebp
 768:	57                   	push   %edi
 769:	56                   	push   %esi
 76a:	53                   	push   %ebx
 76b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 76e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 771:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 778:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 77f:	00 
 780:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 782:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 784:	39 ca                	cmp    %ecx,%edx
 786:	73 30                	jae    7b8 <free+0x58>
 788:	39 c1                	cmp    %eax,%ecx
 78a:	72 04                	jb     790 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 78c:	39 c2                	cmp    %eax,%edx
 78e:	72 f0                	jb     780 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 790:	8b 73 fc             	mov    -0x4(%ebx),%esi
 793:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 796:	39 f8                	cmp    %edi,%eax
 798:	74 36                	je     7d0 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 79a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 79d:	8b 42 04             	mov    0x4(%edx),%eax
 7a0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 7a3:	39 f1                	cmp    %esi,%ecx
 7a5:	74 40                	je     7e7 <free+0x87>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 7a7:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 7a9:	5b                   	pop    %ebx
  freep = p;
 7aa:	89 15 a0 0b 00 00    	mov    %edx,0xba0
}
 7b0:	5e                   	pop    %esi
 7b1:	5f                   	pop    %edi
 7b2:	5d                   	pop    %ebp
 7b3:	c3                   	ret
 7b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7b8:	39 c2                	cmp    %eax,%edx
 7ba:	72 c4                	jb     780 <free+0x20>
 7bc:	39 c1                	cmp    %eax,%ecx
 7be:	73 c0                	jae    780 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 7c0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7c3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 7c6:	39 f8                	cmp    %edi,%eax
 7c8:	75 d0                	jne    79a <free+0x3a>
 7ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 7d0:	03 70 04             	add    0x4(%eax),%esi
 7d3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7d6:	8b 02                	mov    (%edx),%eax
 7d8:	8b 00                	mov    (%eax),%eax
 7da:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 7dd:	8b 42 04             	mov    0x4(%edx),%eax
 7e0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 7e3:	39 f1                	cmp    %esi,%ecx
 7e5:	75 c0                	jne    7a7 <free+0x47>
    p->s.size += bp->s.size;
 7e7:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 7ea:	89 15 a0 0b 00 00    	mov    %edx,0xba0
    p->s.size += bp->s.size;
 7f0:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 7f3:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 7f6:	89 0a                	mov    %ecx,(%edx)
}
 7f8:	5b                   	pop    %ebx
 7f9:	5e                   	pop    %esi
 7fa:	5f                   	pop    %edi
 7fb:	5d                   	pop    %ebp
 7fc:	c3                   	ret
 7fd:	8d 76 00             	lea    0x0(%esi),%esi

00000800 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 800:	55                   	push   %ebp
 801:	89 e5                	mov    %esp,%ebp
 803:	57                   	push   %edi
 804:	56                   	push   %esi
 805:	53                   	push   %ebx
 806:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 809:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 80c:	8b 15 a0 0b 00 00    	mov    0xba0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 812:	8d 78 07             	lea    0x7(%eax),%edi
 815:	c1 ef 03             	shr    $0x3,%edi
 818:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 81b:	85 d2                	test   %edx,%edx
 81d:	0f 84 8d 00 00 00    	je     8b0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 823:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 825:	8b 48 04             	mov    0x4(%eax),%ecx
 828:	39 f9                	cmp    %edi,%ecx
 82a:	73 64                	jae    890 <malloc+0x90>
  if(nu < 4096)
 82c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 831:	39 df                	cmp    %ebx,%edi
 833:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 836:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 83d:	eb 0a                	jmp    849 <malloc+0x49>
 83f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 840:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 842:	8b 48 04             	mov    0x4(%eax),%ecx
 845:	39 f9                	cmp    %edi,%ecx
 847:	73 47                	jae    890 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 849:	89 c2                	mov    %eax,%edx
 84b:	39 05 a0 0b 00 00    	cmp    %eax,0xba0
 851:	75 ed                	jne    840 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 853:	83 ec 0c             	sub    $0xc,%esp
 856:	56                   	push   %esi
 857:	e8 1f fc ff ff       	call   47b <sbrk>
  if(p == (char*)-1)
 85c:	83 c4 10             	add    $0x10,%esp
 85f:	83 f8 ff             	cmp    $0xffffffff,%eax
 862:	74 1c                	je     880 <malloc+0x80>
  hp->s.size = nu;
 864:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 867:	83 ec 0c             	sub    $0xc,%esp
 86a:	83 c0 08             	add    $0x8,%eax
 86d:	50                   	push   %eax
 86e:	e8 ed fe ff ff       	call   760 <free>
  return freep;
 873:	8b 15 a0 0b 00 00    	mov    0xba0,%edx
      if((p = morecore(nunits)) == 0)
 879:	83 c4 10             	add    $0x10,%esp
 87c:	85 d2                	test   %edx,%edx
 87e:	75 c0                	jne    840 <malloc+0x40>
        return 0;
  }
}
 880:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 883:	31 c0                	xor    %eax,%eax
}
 885:	5b                   	pop    %ebx
 886:	5e                   	pop    %esi
 887:	5f                   	pop    %edi
 888:	5d                   	pop    %ebp
 889:	c3                   	ret
 88a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 890:	39 cf                	cmp    %ecx,%edi
 892:	74 4c                	je     8e0 <malloc+0xe0>
        p->s.size -= nunits;
 894:	29 f9                	sub    %edi,%ecx
 896:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 899:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 89c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 89f:	89 15 a0 0b 00 00    	mov    %edx,0xba0
}
 8a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 8a8:	83 c0 08             	add    $0x8,%eax
}
 8ab:	5b                   	pop    %ebx
 8ac:	5e                   	pop    %esi
 8ad:	5f                   	pop    %edi
 8ae:	5d                   	pop    %ebp
 8af:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 8b0:	c7 05 a0 0b 00 00 a4 	movl   $0xba4,0xba0
 8b7:	0b 00 00 
    base.s.size = 0;
 8ba:	b8 a4 0b 00 00       	mov    $0xba4,%eax
    base.s.ptr = freep = prevp = &base;
 8bf:	c7 05 a4 0b 00 00 a4 	movl   $0xba4,0xba4
 8c6:	0b 00 00 
    base.s.size = 0;
 8c9:	c7 05 a8 0b 00 00 00 	movl   $0x0,0xba8
 8d0:	00 00 00 
    if(p->s.size >= nunits){
 8d3:	e9 54 ff ff ff       	jmp    82c <malloc+0x2c>
 8d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 8df:	00 
        prevp->s.ptr = p->s.ptr;
 8e0:	8b 08                	mov    (%eax),%ecx
 8e2:	89 0a                	mov    %ecx,(%edx)
 8e4:	eb b9                	jmp    89f <malloc+0x9f>
