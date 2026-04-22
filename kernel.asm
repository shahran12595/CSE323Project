
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc f0 67 11 80       	mov    $0x801167f0,%esp
8010002d:	b8 d0 32 10 80       	mov    $0x801032d0,%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb 54 b5 10 80       	mov    $0x8010b554,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 e0 78 10 80       	push   $0x801078e0
80100051:	68 20 b5 10 80       	push   $0x8010b520
80100056:	e8 65 49 00 00       	call   801049c0 <initlock>
  bcache.head.next = &bcache.head;
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 1c fc 10 80       	mov    $0x8010fc1c,%eax
  bcache.head.prev = &bcache.head;
80100063:	c7 05 6c fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc6c
8010006a:	fc 10 80 
  bcache.head.next = &bcache.head;
8010006d:	c7 05 70 fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc70
80100074:	fc 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100077:	eb 0d                	jmp    80100086 <binit+0x46>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	81 c3 5c 02 00 00    	add    $0x25c,%ebx
    b->next = bcache.head.next;
80100086:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100089:	83 ec 08             	sub    $0x8,%esp
8010008c:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->prev = &bcache.head;
8010008f:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100096:	68 e7 78 10 80       	push   $0x801078e7
8010009b:	50                   	push   %eax
8010009c:	e8 df 47 00 00       	call   80104880 <initsleeplock>
    bcache.head.next->prev = b;
801000a1:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a6:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000a9:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ac:	89 d8                	mov    %ebx,%eax
801000ae:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b4:	81 fb c0 f9 10 80    	cmp    $0x8010f9c0,%ebx
801000ba:	75 c4                	jne    80100080 <binit+0x40>
  }
}
801000bc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000bf:	c9                   	leave
801000c0:	c3                   	ret
801000c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801000cf:	00 

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 20 b5 10 80       	push   $0x8010b520
801000e4:	e8 f7 4a 00 00       	call   80104be0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 70 fc 10 80    	mov    0x8010fc70,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100119:	eb 4f                	jmp    8010016a <bread+0x9a>
8010011b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 6c fc 10 80    	mov    0x8010fc6c,%ebx
80100126:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
8010012c:	75 1d                	jne    8010014b <bread+0x7b>
8010012e:	eb 7e                	jmp    801001ae <bread+0xde>
80100130:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100137:	00 
80100138:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010013f:	00 
80100140:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100143:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100149:	74 63                	je     801001ae <bread+0xde>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010014b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010014e:	85 c0                	test   %eax,%eax
80100150:	75 ee                	jne    80100140 <bread+0x70>
80100152:	f6 03 04             	testb  $0x4,(%ebx)
80100155:	75 e9                	jne    80100140 <bread+0x70>
      b->dev = dev;
80100157:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010015a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010015d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100163:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010016a:	83 ec 0c             	sub    $0xc,%esp
8010016d:	68 20 b5 10 80       	push   $0x8010b520
80100172:	e8 09 4a 00 00       	call   80104b80 <release>
      acquiresleep(&b->lock);
80100177:	8d 43 0c             	lea    0xc(%ebx),%eax
8010017a:	89 04 24             	mov    %eax,(%esp)
8010017d:	e8 3e 47 00 00       	call   801048c0 <acquiresleep>
      return b;
80100182:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100185:	f6 03 02             	testb  $0x2,(%ebx)
80100188:	74 0e                	je     80100198 <bread+0xc8>
    iderw(b);
  }
  return b;
}
8010018a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010018d:	89 d8                	mov    %ebx,%eax
8010018f:	5b                   	pop    %ebx
80100190:	5e                   	pop    %esi
80100191:	5f                   	pop    %edi
80100192:	5d                   	pop    %ebp
80100193:	c3                   	ret
80100194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iderw(b);
80100198:	83 ec 0c             	sub    $0xc,%esp
8010019b:	53                   	push   %ebx
8010019c:	e8 0f 23 00 00       	call   801024b0 <iderw>
801001a1:	83 c4 10             	add    $0x10,%esp
}
801001a4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801001a7:	89 d8                	mov    %ebx,%eax
801001a9:	5b                   	pop    %ebx
801001aa:	5e                   	pop    %esi
801001ab:	5f                   	pop    %edi
801001ac:	5d                   	pop    %ebp
801001ad:	c3                   	ret
  panic("bget: no buffers");
801001ae:	83 ec 0c             	sub    $0xc,%esp
801001b1:	68 ee 78 10 80       	push   $0x801078ee
801001b6:	e8 e5 01 00 00       	call   801003a0 <panic>
801001bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801001c0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001c0:	55                   	push   %ebp
801001c1:	89 e5                	mov    %esp,%ebp
801001c3:	53                   	push   %ebx
801001c4:	83 ec 10             	sub    $0x10,%esp
801001c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001ca:	8d 43 0c             	lea    0xc(%ebx),%eax
801001cd:	50                   	push   %eax
801001ce:	e8 8d 47 00 00       	call   80104960 <holdingsleep>
801001d3:	83 c4 10             	add    $0x10,%esp
801001d6:	85 c0                	test   %eax,%eax
801001d8:	74 0f                	je     801001e9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001da:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001dd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001e0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001e3:	c9                   	leave
  iderw(b);
801001e4:	e9 c7 22 00 00       	jmp    801024b0 <iderw>
    panic("bwrite");
801001e9:	83 ec 0c             	sub    $0xc,%esp
801001ec:	68 ff 78 10 80       	push   $0x801078ff
801001f1:	e8 aa 01 00 00       	call   801003a0 <panic>
801001f6:	66 90                	xchg   %ax,%ax
801001f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801001ff:	00 

80100200 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
80100200:	55                   	push   %ebp
80100201:	89 e5                	mov    %esp,%ebp
80100203:	56                   	push   %esi
80100204:	53                   	push   %ebx
80100205:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
80100208:	8d 73 0c             	lea    0xc(%ebx),%esi
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 4c 47 00 00       	call   80104960 <holdingsleep>
80100214:	83 c4 10             	add    $0x10,%esp
80100217:	85 c0                	test   %eax,%eax
80100219:	74 63                	je     8010027e <brelse+0x7e>
    panic("brelse");

  releasesleep(&b->lock);
8010021b:	83 ec 0c             	sub    $0xc,%esp
8010021e:	56                   	push   %esi
8010021f:	e8 fc 46 00 00       	call   80104920 <releasesleep>

  acquire(&bcache.lock);
80100224:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010022b:	e8 b0 49 00 00       	call   80104be0 <acquire>
  b->refcnt--;
80100230:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100233:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100236:	83 e8 01             	sub    $0x1,%eax
80100239:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010023c:	85 c0                	test   %eax,%eax
8010023e:	75 2c                	jne    8010026c <brelse+0x6c>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100240:	8b 53 54             	mov    0x54(%ebx),%edx
80100243:	8b 43 50             	mov    0x50(%ebx),%eax
80100246:	89 42 50             	mov    %eax,0x50(%edx)
    b->prev->next = b->next;
80100249:	8b 53 54             	mov    0x54(%ebx),%edx
8010024c:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
8010024f:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
    b->prev = &bcache.head;
80100254:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    b->next = bcache.head.next;
8010025b:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
8010025e:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
80100263:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100266:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  }
  
  release(&bcache.lock);
8010026c:	c7 45 08 20 b5 10 80 	movl   $0x8010b520,0x8(%ebp)
}
80100273:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100276:	5b                   	pop    %ebx
80100277:	5e                   	pop    %esi
80100278:	5d                   	pop    %ebp
  release(&bcache.lock);
80100279:	e9 02 49 00 00       	jmp    80104b80 <release>
    panic("brelse");
8010027e:	83 ec 0c             	sub    $0xc,%esp
80100281:	68 06 79 10 80       	push   $0x80107906
80100286:	e8 15 01 00 00       	call   801003a0 <panic>
8010028b:	66 90                	xchg   %ax,%ax
8010028d:	66 90                	xchg   %ax,%ax
8010028f:	66 90                	xchg   %ax,%ax
80100291:	66 90                	xchg   %ax,%ax
80100293:	66 90                	xchg   %ax,%ax
80100295:	66 90                	xchg   %ax,%ax
80100297:	66 90                	xchg   %ax,%ax
80100299:	66 90                	xchg   %ax,%ax
8010029b:	66 90                	xchg   %ax,%ax
8010029d:	66 90                	xchg   %ax,%ax
8010029f:	90                   	nop

801002a0 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
801002a0:	55                   	push   %ebp
801002a1:	89 e5                	mov    %esp,%ebp
801002a3:	57                   	push   %edi
801002a4:	56                   	push   %esi
801002a5:	53                   	push   %ebx
801002a6:	83 ec 18             	sub    $0x18,%esp
801002a9:	8b 5d 10             	mov    0x10(%ebp),%ebx
801002ac:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
801002af:	ff 75 08             	push   0x8(%ebp)
  target = n;
801002b2:	89 df                	mov    %ebx,%edi
  iunlock(ip);
801002b4:	e8 87 17 00 00       	call   80101a40 <iunlock>
  acquire(&cons.lock);
801002b9:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801002c0:	e8 1b 49 00 00       	call   80104be0 <acquire>
  while(n > 0){
801002c5:	83 c4 10             	add    $0x10,%esp
801002c8:	85 db                	test   %ebx,%ebx
801002ca:	0f 8e 94 00 00 00    	jle    80100364 <consoleread+0xc4>
    while(input.r == input.w){
801002d0:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801002d5:	39 05 04 ff 10 80    	cmp    %eax,0x8010ff04
801002db:	74 25                	je     80100302 <consoleread+0x62>
801002dd:	eb 59                	jmp    80100338 <consoleread+0x98>
801002df:	90                   	nop
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002e0:	83 ec 08             	sub    $0x8,%esp
801002e3:	68 20 ff 10 80       	push   $0x8010ff20
801002e8:	68 00 ff 10 80       	push   $0x8010ff00
801002ed:	e8 1e 41 00 00       	call   80104410 <sleep>
    while(input.r == input.w){
801002f2:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801002f7:	83 c4 10             	add    $0x10,%esp
801002fa:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
80100300:	75 36                	jne    80100338 <consoleread+0x98>
      if(myproc()->killed){
80100302:	e8 39 39 00 00       	call   80103c40 <myproc>
80100307:	8b 48 24             	mov    0x24(%eax),%ecx
8010030a:	85 c9                	test   %ecx,%ecx
8010030c:	74 d2                	je     801002e0 <consoleread+0x40>
        release(&cons.lock);
8010030e:	83 ec 0c             	sub    $0xc,%esp
80100311:	68 20 ff 10 80       	push   $0x8010ff20
80100316:	e8 65 48 00 00       	call   80104b80 <release>
        ilock(ip);
8010031b:	5a                   	pop    %edx
8010031c:	ff 75 08             	push   0x8(%ebp)
8010031f:	e8 1c 16 00 00       	call   80101940 <ilock>
        return -1;
80100324:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
80100327:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
8010032a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010032f:	5b                   	pop    %ebx
80100330:	5e                   	pop    %esi
80100331:	5f                   	pop    %edi
80100332:	5d                   	pop    %ebp
80100333:	c3                   	ret
80100334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100338:	8d 50 01             	lea    0x1(%eax),%edx
8010033b:	89 15 00 ff 10 80    	mov    %edx,0x8010ff00
80100341:	89 c2                	mov    %eax,%edx
80100343:	83 e2 7f             	and    $0x7f,%edx
80100346:	0f be 8a 80 fe 10 80 	movsbl -0x7fef0180(%edx),%ecx
    if(c == C('D')){  // EOF
8010034d:	80 f9 04             	cmp    $0x4,%cl
80100350:	74 37                	je     80100389 <consoleread+0xe9>
    *dst++ = c;
80100352:	83 c6 01             	add    $0x1,%esi
    --n;
80100355:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
80100358:	88 4e ff             	mov    %cl,-0x1(%esi)
    if(c == '\n')
8010035b:	83 f9 0a             	cmp    $0xa,%ecx
8010035e:	0f 85 64 ff ff ff    	jne    801002c8 <consoleread+0x28>
  release(&cons.lock);
80100364:	83 ec 0c             	sub    $0xc,%esp
80100367:	68 20 ff 10 80       	push   $0x8010ff20
8010036c:	e8 0f 48 00 00       	call   80104b80 <release>
  ilock(ip);
80100371:	58                   	pop    %eax
80100372:	ff 75 08             	push   0x8(%ebp)
80100375:	e8 c6 15 00 00       	call   80101940 <ilock>
  return target - n;
8010037a:	89 f8                	mov    %edi,%eax
8010037c:	83 c4 10             	add    $0x10,%esp
}
8010037f:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return target - n;
80100382:	29 d8                	sub    %ebx,%eax
}
80100384:	5b                   	pop    %ebx
80100385:	5e                   	pop    %esi
80100386:	5f                   	pop    %edi
80100387:	5d                   	pop    %ebp
80100388:	c3                   	ret
      if(n < target){
80100389:	39 fb                	cmp    %edi,%ebx
8010038b:	73 d7                	jae    80100364 <consoleread+0xc4>
        input.r--;
8010038d:	a3 00 ff 10 80       	mov    %eax,0x8010ff00
80100392:	eb d0                	jmp    80100364 <consoleread+0xc4>
80100394:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100398:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010039f:	00 

801003a0 <panic>:
{
801003a0:	55                   	push   %ebp
801003a1:	89 e5                	mov    %esp,%ebp
801003a3:	53                   	push   %ebx
801003a4:	83 ec 34             	sub    $0x34,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
801003a7:	fa                   	cli
  cons.locking = 0;
801003a8:	c7 05 54 ff 10 80 00 	movl   $0x0,0x8010ff54
801003af:	00 00 00 
  getcallerpcs(&s, pcs);
801003b2:	8d 5d d0             	lea    -0x30(%ebp),%ebx
  cprintf("lapicid %d: panic: ", lapicid());
801003b5:	e8 46 27 00 00       	call   80102b00 <lapicid>
801003ba:	83 ec 08             	sub    $0x8,%esp
801003bd:	50                   	push   %eax
801003be:	68 0d 79 10 80       	push   $0x8010790d
801003c3:	e8 08 03 00 00       	call   801006d0 <cprintf>
  cprintf(s);
801003c8:	58                   	pop    %eax
801003c9:	ff 75 08             	push   0x8(%ebp)
801003cc:	e8 ff 02 00 00       	call   801006d0 <cprintf>
  cprintf("\n");
801003d1:	c7 04 24 ca 7d 10 80 	movl   $0x80107dca,(%esp)
801003d8:	e8 f3 02 00 00       	call   801006d0 <cprintf>
  getcallerpcs(&s, pcs);
801003dd:	8d 45 08             	lea    0x8(%ebp),%eax
801003e0:	5a                   	pop    %edx
801003e1:	59                   	pop    %ecx
801003e2:	53                   	push   %ebx
801003e3:	50                   	push   %eax
801003e4:	e8 f7 45 00 00       	call   801049e0 <getcallerpcs>
  for(i=0; i<10; i++)
801003e9:	83 c4 10             	add    $0x10,%esp
801003ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf(" %p", pcs[i]);
801003f0:	83 ec 08             	sub    $0x8,%esp
801003f3:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
801003f5:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
801003f8:	68 21 79 10 80       	push   $0x80107921
801003fd:	e8 ce 02 00 00       	call   801006d0 <cprintf>
  for(i=0; i<10; i++)
80100402:	8d 45 f8             	lea    -0x8(%ebp),%eax
80100405:	83 c4 10             	add    $0x10,%esp
80100408:	39 c3                	cmp    %eax,%ebx
8010040a:	75 e4                	jne    801003f0 <panic+0x50>
  panicked = 1; // freeze other CPU
8010040c:	c7 05 58 ff 10 80 01 	movl   $0x1,0x8010ff58
80100413:	00 00 00 
  for(;;)
80100416:	eb fe                	jmp    80100416 <panic+0x76>
80100418:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010041f:	00 

80100420 <consputc.part.0>:
consputc(int c)
80100420:	55                   	push   %ebp
80100421:	89 e5                	mov    %esp,%ebp
80100423:	57                   	push   %edi
80100424:	56                   	push   %esi
80100425:	53                   	push   %ebx
80100426:	83 ec 0c             	sub    $0xc,%esp
  if(c == BACKSPACE){
80100429:	3d 00 01 00 00       	cmp    $0x100,%eax
8010042e:	0f 84 cc 00 00 00    	je     80100500 <consputc.part.0+0xe0>
    uartputc(c);
80100434:	83 ec 0c             	sub    $0xc,%esp
80100437:	89 c3                	mov    %eax,%ebx
80100439:	50                   	push   %eax
8010043a:	e8 01 60 00 00       	call   80106440 <uartputc>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010043f:	b8 0e 00 00 00       	mov    $0xe,%eax
80100444:	ba d4 03 00 00       	mov    $0x3d4,%edx
80100449:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010044a:	ba d5 03 00 00       	mov    $0x3d5,%edx
8010044f:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100450:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100453:	ba d4 03 00 00       	mov    $0x3d4,%edx
80100458:	b8 0f 00 00 00       	mov    $0xf,%eax
8010045d:	c1 e1 08             	shl    $0x8,%ecx
80100460:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100461:	ba d5 03 00 00       	mov    $0x3d5,%edx
80100466:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100467:	0f b6 c0             	movzbl %al,%eax
  if(c == '\n')
8010046a:	83 c4 10             	add    $0x10,%esp
  pos |= inb(CRTPORT+1);
8010046d:	09 c8                	or     %ecx,%eax
  if(c == '\n')
8010046f:	83 fb 0a             	cmp    $0xa,%ebx
80100472:	75 74                	jne    801004e8 <consputc.part.0+0xc8>
    pos += 80 - pos%80;
80100474:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80100479:	f7 e2                	mul    %edx
8010047b:	c1 ea 06             	shr    $0x6,%edx
8010047e:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100481:	c1 e0 04             	shl    $0x4,%eax
80100484:	8d 78 50             	lea    0x50(%eax),%edi
  if(pos < 0 || pos > 25*80)
80100487:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
8010048d:	0f 8f 23 01 00 00    	jg     801005b6 <consputc.part.0+0x196>
  if((pos/80) >= 24){  // Scroll up.
80100493:	81 ff 7f 07 00 00    	cmp    $0x77f,%edi
80100499:	0f 8f c1 00 00 00    	jg     80100560 <consputc.part.0+0x140>
  outb(CRTPORT+1, pos>>8);
8010049f:	89 f8                	mov    %edi,%eax
  outb(CRTPORT+1, pos);
801004a1:	89 fb                	mov    %edi,%ebx
  crt[pos] = ' ' | 0x0700;
801004a3:	8d bc 3f 00 80 0b 80 	lea    -0x7ff48000(%edi,%edi,1),%edi
  outb(CRTPORT+1, pos>>8);
801004aa:	0f b6 f4             	movzbl %ah,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004ad:	b8 0e 00 00 00       	mov    $0xe,%eax
801004b2:	ba d4 03 00 00       	mov    $0x3d4,%edx
801004b7:	ee                   	out    %al,(%dx)
801004b8:	ba d5 03 00 00       	mov    $0x3d5,%edx
801004bd:	89 f0                	mov    %esi,%eax
801004bf:	ee                   	out    %al,(%dx)
801004c0:	b8 0f 00 00 00       	mov    $0xf,%eax
801004c5:	ba d4 03 00 00       	mov    $0x3d4,%edx
801004ca:	ee                   	out    %al,(%dx)
801004cb:	ba d5 03 00 00       	mov    $0x3d5,%edx
801004d0:	89 d8                	mov    %ebx,%eax
801004d2:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004d3:	b8 20 07 00 00       	mov    $0x720,%eax
801004d8:	66 89 07             	mov    %ax,(%edi)
}
801004db:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004de:	5b                   	pop    %ebx
801004df:	5e                   	pop    %esi
801004e0:	5f                   	pop    %edi
801004e1:	5d                   	pop    %ebp
801004e2:	c3                   	ret
801004e3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
801004e8:	0f b6 db             	movzbl %bl,%ebx
801004eb:	8d 78 01             	lea    0x1(%eax),%edi
801004ee:	80 cf 07             	or     $0x7,%bh
801004f1:	66 89 9c 00 00 80 0b 	mov    %bx,-0x7ff48000(%eax,%eax,1)
801004f8:	80 
801004f9:	eb 8c                	jmp    80100487 <consputc.part.0+0x67>
801004fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100500:	83 ec 0c             	sub    $0xc,%esp
80100503:	6a 08                	push   $0x8
80100505:	e8 36 5f 00 00       	call   80106440 <uartputc>
8010050a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100511:	e8 2a 5f 00 00       	call   80106440 <uartputc>
80100516:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010051d:	e8 1e 5f 00 00       	call   80106440 <uartputc>
80100522:	b8 0e 00 00 00       	mov    $0xe,%eax
80100527:	ba d4 03 00 00       	mov    $0x3d4,%edx
8010052c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010052d:	ba d5 03 00 00       	mov    $0x3d5,%edx
80100532:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100533:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100536:	ba d4 03 00 00       	mov    $0x3d4,%edx
8010053b:	b8 0f 00 00 00       	mov    $0xf,%eax
80100540:	c1 e3 08             	shl    $0x8,%ebx
80100543:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100544:	ba d5 03 00 00       	mov    $0x3d5,%edx
80100549:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
8010054a:	0f b6 c8             	movzbl %al,%ecx
    if(pos > 0) --pos;
8010054d:	83 c4 10             	add    $0x10,%esp
80100550:	09 d9                	or     %ebx,%ecx
80100552:	74 54                	je     801005a8 <consputc.part.0+0x188>
80100554:	8d 79 ff             	lea    -0x1(%ecx),%edi
80100557:	e9 2b ff ff ff       	jmp    80100487 <consputc.part.0+0x67>
8010055c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100560:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
80100563:	8d 5f b0             	lea    -0x50(%edi),%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100566:	8d bc 3f 60 7f 0b 80 	lea    -0x7ff480a0(%edi,%edi,1),%edi
  outb(CRTPORT+1, pos);
8010056d:	be 07 00 00 00       	mov    $0x7,%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100572:	68 60 0e 00 00       	push   $0xe60
80100577:	68 a0 80 0b 80       	push   $0x800b80a0
8010057c:	68 00 80 0b 80       	push   $0x800b8000
80100581:	e8 0a 48 00 00       	call   80104d90 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100586:	b8 80 07 00 00       	mov    $0x780,%eax
8010058b:	83 c4 0c             	add    $0xc,%esp
8010058e:	29 d8                	sub    %ebx,%eax
80100590:	01 c0                	add    %eax,%eax
80100592:	50                   	push   %eax
80100593:	6a 00                	push   $0x0
80100595:	57                   	push   %edi
80100596:	e8 65 47 00 00       	call   80104d00 <memset>
  outb(CRTPORT+1, pos);
8010059b:	83 c4 10             	add    $0x10,%esp
8010059e:	e9 0a ff ff ff       	jmp    801004ad <consputc.part.0+0x8d>
801005a3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801005a8:	bf 00 80 0b 80       	mov    $0x800b8000,%edi
801005ad:	31 db                	xor    %ebx,%ebx
801005af:	31 f6                	xor    %esi,%esi
801005b1:	e9 f7 fe ff ff       	jmp    801004ad <consputc.part.0+0x8d>
    panic("pos under/overflow");
801005b6:	83 ec 0c             	sub    $0xc,%esp
801005b9:	68 25 79 10 80       	push   $0x80107925
801005be:	e8 dd fd ff ff       	call   801003a0 <panic>
801005c3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801005c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801005cf:	00 

801005d0 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
801005d0:	55                   	push   %ebp
801005d1:	89 e5                	mov    %esp,%ebp
801005d3:	57                   	push   %edi
801005d4:	56                   	push   %esi
801005d5:	53                   	push   %ebx
801005d6:	83 ec 18             	sub    $0x18,%esp
801005d9:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
801005dc:	ff 75 08             	push   0x8(%ebp)
801005df:	e8 5c 14 00 00       	call   80101a40 <iunlock>
  acquire(&cons.lock);
801005e4:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801005eb:	e8 f0 45 00 00       	call   80104be0 <acquire>
  for(i = 0; i < n; i++)
801005f0:	83 c4 10             	add    $0x10,%esp
801005f3:	85 f6                	test   %esi,%esi
801005f5:	7e 28                	jle    8010061f <consolewrite+0x4f>
801005f7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801005fa:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
  if(panicked){
801005fd:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
80100603:	85 d2                	test   %edx,%edx
80100605:	74 09                	je     80100610 <consolewrite+0x40>
  asm volatile("cli");
80100607:	fa                   	cli
    for(;;)
80100608:	eb fe                	jmp    80100608 <consolewrite+0x38>
8010060a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100610:	0f b6 03             	movzbl (%ebx),%eax
  for(i = 0; i < n; i++)
80100613:	83 c3 01             	add    $0x1,%ebx
80100616:	e8 05 fe ff ff       	call   80100420 <consputc.part.0>
8010061b:	39 fb                	cmp    %edi,%ebx
8010061d:	75 de                	jne    801005fd <consolewrite+0x2d>
  release(&cons.lock);
8010061f:	83 ec 0c             	sub    $0xc,%esp
80100622:	68 20 ff 10 80       	push   $0x8010ff20
80100627:	e8 54 45 00 00       	call   80104b80 <release>
  ilock(ip);
8010062c:	58                   	pop    %eax
8010062d:	ff 75 08             	push   0x8(%ebp)
80100630:	e8 0b 13 00 00       	call   80101940 <ilock>

  return n;
}
80100635:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100638:	89 f0                	mov    %esi,%eax
8010063a:	5b                   	pop    %ebx
8010063b:	5e                   	pop    %esi
8010063c:	5f                   	pop    %edi
8010063d:	5d                   	pop    %ebp
8010063e:	c3                   	ret
8010063f:	90                   	nop

80100640 <printint>:
{
80100640:	55                   	push   %ebp
80100641:	89 e5                	mov    %esp,%ebp
80100643:	57                   	push   %edi
80100644:	56                   	push   %esi
80100645:	53                   	push   %ebx
80100646:	89 d3                	mov    %edx,%ebx
80100648:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010064b:	85 c0                	test   %eax,%eax
8010064d:	79 05                	jns    80100654 <printint+0x14>
8010064f:	83 e1 01             	and    $0x1,%ecx
80100652:	75 5d                	jne    801006b1 <printint+0x71>
80100654:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
8010065b:	89 c1                	mov    %eax,%ecx
  i = 0;
8010065d:	31 f6                	xor    %esi,%esi
8010065f:	90                   	nop
    buf[i++] = digits[x % base];
80100660:	89 c8                	mov    %ecx,%eax
80100662:	31 d2                	xor    %edx,%edx
80100664:	89 f7                	mov    %esi,%edi
80100666:	f7 f3                	div    %ebx
80100668:	8d 76 01             	lea    0x1(%esi),%esi
  }while((x /= base) != 0);
8010066b:	39 d9                	cmp    %ebx,%ecx
    buf[i++] = digits[x % base];
8010066d:	0f b6 92 1c 7e 10 80 	movzbl -0x7fef81e4(%edx),%edx
  }while((x /= base) != 0);
80100674:	89 c1                	mov    %eax,%ecx
    buf[i++] = digits[x % base];
80100676:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
8010067a:	73 e4                	jae    80100660 <printint+0x20>
  if(sign)
8010067c:	8b 55 d4             	mov    -0x2c(%ebp),%edx
8010067f:	85 d2                	test   %edx,%edx
80100681:	74 07                	je     8010068a <printint+0x4a>
    buf[i++] = '-';
80100683:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
80100688:	89 f7                	mov    %esi,%edi
  while(--i >= 0)
8010068a:	8d 5d d8             	lea    -0x28(%ebp),%ebx
8010068d:	01 df                	add    %ebx,%edi
  if(panicked){
8010068f:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
80100694:	85 c0                	test   %eax,%eax
80100696:	74 08                	je     801006a0 <printint+0x60>
80100698:	fa                   	cli
    for(;;)
80100699:	eb fe                	jmp    80100699 <printint+0x59>
8010069b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    consputc(buf[i]);
801006a0:	0f be 07             	movsbl (%edi),%eax
801006a3:	e8 78 fd ff ff       	call   80100420 <consputc.part.0>
  while(--i >= 0)
801006a8:	39 fb                	cmp    %edi,%ebx
801006aa:	74 10                	je     801006bc <printint+0x7c>
801006ac:	83 ef 01             	sub    $0x1,%edi
801006af:	eb de                	jmp    8010068f <printint+0x4f>
  if(sign && (sign = xx < 0))
801006b1:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
    x = -xx;
801006b8:	f7 d8                	neg    %eax
801006ba:	eb 9f                	jmp    8010065b <printint+0x1b>
}
801006bc:	83 c4 2c             	add    $0x2c,%esp
801006bf:	5b                   	pop    %ebx
801006c0:	5e                   	pop    %esi
801006c1:	5f                   	pop    %edi
801006c2:	5d                   	pop    %ebp
801006c3:	c3                   	ret
801006c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801006c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801006cf:	00 

801006d0 <cprintf>:
{
801006d0:	55                   	push   %ebp
801006d1:	89 e5                	mov    %esp,%ebp
801006d3:	57                   	push   %edi
801006d4:	56                   	push   %esi
801006d5:	53                   	push   %ebx
801006d6:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
801006d9:	8b 15 54 ff 10 80    	mov    0x8010ff54,%edx
  if (fmt == 0)
801006df:	8b 75 08             	mov    0x8(%ebp),%esi
  if(locking)
801006e2:	85 d2                	test   %edx,%edx
801006e4:	0f 85 06 01 00 00    	jne    801007f0 <cprintf+0x120>
  if (fmt == 0)
801006ea:	85 f6                	test   %esi,%esi
801006ec:	0f 84 c2 01 00 00    	je     801008b4 <cprintf+0x1e4>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006f2:	0f b6 06             	movzbl (%esi),%eax
801006f5:	85 c0                	test   %eax,%eax
801006f7:	74 57                	je     80100750 <cprintf+0x80>
801006f9:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  argp = (uint*)(void*)(&fmt + 1);
801006fc:	8d 7d 0c             	lea    0xc(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006ff:	31 db                	xor    %ebx,%ebx
    if(c != '%'){
80100701:	83 f8 25             	cmp    $0x25,%eax
80100704:	75 5a                	jne    80100760 <cprintf+0x90>
    c = fmt[++i] & 0xff;
80100706:	83 c3 01             	add    $0x1,%ebx
80100709:	0f b6 14 1e          	movzbl (%esi,%ebx,1),%edx
    if(c == 0)
8010070d:	85 d2                	test   %edx,%edx
8010070f:	74 34                	je     80100745 <cprintf+0x75>
    switch(c){
80100711:	83 fa 70             	cmp    $0x70,%edx
80100714:	0f 84 b6 00 00 00    	je     801007d0 <cprintf+0x100>
8010071a:	7f 74                	jg     80100790 <cprintf+0xc0>
8010071c:	83 fa 25             	cmp    $0x25,%edx
8010071f:	74 4f                	je     80100770 <cprintf+0xa0>
80100721:	83 fa 64             	cmp    $0x64,%edx
80100724:	75 78                	jne    8010079e <cprintf+0xce>
      printint(*argp++, 10, 1);
80100726:	8b 07                	mov    (%edi),%eax
80100728:	b9 01 00 00 00       	mov    $0x1,%ecx
8010072d:	ba 0a 00 00 00       	mov    $0xa,%edx
80100732:	83 c7 04             	add    $0x4,%edi
80100735:	e8 06 ff ff ff       	call   80100640 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010073a:	83 c3 01             	add    $0x1,%ebx
8010073d:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100741:	85 c0                	test   %eax,%eax
80100743:	75 bc                	jne    80100701 <cprintf+0x31>
80100745:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  if(locking)
80100748:	85 d2                	test   %edx,%edx
8010074a:	0f 85 c9 00 00 00    	jne    80100819 <cprintf+0x149>
}
80100750:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100753:	5b                   	pop    %ebx
80100754:	5e                   	pop    %esi
80100755:	5f                   	pop    %edi
80100756:	5d                   	pop    %ebp
80100757:	c3                   	ret
80100758:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010075f:	00 
  if(panicked){
80100760:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
80100766:	85 c9                	test   %ecx,%ecx
80100768:	74 18                	je     80100782 <cprintf+0xb2>
8010076a:	fa                   	cli
    for(;;)
8010076b:	eb fe                	jmp    8010076b <cprintf+0x9b>
8010076d:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
80100770:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
80100775:	85 c0                	test   %eax,%eax
80100777:	0f 85 1b 01 00 00    	jne    80100898 <cprintf+0x1c8>
8010077d:	b8 25 00 00 00       	mov    $0x25,%eax
80100782:	e8 99 fc ff ff       	call   80100420 <consputc.part.0>
      break;
80100787:	eb b1                	jmp    8010073a <cprintf+0x6a>
80100789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100790:	83 fa 73             	cmp    $0x73,%edx
80100793:	0f 84 95 00 00 00    	je     8010082e <cprintf+0x15e>
80100799:	83 fa 78             	cmp    $0x78,%edx
8010079c:	74 32                	je     801007d0 <cprintf+0x100>
  if(panicked){
8010079e:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
801007a4:	85 c9                	test   %ecx,%ecx
801007a6:	0f 85 e5 00 00 00    	jne    80100891 <cprintf+0x1c1>
801007ac:	b8 25 00 00 00       	mov    $0x25,%eax
801007b1:	89 55 e0             	mov    %edx,-0x20(%ebp)
801007b4:	e8 67 fc ff ff       	call   80100420 <consputc.part.0>
801007b9:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
801007be:	85 c0                	test   %eax,%eax
801007c0:	0f 84 da 00 00 00    	je     801008a0 <cprintf+0x1d0>
801007c6:	fa                   	cli
    for(;;)
801007c7:	eb fe                	jmp    801007c7 <cprintf+0xf7>
801007c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      printint(*argp++, 16, 0);
801007d0:	8b 07                	mov    (%edi),%eax
801007d2:	31 c9                	xor    %ecx,%ecx
801007d4:	ba 10 00 00 00       	mov    $0x10,%edx
801007d9:	83 c7 04             	add    $0x4,%edi
801007dc:	e8 5f fe ff ff       	call   80100640 <printint>
      break;
801007e1:	e9 54 ff ff ff       	jmp    8010073a <cprintf+0x6a>
801007e6:	66 90                	xchg   %ax,%ax
801007e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801007ef:	00 
    acquire(&cons.lock);
801007f0:	83 ec 0c             	sub    $0xc,%esp
801007f3:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801007f6:	68 20 ff 10 80       	push   $0x8010ff20
801007fb:	e8 e0 43 00 00       	call   80104be0 <acquire>
  if (fmt == 0)
80100800:	83 c4 10             	add    $0x10,%esp
80100803:	85 f6                	test   %esi,%esi
80100805:	0f 84 a9 00 00 00    	je     801008b4 <cprintf+0x1e4>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010080b:	0f b6 06             	movzbl (%esi),%eax
8010080e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100811:	85 c0                	test   %eax,%eax
80100813:	0f 85 e0 fe ff ff    	jne    801006f9 <cprintf+0x29>
    release(&cons.lock);
80100819:	83 ec 0c             	sub    $0xc,%esp
8010081c:	68 20 ff 10 80       	push   $0x8010ff20
80100821:	e8 5a 43 00 00       	call   80104b80 <release>
80100826:	83 c4 10             	add    $0x10,%esp
80100829:	e9 22 ff ff ff       	jmp    80100750 <cprintf+0x80>
      if((s = (char*)*argp++) == 0)
8010082e:	8d 57 04             	lea    0x4(%edi),%edx
80100831:	8b 3f                	mov    (%edi),%edi
80100833:	85 ff                	test   %edi,%edi
80100835:	74 21                	je     80100858 <cprintf+0x188>
      for(; *s; s++)
80100837:	0f be 07             	movsbl (%edi),%eax
8010083a:	84 c0                	test   %al,%al
8010083c:	74 6f                	je     801008ad <cprintf+0x1dd>
8010083e:	89 5d e0             	mov    %ebx,-0x20(%ebp)
80100841:	89 fb                	mov    %edi,%ebx
80100843:	89 f7                	mov    %esi,%edi
80100845:	89 d6                	mov    %edx,%esi
  if(panicked){
80100847:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
8010084d:	85 d2                	test   %edx,%edx
8010084f:	74 22                	je     80100873 <cprintf+0x1a3>
80100851:	fa                   	cli
    for(;;)
80100852:	eb fe                	jmp    80100852 <cprintf+0x182>
80100854:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = "(null)";
80100858:	89 f7                	mov    %esi,%edi
8010085a:	89 d6                	mov    %edx,%esi
  if(panicked){
8010085c:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
        s = "(null)";
80100862:	89 5d e0             	mov    %ebx,-0x20(%ebp)
80100865:	b8 28 00 00 00       	mov    $0x28,%eax
8010086a:	bb 38 79 10 80       	mov    $0x80107938,%ebx
  if(panicked){
8010086f:	85 d2                	test   %edx,%edx
80100871:	75 de                	jne    80100851 <cprintf+0x181>
80100873:	e8 a8 fb ff ff       	call   80100420 <consputc.part.0>
      for(; *s; s++)
80100878:	0f be 43 01          	movsbl 0x1(%ebx),%eax
8010087c:	83 c3 01             	add    $0x1,%ebx
8010087f:	84 c0                	test   %al,%al
80100881:	75 c4                	jne    80100847 <cprintf+0x177>
      if((s = (char*)*argp++) == 0)
80100883:	89 f2                	mov    %esi,%edx
80100885:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80100888:	89 fe                	mov    %edi,%esi
8010088a:	89 d7                	mov    %edx,%edi
8010088c:	e9 a9 fe ff ff       	jmp    8010073a <cprintf+0x6a>
80100891:	fa                   	cli
    for(;;)
80100892:	eb fe                	jmp    80100892 <cprintf+0x1c2>
80100894:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100898:	fa                   	cli
80100899:	eb fe                	jmp    80100899 <cprintf+0x1c9>
8010089b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801008a0:	8b 45 e0             	mov    -0x20(%ebp),%eax
801008a3:	e8 78 fb ff ff       	call   80100420 <consputc.part.0>
      break;
801008a8:	e9 8d fe ff ff       	jmp    8010073a <cprintf+0x6a>
      if((s = (char*)*argp++) == 0)
801008ad:	89 d7                	mov    %edx,%edi
801008af:	e9 86 fe ff ff       	jmp    8010073a <cprintf+0x6a>
    panic("null fmt");
801008b4:	83 ec 0c             	sub    $0xc,%esp
801008b7:	68 3f 79 10 80       	push   $0x8010793f
801008bc:	e8 df fa ff ff       	call   801003a0 <panic>
801008c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801008c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801008cf:	00 

801008d0 <consoleintr>:
{
801008d0:	55                   	push   %ebp
801008d1:	89 e5                	mov    %esp,%ebp
801008d3:	57                   	push   %edi
801008d4:	56                   	push   %esi
  int c, doprocdump = 0;
801008d5:	31 f6                	xor    %esi,%esi
{
801008d7:	53                   	push   %ebx
801008d8:	83 ec 28             	sub    $0x28,%esp
801008db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
801008de:	68 20 ff 10 80       	push   $0x8010ff20
801008e3:	e8 f8 42 00 00       	call   80104be0 <acquire>
  while((c = getc()) >= 0){
801008e8:	83 c4 10             	add    $0x10,%esp
801008eb:	ff d3                	call   *%ebx
801008ed:	85 c0                	test   %eax,%eax
801008ef:	78 20                	js     80100911 <consoleintr+0x41>
    switch(c){
801008f1:	83 f8 15             	cmp    $0x15,%eax
801008f4:	74 42                	je     80100938 <consoleintr+0x68>
801008f6:	7f 78                	jg     80100970 <consoleintr+0xa0>
801008f8:	83 f8 08             	cmp    $0x8,%eax
801008fb:	74 78                	je     80100975 <consoleintr+0xa5>
801008fd:	83 f8 10             	cmp    $0x10,%eax
80100900:	0f 85 37 01 00 00    	jne    80100a3d <consoleintr+0x16d>
80100906:	be 01 00 00 00       	mov    $0x1,%esi
  while((c = getc()) >= 0){
8010090b:	ff d3                	call   *%ebx
8010090d:	85 c0                	test   %eax,%eax
8010090f:	79 e0                	jns    801008f1 <consoleintr+0x21>
  release(&cons.lock);
80100911:	83 ec 0c             	sub    $0xc,%esp
80100914:	68 20 ff 10 80       	push   $0x8010ff20
80100919:	e8 62 42 00 00       	call   80104b80 <release>
  if(doprocdump) {
8010091e:	83 c4 10             	add    $0x10,%esp
80100921:	85 f6                	test   %esi,%esi
80100923:	0f 85 7a 01 00 00    	jne    80100aa3 <consoleintr+0x1d3>
}
80100929:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010092c:	5b                   	pop    %ebx
8010092d:	5e                   	pop    %esi
8010092e:	5f                   	pop    %edi
8010092f:	5d                   	pop    %ebp
80100930:	c3                   	ret
80100931:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      while(input.e != input.w &&
80100938:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
8010093d:	39 05 04 ff 10 80    	cmp    %eax,0x8010ff04
80100943:	74 a6                	je     801008eb <consoleintr+0x1b>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100945:	83 e8 01             	sub    $0x1,%eax
80100948:	89 c2                	mov    %eax,%edx
8010094a:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
8010094d:	80 ba 80 fe 10 80 0a 	cmpb   $0xa,-0x7fef0180(%edx)
80100954:	74 95                	je     801008eb <consoleintr+0x1b>
  if(panicked){
80100956:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
        input.e--;
8010095c:	a3 08 ff 10 80       	mov    %eax,0x8010ff08
  if(panicked){
80100961:	85 d2                	test   %edx,%edx
80100963:	74 3b                	je     801009a0 <consoleintr+0xd0>
80100965:	fa                   	cli
    for(;;)
80100966:	eb fe                	jmp    80100966 <consoleintr+0x96>
80100968:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010096f:	00 
    switch(c){
80100970:	83 f8 7f             	cmp    $0x7f,%eax
80100973:	75 4b                	jne    801009c0 <consoleintr+0xf0>
      if(input.e != input.w){
80100975:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
8010097a:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
80100980:	0f 84 65 ff ff ff    	je     801008eb <consoleintr+0x1b>
        input.e--;
80100986:	83 e8 01             	sub    $0x1,%eax
80100989:	a3 08 ff 10 80       	mov    %eax,0x8010ff08
  if(panicked){
8010098e:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
80100993:	85 c0                	test   %eax,%eax
80100995:	0f 84 f9 00 00 00    	je     80100a94 <consoleintr+0x1c4>
8010099b:	fa                   	cli
    for(;;)
8010099c:	eb fe                	jmp    8010099c <consoleintr+0xcc>
8010099e:	66 90                	xchg   %ax,%ax
801009a0:	b8 00 01 00 00       	mov    $0x100,%eax
801009a5:	e8 76 fa ff ff       	call   80100420 <consputc.part.0>
      while(input.e != input.w &&
801009aa:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
801009af:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801009b5:	75 8e                	jne    80100945 <consoleintr+0x75>
801009b7:	e9 2f ff ff ff       	jmp    801008eb <consoleintr+0x1b>
801009bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(c != 0 && input.e-input.r < INPUT_BUF){
801009c0:	8b 15 08 ff 10 80    	mov    0x8010ff08,%edx
801009c6:	89 d1                	mov    %edx,%ecx
801009c8:	2b 0d 00 ff 10 80    	sub    0x8010ff00,%ecx
801009ce:	83 f9 7f             	cmp    $0x7f,%ecx
801009d1:	0f 87 14 ff ff ff    	ja     801008eb <consoleintr+0x1b>
  if(panicked){
801009d7:	8b 3d 58 ff 10 80    	mov    0x8010ff58,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801009dd:	8d 4a 01             	lea    0x1(%edx),%ecx
801009e0:	83 e2 7f             	and    $0x7f,%edx
801009e3:	89 0d 08 ff 10 80    	mov    %ecx,0x8010ff08
801009e9:	88 82 80 fe 10 80    	mov    %al,-0x7fef0180(%edx)
  if(panicked){
801009ef:	85 ff                	test   %edi,%edi
801009f1:	0f 85 b8 00 00 00    	jne    80100aaf <consoleintr+0x1df>
801009f7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801009fa:	e8 21 fa ff ff       	call   80100420 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801009ff:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100a02:	8b 15 08 ff 10 80    	mov    0x8010ff08,%edx
80100a08:	83 f8 0a             	cmp    $0xa,%eax
80100a0b:	74 15                	je     80100a22 <consoleintr+0x152>
80100a0d:	83 f8 04             	cmp    $0x4,%eax
80100a10:	74 10                	je     80100a22 <consoleintr+0x152>
80100a12:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
80100a17:	83 e8 80             	sub    $0xffffff80,%eax
80100a1a:	39 d0                	cmp    %edx,%eax
80100a1c:	0f 85 c9 fe ff ff    	jne    801008eb <consoleintr+0x1b>
          wakeup(&input.r);
80100a22:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100a25:	89 15 04 ff 10 80    	mov    %edx,0x8010ff04
          wakeup(&input.r);
80100a2b:	68 00 ff 10 80       	push   $0x8010ff00
80100a30:	e8 9b 3a 00 00       	call   801044d0 <wakeup>
80100a35:	83 c4 10             	add    $0x10,%esp
80100a38:	e9 ae fe ff ff       	jmp    801008eb <consoleintr+0x1b>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100a3d:	85 c0                	test   %eax,%eax
80100a3f:	0f 84 a6 fe ff ff    	je     801008eb <consoleintr+0x1b>
80100a45:	8b 15 08 ff 10 80    	mov    0x8010ff08,%edx
80100a4b:	89 d1                	mov    %edx,%ecx
80100a4d:	2b 0d 00 ff 10 80    	sub    0x8010ff00,%ecx
80100a53:	83 f9 7f             	cmp    $0x7f,%ecx
80100a56:	0f 87 8f fe ff ff    	ja     801008eb <consoleintr+0x1b>
        input.buf[input.e++ % INPUT_BUF] = c;
80100a5c:	8d 4a 01             	lea    0x1(%edx),%ecx
  if(panicked){
80100a5f:	8b 3d 58 ff 10 80    	mov    0x8010ff58,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
80100a65:	83 e2 7f             	and    $0x7f,%edx
        c = (c == '\r') ? '\n' : c;
80100a68:	83 f8 0d             	cmp    $0xd,%eax
80100a6b:	0f 85 72 ff ff ff    	jne    801009e3 <consoleintr+0x113>
        input.buf[input.e++ % INPUT_BUF] = c;
80100a71:	89 0d 08 ff 10 80    	mov    %ecx,0x8010ff08
80100a77:	c6 82 80 fe 10 80 0a 	movb   $0xa,-0x7fef0180(%edx)
  if(panicked){
80100a7e:	85 ff                	test   %edi,%edi
80100a80:	75 2d                	jne    80100aaf <consoleintr+0x1df>
80100a82:	b8 0a 00 00 00       	mov    $0xa,%eax
80100a87:	e8 94 f9 ff ff       	call   80100420 <consputc.part.0>
          input.w = input.e;
80100a8c:	8b 15 08 ff 10 80    	mov    0x8010ff08,%edx
80100a92:	eb 8e                	jmp    80100a22 <consoleintr+0x152>
80100a94:	b8 00 01 00 00       	mov    $0x100,%eax
80100a99:	e8 82 f9 ff ff       	call   80100420 <consputc.part.0>
80100a9e:	e9 48 fe ff ff       	jmp    801008eb <consoleintr+0x1b>
}
80100aa3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100aa6:	5b                   	pop    %ebx
80100aa7:	5e                   	pop    %esi
80100aa8:	5f                   	pop    %edi
80100aa9:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100aaa:	e9 61 3c 00 00       	jmp    80104710 <procdump>
80100aaf:	fa                   	cli
    for(;;)
80100ab0:	eb fe                	jmp    80100ab0 <consoleintr+0x1e0>
80100ab2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100ab8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100abf:	00 

80100ac0 <consoleinit>:

void
consoleinit(void)
{
80100ac0:	55                   	push   %ebp
80100ac1:	89 e5                	mov    %esp,%ebp
80100ac3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100ac6:	68 48 79 10 80       	push   $0x80107948
80100acb:	68 20 ff 10 80       	push   $0x8010ff20
80100ad0:	e8 eb 3e 00 00       	call   801049c0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100ad5:	58                   	pop    %eax
80100ad6:	5a                   	pop    %edx
80100ad7:	6a 00                	push   $0x0
80100ad9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100adb:	c7 05 0c 09 11 80 d0 	movl   $0x801005d0,0x8011090c
80100ae2:	05 10 80 
  devsw[CONSOLE].read = consoleread;
80100ae5:	c7 05 08 09 11 80 a0 	movl   $0x801002a0,0x80110908
80100aec:	02 10 80 
  cons.locking = 1;
80100aef:	c7 05 54 ff 10 80 01 	movl   $0x1,0x8010ff54
80100af6:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100af9:	e8 82 1b 00 00       	call   80102680 <ioapicenable>
}
80100afe:	83 c4 10             	add    $0x10,%esp
80100b01:	c9                   	leave
80100b02:	c3                   	ret
80100b03:	66 90                	xchg   %ax,%ax
80100b05:	66 90                	xchg   %ax,%ax
80100b07:	66 90                	xchg   %ax,%ax
80100b09:	66 90                	xchg   %ax,%ax
80100b0b:	66 90                	xchg   %ax,%ax
80100b0d:	66 90                	xchg   %ax,%ax
80100b0f:	90                   	nop

80100b10 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100b10:	55                   	push   %ebp
80100b11:	89 e5                	mov    %esp,%ebp
80100b13:	57                   	push   %edi
80100b14:	56                   	push   %esi
80100b15:	53                   	push   %ebx
80100b16:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100b1c:	e8 1f 31 00 00       	call   80103c40 <myproc>
80100b21:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100b27:	e8 b4 24 00 00       	call   80102fe0 <begin_op>

  if((ip = namei(path)) == 0){
80100b2c:	83 ec 0c             	sub    $0xc,%esp
80100b2f:	ff 75 08             	push   0x8(%ebp)
80100b32:	e8 49 17 00 00       	call   80102280 <namei>
80100b37:	83 c4 10             	add    $0x10,%esp
80100b3a:	85 c0                	test   %eax,%eax
80100b3c:	0f 84 30 03 00 00    	je     80100e72 <exec+0x362>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100b42:	83 ec 0c             	sub    $0xc,%esp
80100b45:	89 c7                	mov    %eax,%edi
80100b47:	50                   	push   %eax
80100b48:	e8 f3 0d 00 00       	call   80101940 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100b4d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100b53:	6a 34                	push   $0x34
80100b55:	6a 00                	push   $0x0
80100b57:	50                   	push   %eax
80100b58:	57                   	push   %edi
80100b59:	e8 22 11 00 00       	call   80101c80 <readi>
80100b5e:	83 c4 20             	add    $0x20,%esp
80100b61:	83 f8 34             	cmp    $0x34,%eax
80100b64:	0f 85 01 01 00 00    	jne    80100c6b <exec+0x15b>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100b6a:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100b71:	45 4c 46 
80100b74:	0f 85 f1 00 00 00    	jne    80100c6b <exec+0x15b>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100b7a:	e8 21 6a 00 00       	call   801075a0 <setupkvm>
80100b7f:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100b85:	85 c0                	test   %eax,%eax
80100b87:	0f 84 de 00 00 00    	je     80100c6b <exec+0x15b>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b8d:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100b94:	00 
80100b95:	0f 84 a7 02 00 00    	je     80100e42 <exec+0x332>
  sz = 0;
80100b9b:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100ba2:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100ba5:	8b 9d 40 ff ff ff    	mov    -0xc0(%ebp),%ebx
80100bab:	31 f6                	xor    %esi,%esi
80100bad:	e9 8c 00 00 00       	jmp    80100c3e <exec+0x12e>
80100bb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100bb8:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100bbf:	75 6c                	jne    80100c2d <exec+0x11d>
      continue;
    if(ph.memsz < ph.filesz)
80100bc1:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100bc7:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100bcd:	0f 82 87 00 00 00    	jb     80100c5a <exec+0x14a>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100bd3:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100bd9:	72 7f                	jb     80100c5a <exec+0x14a>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100bdb:	83 ec 04             	sub    $0x4,%esp
80100bde:	50                   	push   %eax
80100bdf:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80100be5:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100beb:	e8 e0 67 00 00       	call   801073d0 <allocuvm>
80100bf0:	83 c4 10             	add    $0x10,%esp
80100bf3:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100bf9:	85 c0                	test   %eax,%eax
80100bfb:	74 5d                	je     80100c5a <exec+0x14a>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100bfd:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100c03:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100c08:	75 50                	jne    80100c5a <exec+0x14a>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100c0a:	83 ec 0c             	sub    $0xc,%esp
80100c0d:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
80100c13:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
80100c19:	57                   	push   %edi
80100c1a:	50                   	push   %eax
80100c1b:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100c21:	e8 da 66 00 00       	call   80107300 <loaduvm>
80100c26:	83 c4 20             	add    $0x20,%esp
80100c29:	85 c0                	test   %eax,%eax
80100c2b:	78 2d                	js     80100c5a <exec+0x14a>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c2d:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100c34:	83 c6 01             	add    $0x1,%esi
80100c37:	83 c3 20             	add    $0x20,%ebx
80100c3a:	39 f0                	cmp    %esi,%eax
80100c3c:	7e 52                	jle    80100c90 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100c3e:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100c44:	6a 20                	push   $0x20
80100c46:	53                   	push   %ebx
80100c47:	50                   	push   %eax
80100c48:	57                   	push   %edi
80100c49:	e8 32 10 00 00       	call   80101c80 <readi>
80100c4e:	83 c4 10             	add    $0x10,%esp
80100c51:	83 f8 20             	cmp    $0x20,%eax
80100c54:	0f 84 5e ff ff ff    	je     80100bb8 <exec+0xa8>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100c5a:	83 ec 0c             	sub    $0xc,%esp
80100c5d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100c63:	e8 b8 68 00 00       	call   80107520 <freevm>
  if(ip){
80100c68:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80100c6b:	83 ec 0c             	sub    $0xc,%esp
80100c6e:	57                   	push   %edi
80100c6f:	e8 8c 0f 00 00       	call   80101c00 <iunlockput>
    end_op();
80100c74:	e8 d7 23 00 00       	call   80103050 <end_op>
80100c79:	83 c4 10             	add    $0x10,%esp
    return -1;
80100c7c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return -1;
}
80100c81:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100c84:	5b                   	pop    %ebx
80100c85:	5e                   	pop    %esi
80100c86:	5f                   	pop    %edi
80100c87:	5d                   	pop    %ebp
80100c88:	c3                   	ret
80100c89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  sz = PGROUNDUP(sz);
80100c90:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100c96:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
80100c9c:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100ca2:	8d 9e 00 20 00 00    	lea    0x2000(%esi),%ebx
  iunlockput(ip);
80100ca8:	83 ec 0c             	sub    $0xc,%esp
80100cab:	57                   	push   %edi
80100cac:	e8 4f 0f 00 00       	call   80101c00 <iunlockput>
  end_op();
80100cb1:	e8 9a 23 00 00       	call   80103050 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100cb6:	83 c4 0c             	add    $0xc,%esp
80100cb9:	53                   	push   %ebx
80100cba:	56                   	push   %esi
80100cbb:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100cc1:	56                   	push   %esi
80100cc2:	e8 09 67 00 00       	call   801073d0 <allocuvm>
80100cc7:	83 c4 10             	add    $0x10,%esp
80100cca:	89 c7                	mov    %eax,%edi
80100ccc:	85 c0                	test   %eax,%eax
80100cce:	0f 84 86 00 00 00    	je     80100d5a <exec+0x24a>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100cd4:	83 ec 08             	sub    $0x8,%esp
80100cd7:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  sp = sz;
80100cdd:	89 fb                	mov    %edi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100cdf:	50                   	push   %eax
80100ce0:	56                   	push   %esi
  for(argc = 0; argv[argc]; argc++) {
80100ce1:	31 f6                	xor    %esi,%esi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100ce3:	e8 58 69 00 00       	call   80107640 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100ce8:	8b 45 0c             	mov    0xc(%ebp),%eax
80100ceb:	83 c4 10             	add    $0x10,%esp
80100cee:	8b 10                	mov    (%eax),%edx
80100cf0:	85 d2                	test   %edx,%edx
80100cf2:	0f 84 56 01 00 00    	je     80100e4e <exec+0x33e>
80100cf8:	89 bd f0 fe ff ff    	mov    %edi,-0x110(%ebp)
80100cfe:	8b 7d 0c             	mov    0xc(%ebp),%edi
80100d01:	eb 23                	jmp    80100d26 <exec+0x216>
80100d03:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80100d08:	8d 46 01             	lea    0x1(%esi),%eax
    ustack[3+argc] = sp;
80100d0b:	89 9c b5 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%esi,4)
80100d12:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
  for(argc = 0; argv[argc]; argc++) {
80100d18:	8b 14 87             	mov    (%edi,%eax,4),%edx
80100d1b:	85 d2                	test   %edx,%edx
80100d1d:	74 51                	je     80100d70 <exec+0x260>
    if(argc >= MAXARG)
80100d1f:	83 f8 20             	cmp    $0x20,%eax
80100d22:	74 36                	je     80100d5a <exec+0x24a>
80100d24:	89 c6                	mov    %eax,%esi
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d26:	83 ec 0c             	sub    $0xc,%esp
80100d29:	52                   	push   %edx
80100d2a:	e8 d1 41 00 00       	call   80104f00 <strlen>
80100d2f:	29 c3                	sub    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d31:	58                   	pop    %eax
80100d32:	ff 34 b7             	push   (%edi,%esi,4)
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d35:	83 eb 01             	sub    $0x1,%ebx
80100d38:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d3b:	e8 c0 41 00 00       	call   80104f00 <strlen>
80100d40:	83 c0 01             	add    $0x1,%eax
80100d43:	50                   	push   %eax
80100d44:	ff 34 b7             	push   (%edi,%esi,4)
80100d47:	53                   	push   %ebx
80100d48:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100d4e:	e8 ad 6a 00 00       	call   80107800 <copyout>
80100d53:	83 c4 20             	add    $0x20,%esp
80100d56:	85 c0                	test   %eax,%eax
80100d58:	79 ae                	jns    80100d08 <exec+0x1f8>
    freevm(pgdir);
80100d5a:	83 ec 0c             	sub    $0xc,%esp
80100d5d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100d63:	e8 b8 67 00 00       	call   80107520 <freevm>
80100d68:	83 c4 10             	add    $0x10,%esp
80100d6b:	e9 0c ff ff ff       	jmp    80100c7c <exec+0x16c>
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d70:	8d 14 b5 08 00 00 00 	lea    0x8(,%esi,4),%edx
  ustack[3+argc] = 0;
80100d77:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100d7d:	89 85 e8 fe ff ff    	mov    %eax,-0x118(%ebp)
80100d83:	8d 46 04             	lea    0x4(%esi),%eax
  sp -= (3+argc+1) * 4;
80100d86:	8d 72 0c             	lea    0xc(%edx),%esi
  ustack[3+argc] = 0;
80100d89:	c7 84 85 58 ff ff ff 	movl   $0x0,-0xa8(%ebp,%eax,4)
80100d90:	00 00 00 00 
  ustack[1] = argc;
80100d94:	8b 85 e8 fe ff ff    	mov    -0x118(%ebp),%eax
  ustack[0] = 0xffffffff;  // fake return PC
80100d9a:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100da1:	ff ff ff 
  ustack[1] = argc;
80100da4:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100daa:	89 d8                	mov    %ebx,%eax
  sp -= (3+argc+1) * 4;
80100dac:	29 f3                	sub    %esi,%ebx
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100dae:	29 d0                	sub    %edx,%eax
80100db0:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100db6:	56                   	push   %esi
80100db7:	51                   	push   %ecx
80100db8:	53                   	push   %ebx
80100db9:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100dbf:	e8 3c 6a 00 00       	call   80107800 <copyout>
80100dc4:	83 c4 10             	add    $0x10,%esp
80100dc7:	85 c0                	test   %eax,%eax
80100dc9:	78 8f                	js     80100d5a <exec+0x24a>
  for(last=s=path; *s; s++)
80100dcb:	8b 45 08             	mov    0x8(%ebp),%eax
80100dce:	8b 55 08             	mov    0x8(%ebp),%edx
80100dd1:	0f b6 00             	movzbl (%eax),%eax
80100dd4:	84 c0                	test   %al,%al
80100dd6:	74 17                	je     80100def <exec+0x2df>
80100dd8:	89 d1                	mov    %edx,%ecx
80100dda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      last = s+1;
80100de0:	83 c1 01             	add    $0x1,%ecx
80100de3:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80100de5:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
80100de8:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
80100deb:	84 c0                	test   %al,%al
80100ded:	75 f1                	jne    80100de0 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100def:	83 ec 04             	sub    $0x4,%esp
80100df2:	6a 10                	push   $0x10
80100df4:	52                   	push   %edx
80100df5:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
80100dfb:	8d 46 70             	lea    0x70(%esi),%eax
80100dfe:	50                   	push   %eax
80100dff:	e8 ac 40 00 00       	call   80104eb0 <safestrcpy>
  curproc->pgdir = pgdir;
80100e04:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100e0a:	89 f0                	mov    %esi,%eax
80100e0c:	8b 76 04             	mov    0x4(%esi),%esi
  curproc->sz = sz;
80100e0f:	89 38                	mov    %edi,(%eax)
  curproc->pgdir = pgdir;
80100e11:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80100e14:	89 c1                	mov    %eax,%ecx
80100e16:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100e1c:	8b 40 18             	mov    0x18(%eax),%eax
80100e1f:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100e22:	8b 41 18             	mov    0x18(%ecx),%eax
80100e25:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100e28:	89 0c 24             	mov    %ecx,(%esp)
80100e2b:	e8 40 63 00 00       	call   80107170 <switchuvm>
  freevm(oldpgdir);
80100e30:	89 34 24             	mov    %esi,(%esp)
80100e33:	e8 e8 66 00 00       	call   80107520 <freevm>
  return 0;
80100e38:	83 c4 10             	add    $0x10,%esp
80100e3b:	31 c0                	xor    %eax,%eax
80100e3d:	e9 3f fe ff ff       	jmp    80100c81 <exec+0x171>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100e42:	bb 00 20 00 00       	mov    $0x2000,%ebx
80100e47:	31 f6                	xor    %esi,%esi
80100e49:	e9 5a fe ff ff       	jmp    80100ca8 <exec+0x198>
  for(argc = 0; argv[argc]; argc++) {
80100e4e:	be 10 00 00 00       	mov    $0x10,%esi
80100e53:	ba 04 00 00 00       	mov    $0x4,%edx
80100e58:	b8 03 00 00 00       	mov    $0x3,%eax
80100e5d:	c7 85 e8 fe ff ff 00 	movl   $0x0,-0x118(%ebp)
80100e64:	00 00 00 
80100e67:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80100e6d:	e9 17 ff ff ff       	jmp    80100d89 <exec+0x279>
    end_op();
80100e72:	e8 d9 21 00 00       	call   80103050 <end_op>
    cprintf("exec: fail\n");
80100e77:	83 ec 0c             	sub    $0xc,%esp
80100e7a:	68 50 79 10 80       	push   $0x80107950
80100e7f:	e8 4c f8 ff ff       	call   801006d0 <cprintf>
    return -1;
80100e84:	83 c4 10             	add    $0x10,%esp
80100e87:	e9 f0 fd ff ff       	jmp    80100c7c <exec+0x16c>
80100e8c:	66 90                	xchg   %ax,%ax
80100e8e:	66 90                	xchg   %ax,%ax
80100e90:	66 90                	xchg   %ax,%ax
80100e92:	66 90                	xchg   %ax,%ax
80100e94:	66 90                	xchg   %ax,%ax
80100e96:	66 90                	xchg   %ax,%ax
80100e98:	66 90                	xchg   %ax,%ax
80100e9a:	66 90                	xchg   %ax,%ax
80100e9c:	66 90                	xchg   %ax,%ax
80100e9e:	66 90                	xchg   %ax,%ax

80100ea0 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100ea0:	55                   	push   %ebp
80100ea1:	89 e5                	mov    %esp,%ebp
80100ea3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100ea6:	68 5c 79 10 80       	push   $0x8010795c
80100eab:	68 60 ff 10 80       	push   $0x8010ff60
80100eb0:	e8 0b 3b 00 00       	call   801049c0 <initlock>
}
80100eb5:	83 c4 10             	add    $0x10,%esp
80100eb8:	c9                   	leave
80100eb9:	c3                   	ret
80100eba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100ec0 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100ec0:	55                   	push   %ebp
80100ec1:	89 e5                	mov    %esp,%ebp
80100ec3:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100ec4:	bb 94 ff 10 80       	mov    $0x8010ff94,%ebx
{
80100ec9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100ecc:	68 60 ff 10 80       	push   $0x8010ff60
80100ed1:	e8 0a 3d 00 00       	call   80104be0 <acquire>
80100ed6:	83 c4 10             	add    $0x10,%esp
80100ed9:	eb 10                	jmp    80100eeb <filealloc+0x2b>
80100edb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100ee0:	83 c3 18             	add    $0x18,%ebx
80100ee3:	81 fb f4 08 11 80    	cmp    $0x801108f4,%ebx
80100ee9:	74 25                	je     80100f10 <filealloc+0x50>
    if(f->ref == 0){
80100eeb:	8b 43 04             	mov    0x4(%ebx),%eax
80100eee:	85 c0                	test   %eax,%eax
80100ef0:	75 ee                	jne    80100ee0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100ef2:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100ef5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100efc:	68 60 ff 10 80       	push   $0x8010ff60
80100f01:	e8 7a 3c 00 00       	call   80104b80 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100f06:	89 d8                	mov    %ebx,%eax
      return f;
80100f08:	83 c4 10             	add    $0x10,%esp
}
80100f0b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f0e:	c9                   	leave
80100f0f:	c3                   	ret
  release(&ftable.lock);
80100f10:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100f13:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100f15:	68 60 ff 10 80       	push   $0x8010ff60
80100f1a:	e8 61 3c 00 00       	call   80104b80 <release>
}
80100f1f:	89 d8                	mov    %ebx,%eax
  return 0;
80100f21:	83 c4 10             	add    $0x10,%esp
}
80100f24:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f27:	c9                   	leave
80100f28:	c3                   	ret
80100f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100f30 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100f30:	55                   	push   %ebp
80100f31:	89 e5                	mov    %esp,%ebp
80100f33:	53                   	push   %ebx
80100f34:	83 ec 10             	sub    $0x10,%esp
80100f37:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100f3a:	68 60 ff 10 80       	push   $0x8010ff60
80100f3f:	e8 9c 3c 00 00       	call   80104be0 <acquire>
  if(f->ref < 1)
80100f44:	8b 43 04             	mov    0x4(%ebx),%eax
80100f47:	83 c4 10             	add    $0x10,%esp
80100f4a:	85 c0                	test   %eax,%eax
80100f4c:	7e 1a                	jle    80100f68 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100f4e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100f51:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100f54:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100f57:	68 60 ff 10 80       	push   $0x8010ff60
80100f5c:	e8 1f 3c 00 00       	call   80104b80 <release>
  return f;
}
80100f61:	89 d8                	mov    %ebx,%eax
80100f63:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f66:	c9                   	leave
80100f67:	c3                   	ret
    panic("filedup");
80100f68:	83 ec 0c             	sub    $0xc,%esp
80100f6b:	68 63 79 10 80       	push   $0x80107963
80100f70:	e8 2b f4 ff ff       	call   801003a0 <panic>
80100f75:	8d 76 00             	lea    0x0(%esi),%esi
80100f78:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100f7f:	00 

80100f80 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100f80:	55                   	push   %ebp
80100f81:	89 e5                	mov    %esp,%ebp
80100f83:	57                   	push   %edi
80100f84:	56                   	push   %esi
80100f85:	53                   	push   %ebx
80100f86:	83 ec 28             	sub    $0x28,%esp
80100f89:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100f8c:	68 60 ff 10 80       	push   $0x8010ff60
80100f91:	e8 4a 3c 00 00       	call   80104be0 <acquire>
  if(f->ref < 1)
80100f96:	8b 43 04             	mov    0x4(%ebx),%eax
80100f99:	83 c4 10             	add    $0x10,%esp
80100f9c:	85 c0                	test   %eax,%eax
80100f9e:	0f 8e a8 00 00 00    	jle    8010104c <fileclose+0xcc>
    panic("fileclose");
  if(--f->ref > 0){
80100fa4:	83 e8 01             	sub    $0x1,%eax
80100fa7:	89 43 04             	mov    %eax,0x4(%ebx)
80100faa:	75 44                	jne    80100ff0 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100fac:	8b 43 0c             	mov    0xc(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100faf:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100fb2:	8b 33                	mov    (%ebx),%esi
  f->type = FD_NONE;
80100fb4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100fba:	0f b6 7b 09          	movzbl 0x9(%ebx),%edi
80100fbe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100fc1:	8b 43 10             	mov    0x10(%ebx),%eax
80100fc4:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100fc7:	68 60 ff 10 80       	push   $0x8010ff60
80100fcc:	e8 af 3b 00 00       	call   80104b80 <release>

  if(ff.type == FD_PIPE)
80100fd1:	83 c4 10             	add    $0x10,%esp
80100fd4:	83 fe 01             	cmp    $0x1,%esi
80100fd7:	74 57                	je     80101030 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100fd9:	83 fe 02             	cmp    $0x2,%esi
80100fdc:	74 2a                	je     80101008 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100fde:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fe1:	5b                   	pop    %ebx
80100fe2:	5e                   	pop    %esi
80100fe3:	5f                   	pop    %edi
80100fe4:	5d                   	pop    %ebp
80100fe5:	c3                   	ret
80100fe6:	66 90                	xchg   %ax,%ax
80100fe8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100fef:	00 
    release(&ftable.lock);
80100ff0:	c7 45 08 60 ff 10 80 	movl   $0x8010ff60,0x8(%ebp)
}
80100ff7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ffa:	5b                   	pop    %ebx
80100ffb:	5e                   	pop    %esi
80100ffc:	5f                   	pop    %edi
80100ffd:	5d                   	pop    %ebp
    release(&ftable.lock);
80100ffe:	e9 7d 3b 00 00       	jmp    80104b80 <release>
80101003:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    begin_op();
80101008:	e8 d3 1f 00 00       	call   80102fe0 <begin_op>
    iput(ff.ip);
8010100d:	83 ec 0c             	sub    $0xc,%esp
80101010:	ff 75 e0             	push   -0x20(%ebp)
80101013:	e8 78 0a 00 00       	call   80101a90 <iput>
    end_op();
80101018:	83 c4 10             	add    $0x10,%esp
}
8010101b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010101e:	5b                   	pop    %ebx
8010101f:	5e                   	pop    %esi
80101020:	5f                   	pop    %edi
80101021:	5d                   	pop    %ebp
    end_op();
80101022:	e9 29 20 00 00       	jmp    80103050 <end_op>
80101027:	90                   	nop
80101028:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010102f:	00 
    pipeclose(ff.pipe, ff.writable);
80101030:	89 f8                	mov    %edi,%eax
80101032:	83 ec 08             	sub    $0x8,%esp
80101035:	0f be c0             	movsbl %al,%eax
80101038:	50                   	push   %eax
80101039:	ff 75 e4             	push   -0x1c(%ebp)
8010103c:	e8 2f 27 00 00       	call   80103770 <pipeclose>
80101041:	83 c4 10             	add    $0x10,%esp
}
80101044:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101047:	5b                   	pop    %ebx
80101048:	5e                   	pop    %esi
80101049:	5f                   	pop    %edi
8010104a:	5d                   	pop    %ebp
8010104b:	c3                   	ret
    panic("fileclose");
8010104c:	83 ec 0c             	sub    $0xc,%esp
8010104f:	68 6b 79 10 80       	push   $0x8010796b
80101054:	e8 47 f3 ff ff       	call   801003a0 <panic>
80101059:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101060 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101060:	55                   	push   %ebp
80101061:	89 e5                	mov    %esp,%ebp
80101063:	53                   	push   %ebx
80101064:	83 ec 04             	sub    $0x4,%esp
80101067:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
8010106a:	83 3b 02             	cmpl   $0x2,(%ebx)
8010106d:	75 31                	jne    801010a0 <filestat+0x40>
    ilock(f->ip);
8010106f:	83 ec 0c             	sub    $0xc,%esp
80101072:	ff 73 10             	push   0x10(%ebx)
80101075:	e8 c6 08 00 00       	call   80101940 <ilock>
    stati(f->ip, st);
8010107a:	58                   	pop    %eax
8010107b:	5a                   	pop    %edx
8010107c:	ff 75 0c             	push   0xc(%ebp)
8010107f:	ff 73 10             	push   0x10(%ebx)
80101082:	e8 c9 0b 00 00       	call   80101c50 <stati>
    iunlock(f->ip);
80101087:	59                   	pop    %ecx
80101088:	ff 73 10             	push   0x10(%ebx)
8010108b:	e8 b0 09 00 00       	call   80101a40 <iunlock>
    return 0;
  }
  return -1;
}
80101090:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80101093:	83 c4 10             	add    $0x10,%esp
80101096:	31 c0                	xor    %eax,%eax
}
80101098:	c9                   	leave
80101099:	c3                   	ret
8010109a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801010a0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
801010a3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801010a8:	c9                   	leave
801010a9:	c3                   	ret
801010aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801010b0 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
801010b0:	55                   	push   %ebp
801010b1:	89 e5                	mov    %esp,%ebp
801010b3:	57                   	push   %edi
801010b4:	56                   	push   %esi
801010b5:	53                   	push   %ebx
801010b6:	83 ec 0c             	sub    $0xc,%esp
801010b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801010bc:	8b 75 0c             	mov    0xc(%ebp),%esi
801010bf:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
801010c2:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
801010c6:	74 60                	je     80101128 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
801010c8:	8b 03                	mov    (%ebx),%eax
801010ca:	83 f8 01             	cmp    $0x1,%eax
801010cd:	74 41                	je     80101110 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
801010cf:	83 f8 02             	cmp    $0x2,%eax
801010d2:	75 5b                	jne    8010112f <fileread+0x7f>
    ilock(f->ip);
801010d4:	83 ec 0c             	sub    $0xc,%esp
801010d7:	ff 73 10             	push   0x10(%ebx)
801010da:	e8 61 08 00 00       	call   80101940 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
801010df:	57                   	push   %edi
801010e0:	ff 73 14             	push   0x14(%ebx)
801010e3:	56                   	push   %esi
801010e4:	ff 73 10             	push   0x10(%ebx)
801010e7:	e8 94 0b 00 00       	call   80101c80 <readi>
801010ec:	83 c4 20             	add    $0x20,%esp
801010ef:	89 c6                	mov    %eax,%esi
801010f1:	85 c0                	test   %eax,%eax
801010f3:	7e 03                	jle    801010f8 <fileread+0x48>
      f->off += r;
801010f5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
801010f8:	83 ec 0c             	sub    $0xc,%esp
801010fb:	ff 73 10             	push   0x10(%ebx)
801010fe:	e8 3d 09 00 00       	call   80101a40 <iunlock>
    return r;
80101103:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101106:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101109:	89 f0                	mov    %esi,%eax
8010110b:	5b                   	pop    %ebx
8010110c:	5e                   	pop    %esi
8010110d:	5f                   	pop    %edi
8010110e:	5d                   	pop    %ebp
8010110f:	c3                   	ret
    return piperead(f->pipe, addr, n);
80101110:	8b 43 0c             	mov    0xc(%ebx),%eax
80101113:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101116:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101119:	5b                   	pop    %ebx
8010111a:	5e                   	pop    %esi
8010111b:	5f                   	pop    %edi
8010111c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010111d:	e9 fe 27 00 00       	jmp    80103920 <piperead>
80101122:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101128:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010112d:	eb d7                	jmp    80101106 <fileread+0x56>
  panic("fileread");
8010112f:	83 ec 0c             	sub    $0xc,%esp
80101132:	68 75 79 10 80       	push   $0x80107975
80101137:	e8 64 f2 ff ff       	call   801003a0 <panic>
8010113c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101140 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101140:	55                   	push   %ebp
80101141:	89 e5                	mov    %esp,%ebp
80101143:	57                   	push   %edi
80101144:	56                   	push   %esi
80101145:	53                   	push   %ebx
80101146:	83 ec 1c             	sub    $0x1c,%esp
80101149:	8b 45 0c             	mov    0xc(%ebp),%eax
8010114c:	8b 7d 08             	mov    0x8(%ebp),%edi
8010114f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101152:	8b 45 10             	mov    0x10(%ebp),%eax
80101155:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int r;

  if(f->writable == 0)
80101158:	80 7f 09 00          	cmpb   $0x0,0x9(%edi)
8010115c:	0f 84 b3 00 00 00    	je     80101215 <filewrite+0xd5>
    return -1;
  if(f->type == FD_PIPE)
80101162:	8b 17                	mov    (%edi),%edx
80101164:	83 fa 01             	cmp    $0x1,%edx
80101167:	0f 84 b7 00 00 00    	je     80101224 <filewrite+0xe4>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010116d:	83 fa 02             	cmp    $0x2,%edx
80101170:	0f 85 c0 00 00 00    	jne    80101236 <filewrite+0xf6>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101176:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    int i = 0;
80101179:	31 f6                	xor    %esi,%esi
    while(i < n){
8010117b:	85 d2                	test   %edx,%edx
8010117d:	7f 2e                	jg     801011ad <filewrite+0x6d>
8010117f:	e9 8c 00 00 00       	jmp    80101210 <filewrite+0xd0>
80101184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101188:	01 47 14             	add    %eax,0x14(%edi)
      iunlock(f->ip);
8010118b:	83 ec 0c             	sub    $0xc,%esp
        f->off += r;
8010118e:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101191:	51                   	push   %ecx
80101192:	e8 a9 08 00 00       	call   80101a40 <iunlock>
      end_op();
80101197:	e8 b4 1e 00 00       	call   80103050 <end_op>

      if(r < 0)
        break;
      if(r != n1)
8010119c:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010119f:	83 c4 10             	add    $0x10,%esp
801011a2:	39 d8                	cmp    %ebx,%eax
801011a4:	75 5d                	jne    80101203 <filewrite+0xc3>
        panic("short filewrite");
      i += r;
801011a6:	01 c6                	add    %eax,%esi
    while(i < n){
801011a8:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
801011ab:	7e 63                	jle    80101210 <filewrite+0xd0>
      int n1 = n - i;
801011ad:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
      if(n1 > max)
801011b0:	b8 00 06 00 00       	mov    $0x600,%eax
      int n1 = n - i;
801011b5:	29 f3                	sub    %esi,%ebx
      if(n1 > max)
801011b7:	39 c3                	cmp    %eax,%ebx
801011b9:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
801011bc:	e8 1f 1e 00 00       	call   80102fe0 <begin_op>
      ilock(f->ip);
801011c1:	83 ec 0c             	sub    $0xc,%esp
801011c4:	ff 77 10             	push   0x10(%edi)
801011c7:	e8 74 07 00 00       	call   80101940 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801011cc:	53                   	push   %ebx
801011cd:	ff 77 14             	push   0x14(%edi)
801011d0:	8b 45 dc             	mov    -0x24(%ebp),%eax
801011d3:	01 f0                	add    %esi,%eax
801011d5:	50                   	push   %eax
801011d6:	ff 77 10             	push   0x10(%edi)
801011d9:	e8 a2 0b 00 00       	call   80101d80 <writei>
      iunlock(f->ip);
801011de:	8b 4f 10             	mov    0x10(%edi),%ecx
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801011e1:	83 c4 20             	add    $0x20,%esp
801011e4:	85 c0                	test   %eax,%eax
801011e6:	7f a0                	jg     80101188 <filewrite+0x48>
      iunlock(f->ip);
801011e8:	83 ec 0c             	sub    $0xc,%esp
801011eb:	89 45 e0             	mov    %eax,-0x20(%ebp)
801011ee:	51                   	push   %ecx
801011ef:	e8 4c 08 00 00       	call   80101a40 <iunlock>
      end_op();
801011f4:	e8 57 1e 00 00       	call   80103050 <end_op>
      if(r < 0)
801011f9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801011fc:	83 c4 10             	add    $0x10,%esp
801011ff:	85 c0                	test   %eax,%eax
80101201:	75 0d                	jne    80101210 <filewrite+0xd0>
        panic("short filewrite");
80101203:	83 ec 0c             	sub    $0xc,%esp
80101206:	68 7e 79 10 80       	push   $0x8010797e
8010120b:	e8 90 f1 ff ff       	call   801003a0 <panic>
    }
    return i == n ? n : -1;
80101210:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
80101213:	74 05                	je     8010121a <filewrite+0xda>
    return -1;
80101215:	be ff ff ff ff       	mov    $0xffffffff,%esi
  }
  panic("filewrite");
}
8010121a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010121d:	89 f0                	mov    %esi,%eax
8010121f:	5b                   	pop    %ebx
80101220:	5e                   	pop    %esi
80101221:	5f                   	pop    %edi
80101222:	5d                   	pop    %ebp
80101223:	c3                   	ret
    return pipewrite(f->pipe, addr, n);
80101224:	8b 47 0c             	mov    0xc(%edi),%eax
80101227:	89 45 08             	mov    %eax,0x8(%ebp)
}
8010122a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010122d:	5b                   	pop    %ebx
8010122e:	5e                   	pop    %esi
8010122f:	5f                   	pop    %edi
80101230:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
80101231:	e9 da 25 00 00       	jmp    80103810 <pipewrite>
  panic("filewrite");
80101236:	83 ec 0c             	sub    $0xc,%esp
80101239:	68 84 79 10 80       	push   $0x80107984
8010123e:	e8 5d f1 ff ff       	call   801003a0 <panic>
80101243:	66 90                	xchg   %ax,%ax
80101245:	66 90                	xchg   %ax,%ax
80101247:	66 90                	xchg   %ax,%ax
80101249:	66 90                	xchg   %ax,%ax
8010124b:	66 90                	xchg   %ax,%ax
8010124d:	66 90                	xchg   %ax,%ax
8010124f:	90                   	nop

80101250 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101250:	55                   	push   %ebp
80101251:	89 e5                	mov    %esp,%ebp
80101253:	57                   	push   %edi
80101254:	89 d7                	mov    %edx,%edi
80101256:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101257:	31 f6                	xor    %esi,%esi
{
80101259:	53                   	push   %ebx
8010125a:	89 c3                	mov    %eax,%ebx
8010125c:	83 ec 28             	sub    $0x28,%esp
  acquire(&icache.lock);
8010125f:	68 60 09 11 80       	push   $0x80110960
80101264:	e8 77 39 00 00       	call   80104be0 <acquire>
80101269:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010126c:	b8 94 09 11 80       	mov    $0x80110994,%eax
80101271:	eb 19                	jmp    8010128c <iget+0x3c>
80101273:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101278:	39 18                	cmp    %ebx,(%eax)
8010127a:	0f 84 b0 00 00 00    	je     80101330 <iget+0xe0>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101280:	05 90 00 00 00       	add    $0x90,%eax
80101285:	3d b4 25 11 80       	cmp    $0x801125b4,%eax
8010128a:	74 24                	je     801012b0 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010128c:	8b 50 08             	mov    0x8(%eax),%edx
8010128f:	85 d2                	test   %edx,%edx
80101291:	7f e5                	jg     80101278 <iget+0x28>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101293:	89 c1                	mov    %eax,%ecx
80101295:	85 f6                	test   %esi,%esi
80101297:	75 4f                	jne    801012e8 <iget+0x98>
80101299:	85 d2                	test   %edx,%edx
8010129b:	0f 85 be 00 00 00    	jne    8010135f <iget+0x10f>
      empty = ip;
801012a1:	89 c6                	mov    %eax,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012a3:	05 90 00 00 00       	add    $0x90,%eax
801012a8:	3d b4 25 11 80       	cmp    $0x801125b4,%eax
801012ad:	75 dd                	jne    8010128c <iget+0x3c>
801012af:	90                   	nop
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801012b0:	85 f6                	test   %esi,%esi
801012b2:	0f 84 c3 00 00 00    	je     8010137b <iget+0x12b>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
801012b8:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
801012bb:	89 1e                	mov    %ebx,(%esi)
  ip->inum = inum;
801012bd:	89 7e 04             	mov    %edi,0x4(%esi)
  ip->ref = 1;
801012c0:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
801012c7:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
801012ce:	68 60 09 11 80       	push   $0x80110960
801012d3:	e8 a8 38 00 00       	call   80104b80 <release>

  return ip;
801012d8:	83 c4 10             	add    $0x10,%esp
}
801012db:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012de:	89 f0                	mov    %esi,%eax
801012e0:	5b                   	pop    %ebx
801012e1:	5e                   	pop    %esi
801012e2:	5f                   	pop    %edi
801012e3:	5d                   	pop    %ebp
801012e4:	c3                   	ret
801012e5:	8d 76 00             	lea    0x0(%esi),%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012e8:	05 90 00 00 00       	add    $0x90,%eax
801012ed:	3d b4 25 11 80       	cmp    $0x801125b4,%eax
801012f2:	74 c4                	je     801012b8 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012f4:	8b 50 08             	mov    0x8(%eax),%edx
801012f7:	85 d2                	test   %edx,%edx
801012f9:	0f 8f 79 ff ff ff    	jg     80101278 <iget+0x28>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012ff:	8d 81 20 01 00 00    	lea    0x120(%ecx),%eax
80101305:	81 f9 94 24 11 80    	cmp    $0x80112494,%ecx
8010130b:	74 a3                	je     801012b0 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010130d:	8b 50 08             	mov    0x8(%eax),%edx
80101310:	85 d2                	test   %edx,%edx
80101312:	0f 8f 60 ff ff ff    	jg     80101278 <iget+0x28>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101318:	89 c1                	mov    %eax,%ecx
8010131a:	05 90 00 00 00       	add    $0x90,%eax
8010131f:	3d b4 25 11 80       	cmp    $0x801125b4,%eax
80101324:	75 ce                	jne    801012f4 <iget+0xa4>
80101326:	eb 90                	jmp    801012b8 <iget+0x68>
80101328:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010132f:	00 
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101330:	39 78 04             	cmp    %edi,0x4(%eax)
80101333:	0f 85 47 ff ff ff    	jne    80101280 <iget+0x30>
      release(&icache.lock);
80101339:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
8010133c:	83 c2 01             	add    $0x1,%edx
8010133f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101342:	89 50 08             	mov    %edx,0x8(%eax)
      release(&icache.lock);
80101345:	68 60 09 11 80       	push   $0x80110960
8010134a:	e8 31 38 00 00       	call   80104b80 <release>
      return ip;
8010134f:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80101352:	83 c4 10             	add    $0x10,%esp
}
80101355:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101358:	5b                   	pop    %ebx
80101359:	89 f0                	mov    %esi,%eax
8010135b:	5e                   	pop    %esi
8010135c:	5f                   	pop    %edi
8010135d:	5d                   	pop    %ebp
8010135e:	c3                   	ret
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010135f:	05 90 00 00 00       	add    $0x90,%eax
80101364:	3d b4 25 11 80       	cmp    $0x801125b4,%eax
80101369:	74 10                	je     8010137b <iget+0x12b>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010136b:	8b 50 08             	mov    0x8(%eax),%edx
8010136e:	85 d2                	test   %edx,%edx
80101370:	0f 8f 02 ff ff ff    	jg     80101278 <iget+0x28>
80101376:	e9 1e ff ff ff       	jmp    80101299 <iget+0x49>
    panic("iget: no inodes");
8010137b:	83 ec 0c             	sub    $0xc,%esp
8010137e:	68 8e 79 10 80       	push   $0x8010798e
80101383:	e8 18 f0 ff ff       	call   801003a0 <panic>
80101388:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010138f:	00 

80101390 <bfree>:
{
80101390:	55                   	push   %ebp
80101391:	89 e5                	mov    %esp,%ebp
80101393:	57                   	push   %edi
80101394:	56                   	push   %esi
80101395:	89 c6                	mov    %eax,%esi
80101397:	53                   	push   %ebx
80101398:	89 d3                	mov    %edx,%ebx
8010139a:	83 ec 44             	sub    $0x44,%esp
  bp = bread(dev, 1);
8010139d:	6a 01                	push   $0x1
8010139f:	50                   	push   %eax
801013a0:	e8 2b ed ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801013a5:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
801013a8:	89 c7                	mov    %eax,%edi
  memmove(sb, bp->data, sizeof(*sb));
801013aa:	83 c0 5c             	add    $0x5c,%eax
801013ad:	6a 2c                	push   $0x2c
801013af:	50                   	push   %eax
801013b0:	8d 45 bc             	lea    -0x44(%ebp),%eax
801013b3:	50                   	push   %eax
801013b4:	e8 d7 39 00 00       	call   80104d90 <memmove>
  brelse(bp);
801013b9:	89 3c 24             	mov    %edi,(%esp)
801013bc:	e8 3f ee ff ff       	call   80100200 <brelse>
  bp = bread(dev, BBLOCK(b, sb));
801013c1:	5a                   	pop    %edx
801013c2:	59                   	pop    %ecx
801013c3:	31 d2                	xor    %edx,%edx
801013c5:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  uint global_start = sb.logstart + sb.nlog;
801013c8:	8b 45 cc             	mov    -0x34(%ebp),%eax
801013cb:	03 45 d0             	add    -0x30(%ebp),%eax
  bp = bread(dev, BBLOCK(b, sb));
801013ce:	29 c3                	sub    %eax,%ebx
801013d0:	c1 e9 03             	shr    $0x3,%ecx
801013d3:	01 c1                	add    %eax,%ecx
801013d5:	89 d8                	mov    %ebx,%eax
801013d7:	f7 75 dc             	divl   -0x24(%ebp)
801013da:	89 d8                	mov    %ebx,%eax
801013dc:	29 d0                	sub    %edx,%eax
801013de:	01 c1                	add    %eax,%ecx
801013e0:	51                   	push   %ecx
801013e1:	56                   	push   %esi
801013e2:	e8 e9 ec ff ff       	call   801000d0 <bread>
  bi = (b - global_start) % sb.bpg;
801013e7:	31 d2                	xor    %edx,%edx
  if((bp->data[bi/8] & m) == 0)
801013e9:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
801013ec:	89 c6                	mov    %eax,%esi
  bi = (b - global_start) % sb.bpg;
801013ee:	89 d8                	mov    %ebx,%eax
801013f0:	f7 75 dc             	divl   -0x24(%ebp)
  m = 1 << (bi % 8);
801013f3:	b8 01 00 00 00       	mov    $0x1,%eax
801013f8:	89 d1                	mov    %edx,%ecx
801013fa:	83 e1 07             	and    $0x7,%ecx
801013fd:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
801013ff:	85 d2                	test   %edx,%edx
80101401:	8d 4a 07             	lea    0x7(%edx),%ecx
80101404:	0f 49 ca             	cmovns %edx,%ecx
80101407:	c1 f9 03             	sar    $0x3,%ecx
8010140a:	0f b6 5c 0e 5c       	movzbl 0x5c(%esi,%ecx,1),%ebx
8010140f:	85 c3                	test   %eax,%ebx
80101411:	74 24                	je     80101437 <bfree+0xa7>
  bp->data[bi/8] &= ~m;  // Clear the bit
80101413:	f7 d0                	not    %eax
  log_write(bp);
80101415:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;  // Clear the bit
80101418:	21 d8                	and    %ebx,%eax
8010141a:	88 44 0e 5c          	mov    %al,0x5c(%esi,%ecx,1)
  log_write(bp);
8010141e:	56                   	push   %esi
8010141f:	e8 9c 1d 00 00       	call   801031c0 <log_write>
  brelse(bp);
80101424:	89 34 24             	mov    %esi,(%esp)
80101427:	e8 d4 ed ff ff       	call   80100200 <brelse>
}
8010142c:	83 c4 10             	add    $0x10,%esp
8010142f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101432:	5b                   	pop    %ebx
80101433:	5e                   	pop    %esi
80101434:	5f                   	pop    %edi
80101435:	5d                   	pop    %ebp
80101436:	c3                   	ret
    panic("freeing free block");
80101437:	83 ec 0c             	sub    $0xc,%esp
8010143a:	68 9e 79 10 80       	push   $0x8010799e
8010143f:	e8 5c ef ff ff       	call   801003a0 <panic>
80101444:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101448:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010144f:	00 

80101450 <balloc>:
{
80101450:	55                   	push   %ebp
80101451:	89 e5                	mov    %esp,%ebp
80101453:	57                   	push   %edi
80101454:	56                   	push   %esi
80101455:	53                   	push   %ebx
80101456:	83 ec 64             	sub    $0x64,%esp
80101459:	89 45 ac             	mov    %eax,-0x54(%ebp)
  bp = bread(dev, 1);
8010145c:	6a 01                	push   $0x1
8010145e:	50                   	push   %eax
8010145f:	e8 6c ec ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101464:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80101467:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101469:	83 c0 5c             	add    $0x5c,%eax
8010146c:	6a 2c                	push   $0x2c
8010146e:	50                   	push   %eax
8010146f:	8d 45 bc             	lea    -0x44(%ebp),%eax
80101472:	50                   	push   %eax
80101473:	e8 18 39 00 00       	call   80104d90 <memmove>
  brelse(bp);
80101478:	89 1c 24             	mov    %ebx,(%esp)
8010147b:	e8 80 ed ff ff       	call   80100200 <brelse>
  for(g = 0; g < sb.ngroups; g++) {
80101480:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101483:	83 c4 10             	add    $0x10,%esp
80101486:	85 db                	test   %ebx,%ebx
80101488:	0f 84 f4 00 00 00    	je     80101582 <balloc+0x132>
  uint global_start = sb.logstart + sb.nlog;
8010148e:	8b 45 cc             	mov    -0x34(%ebp),%eax
80101491:	03 45 d0             	add    -0x30(%ebp),%eax
  for(g = 0; g < sb.ngroups; g++) {
80101494:	c7 45 b0 00 00 00 00 	movl   $0x0,-0x50(%ebp)
  uint global_start = sb.logstart + sb.nlog;
8010149b:	89 c6                	mov    %eax,%esi
  uint bpg = sb.bpg;
8010149d:	8b 45 dc             	mov    -0x24(%ebp),%eax
801014a0:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  uint inode_blocks_per_group = ipg / IPB; 
801014a3:	8b 45 e0             	mov    -0x20(%ebp),%eax
801014a6:	c1 e8 03             	shr    $0x3,%eax
801014a9:	89 45 a4             	mov    %eax,-0x5c(%ebp)
    uint bmap_block = group_start + inode_blocks_per_group;
801014ac:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    bp = bread(dev, bmap_block);
801014af:	83 ec 08             	sub    $0x8,%esp
    uint bmap_block = group_start + inode_blocks_per_group;
801014b2:	01 f0                	add    %esi,%eax
    bp = bread(dev, bmap_block);
801014b4:	50                   	push   %eax
801014b5:	ff 75 ac             	push   -0x54(%ebp)
801014b8:	e8 13 ec ff ff       	call   801000d0 <bread>
    for(bi = 0; bi < BPB && bi < bpg; bi++) {
801014bd:	8b 4d b4             	mov    -0x4c(%ebp),%ecx
801014c0:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, bmap_block);
801014c3:	89 c7                	mov    %eax,%edi
    for(bi = 0; bi < BPB && bi < bpg; bi++) {
801014c5:	85 c9                	test   %ecx,%ecx
801014c7:	0f 84 96 00 00 00    	je     80101563 <balloc+0x113>
801014cd:	89 75 a8             	mov    %esi,-0x58(%ebp)
801014d0:	31 db                	xor    %ebx,%ebx
801014d2:	eb 14                	jmp    801014e8 <balloc+0x98>
801014d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801014d8:	83 c3 01             	add    $0x1,%ebx
801014db:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
801014e1:	74 7d                	je     80101560 <balloc+0x110>
801014e3:	3b 5d b4             	cmp    -0x4c(%ebp),%ebx
801014e6:	73 78                	jae    80101560 <balloc+0x110>
      m = 1 << (bi % 8);
801014e8:	89 d9                	mov    %ebx,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is bit zero (free)?
801014ea:	89 da                	mov    %ebx,%edx
      m = 1 << (bi % 8);
801014ec:	b8 01 00 00 00       	mov    $0x1,%eax
801014f1:	83 e1 07             	and    $0x7,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is bit zero (free)?
801014f4:	c1 fa 03             	sar    $0x3,%edx
      m = 1 << (bi % 8);
801014f7:	d3 e0                	shl    %cl,%eax
      if((bp->data[bi/8] & m) == 0){  // Is bit zero (free)?
801014f9:	0f b6 74 17 5c       	movzbl 0x5c(%edi,%edx,1),%esi
      m = 1 << (bi % 8);
801014fe:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is bit zero (free)?
80101500:	89 f0                	mov    %esi,%eax
80101502:	85 ce                	test   %ecx,%esi
80101504:	75 d2                	jne    801014d8 <balloc+0x88>
        log_write(bp);
80101506:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark used
80101509:	09 c8                	or     %ecx,%eax
        uint abs_block = group_start + bi;
8010150b:	03 5d a8             	add    -0x58(%ebp),%ebx
        bp->data[bi/8] |= m;  // Mark used
8010150e:	88 44 17 5c          	mov    %al,0x5c(%edi,%edx,1)
        log_write(bp);
80101512:	57                   	push   %edi
80101513:	e8 a8 1c 00 00       	call   801031c0 <log_write>
        brelse(bp);
80101518:	89 3c 24             	mov    %edi,(%esp)
8010151b:	e8 e0 ec ff ff       	call   80100200 <brelse>
        bp = bread(dev, abs_block);
80101520:	58                   	pop    %eax
80101521:	5a                   	pop    %edx
80101522:	53                   	push   %ebx
80101523:	ff 75 ac             	push   -0x54(%ebp)
80101526:	e8 a5 eb ff ff       	call   801000d0 <bread>
        memset(bp->data, 0, BSIZE);
8010152b:	83 c4 0c             	add    $0xc,%esp
        bp = bread(dev, abs_block);
8010152e:	89 c6                	mov    %eax,%esi
        memset(bp->data, 0, BSIZE);
80101530:	8d 40 5c             	lea    0x5c(%eax),%eax
80101533:	68 00 02 00 00       	push   $0x200
80101538:	6a 00                	push   $0x0
8010153a:	50                   	push   %eax
8010153b:	e8 c0 37 00 00       	call   80104d00 <memset>
        log_write(bp);
80101540:	89 34 24             	mov    %esi,(%esp)
80101543:	e8 78 1c 00 00       	call   801031c0 <log_write>
        brelse(bp);
80101548:	89 34 24             	mov    %esi,(%esp)
8010154b:	e8 b0 ec ff ff       	call   80100200 <brelse>
        return abs_block;
80101550:	83 c4 10             	add    $0x10,%esp
}
80101553:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101556:	89 d8                	mov    %ebx,%eax
80101558:	5b                   	pop    %ebx
80101559:	5e                   	pop    %esi
8010155a:	5f                   	pop    %edi
8010155b:	5d                   	pop    %ebp
8010155c:	c3                   	ret
8010155d:	8d 76 00             	lea    0x0(%esi),%esi
80101560:	8b 75 a8             	mov    -0x58(%ebp),%esi
    brelse(bp);
80101563:	83 ec 0c             	sub    $0xc,%esp
80101566:	57                   	push   %edi
80101567:	e8 94 ec ff ff       	call   80100200 <brelse>
  for(g = 0; g < sb.ngroups; g++) {
8010156c:	83 45 b0 01          	addl   $0x1,-0x50(%ebp)
80101570:	03 75 b4             	add    -0x4c(%ebp),%esi
80101573:	83 c4 10             	add    $0x10,%esp
80101576:	8b 45 b0             	mov    -0x50(%ebp),%eax
80101579:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
8010157c:	0f 82 2a ff ff ff    	jb     801014ac <balloc+0x5c>
  cprintf("balloc: out of blocks");
80101582:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80101585:	31 db                	xor    %ebx,%ebx
  cprintf("balloc: out of blocks");
80101587:	68 b1 79 10 80       	push   $0x801079b1
8010158c:	e8 3f f1 ff ff       	call   801006d0 <cprintf>
  return 0;
80101591:	83 c4 10             	add    $0x10,%esp
}
80101594:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101597:	89 d8                	mov    %ebx,%eax
80101599:	5b                   	pop    %ebx
8010159a:	5e                   	pop    %esi
8010159b:	5f                   	pop    %edi
8010159c:	5d                   	pop    %ebp
8010159d:	c3                   	ret
8010159e:	66 90                	xchg   %ax,%ax

801015a0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801015a0:	55                   	push   %ebp
801015a1:	89 c1                	mov    %eax,%ecx
801015a3:	89 e5                	mov    %esp,%ebp
801015a5:	53                   	push   %ebx
801015a6:	83 ec 14             	sub    $0x14,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801015a9:	83 fa 0b             	cmp    $0xb,%edx
801015ac:	76 72                	jbe    80101620 <bmap+0x80>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
801015ae:	83 ea 0c             	sub    $0xc,%edx

  if(bn < NINDIRECT){
801015b1:	83 fa 7f             	cmp    $0x7f,%edx
801015b4:	77 52                	ja     80101608 <bmap+0x68>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
801015b6:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
801015bc:	85 c0                	test   %eax,%eax
801015be:	0f 84 bc 00 00 00    	je     80101680 <bmap+0xe0>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801015c4:	83 ec 08             	sub    $0x8,%esp
801015c7:	89 55 f0             	mov    %edx,-0x10(%ebp)
801015ca:	50                   	push   %eax
801015cb:	ff 31                	push   (%ecx)
801015cd:	89 4d f4             	mov    %ecx,-0xc(%ebp)
801015d0:	e8 fb ea ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801015d5:	8b 55 f0             	mov    -0x10(%ebp),%edx
801015d8:	83 c4 10             	add    $0x10,%esp
801015db:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    bp = bread(ip->dev, addr);
801015de:	89 c3                	mov    %eax,%ebx
    if((addr = a[bn]) == 0){
801015e0:	8d 54 90 5c          	lea    0x5c(%eax,%edx,4),%edx
801015e4:	8b 02                	mov    (%edx),%eax
801015e6:	85 c0                	test   %eax,%eax
801015e8:	74 66                	je     80101650 <bmap+0xb0>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
801015ea:	83 ec 0c             	sub    $0xc,%esp
801015ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
801015f0:	53                   	push   %ebx
801015f1:	e8 0a ec ff ff       	call   80100200 <brelse>
    return addr;
801015f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801015f9:	83 c4 10             	add    $0x10,%esp
  }

  //panic("bmap: out of range");
  cprintf("balloc: out of blocks\n"); 
  return 0;
}
801015fc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801015ff:	c9                   	leave
80101600:	c3                   	ret
80101601:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  cprintf("balloc: out of blocks\n"); 
80101608:	83 ec 0c             	sub    $0xc,%esp
8010160b:	68 c7 79 10 80       	push   $0x801079c7
80101610:	e8 bb f0 ff ff       	call   801006d0 <cprintf>
}
80101615:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return 0;
80101618:	83 c4 10             	add    $0x10,%esp
8010161b:	31 c0                	xor    %eax,%eax
}
8010161d:	c9                   	leave
8010161e:	c3                   	ret
8010161f:	90                   	nop
    if((addr = ip->addrs[bn]) == 0)
80101620:	83 c2 14             	add    $0x14,%edx
80101623:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101627:	85 c0                	test   %eax,%eax
80101629:	75 d1                	jne    801015fc <bmap+0x5c>
      ip->addrs[bn] = addr = balloc(ip->dev);
8010162b:	8b 01                	mov    (%ecx),%eax
8010162d:	89 55 f0             	mov    %edx,-0x10(%ebp)
80101630:	89 4d f4             	mov    %ecx,-0xc(%ebp)
80101633:	e8 18 fe ff ff       	call   80101450 <balloc>
80101638:	8b 4d f4             	mov    -0xc(%ebp),%ecx
8010163b:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010163e:	89 44 91 0c          	mov    %eax,0xc(%ecx,%edx,4)
}
80101642:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101645:	c9                   	leave
80101646:	c3                   	ret
80101647:	90                   	nop
80101648:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010164f:	00 
      a[bn] = addr = balloc(ip->dev);
80101650:	8b 01                	mov    (%ecx),%eax
80101652:	89 55 f4             	mov    %edx,-0xc(%ebp)
80101655:	e8 f6 fd ff ff       	call   80101450 <balloc>
8010165a:	8b 55 f4             	mov    -0xc(%ebp),%edx
      log_write(bp);
8010165d:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101660:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101663:	89 02                	mov    %eax,(%edx)
      log_write(bp);
80101665:	53                   	push   %ebx
80101666:	e8 55 1b 00 00       	call   801031c0 <log_write>
8010166b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010166e:	83 c4 10             	add    $0x10,%esp
80101671:	e9 74 ff ff ff       	jmp    801015ea <bmap+0x4a>
80101676:	66 90                	xchg   %ax,%ax
80101678:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010167f:	00 
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101680:	8b 01                	mov    (%ecx),%eax
80101682:	89 55 f0             	mov    %edx,-0x10(%ebp)
80101685:	89 4d f4             	mov    %ecx,-0xc(%ebp)
80101688:	e8 c3 fd ff ff       	call   80101450 <balloc>
8010168d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80101690:	8b 55 f0             	mov    -0x10(%ebp),%edx
80101693:	89 81 8c 00 00 00    	mov    %eax,0x8c(%ecx)
80101699:	e9 26 ff ff ff       	jmp    801015c4 <bmap+0x24>
8010169e:	66 90                	xchg   %ax,%ax

801016a0 <readsb>:
{
801016a0:	55                   	push   %ebp
801016a1:	89 e5                	mov    %esp,%ebp
801016a3:	56                   	push   %esi
801016a4:	53                   	push   %ebx
801016a5:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
801016a8:	83 ec 08             	sub    $0x8,%esp
801016ab:	6a 01                	push   $0x1
801016ad:	ff 75 08             	push   0x8(%ebp)
801016b0:	e8 1b ea ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801016b5:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
801016b8:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801016ba:	8d 40 5c             	lea    0x5c(%eax),%eax
801016bd:	6a 2c                	push   $0x2c
801016bf:	50                   	push   %eax
801016c0:	56                   	push   %esi
801016c1:	e8 ca 36 00 00       	call   80104d90 <memmove>
  brelse(bp);
801016c6:	83 c4 10             	add    $0x10,%esp
801016c9:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801016cc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016cf:	5b                   	pop    %ebx
801016d0:	5e                   	pop    %esi
801016d1:	5d                   	pop    %ebp
  brelse(bp);
801016d2:	e9 29 eb ff ff       	jmp    80100200 <brelse>
801016d7:	90                   	nop
801016d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801016df:	00 

801016e0 <iinit>:
{
801016e0:	55                   	push   %ebp
801016e1:	89 e5                	mov    %esp,%ebp
801016e3:	53                   	push   %ebx
801016e4:	bb a0 09 11 80       	mov    $0x801109a0,%ebx
801016e9:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
801016ec:	68 de 79 10 80       	push   $0x801079de
801016f1:	68 60 09 11 80       	push   $0x80110960
801016f6:	e8 c5 32 00 00       	call   801049c0 <initlock>
  for(i = 0; i < NINODE; i++) {
801016fb:	83 c4 10             	add    $0x10,%esp
801016fe:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101700:	83 ec 08             	sub    $0x8,%esp
80101703:	68 e5 79 10 80       	push   $0x801079e5
80101708:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
80101709:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
8010170f:	e8 6c 31 00 00       	call   80104880 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101714:	83 c4 10             	add    $0x10,%esp
80101717:	81 fb c0 25 11 80    	cmp    $0x801125c0,%ebx
8010171d:	75 e1                	jne    80101700 <iinit+0x20>
  bp = bread(dev, 1);
8010171f:	83 ec 08             	sub    $0x8,%esp
80101722:	6a 01                	push   $0x1
80101724:	ff 75 08             	push   0x8(%ebp)
80101727:	e8 a4 e9 ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
8010172c:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
8010172f:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101731:	8d 40 5c             	lea    0x5c(%eax),%eax
80101734:	6a 2c                	push   $0x2c
80101736:	50                   	push   %eax
80101737:	68 c0 25 11 80       	push   $0x801125c0
8010173c:	e8 4f 36 00 00       	call   80104d90 <memmove>
  brelse(bp);
80101741:	89 1c 24             	mov    %ebx,(%esp)
80101744:	e8 b7 ea ff ff       	call   80100200 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101749:	ff 35 dc 25 11 80    	push   0x801125dc
8010174f:	ff 35 d8 25 11 80    	push   0x801125d8
80101755:	ff 35 d4 25 11 80    	push   0x801125d4
8010175b:	ff 35 d0 25 11 80    	push   0x801125d0
80101761:	ff 35 cc 25 11 80    	push   0x801125cc
80101767:	ff 35 c8 25 11 80    	push   0x801125c8
8010176d:	ff 35 c4 25 11 80    	push   0x801125c4
80101773:	68 30 7e 10 80       	push   $0x80107e30
80101778:	e8 53 ef ff ff       	call   801006d0 <cprintf>
}
8010177d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101780:	83 c4 30             	add    $0x30,%esp
80101783:	c9                   	leave
80101784:	c3                   	ret
80101785:	8d 76 00             	lea    0x0(%esi),%esi
80101788:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010178f:	00 

80101790 <ialloc>:
{
80101790:	55                   	push   %ebp
80101791:	89 e5                	mov    %esp,%ebp
80101793:	57                   	push   %edi
80101794:	56                   	push   %esi
80101795:	53                   	push   %ebx
80101796:	83 ec 1c             	sub    $0x1c,%esp
80101799:	8b 45 0c             	mov    0xc(%ebp),%eax
8010179c:	8b 75 08             	mov    0x8(%ebp),%esi
8010179f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
801017a2:	83 3d cc 25 11 80 01 	cmpl   $0x1,0x801125cc
801017a9:	0f 86 ae 00 00 00    	jbe    8010185d <ialloc+0xcd>
801017af:	bb 01 00 00 00       	mov    $0x1,%ebx
801017b4:	eb 25                	jmp    801017db <ialloc+0x4b>
801017b6:	66 90                	xchg   %ax,%ax
801017b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801017bf:	00 
    brelse(bp);
801017c0:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
801017c3:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
801017c6:	57                   	push   %edi
801017c7:	e8 34 ea ff ff       	call   80100200 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
801017cc:	83 c4 10             	add    $0x10,%esp
801017cf:	3b 1d cc 25 11 80    	cmp    0x801125cc,%ebx
801017d5:	0f 83 82 00 00 00    	jae    8010185d <ialloc+0xcd>
    bp = bread(dev, IBLOCK(inum, sb));
801017db:	89 d8                	mov    %ebx,%eax
801017dd:	31 d2                	xor    %edx,%edx
801017df:	8b 0d d0 25 11 80    	mov    0x801125d0,%ecx
801017e5:	83 ec 08             	sub    $0x8,%esp
801017e8:	f7 35 e4 25 11 80    	divl   0x801125e4
801017ee:	03 0d d4 25 11 80    	add    0x801125d4,%ecx
801017f4:	0f af 05 e0 25 11 80 	imul   0x801125e0,%eax
801017fb:	01 c8                	add    %ecx,%eax
801017fd:	c1 ea 03             	shr    $0x3,%edx
80101800:	01 d0                	add    %edx,%eax
80101802:	50                   	push   %eax
80101803:	56                   	push   %esi
80101804:	e8 c7 e8 ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
80101809:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
8010180c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010180e:	89 d8                	mov    %ebx,%eax
80101810:	83 e0 07             	and    $0x7,%eax
80101813:	c1 e0 06             	shl    $0x6,%eax
80101816:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010181a:	66 83 39 00          	cmpw   $0x0,(%ecx)
8010181e:	75 a0                	jne    801017c0 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101820:	83 ec 04             	sub    $0x4,%esp
80101823:	6a 40                	push   $0x40
80101825:	6a 00                	push   $0x0
80101827:	51                   	push   %ecx
80101828:	89 4d e0             	mov    %ecx,-0x20(%ebp)
8010182b:	e8 d0 34 00 00       	call   80104d00 <memset>
      dip->type = type;
80101830:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101834:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101837:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010183a:	89 3c 24             	mov    %edi,(%esp)
8010183d:	e8 7e 19 00 00       	call   801031c0 <log_write>
      brelse(bp);
80101842:	89 3c 24             	mov    %edi,(%esp)
80101845:	e8 b6 e9 ff ff       	call   80100200 <brelse>
      return iget(dev, inum);
8010184a:	83 c4 10             	add    $0x10,%esp
}
8010184d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101850:	89 da                	mov    %ebx,%edx
80101852:	89 f0                	mov    %esi,%eax
}
80101854:	5b                   	pop    %ebx
80101855:	5e                   	pop    %esi
80101856:	5f                   	pop    %edi
80101857:	5d                   	pop    %ebp
      return iget(dev, inum);
80101858:	e9 f3 f9 ff ff       	jmp    80101250 <iget>
  panic("ialloc: no inodes");
8010185d:	83 ec 0c             	sub    $0xc,%esp
80101860:	68 eb 79 10 80       	push   $0x801079eb
80101865:	e8 36 eb ff ff       	call   801003a0 <panic>
8010186a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101870 <iupdate>:
{
80101870:	55                   	push   %ebp
80101871:	31 d2                	xor    %edx,%edx
80101873:	89 e5                	mov    %esp,%ebp
80101875:	56                   	push   %esi
80101876:	53                   	push   %ebx
80101877:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010187a:	8b 0d d0 25 11 80    	mov    0x801125d0,%ecx
80101880:	03 0d d4 25 11 80    	add    0x801125d4,%ecx
80101886:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101889:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010188c:	83 ec 08             	sub    $0x8,%esp
8010188f:	f7 35 e4 25 11 80    	divl   0x801125e4
80101895:	0f af 05 e0 25 11 80 	imul   0x801125e0,%eax
8010189c:	01 c8                	add    %ecx,%eax
8010189e:	c1 ea 03             	shr    $0x3,%edx
801018a1:	01 d0                	add    %edx,%eax
801018a3:	50                   	push   %eax
801018a4:	ff 73 a4             	push   -0x5c(%ebx)
801018a7:	e8 24 e8 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
801018ac:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801018b0:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801018b3:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801018b5:	8b 43 a8             	mov    -0x58(%ebx),%eax
801018b8:	83 e0 07             	and    $0x7,%eax
801018bb:	c1 e0 06             	shl    $0x6,%eax
  dip->type = ip->type;
801018be:	66 89 54 06 5c       	mov    %dx,0x5c(%esi,%eax,1)
  dip->major = ip->major;
801018c3:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
801018c7:	66 89 54 06 5e       	mov    %dx,0x5e(%esi,%eax,1)
  dip->minor = ip->minor;
801018cc:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
801018d0:	66 89 54 06 60       	mov    %dx,0x60(%esi,%eax,1)
  dip->nlink = ip->nlink;
801018d5:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
801018d9:	66 89 54 06 62       	mov    %dx,0x62(%esi,%eax,1)
  dip->size = ip->size;
801018de:	8b 53 fc             	mov    -0x4(%ebx),%edx
801018e1:	89 54 06 64          	mov    %edx,0x64(%esi,%eax,1)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801018e5:	8d 44 06 68          	lea    0x68(%esi,%eax,1),%eax
801018e9:	6a 34                	push   $0x34
801018eb:	53                   	push   %ebx
801018ec:	50                   	push   %eax
801018ed:	e8 9e 34 00 00       	call   80104d90 <memmove>
  log_write(bp);
801018f2:	89 34 24             	mov    %esi,(%esp)
801018f5:	e8 c6 18 00 00       	call   801031c0 <log_write>
  brelse(bp);
801018fa:	83 c4 10             	add    $0x10,%esp
801018fd:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101900:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101903:	5b                   	pop    %ebx
80101904:	5e                   	pop    %esi
80101905:	5d                   	pop    %ebp
  brelse(bp);
80101906:	e9 f5 e8 ff ff       	jmp    80100200 <brelse>
8010190b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80101910 <idup>:
{
80101910:	55                   	push   %ebp
80101911:	89 e5                	mov    %esp,%ebp
80101913:	53                   	push   %ebx
80101914:	83 ec 10             	sub    $0x10,%esp
80101917:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010191a:	68 60 09 11 80       	push   $0x80110960
8010191f:	e8 bc 32 00 00       	call   80104be0 <acquire>
  ip->ref++;
80101924:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101928:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
8010192f:	e8 4c 32 00 00       	call   80104b80 <release>
}
80101934:	89 d8                	mov    %ebx,%eax
80101936:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101939:	c9                   	leave
8010193a:	c3                   	ret
8010193b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80101940 <ilock>:
{
80101940:	55                   	push   %ebp
80101941:	89 e5                	mov    %esp,%ebp
80101943:	53                   	push   %ebx
80101944:	83 ec 14             	sub    $0x14,%esp
80101947:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
8010194a:	85 db                	test   %ebx,%ebx
8010194c:	0f 84 d4 00 00 00    	je     80101a26 <ilock+0xe6>
80101952:	8b 53 08             	mov    0x8(%ebx),%edx
80101955:	85 d2                	test   %edx,%edx
80101957:	0f 8e c9 00 00 00    	jle    80101a26 <ilock+0xe6>
  acquiresleep(&ip->lock);
8010195d:	83 ec 0c             	sub    $0xc,%esp
80101960:	8d 43 0c             	lea    0xc(%ebx),%eax
80101963:	50                   	push   %eax
80101964:	e8 57 2f 00 00       	call   801048c0 <acquiresleep>
  if(ip->valid == 0){
80101969:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010196c:	83 c4 10             	add    $0x10,%esp
8010196f:	85 c0                	test   %eax,%eax
80101971:	74 0d                	je     80101980 <ilock+0x40>
}
80101973:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101976:	c9                   	leave
80101977:	c3                   	ret
80101978:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010197f:	00 
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101980:	8b 43 04             	mov    0x4(%ebx),%eax
80101983:	31 d2                	xor    %edx,%edx
80101985:	8b 0d d0 25 11 80    	mov    0x801125d0,%ecx
8010198b:	83 ec 08             	sub    $0x8,%esp
8010198e:	03 0d d4 25 11 80    	add    0x801125d4,%ecx
80101994:	f7 35 e4 25 11 80    	divl   0x801125e4
8010199a:	0f af 05 e0 25 11 80 	imul   0x801125e0,%eax
801019a1:	01 c8                	add    %ecx,%eax
801019a3:	c1 ea 03             	shr    $0x3,%edx
801019a6:	01 d0                	add    %edx,%eax
801019a8:	50                   	push   %eax
801019a9:	ff 33                	push   (%ebx)
801019ab:	e8 20 e7 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801019b0:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801019b3:	89 c2                	mov    %eax,%edx
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801019b5:	8b 43 04             	mov    0x4(%ebx),%eax
801019b8:	89 55 f4             	mov    %edx,-0xc(%ebp)
801019bb:	83 e0 07             	and    $0x7,%eax
801019be:	c1 e0 06             	shl    $0x6,%eax
801019c1:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    ip->type = dip->type;
801019c5:	0f b7 08             	movzwl (%eax),%ecx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801019c8:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
801019cb:	66 89 4b 50          	mov    %cx,0x50(%ebx)
    ip->major = dip->major;
801019cf:	0f b7 48 f6          	movzwl -0xa(%eax),%ecx
801019d3:	66 89 4b 52          	mov    %cx,0x52(%ebx)
    ip->minor = dip->minor;
801019d7:	0f b7 48 f8          	movzwl -0x8(%eax),%ecx
801019db:	66 89 4b 54          	mov    %cx,0x54(%ebx)
    ip->nlink = dip->nlink;
801019df:	0f b7 48 fa          	movzwl -0x6(%eax),%ecx
801019e3:	66 89 4b 56          	mov    %cx,0x56(%ebx)
    ip->size = dip->size;
801019e7:	8b 48 fc             	mov    -0x4(%eax),%ecx
801019ea:	89 4b 58             	mov    %ecx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801019ed:	6a 34                	push   $0x34
801019ef:	50                   	push   %eax
801019f0:	8d 43 5c             	lea    0x5c(%ebx),%eax
801019f3:	50                   	push   %eax
801019f4:	e8 97 33 00 00       	call   80104d90 <memmove>
    brelse(bp);
801019f9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801019fc:	89 14 24             	mov    %edx,(%esp)
801019ff:	e8 fc e7 ff ff       	call   80100200 <brelse>
    ip->valid = 1;
80101a04:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101a0b:	83 c4 10             	add    $0x10,%esp
80101a0e:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
80101a13:	0f 85 5a ff ff ff    	jne    80101973 <ilock+0x33>
      panic("ilock: no type");
80101a19:	83 ec 0c             	sub    $0xc,%esp
80101a1c:	68 03 7a 10 80       	push   $0x80107a03
80101a21:	e8 7a e9 ff ff       	call   801003a0 <panic>
    panic("ilock");
80101a26:	83 ec 0c             	sub    $0xc,%esp
80101a29:	68 fd 79 10 80       	push   $0x801079fd
80101a2e:	e8 6d e9 ff ff       	call   801003a0 <panic>
80101a33:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80101a38:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101a3f:	00 

80101a40 <iunlock>:
{
80101a40:	55                   	push   %ebp
80101a41:	89 e5                	mov    %esp,%ebp
80101a43:	56                   	push   %esi
80101a44:	53                   	push   %ebx
80101a45:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101a48:	85 db                	test   %ebx,%ebx
80101a4a:	74 28                	je     80101a74 <iunlock+0x34>
80101a4c:	83 ec 0c             	sub    $0xc,%esp
80101a4f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101a52:	56                   	push   %esi
80101a53:	e8 08 2f 00 00       	call   80104960 <holdingsleep>
80101a58:	83 c4 10             	add    $0x10,%esp
80101a5b:	85 c0                	test   %eax,%eax
80101a5d:	74 15                	je     80101a74 <iunlock+0x34>
80101a5f:	8b 43 08             	mov    0x8(%ebx),%eax
80101a62:	85 c0                	test   %eax,%eax
80101a64:	7e 0e                	jle    80101a74 <iunlock+0x34>
  releasesleep(&ip->lock);
80101a66:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101a69:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101a6c:	5b                   	pop    %ebx
80101a6d:	5e                   	pop    %esi
80101a6e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
80101a6f:	e9 ac 2e 00 00       	jmp    80104920 <releasesleep>
    panic("iunlock");
80101a74:	83 ec 0c             	sub    $0xc,%esp
80101a77:	68 12 7a 10 80       	push   $0x80107a12
80101a7c:	e8 1f e9 ff ff       	call   801003a0 <panic>
80101a81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101a88:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101a8f:	00 

80101a90 <iput>:
{
80101a90:	55                   	push   %ebp
80101a91:	89 e5                	mov    %esp,%ebp
80101a93:	57                   	push   %edi
80101a94:	56                   	push   %esi
80101a95:	53                   	push   %ebx
80101a96:	83 ec 28             	sub    $0x28,%esp
80101a99:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
80101a9c:	8d 73 0c             	lea    0xc(%ebx),%esi
80101a9f:	56                   	push   %esi
80101aa0:	e8 1b 2e 00 00       	call   801048c0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101aa5:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101aa8:	83 c4 10             	add    $0x10,%esp
80101aab:	85 d2                	test   %edx,%edx
80101aad:	74 07                	je     80101ab6 <iput+0x26>
80101aaf:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101ab4:	74 32                	je     80101ae8 <iput+0x58>
  releasesleep(&ip->lock);
80101ab6:	83 ec 0c             	sub    $0xc,%esp
80101ab9:	56                   	push   %esi
80101aba:	e8 61 2e 00 00       	call   80104920 <releasesleep>
  acquire(&icache.lock);
80101abf:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101ac6:	e8 15 31 00 00       	call   80104be0 <acquire>
  ip->ref--;
80101acb:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101acf:	83 c4 10             	add    $0x10,%esp
80101ad2:	c7 45 08 60 09 11 80 	movl   $0x80110960,0x8(%ebp)
}
80101ad9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101adc:	5b                   	pop    %ebx
80101add:	5e                   	pop    %esi
80101ade:	5f                   	pop    %edi
80101adf:	5d                   	pop    %ebp
  release(&icache.lock);
80101ae0:	e9 9b 30 00 00       	jmp    80104b80 <release>
80101ae5:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101ae8:	83 ec 0c             	sub    $0xc,%esp
80101aeb:	68 60 09 11 80       	push   $0x80110960
80101af0:	e8 eb 30 00 00       	call   80104be0 <acquire>
    int r = ip->ref;
80101af5:	8b 7b 08             	mov    0x8(%ebx),%edi
    release(&icache.lock);
80101af8:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101aff:	e8 7c 30 00 00       	call   80104b80 <release>
    if(r == 1){
80101b04:	83 c4 10             	add    $0x10,%esp
80101b07:	83 ff 01             	cmp    $0x1,%edi
80101b0a:	75 aa                	jne    80101ab6 <iput+0x26>
80101b0c:	89 f7                	mov    %esi,%edi
80101b0e:	89 d9                	mov    %ebx,%ecx
80101b10:	8d b3 8c 00 00 00    	lea    0x8c(%ebx),%esi
80101b16:	83 c3 5c             	add    $0x5c,%ebx
80101b19:	eb 0c                	jmp    80101b27 <iput+0x97>
80101b1b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101b20:	83 c3 04             	add    $0x4,%ebx
80101b23:	39 f3                	cmp    %esi,%ebx
80101b25:	74 21                	je     80101b48 <iput+0xb8>
    if(ip->addrs[i]){
80101b27:	8b 13                	mov    (%ebx),%edx
80101b29:	85 d2                	test   %edx,%edx
80101b2b:	74 f3                	je     80101b20 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
80101b2d:	8b 01                	mov    (%ecx),%eax
80101b2f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101b32:	e8 59 f8 ff ff       	call   80101390 <bfree>
      ip->addrs[i] = 0;
80101b37:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80101b3d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101b40:	eb de                	jmp    80101b20 <iput+0x90>
80101b42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101b48:	8b 81 8c 00 00 00    	mov    0x8c(%ecx),%eax
80101b4e:	89 fe                	mov    %edi,%esi
80101b50:	89 cb                	mov    %ecx,%ebx
80101b52:	85 c0                	test   %eax,%eax
80101b54:	75 2d                	jne    80101b83 <iput+0xf3>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80101b56:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101b59:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101b60:	53                   	push   %ebx
80101b61:	e8 0a fd ff ff       	call   80101870 <iupdate>
      ip->type = 0;
80101b66:	31 c0                	xor    %eax,%eax
80101b68:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101b6c:	89 1c 24             	mov    %ebx,(%esp)
80101b6f:	e8 fc fc ff ff       	call   80101870 <iupdate>
      ip->valid = 0;
80101b74:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101b7b:	83 c4 10             	add    $0x10,%esp
80101b7e:	e9 33 ff ff ff       	jmp    80101ab6 <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101b83:	83 ec 08             	sub    $0x8,%esp
80101b86:	50                   	push   %eax
80101b87:	ff 31                	push   (%ecx)
80101b89:	e8 42 e5 ff ff       	call   801000d0 <bread>
    for(j = 0; j < NINDIRECT; j++){
80101b8e:	83 c4 10             	add    $0x10,%esp
80101b91:	89 d9                	mov    %ebx,%ecx
80101b93:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101b96:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101b99:	8d 70 5c             	lea    0x5c(%eax),%esi
80101b9c:	8d 98 5c 02 00 00    	lea    0x25c(%eax),%ebx
80101ba2:	eb 13                	jmp    80101bb7 <iput+0x127>
80101ba4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ba8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101baf:	00 
80101bb0:	83 c6 04             	add    $0x4,%esi
80101bb3:	39 de                	cmp    %ebx,%esi
80101bb5:	74 15                	je     80101bcc <iput+0x13c>
      if(a[j])
80101bb7:	8b 16                	mov    (%esi),%edx
80101bb9:	85 d2                	test   %edx,%edx
80101bbb:	74 f3                	je     80101bb0 <iput+0x120>
        bfree(ip->dev, a[j]);
80101bbd:	8b 01                	mov    (%ecx),%eax
80101bbf:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101bc2:	e8 c9 f7 ff ff       	call   80101390 <bfree>
80101bc7:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101bca:	eb e4                	jmp    80101bb0 <iput+0x120>
    brelse(bp);
80101bcc:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101bcf:	83 ec 0c             	sub    $0xc,%esp
80101bd2:	8b 75 e0             	mov    -0x20(%ebp),%esi
80101bd5:	89 cb                	mov    %ecx,%ebx
80101bd7:	50                   	push   %eax
80101bd8:	e8 23 e6 ff ff       	call   80100200 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101bdd:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101be3:	8b 03                	mov    (%ebx),%eax
80101be5:	e8 a6 f7 ff ff       	call   80101390 <bfree>
    ip->addrs[NDIRECT] = 0;
80101bea:	83 c4 10             	add    $0x10,%esp
80101bed:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101bf4:	00 00 00 
80101bf7:	e9 5a ff ff ff       	jmp    80101b56 <iput+0xc6>
80101bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101c00 <iunlockput>:
{
80101c00:	55                   	push   %ebp
80101c01:	89 e5                	mov    %esp,%ebp
80101c03:	56                   	push   %esi
80101c04:	53                   	push   %ebx
80101c05:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101c08:	85 db                	test   %ebx,%ebx
80101c0a:	74 34                	je     80101c40 <iunlockput+0x40>
80101c0c:	83 ec 0c             	sub    $0xc,%esp
80101c0f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101c12:	56                   	push   %esi
80101c13:	e8 48 2d 00 00       	call   80104960 <holdingsleep>
80101c18:	83 c4 10             	add    $0x10,%esp
80101c1b:	85 c0                	test   %eax,%eax
80101c1d:	74 21                	je     80101c40 <iunlockput+0x40>
80101c1f:	8b 43 08             	mov    0x8(%ebx),%eax
80101c22:	85 c0                	test   %eax,%eax
80101c24:	7e 1a                	jle    80101c40 <iunlockput+0x40>
  releasesleep(&ip->lock);
80101c26:	83 ec 0c             	sub    $0xc,%esp
80101c29:	56                   	push   %esi
80101c2a:	e8 f1 2c 00 00       	call   80104920 <releasesleep>
  iput(ip);
80101c2f:	83 c4 10             	add    $0x10,%esp
80101c32:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101c35:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101c38:	5b                   	pop    %ebx
80101c39:	5e                   	pop    %esi
80101c3a:	5d                   	pop    %ebp
  iput(ip);
80101c3b:	e9 50 fe ff ff       	jmp    80101a90 <iput>
    panic("iunlock");
80101c40:	83 ec 0c             	sub    $0xc,%esp
80101c43:	68 12 7a 10 80       	push   $0x80107a12
80101c48:	e8 53 e7 ff ff       	call   801003a0 <panic>
80101c4d:	8d 76 00             	lea    0x0(%esi),%esi

80101c50 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101c50:	55                   	push   %ebp
80101c51:	89 e5                	mov    %esp,%ebp
80101c53:	8b 55 08             	mov    0x8(%ebp),%edx
80101c56:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101c59:	8b 0a                	mov    (%edx),%ecx
80101c5b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101c5e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101c61:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101c64:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101c68:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101c6b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101c6f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101c73:	8b 52 58             	mov    0x58(%edx),%edx
80101c76:	89 50 10             	mov    %edx,0x10(%eax)
}
80101c79:	5d                   	pop    %ebp
80101c7a:	c3                   	ret
80101c7b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80101c80 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101c80:	55                   	push   %ebp
80101c81:	89 e5                	mov    %esp,%ebp
80101c83:	57                   	push   %edi
80101c84:	56                   	push   %esi
80101c85:	53                   	push   %ebx
80101c86:	83 ec 1c             	sub    $0x1c,%esp
80101c89:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c8c:	8b 75 08             	mov    0x8(%ebp),%esi
80101c8f:	8b 7d 10             	mov    0x10(%ebp),%edi
80101c92:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101c95:	8b 45 14             	mov    0x14(%ebp),%eax
80101c98:	89 75 d8             	mov    %esi,-0x28(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101c9b:	66 83 7e 50 03       	cmpw   $0x3,0x50(%esi)
80101ca0:	0f 84 aa 00 00 00    	je     80101d50 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101ca6:	8b 75 d8             	mov    -0x28(%ebp),%esi
80101ca9:	8b 56 58             	mov    0x58(%esi),%edx
80101cac:	39 fa                	cmp    %edi,%edx
80101cae:	0f 82 bd 00 00 00    	jb     80101d71 <readi+0xf1>
80101cb4:	89 f9                	mov    %edi,%ecx
80101cb6:	31 db                	xor    %ebx,%ebx
80101cb8:	01 c1                	add    %eax,%ecx
80101cba:	0f 92 c3             	setb   %bl
80101cbd:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80101cc0:	0f 82 ab 00 00 00    	jb     80101d71 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101cc6:	89 d3                	mov    %edx,%ebx
80101cc8:	29 fb                	sub    %edi,%ebx
80101cca:	39 ca                	cmp    %ecx,%edx
80101ccc:	0f 42 c3             	cmovb  %ebx,%eax

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ccf:	85 c0                	test   %eax,%eax
80101cd1:	74 73                	je     80101d46 <readi+0xc6>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101cd3:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80101cd6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101cd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ce0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101ce3:	89 fa                	mov    %edi,%edx
80101ce5:	c1 ea 09             	shr    $0x9,%edx
80101ce8:	89 d8                	mov    %ebx,%eax
80101cea:	e8 b1 f8 ff ff       	call   801015a0 <bmap>
80101cef:	83 ec 08             	sub    $0x8,%esp
80101cf2:	50                   	push   %eax
80101cf3:	ff 33                	push   (%ebx)
80101cf5:	e8 d6 e3 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101cfa:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101cfd:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101d02:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101d04:	89 f8                	mov    %edi,%eax
80101d06:	25 ff 01 00 00       	and    $0x1ff,%eax
80101d0b:	29 f3                	sub    %esi,%ebx
80101d0d:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101d0f:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101d13:	39 d9                	cmp    %ebx,%ecx
80101d15:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101d18:	83 c4 0c             	add    $0xc,%esp
80101d1b:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101d1c:	01 de                	add    %ebx,%esi
80101d1e:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101d20:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101d23:	50                   	push   %eax
80101d24:	ff 75 e0             	push   -0x20(%ebp)
80101d27:	e8 64 30 00 00       	call   80104d90 <memmove>
    brelse(bp);
80101d2c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101d2f:	89 14 24             	mov    %edx,(%esp)
80101d32:	e8 c9 e4 ff ff       	call   80100200 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101d37:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101d3a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101d3d:	83 c4 10             	add    $0x10,%esp
80101d40:	39 de                	cmp    %ebx,%esi
80101d42:	72 9c                	jb     80101ce0 <readi+0x60>
80101d44:	89 d8                	mov    %ebx,%eax
  }
  return n;
}
80101d46:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d49:	5b                   	pop    %ebx
80101d4a:	5e                   	pop    %esi
80101d4b:	5f                   	pop    %edi
80101d4c:	5d                   	pop    %ebp
80101d4d:	c3                   	ret
80101d4e:	66 90                	xchg   %ax,%ax
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101d50:	0f bf 56 52          	movswl 0x52(%esi),%edx
80101d54:	66 83 fa 09          	cmp    $0x9,%dx
80101d58:	77 17                	ja     80101d71 <readi+0xf1>
80101d5a:	8b 14 d5 00 09 11 80 	mov    -0x7feef700(,%edx,8),%edx
80101d61:	85 d2                	test   %edx,%edx
80101d63:	74 0c                	je     80101d71 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101d65:	89 45 10             	mov    %eax,0x10(%ebp)
}
80101d68:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d6b:	5b                   	pop    %ebx
80101d6c:	5e                   	pop    %esi
80101d6d:	5f                   	pop    %edi
80101d6e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101d6f:	ff e2                	jmp    *%edx
      return -1;
80101d71:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101d76:	eb ce                	jmp    80101d46 <readi+0xc6>
80101d78:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101d7f:	00 

80101d80 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101d80:	55                   	push   %ebp
80101d81:	89 e5                	mov    %esp,%ebp
80101d83:	57                   	push   %edi
80101d84:	56                   	push   %esi
80101d85:	53                   	push   %ebx
80101d86:	83 ec 1c             	sub    $0x1c,%esp
80101d89:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101d8c:	8b 55 14             	mov    0x14(%ebp),%edx
80101d8f:	8b 45 08             	mov    0x8(%ebp),%eax
80101d92:	89 7d dc             	mov    %edi,-0x24(%ebp)
80101d95:	8b 7d 10             	mov    0x10(%ebp),%edi
80101d98:	89 55 e0             	mov    %edx,-0x20(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101d9b:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
80101da0:	0f 84 ba 00 00 00    	je     80101e60 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101da6:	39 78 58             	cmp    %edi,0x58(%eax)
80101da9:	0f 82 ea 00 00 00    	jb     80101e99 <writei+0x119>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101daf:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101db2:	89 ca                	mov    %ecx,%edx
80101db4:	01 fa                	add    %edi,%edx
80101db6:	0f 82 dd 00 00 00    	jb     80101e99 <writei+0x119>
80101dbc:	81 fa 00 18 01 00    	cmp    $0x11800,%edx
80101dc2:	0f 87 d1 00 00 00    	ja     80101e99 <writei+0x119>
    log_write(bp);
    brelse(bp);
  }*/

  // IN writei (fs.c) - The FIX
for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101dc8:	85 c9                	test   %ecx,%ecx
80101dca:	0f 84 85 00 00 00    	je     80101e55 <writei+0xd5>
80101dd0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  uint addr = bmap(ip, off/BSIZE); // 1. Get address first
  if(addr == 0)                    // 2. Check if disk is full
    break;                         // 3. Stop writing gracefully

  bp = bread(ip->dev, addr);       // 4. Only read if address is valid
  m = min(n - tot, BSIZE - off%BSIZE);
80101dd7:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101dda:	eb 5e                	jmp    80101e3a <writei+0xba>
80101ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bp = bread(ip->dev, addr);       // 4. Only read if address is valid
80101de0:	83 ec 08             	sub    $0x8,%esp
80101de3:	50                   	push   %eax
80101de4:	ff 36                	push   (%esi)
80101de6:	e8 e5 e2 ff ff       	call   801000d0 <bread>
  m = min(n - tot, BSIZE - off%BSIZE);
80101deb:	b9 00 02 00 00       	mov    $0x200,%ecx
80101df0:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101df3:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
  bp = bread(ip->dev, addr);       // 4. Only read if address is valid
80101df6:	89 c6                	mov    %eax,%esi
  m = min(n - tot, BSIZE - off%BSIZE);
80101df8:	89 f8                	mov    %edi,%eax
80101dfa:	25 ff 01 00 00       	and    $0x1ff,%eax
80101dff:	29 c1                	sub    %eax,%ecx
  memmove(bp->data + off%BSIZE, src, m);
80101e01:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  m = min(n - tot, BSIZE - off%BSIZE);
80101e05:	39 d9                	cmp    %ebx,%ecx
80101e07:	0f 46 d9             	cmovbe %ecx,%ebx
  memmove(bp->data + off%BSIZE, src, m);
80101e0a:	83 c4 0c             	add    $0xc,%esp
80101e0d:	53                   	push   %ebx
for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101e0e:	01 df                	add    %ebx,%edi
  memmove(bp->data + off%BSIZE, src, m);
80101e10:	ff 75 dc             	push   -0x24(%ebp)
80101e13:	50                   	push   %eax
80101e14:	e8 77 2f 00 00       	call   80104d90 <memmove>
  log_write(bp);
80101e19:	89 34 24             	mov    %esi,(%esp)
80101e1c:	e8 9f 13 00 00       	call   801031c0 <log_write>
  brelse(bp);
80101e21:	89 34 24             	mov    %esi,(%esp)
80101e24:	e8 d7 e3 ff ff       	call   80100200 <brelse>
for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101e29:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101e2c:	83 c4 10             	add    $0x10,%esp
80101e2f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101e32:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101e35:	3b 45 e0             	cmp    -0x20(%ebp),%eax
80101e38:	73 13                	jae    80101e4d <writei+0xcd>
  uint addr = bmap(ip, off/BSIZE); // 1. Get address first
80101e3a:	8b 75 d8             	mov    -0x28(%ebp),%esi
80101e3d:	89 fa                	mov    %edi,%edx
80101e3f:	c1 ea 09             	shr    $0x9,%edx
80101e42:	89 f0                	mov    %esi,%eax
80101e44:	e8 57 f7 ff ff       	call   801015a0 <bmap>
  if(addr == 0)                    // 2. Check if disk is full
80101e49:	85 c0                	test   %eax,%eax
80101e4b:	75 93                	jne    80101de0 <writei+0x60>
} 
//** fix */
  if(n > 0 && off > ip->size){
80101e4d:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101e50:	39 78 58             	cmp    %edi,0x58(%eax)
80101e53:	72 33                	jb     80101e88 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101e55:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101e58:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e5b:	5b                   	pop    %ebx
80101e5c:	5e                   	pop    %esi
80101e5d:	5f                   	pop    %edi
80101e5e:	5d                   	pop    %ebp
80101e5f:	c3                   	ret
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101e60:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101e64:	66 83 f8 09          	cmp    $0x9,%ax
80101e68:	77 2f                	ja     80101e99 <writei+0x119>
80101e6a:	8b 04 c5 04 09 11 80 	mov    -0x7feef6fc(,%eax,8),%eax
80101e71:	85 c0                	test   %eax,%eax
80101e73:	74 24                	je     80101e99 <writei+0x119>
    return devsw[ip->major].write(ip, src, n);
80101e75:	89 55 10             	mov    %edx,0x10(%ebp)
}
80101e78:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e7b:	5b                   	pop    %ebx
80101e7c:	5e                   	pop    %esi
80101e7d:	5f                   	pop    %edi
80101e7e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101e7f:	ff e0                	jmp    *%eax
80101e81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    iupdate(ip);
80101e88:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101e8b:	89 78 58             	mov    %edi,0x58(%eax)
    iupdate(ip);
80101e8e:	50                   	push   %eax
80101e8f:	e8 dc f9 ff ff       	call   80101870 <iupdate>
80101e94:	83 c4 10             	add    $0x10,%esp
80101e97:	eb bc                	jmp    80101e55 <writei+0xd5>
      return -1;
80101e99:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101e9e:	eb b8                	jmp    80101e58 <writei+0xd8>

80101ea0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101ea0:	55                   	push   %ebp
80101ea1:	89 e5                	mov    %esp,%ebp
80101ea3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101ea6:	6a 0e                	push   $0xe
80101ea8:	ff 75 0c             	push   0xc(%ebp)
80101eab:	ff 75 08             	push   0x8(%ebp)
80101eae:	e8 4d 2f 00 00       	call   80104e00 <strncmp>
}
80101eb3:	c9                   	leave
80101eb4:	c3                   	ret
80101eb5:	8d 76 00             	lea    0x0(%esi),%esi
80101eb8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101ebf:	00 

80101ec0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101ec0:	55                   	push   %ebp
80101ec1:	89 e5                	mov    %esp,%ebp
80101ec3:	57                   	push   %edi
80101ec4:	56                   	push   %esi
80101ec5:	53                   	push   %ebx
80101ec6:	83 ec 1c             	sub    $0x1c,%esp
80101ec9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101ecc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101ed1:	0f 85 8d 00 00 00    	jne    80101f64 <dirlookup+0xa4>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101ed7:	8b 53 58             	mov    0x58(%ebx),%edx
80101eda:	31 ff                	xor    %edi,%edi
80101edc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101edf:	85 d2                	test   %edx,%edx
80101ee1:	74 46                	je     80101f29 <dirlookup+0x69>
80101ee3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80101ee8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101eef:	00 
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ef0:	6a 10                	push   $0x10
80101ef2:	57                   	push   %edi
80101ef3:	56                   	push   %esi
80101ef4:	53                   	push   %ebx
80101ef5:	e8 86 fd ff ff       	call   80101c80 <readi>
80101efa:	83 c4 10             	add    $0x10,%esp
80101efd:	83 f8 10             	cmp    $0x10,%eax
80101f00:	75 55                	jne    80101f57 <dirlookup+0x97>
      panic("dirlookup read");
    if(de.inum == 0)
80101f02:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101f07:	74 18                	je     80101f21 <dirlookup+0x61>
  return strncmp(s, t, DIRSIZ);
80101f09:	83 ec 04             	sub    $0x4,%esp
80101f0c:	8d 45 da             	lea    -0x26(%ebp),%eax
80101f0f:	6a 0e                	push   $0xe
80101f11:	50                   	push   %eax
80101f12:	ff 75 0c             	push   0xc(%ebp)
80101f15:	e8 e6 2e 00 00       	call   80104e00 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101f1a:	83 c4 10             	add    $0x10,%esp
80101f1d:	85 c0                	test   %eax,%eax
80101f1f:	74 17                	je     80101f38 <dirlookup+0x78>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101f21:	83 c7 10             	add    $0x10,%edi
80101f24:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101f27:	72 c7                	jb     80101ef0 <dirlookup+0x30>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101f29:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101f2c:	31 c0                	xor    %eax,%eax
}
80101f2e:	5b                   	pop    %ebx
80101f2f:	5e                   	pop    %esi
80101f30:	5f                   	pop    %edi
80101f31:	5d                   	pop    %ebp
80101f32:	c3                   	ret
80101f33:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(poff)
80101f38:	8b 45 10             	mov    0x10(%ebp),%eax
80101f3b:	85 c0                	test   %eax,%eax
80101f3d:	74 05                	je     80101f44 <dirlookup+0x84>
        *poff = off;
80101f3f:	8b 45 10             	mov    0x10(%ebp),%eax
80101f42:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101f44:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101f48:	8b 03                	mov    (%ebx),%eax
80101f4a:	e8 01 f3 ff ff       	call   80101250 <iget>
}
80101f4f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f52:	5b                   	pop    %ebx
80101f53:	5e                   	pop    %esi
80101f54:	5f                   	pop    %edi
80101f55:	5d                   	pop    %ebp
80101f56:	c3                   	ret
      panic("dirlookup read");
80101f57:	83 ec 0c             	sub    $0xc,%esp
80101f5a:	68 2c 7a 10 80       	push   $0x80107a2c
80101f5f:	e8 3c e4 ff ff       	call   801003a0 <panic>
    panic("dirlookup not DIR");
80101f64:	83 ec 0c             	sub    $0xc,%esp
80101f67:	68 1a 7a 10 80       	push   $0x80107a1a
80101f6c:	e8 2f e4 ff ff       	call   801003a0 <panic>
80101f71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f78:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101f7f:	00 

80101f80 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101f80:	55                   	push   %ebp
80101f81:	89 e5                	mov    %esp,%ebp
80101f83:	57                   	push   %edi
80101f84:	56                   	push   %esi
80101f85:	53                   	push   %ebx
80101f86:	89 c3                	mov    %eax,%ebx
80101f88:	83 ec 1c             	sub    $0x1c,%esp
80101f8b:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101f8e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
80101f91:	80 38 2f             	cmpb   $0x2f,(%eax)
80101f94:	0f 84 bc 01 00 00    	je     80102156 <namex+0x1d6>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101f9a:	e8 a1 1c 00 00       	call   80103c40 <myproc>
  acquire(&icache.lock);
80101f9f:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101fa2:	8b 70 6c             	mov    0x6c(%eax),%esi
  acquire(&icache.lock);
80101fa5:	68 60 09 11 80       	push   $0x80110960
80101faa:	e8 31 2c 00 00       	call   80104be0 <acquire>
  ip->ref++;
80101faf:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101fb3:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101fba:	e8 c1 2b 00 00       	call   80104b80 <release>
80101fbf:	83 c4 10             	add    $0x10,%esp
80101fc2:	eb 0f                	jmp    80101fd3 <namex+0x53>
80101fc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101fc8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101fcf:	00 
    path++;
80101fd0:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101fd3:	0f b6 03             	movzbl (%ebx),%eax
80101fd6:	3c 2f                	cmp    $0x2f,%al
80101fd8:	74 f6                	je     80101fd0 <namex+0x50>
  if(*path == 0)
80101fda:	84 c0                	test   %al,%al
80101fdc:	0f 84 16 01 00 00    	je     801020f8 <namex+0x178>
  while(*path != '/' && *path != 0)
80101fe2:	0f b6 03             	movzbl (%ebx),%eax
80101fe5:	84 c0                	test   %al,%al
80101fe7:	0f 84 23 01 00 00    	je     80102110 <namex+0x190>
80101fed:	89 df                	mov    %ebx,%edi
80101fef:	3c 2f                	cmp    $0x2f,%al
80101ff1:	0f 84 19 01 00 00    	je     80102110 <namex+0x190>
80101ff7:	90                   	nop
80101ff8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101fff:	00 
80102000:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
80102004:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
80102007:	3c 2f                	cmp    $0x2f,%al
80102009:	74 04                	je     8010200f <namex+0x8f>
8010200b:	84 c0                	test   %al,%al
8010200d:	75 f1                	jne    80102000 <namex+0x80>
  len = path - s;
8010200f:	89 f8                	mov    %edi,%eax
80102011:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
80102013:	83 f8 0d             	cmp    $0xd,%eax
80102016:	0f 8e b4 00 00 00    	jle    801020d0 <namex+0x150>
    memmove(name, s, DIRSIZ);
8010201c:	83 ec 04             	sub    $0x4,%esp
8010201f:	6a 0e                	push   $0xe
80102021:	53                   	push   %ebx
80102022:	89 fb                	mov    %edi,%ebx
80102024:	ff 75 e4             	push   -0x1c(%ebp)
80102027:	e8 64 2d 00 00       	call   80104d90 <memmove>
8010202c:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
8010202f:	80 3f 2f             	cmpb   $0x2f,(%edi)
80102032:	75 14                	jne    80102048 <namex+0xc8>
80102034:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102038:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010203f:	00 
    path++;
80102040:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80102043:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80102046:	74 f8                	je     80102040 <namex+0xc0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80102048:	83 ec 0c             	sub    $0xc,%esp
8010204b:	56                   	push   %esi
8010204c:	e8 ef f8 ff ff       	call   80101940 <ilock>
    if(ip->type != T_DIR){
80102051:	83 c4 10             	add    $0x10,%esp
80102054:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80102059:	0f 85 bd 00 00 00    	jne    8010211c <namex+0x19c>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
8010205f:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102062:	85 c0                	test   %eax,%eax
80102064:	74 09                	je     8010206f <namex+0xef>
80102066:	80 3b 00             	cmpb   $0x0,(%ebx)
80102069:	0f 84 fd 00 00 00    	je     8010216c <namex+0x1ec>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
8010206f:	83 ec 04             	sub    $0x4,%esp
80102072:	6a 00                	push   $0x0
80102074:	ff 75 e4             	push   -0x1c(%ebp)
80102077:	56                   	push   %esi
80102078:	e8 43 fe ff ff       	call   80101ec0 <dirlookup>
8010207d:	83 c4 10             	add    $0x10,%esp
80102080:	89 c7                	mov    %eax,%edi
80102082:	85 c0                	test   %eax,%eax
80102084:	0f 84 92 00 00 00    	je     8010211c <namex+0x19c>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
8010208a:	83 ec 0c             	sub    $0xc,%esp
8010208d:	8d 4e 0c             	lea    0xc(%esi),%ecx
80102090:	51                   	push   %ecx
80102091:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80102094:	e8 c7 28 00 00       	call   80104960 <holdingsleep>
80102099:	83 c4 10             	add    $0x10,%esp
8010209c:	85 c0                	test   %eax,%eax
8010209e:	0f 84 08 01 00 00    	je     801021ac <namex+0x22c>
801020a4:	8b 56 08             	mov    0x8(%esi),%edx
801020a7:	85 d2                	test   %edx,%edx
801020a9:	0f 8e fd 00 00 00    	jle    801021ac <namex+0x22c>
  releasesleep(&ip->lock);
801020af:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801020b2:	83 ec 0c             	sub    $0xc,%esp
801020b5:	51                   	push   %ecx
801020b6:	e8 65 28 00 00       	call   80104920 <releasesleep>
  iput(ip);
801020bb:	89 34 24             	mov    %esi,(%esp)
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
    ip = next;
801020be:	89 fe                	mov    %edi,%esi
  iput(ip);
801020c0:	e8 cb f9 ff ff       	call   80101a90 <iput>
801020c5:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
801020c8:	e9 06 ff ff ff       	jmp    80101fd3 <namex+0x53>
801020cd:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
801020d0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801020d3:	01 c2                	add    %eax,%edx
801020d5:	89 55 e0             	mov    %edx,-0x20(%ebp)
    memmove(name, s, len);
801020d8:	83 ec 04             	sub    $0x4,%esp
801020db:	50                   	push   %eax
801020dc:	53                   	push   %ebx
    name[len] = 0;
801020dd:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
801020df:	ff 75 e4             	push   -0x1c(%ebp)
801020e2:	e8 a9 2c 00 00       	call   80104d90 <memmove>
    name[len] = 0;
801020e7:	8b 45 e0             	mov    -0x20(%ebp),%eax
801020ea:	83 c4 10             	add    $0x10,%esp
801020ed:	c6 00 00             	movb   $0x0,(%eax)
801020f0:	e9 3a ff ff ff       	jmp    8010202f <namex+0xaf>
801020f5:	8d 76 00             	lea    0x0(%esi),%esi
  }
  if(nameiparent){
801020f8:	8b 45 dc             	mov    -0x24(%ebp),%eax
801020fb:	85 c0                	test   %eax,%eax
801020fd:	0f 85 99 00 00 00    	jne    8010219c <namex+0x21c>
    iput(ip);
    return 0;
  }
  return ip;
}
80102103:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102106:	89 f0                	mov    %esi,%eax
80102108:	5b                   	pop    %ebx
80102109:	5e                   	pop    %esi
8010210a:	5f                   	pop    %edi
8010210b:	5d                   	pop    %ebp
8010210c:	c3                   	ret
8010210d:	8d 76 00             	lea    0x0(%esi),%esi
  while(*path != '/' && *path != 0)
80102110:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102113:	89 df                	mov    %ebx,%edi
80102115:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102118:	31 c0                	xor    %eax,%eax
8010211a:	eb bc                	jmp    801020d8 <namex+0x158>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
8010211c:	83 ec 0c             	sub    $0xc,%esp
8010211f:	8d 5e 0c             	lea    0xc(%esi),%ebx
80102122:	53                   	push   %ebx
80102123:	e8 38 28 00 00       	call   80104960 <holdingsleep>
80102128:	83 c4 10             	add    $0x10,%esp
8010212b:	85 c0                	test   %eax,%eax
8010212d:	74 7d                	je     801021ac <namex+0x22c>
8010212f:	8b 4e 08             	mov    0x8(%esi),%ecx
80102132:	85 c9                	test   %ecx,%ecx
80102134:	7e 76                	jle    801021ac <namex+0x22c>
  releasesleep(&ip->lock);
80102136:	83 ec 0c             	sub    $0xc,%esp
80102139:	53                   	push   %ebx
8010213a:	e8 e1 27 00 00       	call   80104920 <releasesleep>
  iput(ip);
8010213f:	89 34 24             	mov    %esi,(%esp)
      return 0;
80102142:	31 f6                	xor    %esi,%esi
  iput(ip);
80102144:	e8 47 f9 ff ff       	call   80101a90 <iput>
      return 0;
80102149:	83 c4 10             	add    $0x10,%esp
}
8010214c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010214f:	89 f0                	mov    %esi,%eax
80102151:	5b                   	pop    %ebx
80102152:	5e                   	pop    %esi
80102153:	5f                   	pop    %edi
80102154:	5d                   	pop    %ebp
80102155:	c3                   	ret
    ip = iget(ROOTDEV, ROOTINO);
80102156:	ba 01 00 00 00       	mov    $0x1,%edx
8010215b:	b8 01 00 00 00       	mov    $0x1,%eax
80102160:	e8 eb f0 ff ff       	call   80101250 <iget>
80102165:	89 c6                	mov    %eax,%esi
80102167:	e9 67 fe ff ff       	jmp    80101fd3 <namex+0x53>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
8010216c:	83 ec 0c             	sub    $0xc,%esp
8010216f:	8d 5e 0c             	lea    0xc(%esi),%ebx
80102172:	53                   	push   %ebx
80102173:	e8 e8 27 00 00       	call   80104960 <holdingsleep>
80102178:	83 c4 10             	add    $0x10,%esp
8010217b:	85 c0                	test   %eax,%eax
8010217d:	74 2d                	je     801021ac <namex+0x22c>
8010217f:	8b 7e 08             	mov    0x8(%esi),%edi
80102182:	85 ff                	test   %edi,%edi
80102184:	7e 26                	jle    801021ac <namex+0x22c>
  releasesleep(&ip->lock);
80102186:	83 ec 0c             	sub    $0xc,%esp
80102189:	53                   	push   %ebx
8010218a:	e8 91 27 00 00       	call   80104920 <releasesleep>
}
8010218f:	83 c4 10             	add    $0x10,%esp
}
80102192:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102195:	89 f0                	mov    %esi,%eax
80102197:	5b                   	pop    %ebx
80102198:	5e                   	pop    %esi
80102199:	5f                   	pop    %edi
8010219a:	5d                   	pop    %ebp
8010219b:	c3                   	ret
    iput(ip);
8010219c:	83 ec 0c             	sub    $0xc,%esp
8010219f:	56                   	push   %esi
      return 0;
801021a0:	31 f6                	xor    %esi,%esi
    iput(ip);
801021a2:	e8 e9 f8 ff ff       	call   80101a90 <iput>
    return 0;
801021a7:	83 c4 10             	add    $0x10,%esp
801021aa:	eb a0                	jmp    8010214c <namex+0x1cc>
    panic("iunlock");
801021ac:	83 ec 0c             	sub    $0xc,%esp
801021af:	68 12 7a 10 80       	push   $0x80107a12
801021b4:	e8 e7 e1 ff ff       	call   801003a0 <panic>
801021b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801021c0 <dirlink>:
{
801021c0:	55                   	push   %ebp
801021c1:	89 e5                	mov    %esp,%ebp
801021c3:	57                   	push   %edi
801021c4:	56                   	push   %esi
801021c5:	53                   	push   %ebx
801021c6:	83 ec 20             	sub    $0x20,%esp
801021c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
801021cc:	6a 00                	push   $0x0
801021ce:	ff 75 0c             	push   0xc(%ebp)
801021d1:	53                   	push   %ebx
801021d2:	e8 e9 fc ff ff       	call   80101ec0 <dirlookup>
801021d7:	83 c4 10             	add    $0x10,%esp
801021da:	85 c0                	test   %eax,%eax
801021dc:	75 67                	jne    80102245 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
801021de:	8b 7b 58             	mov    0x58(%ebx),%edi
801021e1:	8d 75 d8             	lea    -0x28(%ebp),%esi
801021e4:	85 ff                	test   %edi,%edi
801021e6:	74 29                	je     80102211 <dirlink+0x51>
801021e8:	31 ff                	xor    %edi,%edi
801021ea:	8d 75 d8             	lea    -0x28(%ebp),%esi
801021ed:	eb 09                	jmp    801021f8 <dirlink+0x38>
801021ef:	90                   	nop
801021f0:	83 c7 10             	add    $0x10,%edi
801021f3:	3b 7b 58             	cmp    0x58(%ebx),%edi
801021f6:	73 19                	jae    80102211 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801021f8:	6a 10                	push   $0x10
801021fa:	57                   	push   %edi
801021fb:	56                   	push   %esi
801021fc:	53                   	push   %ebx
801021fd:	e8 7e fa ff ff       	call   80101c80 <readi>
80102202:	83 c4 10             	add    $0x10,%esp
80102205:	83 f8 10             	cmp    $0x10,%eax
80102208:	75 4e                	jne    80102258 <dirlink+0x98>
    if(de.inum == 0)
8010220a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010220f:	75 df                	jne    801021f0 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80102211:	83 ec 04             	sub    $0x4,%esp
80102214:	8d 45 da             	lea    -0x26(%ebp),%eax
80102217:	6a 0e                	push   $0xe
80102219:	ff 75 0c             	push   0xc(%ebp)
8010221c:	50                   	push   %eax
8010221d:	e8 2e 2c 00 00       	call   80104e50 <strncpy>
  de.inum = inum;
80102222:	8b 45 10             	mov    0x10(%ebp),%eax
80102225:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102229:	6a 10                	push   $0x10
8010222b:	57                   	push   %edi
8010222c:	56                   	push   %esi
8010222d:	53                   	push   %ebx
8010222e:	e8 4d fb ff ff       	call   80101d80 <writei>
80102233:	83 c4 20             	add    $0x20,%esp
80102236:	83 f8 10             	cmp    $0x10,%eax
80102239:	75 2a                	jne    80102265 <dirlink+0xa5>
  return 0;
8010223b:	31 c0                	xor    %eax,%eax
}
8010223d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102240:	5b                   	pop    %ebx
80102241:	5e                   	pop    %esi
80102242:	5f                   	pop    %edi
80102243:	5d                   	pop    %ebp
80102244:	c3                   	ret
    iput(ip);
80102245:	83 ec 0c             	sub    $0xc,%esp
80102248:	50                   	push   %eax
80102249:	e8 42 f8 ff ff       	call   80101a90 <iput>
    return -1;
8010224e:	83 c4 10             	add    $0x10,%esp
80102251:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102256:	eb e5                	jmp    8010223d <dirlink+0x7d>
      panic("dirlink read");
80102258:	83 ec 0c             	sub    $0xc,%esp
8010225b:	68 3b 7a 10 80       	push   $0x80107a3b
80102260:	e8 3b e1 ff ff       	call   801003a0 <panic>
    panic("dirlink");
80102265:	83 ec 0c             	sub    $0xc,%esp
80102268:	68 ce 7c 10 80       	push   $0x80107cce
8010226d:	e8 2e e1 ff ff       	call   801003a0 <panic>
80102272:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102278:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010227f:	00 

80102280 <namei>:

struct inode*
namei(char *path)
{
80102280:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102281:	31 d2                	xor    %edx,%edx
{
80102283:	89 e5                	mov    %esp,%ebp
80102285:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80102288:	8b 45 08             	mov    0x8(%ebp),%eax
8010228b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
8010228e:	e8 ed fc ff ff       	call   80101f80 <namex>
}
80102293:	c9                   	leave
80102294:	c3                   	ret
80102295:	8d 76 00             	lea    0x0(%esi),%esi
80102298:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010229f:	00 

801022a0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
801022a0:	55                   	push   %ebp
  return namex(path, 1, name);
801022a1:	ba 01 00 00 00       	mov    $0x1,%edx
{
801022a6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
801022a8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801022ab:	8b 45 08             	mov    0x8(%ebp),%eax
}
801022ae:	5d                   	pop    %ebp
  return namex(path, 1, name);
801022af:	e9 cc fc ff ff       	jmp    80101f80 <namex>
801022b4:	66 90                	xchg   %ax,%ax
801022b6:	66 90                	xchg   %ax,%ax
801022b8:	66 90                	xchg   %ax,%ax
801022ba:	66 90                	xchg   %ax,%ax
801022bc:	66 90                	xchg   %ax,%ax
801022be:	66 90                	xchg   %ax,%ax

801022c0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801022c0:	55                   	push   %ebp
801022c1:	89 e5                	mov    %esp,%ebp
801022c3:	57                   	push   %edi
801022c4:	56                   	push   %esi
801022c5:	53                   	push   %ebx
801022c6:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
801022c9:	85 c0                	test   %eax,%eax
801022cb:	0f 84 ac 00 00 00    	je     8010237d <idestart+0xbd>
    panic("idestart");
  if(b->blockno >= FSSIZE)
801022d1:	8b 70 08             	mov    0x8(%eax),%esi
801022d4:	89 c3                	mov    %eax,%ebx
801022d6:	81 fe 1f 4e 00 00    	cmp    $0x4e1f,%esi
801022dc:	0f 87 8e 00 00 00    	ja     80102370 <idestart+0xb0>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801022e2:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
801022e7:	90                   	nop
801022e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801022ef:	00 
801022f0:	89 ca                	mov    %ecx,%edx
801022f2:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801022f3:	83 e0 c0             	and    $0xffffffc0,%eax
801022f6:	3c 40                	cmp    $0x40,%al
801022f8:	75 f6                	jne    801022f0 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801022fa:	ba f6 03 00 00       	mov    $0x3f6,%edx
801022ff:	31 c0                	xor    %eax,%eax
80102301:	ee                   	out    %al,(%dx)
80102302:	b8 01 00 00 00       	mov    $0x1,%eax
80102307:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010230c:	ee                   	out    %al,(%dx)
8010230d:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102312:	89 f0                	mov    %esi,%eax
80102314:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102315:	89 f0                	mov    %esi,%eax
80102317:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010231c:	c1 f8 08             	sar    $0x8,%eax
8010231f:	ee                   	out    %al,(%dx)
80102320:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102325:	31 c0                	xor    %eax,%eax
80102327:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80102328:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
8010232c:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102331:	c1 e0 04             	shl    $0x4,%eax
80102334:	83 e0 10             	and    $0x10,%eax
80102337:	83 c8 e0             	or     $0xffffffe0,%eax
8010233a:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010233b:	f6 03 04             	testb  $0x4,(%ebx)
8010233e:	75 10                	jne    80102350 <idestart+0x90>
80102340:	b8 20 00 00 00       	mov    $0x20,%eax
80102345:	89 ca                	mov    %ecx,%edx
80102347:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80102348:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010234b:	5b                   	pop    %ebx
8010234c:	5e                   	pop    %esi
8010234d:	5f                   	pop    %edi
8010234e:	5d                   	pop    %ebp
8010234f:	c3                   	ret
80102350:	b8 30 00 00 00       	mov    $0x30,%eax
80102355:	89 ca                	mov    %ecx,%edx
80102357:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102358:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
8010235d:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102360:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102365:	fc                   	cld
80102366:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102368:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010236b:	5b                   	pop    %ebx
8010236c:	5e                   	pop    %esi
8010236d:	5f                   	pop    %edi
8010236e:	5d                   	pop    %ebp
8010236f:	c3                   	ret
    panic("incorrect blockno");
80102370:	83 ec 0c             	sub    $0xc,%esp
80102373:	68 51 7a 10 80       	push   $0x80107a51
80102378:	e8 23 e0 ff ff       	call   801003a0 <panic>
    panic("idestart");
8010237d:	83 ec 0c             	sub    $0xc,%esp
80102380:	68 48 7a 10 80       	push   $0x80107a48
80102385:	e8 16 e0 ff ff       	call   801003a0 <panic>
8010238a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102390 <ideinit>:
{
80102390:	55                   	push   %ebp
80102391:	89 e5                	mov    %esp,%ebp
80102393:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102396:	68 63 7a 10 80       	push   $0x80107a63
8010239b:	68 20 26 11 80       	push   $0x80112620
801023a0:	e8 1b 26 00 00       	call   801049c0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801023a5:	58                   	pop    %eax
801023a6:	a1 a4 27 11 80       	mov    0x801127a4,%eax
801023ab:	5a                   	pop    %edx
801023ac:	83 e8 01             	sub    $0x1,%eax
801023af:	50                   	push   %eax
801023b0:	6a 0e                	push   $0xe
801023b2:	e8 c9 02 00 00       	call   80102680 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801023b7:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801023ba:	ba f7 01 00 00       	mov    $0x1f7,%edx
801023bf:	90                   	nop
801023c0:	ec                   	in     (%dx),%al
801023c1:	83 e0 c0             	and    $0xffffffc0,%eax
801023c4:	3c 40                	cmp    $0x40,%al
801023c6:	75 f8                	jne    801023c0 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801023c8:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
801023cd:	ba f6 01 00 00       	mov    $0x1f6,%edx
801023d2:	ee                   	out    %al,(%dx)
801023d3:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801023d8:	ba f7 01 00 00       	mov    $0x1f7,%edx
801023dd:	eb 06                	jmp    801023e5 <ideinit+0x55>
801023df:	90                   	nop
  for(i=0; i<1000; i++){
801023e0:	83 e9 01             	sub    $0x1,%ecx
801023e3:	74 0f                	je     801023f4 <ideinit+0x64>
801023e5:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
801023e6:	84 c0                	test   %al,%al
801023e8:	74 f6                	je     801023e0 <ideinit+0x50>
      havedisk1 = 1;
801023ea:	c7 05 00 26 11 80 01 	movl   $0x1,0x80112600
801023f1:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801023f4:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801023f9:	ba f6 01 00 00       	mov    $0x1f6,%edx
801023fe:	ee                   	out    %al,(%dx)
}
801023ff:	c9                   	leave
80102400:	c3                   	ret
80102401:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102408:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010240f:	00 

80102410 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102410:	55                   	push   %ebp
80102411:	89 e5                	mov    %esp,%ebp
80102413:	57                   	push   %edi
80102414:	56                   	push   %esi
80102415:	53                   	push   %ebx
80102416:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102419:	68 20 26 11 80       	push   $0x80112620
8010241e:	e8 bd 27 00 00       	call   80104be0 <acquire>

  if((b = idequeue) == 0){
80102423:	8b 1d 04 26 11 80    	mov    0x80112604,%ebx
80102429:	83 c4 10             	add    $0x10,%esp
8010242c:	85 db                	test   %ebx,%ebx
8010242e:	74 63                	je     80102493 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102430:	8b 43 58             	mov    0x58(%ebx),%eax
80102433:	a3 04 26 11 80       	mov    %eax,0x80112604

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102438:	8b 33                	mov    (%ebx),%esi
8010243a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102440:	75 2f                	jne    80102471 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102442:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102447:	90                   	nop
80102448:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010244f:	00 
80102450:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102451:	89 c1                	mov    %eax,%ecx
80102453:	83 e1 c0             	and    $0xffffffc0,%ecx
80102456:	80 f9 40             	cmp    $0x40,%cl
80102459:	75 f5                	jne    80102450 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010245b:	a8 21                	test   $0x21,%al
8010245d:	75 12                	jne    80102471 <ideintr+0x61>
  asm volatile("cld; rep insl" :
8010245f:	b9 80 00 00 00       	mov    $0x80,%ecx
80102464:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102469:	8d 7b 5c             	lea    0x5c(%ebx),%edi
8010246c:	fc                   	cld
8010246d:	f3 6d                	rep insl (%dx),%es:(%edi)
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
8010246f:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
80102471:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102474:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102477:	83 ce 02             	or     $0x2,%esi
8010247a:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010247c:	53                   	push   %ebx
8010247d:	e8 4e 20 00 00       	call   801044d0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102482:	a1 04 26 11 80       	mov    0x80112604,%eax
80102487:	83 c4 10             	add    $0x10,%esp
8010248a:	85 c0                	test   %eax,%eax
8010248c:	74 05                	je     80102493 <ideintr+0x83>
    idestart(idequeue);
8010248e:	e8 2d fe ff ff       	call   801022c0 <idestart>
    release(&idelock);
80102493:	83 ec 0c             	sub    $0xc,%esp
80102496:	68 20 26 11 80       	push   $0x80112620
8010249b:	e8 e0 26 00 00       	call   80104b80 <release>

  release(&idelock);
}
801024a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801024a3:	5b                   	pop    %ebx
801024a4:	5e                   	pop    %esi
801024a5:	5f                   	pop    %edi
801024a6:	5d                   	pop    %ebp
801024a7:	c3                   	ret
801024a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801024af:	00 

801024b0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801024b0:	55                   	push   %ebp
801024b1:	89 e5                	mov    %esp,%ebp
801024b3:	53                   	push   %ebx
801024b4:	83 ec 10             	sub    $0x10,%esp
801024b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801024ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801024bd:	50                   	push   %eax
801024be:	e8 9d 24 00 00       	call   80104960 <holdingsleep>
801024c3:	83 c4 10             	add    $0x10,%esp
801024c6:	85 c0                	test   %eax,%eax
801024c8:	0f 84 c3 00 00 00    	je     80102591 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801024ce:	8b 03                	mov    (%ebx),%eax
801024d0:	83 e0 06             	and    $0x6,%eax
801024d3:	83 f8 02             	cmp    $0x2,%eax
801024d6:	0f 84 a8 00 00 00    	je     80102584 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
801024dc:	8b 53 04             	mov    0x4(%ebx),%edx
801024df:	85 d2                	test   %edx,%edx
801024e1:	74 0d                	je     801024f0 <iderw+0x40>
801024e3:	a1 00 26 11 80       	mov    0x80112600,%eax
801024e8:	85 c0                	test   %eax,%eax
801024ea:	0f 84 87 00 00 00    	je     80102577 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
801024f0:	83 ec 0c             	sub    $0xc,%esp
801024f3:	68 20 26 11 80       	push   $0x80112620
801024f8:	e8 e3 26 00 00       	call   80104be0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801024fd:	a1 04 26 11 80       	mov    0x80112604,%eax
  b->qnext = 0;
80102502:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102509:	83 c4 10             	add    $0x10,%esp
8010250c:	85 c0                	test   %eax,%eax
8010250e:	74 60                	je     80102570 <iderw+0xc0>
80102510:	89 c2                	mov    %eax,%edx
80102512:	8b 40 58             	mov    0x58(%eax),%eax
80102515:	85 c0                	test   %eax,%eax
80102517:	75 f7                	jne    80102510 <iderw+0x60>
80102519:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
8010251c:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
8010251e:	39 1d 04 26 11 80    	cmp    %ebx,0x80112604
80102524:	74 3a                	je     80102560 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102526:	8b 03                	mov    (%ebx),%eax
80102528:	83 e0 06             	and    $0x6,%eax
8010252b:	83 f8 02             	cmp    $0x2,%eax
8010252e:	74 1b                	je     8010254b <iderw+0x9b>
    sleep(b, &idelock);
80102530:	83 ec 08             	sub    $0x8,%esp
80102533:	68 20 26 11 80       	push   $0x80112620
80102538:	53                   	push   %ebx
80102539:	e8 d2 1e 00 00       	call   80104410 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010253e:	8b 03                	mov    (%ebx),%eax
80102540:	83 c4 10             	add    $0x10,%esp
80102543:	83 e0 06             	and    $0x6,%eax
80102546:	83 f8 02             	cmp    $0x2,%eax
80102549:	75 e5                	jne    80102530 <iderw+0x80>
  }


  release(&idelock);
8010254b:	c7 45 08 20 26 11 80 	movl   $0x80112620,0x8(%ebp)
}
80102552:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102555:	c9                   	leave
  release(&idelock);
80102556:	e9 25 26 00 00       	jmp    80104b80 <release>
8010255b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    idestart(b);
80102560:	89 d8                	mov    %ebx,%eax
80102562:	e8 59 fd ff ff       	call   801022c0 <idestart>
80102567:	eb bd                	jmp    80102526 <iderw+0x76>
80102569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102570:	ba 04 26 11 80       	mov    $0x80112604,%edx
80102575:	eb a5                	jmp    8010251c <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
80102577:	83 ec 0c             	sub    $0xc,%esp
8010257a:	68 92 7a 10 80       	push   $0x80107a92
8010257f:	e8 1c de ff ff       	call   801003a0 <panic>
    panic("iderw: nothing to do");
80102584:	83 ec 0c             	sub    $0xc,%esp
80102587:	68 7d 7a 10 80       	push   $0x80107a7d
8010258c:	e8 0f de ff ff       	call   801003a0 <panic>
    panic("iderw: buf not locked");
80102591:	83 ec 0c             	sub    $0xc,%esp
80102594:	68 67 7a 10 80       	push   $0x80107a67
80102599:	e8 02 de ff ff       	call   801003a0 <panic>
8010259e:	66 90                	xchg   %ax,%ax
801025a0:	66 90                	xchg   %ax,%ax
801025a2:	66 90                	xchg   %ax,%ax
801025a4:	66 90                	xchg   %ax,%ax
801025a6:	66 90                	xchg   %ax,%ax
801025a8:	66 90                	xchg   %ax,%ax
801025aa:	66 90                	xchg   %ax,%ax
801025ac:	66 90                	xchg   %ax,%ax
801025ae:	66 90                	xchg   %ax,%ax
801025b0:	66 90                	xchg   %ax,%ax
801025b2:	66 90                	xchg   %ax,%ax
801025b4:	66 90                	xchg   %ax,%ax
801025b6:	66 90                	xchg   %ax,%ax
801025b8:	66 90                	xchg   %ax,%ax
801025ba:	66 90                	xchg   %ax,%ax
801025bc:	66 90                	xchg   %ax,%ax
801025be:	66 90                	xchg   %ax,%ax

801025c0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801025c0:	55                   	push   %ebp
801025c1:	89 e5                	mov    %esp,%ebp
801025c3:	56                   	push   %esi
801025c4:	53                   	push   %ebx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801025c5:	c7 05 54 26 11 80 00 	movl   $0xfec00000,0x80112654
801025cc:	00 c0 fe 
  ioapic->reg = reg;
801025cf:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801025d6:	00 00 00 
  return ioapic->data;
801025d9:	8b 15 54 26 11 80    	mov    0x80112654,%edx
801025df:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
801025e2:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
801025e8:	8b 1d 54 26 11 80    	mov    0x80112654,%ebx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801025ee:	0f b6 15 a0 27 11 80 	movzbl 0x801127a0,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801025f5:	c1 ee 10             	shr    $0x10,%esi
801025f8:	89 f0                	mov    %esi,%eax
801025fa:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
801025fd:	8b 43 10             	mov    0x10(%ebx),%eax
  id = ioapicread(REG_ID) >> 24;
80102600:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102603:	39 c2                	cmp    %eax,%edx
80102605:	74 16                	je     8010261d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102607:	83 ec 0c             	sub    $0xc,%esp
8010260a:	68 84 7e 10 80       	push   $0x80107e84
8010260f:	e8 bc e0 ff ff       	call   801006d0 <cprintf>
  ioapic->reg = reg;
80102614:	8b 1d 54 26 11 80    	mov    0x80112654,%ebx
8010261a:	83 c4 10             	add    $0x10,%esp
{
8010261d:	ba 10 00 00 00       	mov    $0x10,%edx
80102622:	31 c0                	xor    %eax,%eax
80102624:	eb 1a                	jmp    80102640 <ioapicinit+0x80>
80102626:	66 90                	xchg   %ax,%ax
80102628:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010262f:	00 
80102630:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102637:	00 
80102638:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010263f:	00 
  ioapic->reg = reg;
80102640:	89 13                	mov    %edx,(%ebx)
80102642:	8d 48 20             	lea    0x20(%eax),%ecx
  ioapic->data = data;
80102645:	8b 1d 54 26 11 80    	mov    0x80112654,%ebx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010264b:	83 c0 01             	add    $0x1,%eax
8010264e:	81 c9 00 00 01 00    	or     $0x10000,%ecx
  ioapic->data = data;
80102654:	89 4b 10             	mov    %ecx,0x10(%ebx)
  ioapic->reg = reg;
80102657:	8d 4a 01             	lea    0x1(%edx),%ecx
  for(i = 0; i <= maxintr; i++){
8010265a:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
8010265d:	89 0b                	mov    %ecx,(%ebx)
  ioapic->data = data;
8010265f:	8b 1d 54 26 11 80    	mov    0x80112654,%ebx
80102665:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
  for(i = 0; i <= maxintr; i++){
8010266c:	39 c6                	cmp    %eax,%esi
8010266e:	7d d0                	jge    80102640 <ioapicinit+0x80>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80102670:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102673:	5b                   	pop    %ebx
80102674:	5e                   	pop    %esi
80102675:	5d                   	pop    %ebp
80102676:	c3                   	ret
80102677:	90                   	nop
80102678:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010267f:	00 

80102680 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102680:	55                   	push   %ebp
  ioapic->reg = reg;
80102681:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
{
80102687:	89 e5                	mov    %esp,%ebp
80102689:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010268c:	8d 50 20             	lea    0x20(%eax),%edx
8010268f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102693:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102695:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010269b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010269e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801026a1:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801026a4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801026a6:	a1 54 26 11 80       	mov    0x80112654,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801026ab:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
801026ae:	89 50 10             	mov    %edx,0x10(%eax)
}
801026b1:	5d                   	pop    %ebp
801026b2:	c3                   	ret
801026b3:	66 90                	xchg   %ax,%ax
801026b5:	66 90                	xchg   %ax,%ax
801026b7:	66 90                	xchg   %ax,%ax
801026b9:	66 90                	xchg   %ax,%ax
801026bb:	66 90                	xchg   %ax,%ax
801026bd:	66 90                	xchg   %ax,%ax
801026bf:	90                   	nop

801026c0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801026c0:	55                   	push   %ebp
801026c1:	89 e5                	mov    %esp,%ebp
801026c3:	53                   	push   %ebx
801026c4:	83 ec 04             	sub    $0x4,%esp
801026c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801026ca:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801026d0:	75 76                	jne    80102748 <kfree+0x88>
801026d2:	81 fb f0 67 11 80    	cmp    $0x801167f0,%ebx
801026d8:	72 6e                	jb     80102748 <kfree+0x88>
801026da:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801026e0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801026e5:	77 61                	ja     80102748 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801026e7:	83 ec 04             	sub    $0x4,%esp
801026ea:	68 00 10 00 00       	push   $0x1000
801026ef:	6a 01                	push   $0x1
801026f1:	53                   	push   %ebx
801026f2:	e8 09 26 00 00       	call   80104d00 <memset>

  if(kmem.use_lock)
801026f7:	8b 15 94 26 11 80    	mov    0x80112694,%edx
801026fd:	83 c4 10             	add    $0x10,%esp
80102700:	85 d2                	test   %edx,%edx
80102702:	75 1c                	jne    80102720 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102704:	a1 98 26 11 80       	mov    0x80112698,%eax
80102709:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010270b:	a1 94 26 11 80       	mov    0x80112694,%eax
  kmem.freelist = r;
80102710:	89 1d 98 26 11 80    	mov    %ebx,0x80112698
  if(kmem.use_lock)
80102716:	85 c0                	test   %eax,%eax
80102718:	75 1e                	jne    80102738 <kfree+0x78>
    release(&kmem.lock);
}
8010271a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010271d:	c9                   	leave
8010271e:	c3                   	ret
8010271f:	90                   	nop
    acquire(&kmem.lock);
80102720:	83 ec 0c             	sub    $0xc,%esp
80102723:	68 60 26 11 80       	push   $0x80112660
80102728:	e8 b3 24 00 00       	call   80104be0 <acquire>
8010272d:	83 c4 10             	add    $0x10,%esp
80102730:	eb d2                	jmp    80102704 <kfree+0x44>
80102732:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102738:	c7 45 08 60 26 11 80 	movl   $0x80112660,0x8(%ebp)
}
8010273f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102742:	c9                   	leave
    release(&kmem.lock);
80102743:	e9 38 24 00 00       	jmp    80104b80 <release>
    panic("kfree");
80102748:	83 ec 0c             	sub    $0xc,%esp
8010274b:	68 b0 7a 10 80       	push   $0x80107ab0
80102750:	e8 4b dc ff ff       	call   801003a0 <panic>
80102755:	8d 76 00             	lea    0x0(%esi),%esi
80102758:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010275f:	00 

80102760 <freerange>:
{
80102760:	55                   	push   %ebp
80102761:	89 e5                	mov    %esp,%ebp
80102763:	56                   	push   %esi
80102764:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102765:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102768:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010276b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102771:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102777:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010277d:	39 de                	cmp    %ebx,%esi
8010277f:	72 2b                	jb     801027ac <freerange+0x4c>
80102781:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102788:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010278f:	00 
    kfree(p);
80102790:	83 ec 0c             	sub    $0xc,%esp
80102793:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102799:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010279f:	50                   	push   %eax
801027a0:	e8 1b ff ff ff       	call   801026c0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027a5:	83 c4 10             	add    $0x10,%esp
801027a8:	39 de                	cmp    %ebx,%esi
801027aa:	73 e4                	jae    80102790 <freerange+0x30>
}
801027ac:	8d 65 f8             	lea    -0x8(%ebp),%esp
801027af:	5b                   	pop    %ebx
801027b0:	5e                   	pop    %esi
801027b1:	5d                   	pop    %ebp
801027b2:	c3                   	ret
801027b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801027b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801027bf:	00 

801027c0 <kinit2>:
{
801027c0:	55                   	push   %ebp
801027c1:	89 e5                	mov    %esp,%ebp
801027c3:	56                   	push   %esi
801027c4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801027c5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801027c8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801027cb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801027d1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027d7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801027dd:	39 de                	cmp    %ebx,%esi
801027df:	72 2b                	jb     8010280c <kinit2+0x4c>
801027e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801027ef:	00 
    kfree(p);
801027f0:	83 ec 0c             	sub    $0xc,%esp
801027f3:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027f9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801027ff:	50                   	push   %eax
80102800:	e8 bb fe ff ff       	call   801026c0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102805:	83 c4 10             	add    $0x10,%esp
80102808:	39 de                	cmp    %ebx,%esi
8010280a:	73 e4                	jae    801027f0 <kinit2+0x30>
  kmem.use_lock = 1;
8010280c:	c7 05 94 26 11 80 01 	movl   $0x1,0x80112694
80102813:	00 00 00 
}
80102816:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102819:	5b                   	pop    %ebx
8010281a:	5e                   	pop    %esi
8010281b:	5d                   	pop    %ebp
8010281c:	c3                   	ret
8010281d:	8d 76 00             	lea    0x0(%esi),%esi

80102820 <kinit1>:
{
80102820:	55                   	push   %ebp
80102821:	89 e5                	mov    %esp,%ebp
80102823:	56                   	push   %esi
80102824:	53                   	push   %ebx
80102825:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102828:	83 ec 08             	sub    $0x8,%esp
8010282b:	68 b6 7a 10 80       	push   $0x80107ab6
80102830:	68 60 26 11 80       	push   $0x80112660
80102835:	e8 86 21 00 00       	call   801049c0 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010283a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010283d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102840:	c7 05 94 26 11 80 00 	movl   $0x0,0x80112694
80102847:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010284a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102850:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102856:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010285c:	39 de                	cmp    %ebx,%esi
8010285e:	72 1c                	jb     8010287c <kinit1+0x5c>
    kfree(p);
80102860:	83 ec 0c             	sub    $0xc,%esp
80102863:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102869:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010286f:	50                   	push   %eax
80102870:	e8 4b fe ff ff       	call   801026c0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102875:	83 c4 10             	add    $0x10,%esp
80102878:	39 de                	cmp    %ebx,%esi
8010287a:	73 e4                	jae    80102860 <kinit1+0x40>
}
8010287c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010287f:	5b                   	pop    %ebx
80102880:	5e                   	pop    %esi
80102881:	5d                   	pop    %ebp
80102882:	c3                   	ret
80102883:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80102888:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010288f:	00 

80102890 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
80102890:	a1 94 26 11 80       	mov    0x80112694,%eax
80102895:	85 c0                	test   %eax,%eax
80102897:	75 1f                	jne    801028b8 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102899:	a1 98 26 11 80       	mov    0x80112698,%eax
  if(r)
8010289e:	85 c0                	test   %eax,%eax
801028a0:	74 0e                	je     801028b0 <kalloc+0x20>
    kmem.freelist = r->next;
801028a2:	8b 10                	mov    (%eax),%edx
801028a4:	89 15 98 26 11 80    	mov    %edx,0x80112698
  if(kmem.use_lock)
801028aa:	c3                   	ret
801028ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    release(&kmem.lock);
  return (char*)r;
}
801028b0:	c3                   	ret
801028b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
801028b8:	55                   	push   %ebp
801028b9:	89 e5                	mov    %esp,%ebp
801028bb:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
801028be:	68 60 26 11 80       	push   $0x80112660
801028c3:	e8 18 23 00 00       	call   80104be0 <acquire>
  r = kmem.freelist;
801028c8:	a1 98 26 11 80       	mov    0x80112698,%eax
  if(kmem.use_lock)
801028cd:	8b 15 94 26 11 80    	mov    0x80112694,%edx
  if(r)
801028d3:	83 c4 10             	add    $0x10,%esp
801028d6:	85 c0                	test   %eax,%eax
801028d8:	74 08                	je     801028e2 <kalloc+0x52>
    kmem.freelist = r->next;
801028da:	8b 08                	mov    (%eax),%ecx
801028dc:	89 0d 98 26 11 80    	mov    %ecx,0x80112698
  if(kmem.use_lock)
801028e2:	85 d2                	test   %edx,%edx
801028e4:	74 16                	je     801028fc <kalloc+0x6c>
    release(&kmem.lock);
801028e6:	83 ec 0c             	sub    $0xc,%esp
801028e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
801028ec:	68 60 26 11 80       	push   $0x80112660
801028f1:	e8 8a 22 00 00       	call   80104b80 <release>
801028f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028f9:	83 c4 10             	add    $0x10,%esp
}
801028fc:	c9                   	leave
801028fd:	c3                   	ret
801028fe:	66 90                	xchg   %ax,%ax

80102900 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102900:	ba 64 00 00 00       	mov    $0x64,%edx
80102905:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102906:	a8 01                	test   $0x1,%al
80102908:	0f 84 c2 00 00 00    	je     801029d0 <kbdgetc+0xd0>
{
8010290e:	55                   	push   %ebp
8010290f:	ba 60 00 00 00       	mov    $0x60,%edx
80102914:	89 e5                	mov    %esp,%ebp
80102916:	53                   	push   %ebx
80102917:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80102918:	8b 1d 9c 26 11 80    	mov    0x8011269c,%ebx
  data = inb(KBDATAP);
8010291e:	0f b6 c8             	movzbl %al,%ecx
  if(data == 0xE0){
80102921:	3c e0                	cmp    $0xe0,%al
80102923:	74 53                	je     80102978 <kbdgetc+0x78>
    return 0;
  } else if(data & 0x80){
80102925:	84 c0                	test   %al,%al
80102927:	78 67                	js     80102990 <kbdgetc+0x90>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102929:	f6 c3 40             	test   $0x40,%bl
8010292c:	74 09                	je     80102937 <kbdgetc+0x37>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010292e:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102931:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80102934:	0f b6 c8             	movzbl %al,%ecx
  }

  shift |= shiftcode[data];
80102937:	0f b6 91 c0 80 10 80 	movzbl -0x7fef7f40(%ecx),%edx
  shift ^= togglecode[data];
8010293e:	0f b6 81 c0 7f 10 80 	movzbl -0x7fef8040(%ecx),%eax
  shift |= shiftcode[data];
80102945:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
80102947:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
80102949:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
8010294b:	89 15 9c 26 11 80    	mov    %edx,0x8011269c
  c = charcode[shift & (CTL | SHIFT)][data];
80102951:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102954:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
80102957:	8b 04 85 a0 7f 10 80 	mov    -0x7fef8060(,%eax,4),%eax
8010295e:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80102962:	74 0b                	je     8010296f <kbdgetc+0x6f>
    if('a' <= c && c <= 'z')
80102964:	8d 50 9f             	lea    -0x61(%eax),%edx
80102967:	83 fa 19             	cmp    $0x19,%edx
8010296a:	77 4c                	ja     801029b8 <kbdgetc+0xb8>
      c += 'A' - 'a';
8010296c:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
8010296f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102972:	c9                   	leave
80102973:	c3                   	ret
80102974:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
80102978:	83 cb 40             	or     $0x40,%ebx
    return 0;
8010297b:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
8010297d:	89 1d 9c 26 11 80    	mov    %ebx,0x8011269c
}
80102983:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102986:	c9                   	leave
80102987:	c3                   	ret
80102988:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010298f:	00 
    data = (shift & E0ESC ? data : data & 0x7F);
80102990:	83 e0 7f             	and    $0x7f,%eax
80102993:	f6 c3 40             	test   $0x40,%bl
80102996:	0f 44 c8             	cmove  %eax,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80102999:	0f b6 81 c0 80 10 80 	movzbl -0x7fef7f40(%ecx),%eax
801029a0:	83 c8 40             	or     $0x40,%eax
801029a3:	0f b6 c0             	movzbl %al,%eax
801029a6:	f7 d0                	not    %eax
801029a8:	21 d8                	and    %ebx,%eax
801029aa:	a3 9c 26 11 80       	mov    %eax,0x8011269c
    return 0;
801029af:	31 c0                	xor    %eax,%eax
801029b1:	eb d0                	jmp    80102983 <kbdgetc+0x83>
801029b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
801029b8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801029bb:	8d 50 20             	lea    0x20(%eax),%edx
}
801029be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801029c1:	c9                   	leave
      c += 'a' - 'A';
801029c2:	83 f9 1a             	cmp    $0x1a,%ecx
801029c5:	0f 42 c2             	cmovb  %edx,%eax
}
801029c8:	c3                   	ret
801029c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801029d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801029d5:	c3                   	ret
801029d6:	66 90                	xchg   %ax,%ax
801029d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801029df:	00 

801029e0 <kbdintr>:

void
kbdintr(void)
{
801029e0:	55                   	push   %ebp
801029e1:	89 e5                	mov    %esp,%ebp
801029e3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801029e6:	68 00 29 10 80       	push   $0x80102900
801029eb:	e8 e0 de ff ff       	call   801008d0 <consoleintr>
}
801029f0:	83 c4 10             	add    $0x10,%esp
801029f3:	c9                   	leave
801029f4:	c3                   	ret
801029f5:	66 90                	xchg   %ax,%ax
801029f7:	66 90                	xchg   %ax,%ax
801029f9:	66 90                	xchg   %ax,%ax
801029fb:	66 90                	xchg   %ax,%ax
801029fd:	66 90                	xchg   %ax,%ax
801029ff:	90                   	nop

80102a00 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102a00:	a1 a0 26 11 80       	mov    0x801126a0,%eax
80102a05:	85 c0                	test   %eax,%eax
80102a07:	0f 84 cb 00 00 00    	je     80102ad8 <lapicinit+0xd8>
  lapic[index] = value;
80102a0d:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102a14:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a17:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a1a:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102a21:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a24:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a27:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102a2e:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102a31:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a34:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
80102a3b:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102a3e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a41:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102a48:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102a4b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a4e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102a55:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102a58:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102a5b:	8b 50 30             	mov    0x30(%eax),%edx
80102a5e:	81 e2 00 00 fc 00    	and    $0xfc0000,%edx
80102a64:	75 7a                	jne    80102ae0 <lapicinit+0xe0>
  lapic[index] = value;
80102a66:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102a6d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a70:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a73:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102a7a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a7d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a80:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102a87:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a8a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a8d:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102a94:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a97:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a9a:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102aa1:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102aa4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102aa7:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102aae:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102ab1:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102ab4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102ab8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102abf:	00 
80102ac0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102ac6:	80 e6 10             	and    $0x10,%dh
80102ac9:	75 f5                	jne    80102ac0 <lapicinit+0xc0>
  lapic[index] = value;
80102acb:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102ad2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ad5:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102ad8:	c3                   	ret
80102ad9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
80102ae0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102ae7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102aea:	8b 50 20             	mov    0x20(%eax),%edx
}
80102aed:	e9 74 ff ff ff       	jmp    80102a66 <lapicinit+0x66>
80102af2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102af8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102aff:	00 

80102b00 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102b00:	a1 a0 26 11 80       	mov    0x801126a0,%eax
80102b05:	85 c0                	test   %eax,%eax
80102b07:	74 07                	je     80102b10 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
80102b09:	8b 40 20             	mov    0x20(%eax),%eax
80102b0c:	c1 e8 18             	shr    $0x18,%eax
80102b0f:	c3                   	ret
80102b10:	31 c0                	xor    %eax,%eax
}
80102b12:	c3                   	ret
80102b13:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80102b18:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102b1f:	00 

80102b20 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102b20:	a1 a0 26 11 80       	mov    0x801126a0,%eax
80102b25:	85 c0                	test   %eax,%eax
80102b27:	74 0d                	je     80102b36 <lapiceoi+0x16>
  lapic[index] = value;
80102b29:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102b30:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b33:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102b36:	c3                   	ret
80102b37:	90                   	nop
80102b38:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102b3f:	00 

80102b40 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80102b40:	c3                   	ret
80102b41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b48:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102b4f:	00 

80102b50 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102b50:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b51:	b8 0f 00 00 00       	mov    $0xf,%eax
80102b56:	ba 70 00 00 00       	mov    $0x70,%edx
80102b5b:	89 e5                	mov    %esp,%ebp
80102b5d:	56                   	push   %esi
80102b5e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102b61:	53                   	push   %ebx
80102b62:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102b65:	ee                   	out    %al,(%dx)
80102b66:	b8 0a 00 00 00       	mov    $0xa,%eax
80102b6b:	ba 71 00 00 00       	mov    $0x71,%edx
80102b70:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102b71:	31 c0                	xor    %eax,%eax
  lapic[index] = value;
80102b73:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102b76:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102b7c:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102b7e:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
80102b81:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102b84:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102b87:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102b8d:	a1 a0 26 11 80       	mov    0x801126a0,%eax
80102b92:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b98:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102b9b:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102ba2:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ba5:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102ba8:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102baf:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102bb2:	8b 50 20             	mov    0x20(%eax),%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
80102bb5:	ba 02 00 00 00       	mov    $0x2,%edx
  lapic[index] = value;
80102bba:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102bc0:	8b 70 20             	mov    0x20(%eax),%esi
  lapic[index] = value;
80102bc3:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102bc9:	8b 70 20             	mov    0x20(%eax),%esi
  for(i = 0; i < 2; i++){
80102bcc:	83 fa 01             	cmp    $0x1,%edx
80102bcf:	75 07                	jne    80102bd8 <lapicstartap+0x88>
    microdelay(200);
  }
}
80102bd1:	5b                   	pop    %ebx
80102bd2:	5e                   	pop    %esi
80102bd3:	5d                   	pop    %ebp
80102bd4:	c3                   	ret
80102bd5:	8d 76 00             	lea    0x0(%esi),%esi
80102bd8:	ba 01 00 00 00       	mov    $0x1,%edx
80102bdd:	eb db                	jmp    80102bba <lapicstartap+0x6a>
80102bdf:	90                   	nop

80102be0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102be0:	55                   	push   %ebp
80102be1:	b8 0b 00 00 00       	mov    $0xb,%eax
80102be6:	ba 70 00 00 00       	mov    $0x70,%edx
80102beb:	89 e5                	mov    %esp,%ebp
80102bed:	57                   	push   %edi
80102bee:	56                   	push   %esi
80102bef:	53                   	push   %ebx
80102bf0:	83 ec 4c             	sub    $0x4c,%esp
80102bf3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bf4:	ba 71 00 00 00       	mov    $0x71,%edx
80102bf9:	ec                   	in     (%dx),%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bfa:	88 45 b4             	mov    %al,-0x4c(%ebp)
80102bfd:	8d 76 00             	lea    0x0(%esi),%esi
80102c00:	31 c0                	xor    %eax,%eax
80102c02:	ba 70 00 00 00       	mov    $0x70,%edx
80102c07:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c08:	ba 71 00 00 00       	mov    $0x71,%edx
80102c0d:	ec                   	in     (%dx),%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c0e:	ba 70 00 00 00       	mov    $0x70,%edx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c13:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c16:	b8 02 00 00 00       	mov    $0x2,%eax
80102c1b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c1c:	ba 71 00 00 00       	mov    $0x71,%edx
80102c21:	ec                   	in     (%dx),%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c22:	ba 70 00 00 00       	mov    $0x70,%edx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c27:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c2a:	b8 04 00 00 00       	mov    $0x4,%eax
80102c2f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c30:	ba 71 00 00 00       	mov    $0x71,%edx
80102c35:	ec                   	in     (%dx),%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c36:	ba 70 00 00 00       	mov    $0x70,%edx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c3b:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c3e:	b8 07 00 00 00       	mov    $0x7,%eax
80102c43:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c44:	ba 71 00 00 00       	mov    $0x71,%edx
80102c49:	ec                   	in     (%dx),%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c4a:	ba 70 00 00 00       	mov    $0x70,%edx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c4f:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c51:	b8 08 00 00 00       	mov    $0x8,%eax
80102c56:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c57:	ba 71 00 00 00       	mov    $0x71,%edx
80102c5c:	ec                   	in     (%dx),%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c5d:	ba 70 00 00 00       	mov    $0x70,%edx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c62:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c64:	b8 09 00 00 00       	mov    $0x9,%eax
80102c69:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c6a:	ba 71 00 00 00       	mov    $0x71,%edx
80102c6f:	ec                   	in     (%dx),%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c70:	ba 70 00 00 00       	mov    $0x70,%edx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c75:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c78:	b8 0a 00 00 00       	mov    $0xa,%eax
80102c7d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c7e:	ba 71 00 00 00       	mov    $0x71,%edx
80102c83:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102c84:	84 c0                	test   %al,%al
80102c86:	0f 88 74 ff ff ff    	js     80102c00 <cmostime+0x20>
  return inb(CMOS_RETURN);
80102c8c:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102c90:	89 fa                	mov    %edi,%edx
80102c92:	89 5d cc             	mov    %ebx,-0x34(%ebp)
80102c95:	0f b6 fa             	movzbl %dl,%edi
80102c98:	89 f2                	mov    %esi,%edx
80102c9a:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102c9d:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102ca1:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ca4:	ba 70 00 00 00       	mov    $0x70,%edx
80102ca9:	89 7d c4             	mov    %edi,-0x3c(%ebp)
80102cac:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102caf:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102cb3:	89 75 c8             	mov    %esi,-0x38(%ebp)
80102cb6:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102cb9:	31 c0                	xor    %eax,%eax
80102cbb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102cbc:	ba 71 00 00 00       	mov    $0x71,%edx
80102cc1:	ec                   	in     (%dx),%al
80102cc2:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102cc5:	ba 70 00 00 00       	mov    $0x70,%edx
80102cca:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102ccd:	b8 02 00 00 00       	mov    $0x2,%eax
80102cd2:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102cd3:	ba 71 00 00 00       	mov    $0x71,%edx
80102cd8:	ec                   	in     (%dx),%al
80102cd9:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102cdc:	ba 70 00 00 00       	mov    $0x70,%edx
80102ce1:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102ce4:	b8 04 00 00 00       	mov    $0x4,%eax
80102ce9:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102cea:	ba 71 00 00 00       	mov    $0x71,%edx
80102cef:	ec                   	in     (%dx),%al
80102cf0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102cf3:	ba 70 00 00 00       	mov    $0x70,%edx
80102cf8:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102cfb:	b8 07 00 00 00       	mov    $0x7,%eax
80102d00:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d01:	ba 71 00 00 00       	mov    $0x71,%edx
80102d06:	ec                   	in     (%dx),%al
80102d07:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d0a:	ba 70 00 00 00       	mov    $0x70,%edx
80102d0f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102d12:	b8 08 00 00 00       	mov    $0x8,%eax
80102d17:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d18:	ba 71 00 00 00       	mov    $0x71,%edx
80102d1d:	ec                   	in     (%dx),%al
80102d1e:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d21:	ba 70 00 00 00       	mov    $0x70,%edx
80102d26:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102d29:	b8 09 00 00 00       	mov    $0x9,%eax
80102d2e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d2f:	ba 71 00 00 00       	mov    $0x71,%edx
80102d34:	ec                   	in     (%dx),%al
80102d35:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102d38:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102d3b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102d3e:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102d41:	6a 18                	push   $0x18
80102d43:	50                   	push   %eax
80102d44:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102d47:	50                   	push   %eax
80102d48:	e8 f3 1f 00 00       	call   80104d40 <memcmp>
80102d4d:	83 c4 10             	add    $0x10,%esp
80102d50:	85 c0                	test   %eax,%eax
80102d52:	0f 85 a8 fe ff ff    	jne    80102c00 <cmostime+0x20>
      break;
  }

  // convert
  if(bcd) {
80102d58:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102d5b:	f6 45 b4 04          	testb  $0x4,-0x4c(%ebp)
80102d5f:	75 78                	jne    80102dd9 <cmostime+0x1f9>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102d61:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102d64:	89 c2                	mov    %eax,%edx
80102d66:	83 e0 0f             	and    $0xf,%eax
80102d69:	c1 ea 04             	shr    $0x4,%edx
80102d6c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d6f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d72:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102d75:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102d78:	89 c2                	mov    %eax,%edx
80102d7a:	83 e0 0f             	and    $0xf,%eax
80102d7d:	c1 ea 04             	shr    $0x4,%edx
80102d80:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d83:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d86:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102d89:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102d8c:	89 c2                	mov    %eax,%edx
80102d8e:	83 e0 0f             	and    $0xf,%eax
80102d91:	c1 ea 04             	shr    $0x4,%edx
80102d94:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d97:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d9a:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102d9d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102da0:	89 c2                	mov    %eax,%edx
80102da2:	83 e0 0f             	and    $0xf,%eax
80102da5:	c1 ea 04             	shr    $0x4,%edx
80102da8:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102dab:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102dae:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102db1:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102db4:	89 c2                	mov    %eax,%edx
80102db6:	83 e0 0f             	and    $0xf,%eax
80102db9:	c1 ea 04             	shr    $0x4,%edx
80102dbc:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102dbf:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102dc2:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102dc5:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102dc8:	89 c2                	mov    %eax,%edx
80102dca:	83 e0 0f             	and    $0xf,%eax
80102dcd:	c1 ea 04             	shr    $0x4,%edx
80102dd0:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102dd3:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102dd6:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102dd9:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102ddc:	89 03                	mov    %eax,(%ebx)
80102dde:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102de1:	89 43 04             	mov    %eax,0x4(%ebx)
80102de4:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102de7:	89 43 08             	mov    %eax,0x8(%ebx)
80102dea:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102ded:	89 43 0c             	mov    %eax,0xc(%ebx)
80102df0:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102df3:	89 43 10             	mov    %eax,0x10(%ebx)
80102df6:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102df9:	89 43 14             	mov    %eax,0x14(%ebx)
  r->year += 2000;
80102dfc:	81 43 14 d0 07 00 00 	addl   $0x7d0,0x14(%ebx)
}
80102e03:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e06:	5b                   	pop    %ebx
80102e07:	5e                   	pop    %esi
80102e08:	5f                   	pop    %edi
80102e09:	5d                   	pop    %ebp
80102e0a:	c3                   	ret
80102e0b:	66 90                	xchg   %ax,%ax
80102e0d:	66 90                	xchg   %ax,%ax
80102e0f:	66 90                	xchg   %ax,%ax
80102e11:	66 90                	xchg   %ax,%ax
80102e13:	66 90                	xchg   %ax,%ax
80102e15:	66 90                	xchg   %ax,%ax
80102e17:	66 90                	xchg   %ax,%ax
80102e19:	66 90                	xchg   %ax,%ax
80102e1b:	66 90                	xchg   %ax,%ax
80102e1d:	66 90                	xchg   %ax,%ax
80102e1f:	90                   	nop

80102e20 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102e20:	8b 0d 08 27 11 80    	mov    0x80112708,%ecx
80102e26:	85 c9                	test   %ecx,%ecx
80102e28:	0f 8e 8a 00 00 00    	jle    80102eb8 <install_trans+0x98>
{
80102e2e:	55                   	push   %ebp
80102e2f:	89 e5                	mov    %esp,%ebp
80102e31:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80102e32:	31 ff                	xor    %edi,%edi
{
80102e34:	56                   	push   %esi
80102e35:	53                   	push   %ebx
80102e36:	83 ec 0c             	sub    $0xc,%esp
80102e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102e40:	a1 f4 26 11 80       	mov    0x801126f4,%eax
80102e45:	83 ec 08             	sub    $0x8,%esp
80102e48:	8d 44 38 01          	lea    0x1(%eax,%edi,1),%eax
80102e4c:	50                   	push   %eax
80102e4d:	ff 35 04 27 11 80    	push   0x80112704
80102e53:	e8 78 d2 ff ff       	call   801000d0 <bread>
80102e58:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102e5a:	58                   	pop    %eax
80102e5b:	5a                   	pop    %edx
80102e5c:	ff 34 bd 0c 27 11 80 	push   -0x7feed8f4(,%edi,4)
80102e63:	ff 35 04 27 11 80    	push   0x80112704
  for (tail = 0; tail < log.lh.n; tail++) {
80102e69:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102e6c:	e8 5f d2 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102e71:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102e74:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102e76:	8d 46 5c             	lea    0x5c(%esi),%eax
80102e79:	68 00 02 00 00       	push   $0x200
80102e7e:	50                   	push   %eax
80102e7f:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102e82:	50                   	push   %eax
80102e83:	e8 08 1f 00 00       	call   80104d90 <memmove>
    bwrite(dbuf);  // write dst to disk
80102e88:	89 1c 24             	mov    %ebx,(%esp)
80102e8b:	e8 30 d3 ff ff       	call   801001c0 <bwrite>
    brelse(lbuf);
80102e90:	89 34 24             	mov    %esi,(%esp)
80102e93:	e8 68 d3 ff ff       	call   80100200 <brelse>
    brelse(dbuf);
80102e98:	89 1c 24             	mov    %ebx,(%esp)
80102e9b:	e8 60 d3 ff ff       	call   80100200 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102ea0:	83 c4 10             	add    $0x10,%esp
80102ea3:	39 3d 08 27 11 80    	cmp    %edi,0x80112708
80102ea9:	7f 95                	jg     80102e40 <install_trans+0x20>
  }
}
80102eab:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102eae:	5b                   	pop    %ebx
80102eaf:	5e                   	pop    %esi
80102eb0:	5f                   	pop    %edi
80102eb1:	5d                   	pop    %ebp
80102eb2:	c3                   	ret
80102eb3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80102eb8:	c3                   	ret
80102eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102ec0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102ec0:	55                   	push   %ebp
80102ec1:	89 e5                	mov    %esp,%ebp
80102ec3:	53                   	push   %ebx
80102ec4:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102ec7:	ff 35 f4 26 11 80    	push   0x801126f4
80102ecd:	ff 35 04 27 11 80    	push   0x80112704
80102ed3:	e8 f8 d1 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102ed8:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102edb:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80102edd:	a1 08 27 11 80       	mov    0x80112708,%eax
80102ee2:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80102ee5:	85 c0                	test   %eax,%eax
80102ee7:	7e 29                	jle    80102f12 <write_head+0x52>
80102ee9:	31 d2                	xor    %edx,%edx
80102eeb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80102ef0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102ef7:	00 
80102ef8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102eff:	00 
    hb->block[i] = log.lh.block[i];
80102f00:	8b 0c 95 0c 27 11 80 	mov    -0x7feed8f4(,%edx,4),%ecx
80102f07:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102f0b:	83 c2 01             	add    $0x1,%edx
80102f0e:	39 d0                	cmp    %edx,%eax
80102f10:	75 ee                	jne    80102f00 <write_head+0x40>
  }
  bwrite(buf);
80102f12:	83 ec 0c             	sub    $0xc,%esp
80102f15:	53                   	push   %ebx
80102f16:	e8 a5 d2 ff ff       	call   801001c0 <bwrite>
  brelse(buf);
80102f1b:	89 1c 24             	mov    %ebx,(%esp)
80102f1e:	e8 dd d2 ff ff       	call   80100200 <brelse>
}
80102f23:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102f26:	83 c4 10             	add    $0x10,%esp
80102f29:	c9                   	leave
80102f2a:	c3                   	ret
80102f2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102f30 <initlog>:
{
80102f30:	55                   	push   %ebp
80102f31:	89 e5                	mov    %esp,%ebp
80102f33:	53                   	push   %ebx
80102f34:	83 ec 3c             	sub    $0x3c,%esp
80102f37:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102f3a:	68 bb 7a 10 80       	push   $0x80107abb
80102f3f:	68 c0 26 11 80       	push   $0x801126c0
80102f44:	e8 77 1a 00 00       	call   801049c0 <initlock>
  readsb(dev, &sb);
80102f49:	58                   	pop    %eax
80102f4a:	8d 45 cc             	lea    -0x34(%ebp),%eax
80102f4d:	5a                   	pop    %edx
80102f4e:	50                   	push   %eax
80102f4f:	53                   	push   %ebx
80102f50:	e8 4b e7 ff ff       	call   801016a0 <readsb>
  log.start = sb.logstart;
80102f55:	8b 45 e0             	mov    -0x20(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102f58:	59                   	pop    %ecx
  log.dev = dev;
80102f59:	89 1d 04 27 11 80    	mov    %ebx,0x80112704
  log.size = sb.nlog;
80102f5f:	8b 55 dc             	mov    -0x24(%ebp),%edx
  log.start = sb.logstart;
80102f62:	a3 f4 26 11 80       	mov    %eax,0x801126f4
  log.size = sb.nlog;
80102f67:	89 15 f8 26 11 80    	mov    %edx,0x801126f8
  struct buf *buf = bread(log.dev, log.start);
80102f6d:	5a                   	pop    %edx
80102f6e:	50                   	push   %eax
80102f6f:	53                   	push   %ebx
80102f70:	e8 5b d1 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80102f75:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80102f78:	8b 58 5c             	mov    0x5c(%eax),%ebx
80102f7b:	89 1d 08 27 11 80    	mov    %ebx,0x80112708
  for (i = 0; i < log.lh.n; i++) {
80102f81:	85 db                	test   %ebx,%ebx
80102f83:	7e 2d                	jle    80102fb2 <initlog+0x82>
80102f85:	31 d2                	xor    %edx,%edx
80102f87:	eb 17                	jmp    80102fa0 <initlog+0x70>
80102f89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f90:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102f97:	00 
80102f98:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102f9f:	00 
    log.lh.block[i] = lh->block[i];
80102fa0:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80102fa4:	89 0c 95 0c 27 11 80 	mov    %ecx,-0x7feed8f4(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102fab:	83 c2 01             	add    $0x1,%edx
80102fae:	39 d3                	cmp    %edx,%ebx
80102fb0:	75 ee                	jne    80102fa0 <initlog+0x70>
  brelse(buf);
80102fb2:	83 ec 0c             	sub    $0xc,%esp
80102fb5:	50                   	push   %eax
80102fb6:	e8 45 d2 ff ff       	call   80100200 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102fbb:	e8 60 fe ff ff       	call   80102e20 <install_trans>
  log.lh.n = 0;
80102fc0:	c7 05 08 27 11 80 00 	movl   $0x0,0x80112708
80102fc7:	00 00 00 
  write_head(); // clear the log
80102fca:	e8 f1 fe ff ff       	call   80102ec0 <write_head>
}
80102fcf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102fd2:	83 c4 10             	add    $0x10,%esp
80102fd5:	c9                   	leave
80102fd6:	c3                   	ret
80102fd7:	90                   	nop
80102fd8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102fdf:	00 

80102fe0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102fe0:	55                   	push   %ebp
80102fe1:	89 e5                	mov    %esp,%ebp
80102fe3:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102fe6:	68 c0 26 11 80       	push   $0x801126c0
80102feb:	e8 f0 1b 00 00       	call   80104be0 <acquire>
80102ff0:	83 c4 10             	add    $0x10,%esp
80102ff3:	eb 18                	jmp    8010300d <begin_op+0x2d>
80102ff5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102ff8:	83 ec 08             	sub    $0x8,%esp
80102ffb:	68 c0 26 11 80       	push   $0x801126c0
80103000:	68 c0 26 11 80       	push   $0x801126c0
80103005:	e8 06 14 00 00       	call   80104410 <sleep>
8010300a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
8010300d:	a1 00 27 11 80       	mov    0x80112700,%eax
80103012:	85 c0                	test   %eax,%eax
80103014:	75 e2                	jne    80102ff8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80103016:	a1 fc 26 11 80       	mov    0x801126fc,%eax
8010301b:	8b 15 08 27 11 80    	mov    0x80112708,%edx
80103021:	83 c0 01             	add    $0x1,%eax
80103024:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80103027:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
8010302a:	83 fa 1e             	cmp    $0x1e,%edx
8010302d:	7f c9                	jg     80102ff8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
8010302f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80103032:	a3 fc 26 11 80       	mov    %eax,0x801126fc
      release(&log.lock);
80103037:	68 c0 26 11 80       	push   $0x801126c0
8010303c:	e8 3f 1b 00 00       	call   80104b80 <release>
      break;
    }
  }
}
80103041:	83 c4 10             	add    $0x10,%esp
80103044:	c9                   	leave
80103045:	c3                   	ret
80103046:	66 90                	xchg   %ax,%ax
80103048:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010304f:	00 

80103050 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80103050:	55                   	push   %ebp
80103051:	89 e5                	mov    %esp,%ebp
80103053:	57                   	push   %edi
80103054:	56                   	push   %esi
80103055:	53                   	push   %ebx
80103056:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80103059:	68 c0 26 11 80       	push   $0x801126c0
8010305e:	e8 7d 1b 00 00       	call   80104be0 <acquire>
  log.outstanding -= 1;
80103063:	a1 fc 26 11 80       	mov    0x801126fc,%eax
  if(log.committing)
80103068:	8b 35 00 27 11 80    	mov    0x80112700,%esi
8010306e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80103071:	8d 58 ff             	lea    -0x1(%eax),%ebx
80103074:	89 1d fc 26 11 80    	mov    %ebx,0x801126fc
  if(log.committing)
8010307a:	85 f6                	test   %esi,%esi
8010307c:	0f 85 22 01 00 00    	jne    801031a4 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80103082:	85 db                	test   %ebx,%ebx
80103084:	0f 85 f6 00 00 00    	jne    80103180 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
8010308a:	c7 05 00 27 11 80 01 	movl   $0x1,0x80112700
80103091:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80103094:	83 ec 0c             	sub    $0xc,%esp
80103097:	68 c0 26 11 80       	push   $0x801126c0
8010309c:	e8 df 1a 00 00       	call   80104b80 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
801030a1:	8b 0d 08 27 11 80    	mov    0x80112708,%ecx
801030a7:	83 c4 10             	add    $0x10,%esp
801030aa:	85 c9                	test   %ecx,%ecx
801030ac:	7f 42                	jg     801030f0 <end_op+0xa0>
    acquire(&log.lock);
801030ae:	83 ec 0c             	sub    $0xc,%esp
801030b1:	68 c0 26 11 80       	push   $0x801126c0
801030b6:	e8 25 1b 00 00       	call   80104be0 <acquire>
    log.committing = 0;
801030bb:	c7 05 00 27 11 80 00 	movl   $0x0,0x80112700
801030c2:	00 00 00 
    wakeup(&log);
801030c5:	c7 04 24 c0 26 11 80 	movl   $0x801126c0,(%esp)
801030cc:	e8 ff 13 00 00       	call   801044d0 <wakeup>
    release(&log.lock);
801030d1:	c7 04 24 c0 26 11 80 	movl   $0x801126c0,(%esp)
801030d8:	e8 a3 1a 00 00       	call   80104b80 <release>
801030dd:	83 c4 10             	add    $0x10,%esp
}
801030e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801030e3:	5b                   	pop    %ebx
801030e4:	5e                   	pop    %esi
801030e5:	5f                   	pop    %edi
801030e6:	5d                   	pop    %ebp
801030e7:	c3                   	ret
801030e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801030ef:	00 
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
801030f0:	a1 f4 26 11 80       	mov    0x801126f4,%eax
801030f5:	83 ec 08             	sub    $0x8,%esp
801030f8:	8d 44 18 01          	lea    0x1(%eax,%ebx,1),%eax
801030fc:	50                   	push   %eax
801030fd:	ff 35 04 27 11 80    	push   0x80112704
80103103:	e8 c8 cf ff ff       	call   801000d0 <bread>
80103108:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010310a:	58                   	pop    %eax
8010310b:	5a                   	pop    %edx
8010310c:	ff 34 9d 0c 27 11 80 	push   -0x7feed8f4(,%ebx,4)
80103113:	ff 35 04 27 11 80    	push   0x80112704
  for (tail = 0; tail < log.lh.n; tail++) {
80103119:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010311c:	e8 af cf ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80103121:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103124:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80103126:	8d 40 5c             	lea    0x5c(%eax),%eax
80103129:	68 00 02 00 00       	push   $0x200
8010312e:	50                   	push   %eax
8010312f:	8d 46 5c             	lea    0x5c(%esi),%eax
80103132:	50                   	push   %eax
80103133:	e8 58 1c 00 00       	call   80104d90 <memmove>
    bwrite(to);  // write the log
80103138:	89 34 24             	mov    %esi,(%esp)
8010313b:	e8 80 d0 ff ff       	call   801001c0 <bwrite>
    brelse(from);
80103140:	89 3c 24             	mov    %edi,(%esp)
80103143:	e8 b8 d0 ff ff       	call   80100200 <brelse>
    brelse(to);
80103148:	89 34 24             	mov    %esi,(%esp)
8010314b:	e8 b0 d0 ff ff       	call   80100200 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103150:	83 c4 10             	add    $0x10,%esp
80103153:	3b 1d 08 27 11 80    	cmp    0x80112708,%ebx
80103159:	7c 95                	jl     801030f0 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
8010315b:	e8 60 fd ff ff       	call   80102ec0 <write_head>
    install_trans(); // Now install writes to home locations
80103160:	e8 bb fc ff ff       	call   80102e20 <install_trans>
    log.lh.n = 0;
80103165:	c7 05 08 27 11 80 00 	movl   $0x0,0x80112708
8010316c:	00 00 00 
    write_head();    // Erase the transaction from the log
8010316f:	e8 4c fd ff ff       	call   80102ec0 <write_head>
80103174:	e9 35 ff ff ff       	jmp    801030ae <end_op+0x5e>
80103179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&log);
80103180:	83 ec 0c             	sub    $0xc,%esp
80103183:	68 c0 26 11 80       	push   $0x801126c0
80103188:	e8 43 13 00 00       	call   801044d0 <wakeup>
  release(&log.lock);
8010318d:	c7 04 24 c0 26 11 80 	movl   $0x801126c0,(%esp)
80103194:	e8 e7 19 00 00       	call   80104b80 <release>
80103199:	83 c4 10             	add    $0x10,%esp
}
8010319c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010319f:	5b                   	pop    %ebx
801031a0:	5e                   	pop    %esi
801031a1:	5f                   	pop    %edi
801031a2:	5d                   	pop    %ebp
801031a3:	c3                   	ret
    panic("log.committing");
801031a4:	83 ec 0c             	sub    $0xc,%esp
801031a7:	68 bf 7a 10 80       	push   $0x80107abf
801031ac:	e8 ef d1 ff ff       	call   801003a0 <panic>
801031b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801031b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801031bf:	00 

801031c0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
801031c0:	55                   	push   %ebp
801031c1:	89 e5                	mov    %esp,%ebp
801031c3:	53                   	push   %ebx
801031c4:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
801031c7:	8b 15 08 27 11 80    	mov    0x80112708,%edx
{
801031cd:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
801031d0:	83 fa 1d             	cmp    $0x1d,%edx
801031d3:	7f 7d                	jg     80103252 <log_write+0x92>
801031d5:	a1 f8 26 11 80       	mov    0x801126f8,%eax
801031da:	83 e8 01             	sub    $0x1,%eax
801031dd:	39 c2                	cmp    %eax,%edx
801031df:	7d 71                	jge    80103252 <log_write+0x92>
    panic("too big a transaction");
  if (log.outstanding < 1)
801031e1:	a1 fc 26 11 80       	mov    0x801126fc,%eax
801031e6:	85 c0                	test   %eax,%eax
801031e8:	7e 75                	jle    8010325f <log_write+0x9f>
    panic("log_write outside of trans");

  acquire(&log.lock);
801031ea:	83 ec 0c             	sub    $0xc,%esp
801031ed:	68 c0 26 11 80       	push   $0x801126c0
801031f2:	e8 e9 19 00 00       	call   80104be0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
801031f7:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
801031fa:	83 c4 10             	add    $0x10,%esp
801031fd:	31 c0                	xor    %eax,%eax
801031ff:	8b 15 08 27 11 80    	mov    0x80112708,%edx
80103205:	85 d2                	test   %edx,%edx
80103207:	7f 0e                	jg     80103217 <log_write+0x57>
80103209:	eb 15                	jmp    80103220 <log_write+0x60>
8010320b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80103210:	83 c0 01             	add    $0x1,%eax
80103213:	39 d0                	cmp    %edx,%eax
80103215:	74 29                	je     80103240 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103217:	39 0c 85 0c 27 11 80 	cmp    %ecx,-0x7feed8f4(,%eax,4)
8010321e:	75 f0                	jne    80103210 <log_write+0x50>
  log.lh.block[i] = b->blockno;
80103220:	89 0c 85 0c 27 11 80 	mov    %ecx,-0x7feed8f4(,%eax,4)
  if (i == log.lh.n)
80103227:	39 c2                	cmp    %eax,%edx
80103229:	74 1c                	je     80103247 <log_write+0x87>
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
8010322b:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
8010322e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
80103231:	c7 45 08 c0 26 11 80 	movl   $0x801126c0,0x8(%ebp)
}
80103238:	c9                   	leave
  release(&log.lock);
80103239:	e9 42 19 00 00       	jmp    80104b80 <release>
8010323e:	66 90                	xchg   %ax,%ax
  log.lh.block[i] = b->blockno;
80103240:	89 0c 95 0c 27 11 80 	mov    %ecx,-0x7feed8f4(,%edx,4)
    log.lh.n++;
80103247:	83 c2 01             	add    $0x1,%edx
8010324a:	89 15 08 27 11 80    	mov    %edx,0x80112708
80103250:	eb d9                	jmp    8010322b <log_write+0x6b>
    panic("too big a transaction");
80103252:	83 ec 0c             	sub    $0xc,%esp
80103255:	68 ce 7a 10 80       	push   $0x80107ace
8010325a:	e8 41 d1 ff ff       	call   801003a0 <panic>
    panic("log_write outside of trans");
8010325f:	83 ec 0c             	sub    $0xc,%esp
80103262:	68 e4 7a 10 80       	push   $0x80107ae4
80103267:	e8 34 d1 ff ff       	call   801003a0 <panic>
8010326c:	66 90                	xchg   %ax,%ax
8010326e:	66 90                	xchg   %ax,%ax

80103270 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103270:	55                   	push   %ebp
80103271:	89 e5                	mov    %esp,%ebp
80103273:	53                   	push   %ebx
80103274:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103277:	e8 a4 09 00 00       	call   80103c20 <cpuid>
8010327c:	89 c3                	mov    %eax,%ebx
8010327e:	e8 9d 09 00 00       	call   80103c20 <cpuid>
80103283:	83 ec 04             	sub    $0x4,%esp
80103286:	53                   	push   %ebx
80103287:	50                   	push   %eax
80103288:	68 ff 7a 10 80       	push   $0x80107aff
8010328d:	e8 3e d4 ff ff       	call   801006d0 <cprintf>
  idtinit();       // load idt register
80103292:	e8 99 2d 00 00       	call   80106030 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103297:	e8 04 09 00 00       	call   80103ba0 <mycpu>
8010329c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010329e:	b8 01 00 00 00       	mov    $0x1,%eax
801032a3:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
801032aa:	e8 81 0c 00 00       	call   80103f30 <scheduler>
801032af:	90                   	nop

801032b0 <mpenter>:
{
801032b0:	55                   	push   %ebp
801032b1:	89 e5                	mov    %esp,%ebp
801032b3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
801032b6:	e8 a5 3e 00 00       	call   80107160 <switchkvm>
  seginit();
801032bb:	e8 10 3e 00 00       	call   801070d0 <seginit>
  lapicinit();
801032c0:	e8 3b f7 ff ff       	call   80102a00 <lapicinit>
  mpmain();
801032c5:	e8 a6 ff ff ff       	call   80103270 <mpmain>
801032ca:	66 90                	xchg   %ax,%ax
801032cc:	66 90                	xchg   %ax,%ax
801032ce:	66 90                	xchg   %ax,%ax

801032d0 <main>:
{
801032d0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
801032d4:	83 e4 f0             	and    $0xfffffff0,%esp
801032d7:	ff 71 fc             	push   -0x4(%ecx)
801032da:	55                   	push   %ebp
801032db:	89 e5                	mov    %esp,%ebp
801032dd:	53                   	push   %ebx
801032de:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
801032df:	83 ec 08             	sub    $0x8,%esp
801032e2:	68 00 00 40 80       	push   $0x80400000
801032e7:	68 f0 67 11 80       	push   $0x801167f0
801032ec:	e8 2f f5 ff ff       	call   80102820 <kinit1>
  kvmalloc();      // kernel page table
801032f1:	e8 2a 43 00 00       	call   80107620 <kvmalloc>
  mpinit();        // detect other processors
801032f6:	e8 85 01 00 00       	call   80103480 <mpinit>
  lapicinit();     // interrupt controller
801032fb:	e8 00 f7 ff ff       	call   80102a00 <lapicinit>
  seginit();       // segment descriptors
80103300:	e8 cb 3d 00 00       	call   801070d0 <seginit>
  picinit();       // disable pic
80103305:	e8 56 03 00 00       	call   80103660 <picinit>
  ioapicinit();    // another interrupt controller
8010330a:	e8 b1 f2 ff ff       	call   801025c0 <ioapicinit>
  consoleinit();   // console hardware
8010330f:	e8 ac d7 ff ff       	call   80100ac0 <consoleinit>
  uartinit();      // serial port
80103314:	e8 37 30 00 00       	call   80106350 <uartinit>
  pinit();         // process table
80103319:	e8 62 08 00 00       	call   80103b80 <pinit>
  tvinit();        // trap vectors
8010331e:	e8 5d 2c 00 00       	call   80105f80 <tvinit>
  binit();         // buffer cache
80103323:	e8 18 cd ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103328:	e8 73 db ff ff       	call   80100ea0 <fileinit>
  ideinit();       // disk 
8010332d:	e8 5e f0 ff ff       	call   80102390 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103332:	83 c4 0c             	add    $0xc,%esp
80103335:	68 8a 00 00 00       	push   $0x8a
8010333a:	68 8c b4 10 80       	push   $0x8010b48c
8010333f:	68 00 70 00 80       	push   $0x80007000
80103344:	e8 47 1a 00 00       	call   80104d90 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103349:	83 c4 10             	add    $0x10,%esp
8010334c:	69 05 a4 27 11 80 b0 	imul   $0xb0,0x801127a4,%eax
80103353:	00 00 00 
80103356:	05 c0 27 11 80       	add    $0x801127c0,%eax
8010335b:	3d c0 27 11 80       	cmp    $0x801127c0,%eax
80103360:	76 7e                	jbe    801033e0 <main+0x110>
80103362:	bb c0 27 11 80       	mov    $0x801127c0,%ebx
80103367:	eb 20                	jmp    80103389 <main+0xb9>
80103369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103370:	69 05 a4 27 11 80 b0 	imul   $0xb0,0x801127a4,%eax
80103377:	00 00 00 
8010337a:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103380:	05 c0 27 11 80       	add    $0x801127c0,%eax
80103385:	39 c3                	cmp    %eax,%ebx
80103387:	73 57                	jae    801033e0 <main+0x110>
    if(c == mycpu())  // We've started already.
80103389:	e8 12 08 00 00       	call   80103ba0 <mycpu>
8010338e:	39 d8                	cmp    %ebx,%eax
80103390:	74 de                	je     80103370 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103392:	e8 f9 f4 ff ff       	call   80102890 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103397:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
8010339a:	c7 05 f8 6f 00 80 b0 	movl   $0x801032b0,0x80006ff8
801033a1:	32 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
801033a4:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
801033ab:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
801033ae:	05 00 10 00 00       	add    $0x1000,%eax
801033b3:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
801033b8:	0f b6 03             	movzbl (%ebx),%eax
801033bb:	68 00 70 00 00       	push   $0x7000
801033c0:	50                   	push   %eax
801033c1:	e8 8a f7 ff ff       	call   80102b50 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
801033c6:	83 c4 10             	add    $0x10,%esp
801033c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033d0:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
801033d6:	85 c0                	test   %eax,%eax
801033d8:	74 f6                	je     801033d0 <main+0x100>
801033da:	eb 94                	jmp    80103370 <main+0xa0>
801033dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
801033e0:	83 ec 08             	sub    $0x8,%esp
801033e3:	68 00 00 00 8e       	push   $0x8e000000
801033e8:	68 00 00 40 80       	push   $0x80400000
801033ed:	e8 ce f3 ff ff       	call   801027c0 <kinit2>
  userinit();      // first user process
801033f2:	e8 79 08 00 00       	call   80103c70 <userinit>
  mpmain();        // finish this processor's setup
801033f7:	e8 74 fe ff ff       	call   80103270 <mpmain>
801033fc:	66 90                	xchg   %ax,%ax
801033fe:	66 90                	xchg   %ax,%ax

80103400 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103400:	55                   	push   %ebp
80103401:	89 e5                	mov    %esp,%ebp
80103403:	57                   	push   %edi
80103404:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103405:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010340b:	53                   	push   %ebx
  e = addr+len;
8010340c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010340f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103412:	39 de                	cmp    %ebx,%esi
80103414:	72 10                	jb     80103426 <mpsearch1+0x26>
80103416:	eb 58                	jmp    80103470 <mpsearch1+0x70>
80103418:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010341f:	00 
80103420:	89 fe                	mov    %edi,%esi
80103422:	39 df                	cmp    %ebx,%edi
80103424:	73 4a                	jae    80103470 <mpsearch1+0x70>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103426:	83 ec 04             	sub    $0x4,%esp
80103429:	8d 7e 10             	lea    0x10(%esi),%edi
8010342c:	6a 04                	push   $0x4
8010342e:	68 13 7b 10 80       	push   $0x80107b13
80103433:	56                   	push   %esi
80103434:	e8 07 19 00 00       	call   80104d40 <memcmp>
80103439:	83 c4 10             	add    $0x10,%esp
8010343c:	85 c0                	test   %eax,%eax
8010343e:	75 e0                	jne    80103420 <mpsearch1+0x20>
80103440:	89 f2                	mov    %esi,%edx
80103442:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103448:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010344f:	00 
    sum += addr[i];
80103450:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
80103453:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80103456:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103458:	39 fa                	cmp    %edi,%edx
8010345a:	75 f4                	jne    80103450 <mpsearch1+0x50>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010345c:	84 c0                	test   %al,%al
8010345e:	75 c0                	jne    80103420 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103460:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103463:	89 f0                	mov    %esi,%eax
80103465:	5b                   	pop    %ebx
80103466:	5e                   	pop    %esi
80103467:	5f                   	pop    %edi
80103468:	5d                   	pop    %ebp
80103469:	c3                   	ret
8010346a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103470:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80103473:	31 f6                	xor    %esi,%esi
}
80103475:	5b                   	pop    %ebx
80103476:	89 f0                	mov    %esi,%eax
80103478:	5e                   	pop    %esi
80103479:	5f                   	pop    %edi
8010347a:	5d                   	pop    %ebp
8010347b:	c3                   	ret
8010347c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103480 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103480:	55                   	push   %ebp
80103481:	89 e5                	mov    %esp,%ebp
80103483:	57                   	push   %edi
80103484:	56                   	push   %esi
80103485:	53                   	push   %ebx
80103486:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103489:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103490:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103497:	c1 e0 08             	shl    $0x8,%eax
8010349a:	09 d0                	or     %edx,%eax
8010349c:	c1 e0 04             	shl    $0x4,%eax
8010349f:	75 1b                	jne    801034bc <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
801034a1:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
801034a8:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
801034af:	c1 e0 08             	shl    $0x8,%eax
801034b2:	09 d0                	or     %edx,%eax
801034b4:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
801034b7:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
801034bc:	ba 00 04 00 00       	mov    $0x400,%edx
801034c1:	e8 3a ff ff ff       	call   80103400 <mpsearch1>
801034c6:	89 c3                	mov    %eax,%ebx
801034c8:	85 c0                	test   %eax,%eax
801034ca:	0f 84 38 01 00 00    	je     80103608 <mpinit+0x188>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801034d0:	8b 73 04             	mov    0x4(%ebx),%esi
801034d3:	85 f6                	test   %esi,%esi
801034d5:	0f 84 1d 01 00 00    	je     801035f8 <mpinit+0x178>
  if(memcmp(conf, "PCMP", 4) != 0)
801034db:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801034de:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801034e4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
801034e7:	6a 04                	push   $0x4
801034e9:	68 18 7b 10 80       	push   $0x80107b18
801034ee:	50                   	push   %eax
801034ef:	e8 4c 18 00 00       	call   80104d40 <memcmp>
801034f4:	83 c4 10             	add    $0x10,%esp
801034f7:	89 c2                	mov    %eax,%edx
801034f9:	85 c0                	test   %eax,%eax
801034fb:	0f 85 f7 00 00 00    	jne    801035f8 <mpinit+0x178>
  if(conf->version != 1 && conf->version != 4)
80103501:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
80103508:	3c 01                	cmp    $0x1,%al
8010350a:	74 08                	je     80103514 <mpinit+0x94>
8010350c:	3c 04                	cmp    $0x4,%al
8010350e:	0f 85 e4 00 00 00    	jne    801035f8 <mpinit+0x178>
  if(sum((uchar*)conf, conf->length) != 0)
80103514:	0f b7 8e 04 00 00 80 	movzwl -0x7ffffffc(%esi),%ecx
  for(i=0; i<len; i++)
8010351b:	66 85 c9             	test   %cx,%cx
8010351e:	74 28                	je     80103548 <mpinit+0xc8>
80103520:	89 f0                	mov    %esi,%eax
80103522:	8d 3c 31             	lea    (%ecx,%esi,1),%edi
80103525:	8d 76 00             	lea    0x0(%esi),%esi
80103528:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010352f:	00 
    sum += addr[i];
80103530:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
80103537:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
8010353a:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
8010353c:	39 c7                	cmp    %eax,%edi
8010353e:	75 f0                	jne    80103530 <mpinit+0xb0>
  if(sum((uchar*)conf, conf->length) != 0)
80103540:	84 d2                	test   %dl,%dl
80103542:	0f 85 b0 00 00 00    	jne    801035f8 <mpinit+0x178>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103548:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010354e:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  lapic = (uint*)conf->lapicaddr;
80103551:	a3 a0 26 11 80       	mov    %eax,0x801126a0
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103556:	0f b7 8e 04 00 00 80 	movzwl -0x7ffffffc(%esi),%ecx
8010355d:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
80103563:	01 f9                	add    %edi,%ecx
80103565:	39 c8                	cmp    %ecx,%eax
80103567:	72 12                	jb     8010357b <mpinit+0xfb>
80103569:	eb 36                	jmp    801035a1 <mpinit+0x121>
8010356b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    switch(*p){
80103570:	84 d2                	test   %dl,%dl
80103572:	74 54                	je     801035c8 <mpinit+0x148>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103574:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103577:	39 c8                	cmp    %ecx,%eax
80103579:	73 26                	jae    801035a1 <mpinit+0x121>
    switch(*p){
8010357b:	0f b6 10             	movzbl (%eax),%edx
8010357e:	80 fa 02             	cmp    $0x2,%dl
80103581:	74 0d                	je     80103590 <mpinit+0x110>
80103583:	76 eb                	jbe    80103570 <mpinit+0xf0>
80103585:	83 ea 03             	sub    $0x3,%edx
80103588:	80 fa 01             	cmp    $0x1,%dl
8010358b:	76 e7                	jbe    80103574 <mpinit+0xf4>
8010358d:	eb fe                	jmp    8010358d <mpinit+0x10d>
8010358f:	90                   	nop
      ioapicid = ioapic->apicno;
80103590:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
80103594:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
80103597:	88 15 a0 27 11 80    	mov    %dl,0x801127a0
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010359d:	39 c8                	cmp    %ecx,%eax
8010359f:	72 da                	jb     8010357b <mpinit+0xfb>
    }
  }
  if(!ismp)
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801035a1:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
801035a5:	74 15                	je     801035bc <mpinit+0x13c>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801035a7:	b8 70 00 00 00       	mov    $0x70,%eax
801035ac:	ba 22 00 00 00       	mov    $0x22,%edx
801035b1:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801035b2:	ba 23 00 00 00       	mov    $0x23,%edx
801035b7:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
801035b8:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801035bb:	ee                   	out    %al,(%dx)
  }
}
801035bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801035bf:	5b                   	pop    %ebx
801035c0:	5e                   	pop    %esi
801035c1:	5f                   	pop    %edi
801035c2:	5d                   	pop    %ebp
801035c3:	c3                   	ret
801035c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(ncpu < NCPU) {
801035c8:	8b 35 a4 27 11 80    	mov    0x801127a4,%esi
801035ce:	83 fe 07             	cmp    $0x7,%esi
801035d1:	7f 19                	jg     801035ec <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801035d3:	69 fe b0 00 00 00    	imul   $0xb0,%esi,%edi
801035d9:	0f b6 50 01          	movzbl 0x1(%eax),%edx
        ncpu++;
801035dd:	83 c6 01             	add    $0x1,%esi
801035e0:	89 35 a4 27 11 80    	mov    %esi,0x801127a4
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801035e6:	88 97 c0 27 11 80    	mov    %dl,-0x7feed840(%edi)
      p += sizeof(struct mpproc);
801035ec:	83 c0 14             	add    $0x14,%eax
      continue;
801035ef:	eb 86                	jmp    80103577 <mpinit+0xf7>
801035f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
801035f8:	83 ec 0c             	sub    $0xc,%esp
801035fb:	68 1d 7b 10 80       	push   $0x80107b1d
80103600:	e8 9b cd ff ff       	call   801003a0 <panic>
80103605:	8d 76 00             	lea    0x0(%esi),%esi
{
80103608:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
8010360d:	eb 0b                	jmp    8010361a <mpinit+0x19a>
8010360f:	90                   	nop
  for(p = addr; p < e; p += sizeof(struct mp))
80103610:	89 f3                	mov    %esi,%ebx
80103612:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
80103618:	74 de                	je     801035f8 <mpinit+0x178>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010361a:	83 ec 04             	sub    $0x4,%esp
8010361d:	8d 73 10             	lea    0x10(%ebx),%esi
80103620:	6a 04                	push   $0x4
80103622:	68 13 7b 10 80       	push   $0x80107b13
80103627:	53                   	push   %ebx
80103628:	e8 13 17 00 00       	call   80104d40 <memcmp>
8010362d:	83 c4 10             	add    $0x10,%esp
80103630:	85 c0                	test   %eax,%eax
80103632:	75 dc                	jne    80103610 <mpinit+0x190>
80103634:	89 da                	mov    %ebx,%edx
80103636:	66 90                	xchg   %ax,%ax
80103638:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010363f:	00 
    sum += addr[i];
80103640:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
80103643:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80103646:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103648:	39 d6                	cmp    %edx,%esi
8010364a:	75 f4                	jne    80103640 <mpinit+0x1c0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010364c:	84 c0                	test   %al,%al
8010364e:	75 c0                	jne    80103610 <mpinit+0x190>
80103650:	e9 7b fe ff ff       	jmp    801034d0 <mpinit+0x50>
80103655:	66 90                	xchg   %ax,%ax
80103657:	66 90                	xchg   %ax,%ax
80103659:	66 90                	xchg   %ax,%ax
8010365b:	66 90                	xchg   %ax,%ax
8010365d:	66 90                	xchg   %ax,%ax
8010365f:	90                   	nop

80103660 <picinit>:
80103660:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103665:	ba 21 00 00 00       	mov    $0x21,%edx
8010366a:	ee                   	out    %al,(%dx)
8010366b:	ba a1 00 00 00       	mov    $0xa1,%edx
80103670:	ee                   	out    %al,(%dx)
80103671:	c3                   	ret
80103672:	66 90                	xchg   %ax,%ax
80103674:	66 90                	xchg   %ax,%ax
80103676:	66 90                	xchg   %ax,%ax
80103678:	66 90                	xchg   %ax,%ax
8010367a:	66 90                	xchg   %ax,%ax
8010367c:	66 90                	xchg   %ax,%ax
8010367e:	66 90                	xchg   %ax,%ax

80103680 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103680:	55                   	push   %ebp
80103681:	89 e5                	mov    %esp,%ebp
80103683:	57                   	push   %edi
80103684:	56                   	push   %esi
80103685:	53                   	push   %ebx
80103686:	83 ec 0c             	sub    $0xc,%esp
80103689:	8b 75 08             	mov    0x8(%ebp),%esi
8010368c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010368f:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
80103695:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010369b:	e8 20 d8 ff ff       	call   80100ec0 <filealloc>
801036a0:	89 06                	mov    %eax,(%esi)
801036a2:	85 c0                	test   %eax,%eax
801036a4:	0f 84 a5 00 00 00    	je     8010374f <pipealloc+0xcf>
801036aa:	e8 11 d8 ff ff       	call   80100ec0 <filealloc>
801036af:	89 07                	mov    %eax,(%edi)
801036b1:	85 c0                	test   %eax,%eax
801036b3:	0f 84 84 00 00 00    	je     8010373d <pipealloc+0xbd>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801036b9:	e8 d2 f1 ff ff       	call   80102890 <kalloc>
801036be:	89 c3                	mov    %eax,%ebx
801036c0:	85 c0                	test   %eax,%eax
801036c2:	0f 84 a0 00 00 00    	je     80103768 <pipealloc+0xe8>
    goto bad;
  p->readopen = 1;
801036c8:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801036cf:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
801036d2:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
801036d5:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801036dc:	00 00 00 
  p->nwrite = 0;
801036df:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801036e6:	00 00 00 
  p->nread = 0;
801036e9:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801036f0:	00 00 00 
  initlock(&p->lock, "pipe");
801036f3:	68 35 7b 10 80       	push   $0x80107b35
801036f8:	50                   	push   %eax
801036f9:	e8 c2 12 00 00       	call   801049c0 <initlock>
  (*f0)->type = FD_PIPE;
801036fe:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103700:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103703:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103709:	8b 06                	mov    (%esi),%eax
8010370b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010370f:	8b 06                	mov    (%esi),%eax
80103711:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103715:	8b 06                	mov    (%esi),%eax
80103717:	89 58 0c             	mov    %ebx,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010371a:	8b 07                	mov    (%edi),%eax
8010371c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103722:	8b 07                	mov    (%edi),%eax
80103724:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103728:	8b 07                	mov    (%edi),%eax
8010372a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010372e:	8b 07                	mov    (%edi),%eax
80103730:	89 58 0c             	mov    %ebx,0xc(%eax)
  return 0;
80103733:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103735:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103738:	5b                   	pop    %ebx
80103739:	5e                   	pop    %esi
8010373a:	5f                   	pop    %edi
8010373b:	5d                   	pop    %ebp
8010373c:	c3                   	ret
  if(*f0)
8010373d:	8b 06                	mov    (%esi),%eax
8010373f:	85 c0                	test   %eax,%eax
80103741:	74 1e                	je     80103761 <pipealloc+0xe1>
    fileclose(*f0);
80103743:	83 ec 0c             	sub    $0xc,%esp
80103746:	50                   	push   %eax
80103747:	e8 34 d8 ff ff       	call   80100f80 <fileclose>
8010374c:	83 c4 10             	add    $0x10,%esp
  if(*f1)
8010374f:	8b 07                	mov    (%edi),%eax
80103751:	85 c0                	test   %eax,%eax
80103753:	74 0c                	je     80103761 <pipealloc+0xe1>
    fileclose(*f1);
80103755:	83 ec 0c             	sub    $0xc,%esp
80103758:	50                   	push   %eax
80103759:	e8 22 d8 ff ff       	call   80100f80 <fileclose>
8010375e:	83 c4 10             	add    $0x10,%esp
  return -1;
80103761:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103766:	eb cd                	jmp    80103735 <pipealloc+0xb5>
  if(*f0)
80103768:	8b 06                	mov    (%esi),%eax
8010376a:	85 c0                	test   %eax,%eax
8010376c:	75 d5                	jne    80103743 <pipealloc+0xc3>
8010376e:	eb df                	jmp    8010374f <pipealloc+0xcf>

80103770 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103770:	55                   	push   %ebp
80103771:	89 e5                	mov    %esp,%ebp
80103773:	56                   	push   %esi
80103774:	53                   	push   %ebx
80103775:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103778:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010377b:	83 ec 0c             	sub    $0xc,%esp
8010377e:	53                   	push   %ebx
8010377f:	e8 5c 14 00 00       	call   80104be0 <acquire>
  if(writable){
80103784:	83 c4 10             	add    $0x10,%esp
80103787:	85 f6                	test   %esi,%esi
80103789:	74 45                	je     801037d0 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010378b:	83 ec 0c             	sub    $0xc,%esp
8010378e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103794:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010379b:	00 00 00 
    wakeup(&p->nread);
8010379e:	50                   	push   %eax
8010379f:	e8 2c 0d 00 00       	call   801044d0 <wakeup>
801037a4:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801037a7:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801037ad:	85 d2                	test   %edx,%edx
801037af:	75 0a                	jne    801037bb <pipeclose+0x4b>
801037b1:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801037b7:	85 c0                	test   %eax,%eax
801037b9:	74 35                	je     801037f0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801037bb:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801037be:	8d 65 f8             	lea    -0x8(%ebp),%esp
801037c1:	5b                   	pop    %ebx
801037c2:	5e                   	pop    %esi
801037c3:	5d                   	pop    %ebp
    release(&p->lock);
801037c4:	e9 b7 13 00 00       	jmp    80104b80 <release>
801037c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
801037d0:	83 ec 0c             	sub    $0xc,%esp
801037d3:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
801037d9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801037e0:	00 00 00 
    wakeup(&p->nwrite);
801037e3:	50                   	push   %eax
801037e4:	e8 e7 0c 00 00       	call   801044d0 <wakeup>
801037e9:	83 c4 10             	add    $0x10,%esp
801037ec:	eb b9                	jmp    801037a7 <pipeclose+0x37>
801037ee:	66 90                	xchg   %ax,%ax
    release(&p->lock);
801037f0:	83 ec 0c             	sub    $0xc,%esp
801037f3:	53                   	push   %ebx
801037f4:	e8 87 13 00 00       	call   80104b80 <release>
    kfree((char*)p);
801037f9:	83 c4 10             	add    $0x10,%esp
801037fc:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801037ff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103802:	5b                   	pop    %ebx
80103803:	5e                   	pop    %esi
80103804:	5d                   	pop    %ebp
    kfree((char*)p);
80103805:	e9 b6 ee ff ff       	jmp    801026c0 <kfree>
8010380a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103810 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103810:	55                   	push   %ebp
80103811:	89 e5                	mov    %esp,%ebp
80103813:	57                   	push   %edi
80103814:	56                   	push   %esi
80103815:	53                   	push   %ebx
80103816:	83 ec 28             	sub    $0x28,%esp
80103819:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010381c:	8b 7d 10             	mov    0x10(%ebp),%edi
  int i;

  acquire(&p->lock);
8010381f:	53                   	push   %ebx
80103820:	e8 bb 13 00 00       	call   80104be0 <acquire>
  for(i = 0; i < n; i++){
80103825:	83 c4 10             	add    $0x10,%esp
80103828:	85 ff                	test   %edi,%edi
8010382a:	0f 8e cc 00 00 00    	jle    801038fc <pipewrite+0xec>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103830:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
80103836:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103839:	89 7d 10             	mov    %edi,0x10(%ebp)
8010383c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010383f:	8d 34 39             	lea    (%ecx,%edi,1),%esi
80103842:	89 75 e0             	mov    %esi,-0x20(%ebp)
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103845:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010384b:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103851:	8d bb 38 02 00 00    	lea    0x238(%ebx),%edi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103857:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
8010385d:	39 55 e4             	cmp    %edx,-0x1c(%ebp)
80103860:	0f 85 b4 00 00 00    	jne    8010391a <pipewrite+0x10a>
80103866:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103869:	eb 3b                	jmp    801038a6 <pipewrite+0x96>
8010386b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
80103870:	e8 cb 03 00 00       	call   80103c40 <myproc>
80103875:	8b 48 24             	mov    0x24(%eax),%ecx
80103878:	85 c9                	test   %ecx,%ecx
8010387a:	75 34                	jne    801038b0 <pipewrite+0xa0>
      wakeup(&p->nread);
8010387c:	83 ec 0c             	sub    $0xc,%esp
8010387f:	56                   	push   %esi
80103880:	e8 4b 0c 00 00       	call   801044d0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103885:	58                   	pop    %eax
80103886:	5a                   	pop    %edx
80103887:	53                   	push   %ebx
80103888:	57                   	push   %edi
80103889:	e8 82 0b 00 00       	call   80104410 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010388e:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103894:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010389a:	83 c4 10             	add    $0x10,%esp
8010389d:	05 00 02 00 00       	add    $0x200,%eax
801038a2:	39 c2                	cmp    %eax,%edx
801038a4:	75 2a                	jne    801038d0 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
801038a6:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801038ac:	85 c0                	test   %eax,%eax
801038ae:	75 c0                	jne    80103870 <pipewrite+0x60>
        release(&p->lock);
801038b0:	83 ec 0c             	sub    $0xc,%esp
801038b3:	53                   	push   %ebx
801038b4:	e8 c7 12 00 00       	call   80104b80 <release>
        return -1;
801038b9:	83 c4 10             	add    $0x10,%esp
801038bc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801038c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801038c4:	5b                   	pop    %ebx
801038c5:	5e                   	pop    %esi
801038c6:	5f                   	pop    %edi
801038c7:	5d                   	pop    %ebp
801038c8:	c3                   	ret
801038c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801038d0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801038d3:	8d 42 01             	lea    0x1(%edx),%eax
801038d6:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  for(i = 0; i < n; i++){
801038dc:	83 c1 01             	add    $0x1,%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801038df:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
801038e5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801038e8:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
801038ec:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801038f0:	3b 4d e0             	cmp    -0x20(%ebp),%ecx
801038f3:	0f 85 52 ff ff ff    	jne    8010384b <pipewrite+0x3b>
801038f9:	8b 7d 10             	mov    0x10(%ebp),%edi
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801038fc:	83 ec 0c             	sub    $0xc,%esp
801038ff:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103905:	50                   	push   %eax
80103906:	e8 c5 0b 00 00       	call   801044d0 <wakeup>
  release(&p->lock);
8010390b:	89 1c 24             	mov    %ebx,(%esp)
8010390e:	e8 6d 12 00 00       	call   80104b80 <release>
  return n;
80103913:	83 c4 10             	add    $0x10,%esp
80103916:	89 f8                	mov    %edi,%eax
80103918:	eb a7                	jmp    801038c1 <pipewrite+0xb1>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010391a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010391d:	eb b4                	jmp    801038d3 <pipewrite+0xc3>
8010391f:	90                   	nop

80103920 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103920:	55                   	push   %ebp
80103921:	89 e5                	mov    %esp,%ebp
80103923:	57                   	push   %edi
80103924:	56                   	push   %esi
80103925:	53                   	push   %ebx
80103926:	83 ec 18             	sub    $0x18,%esp
80103929:	8b 75 08             	mov    0x8(%ebp),%esi
8010392c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010392f:	56                   	push   %esi
80103930:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103936:	e8 a5 12 00 00       	call   80104be0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010393b:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103941:	83 c4 10             	add    $0x10,%esp
80103944:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010394a:	74 2f                	je     8010397b <piperead+0x5b>
8010394c:	eb 37                	jmp    80103985 <piperead+0x65>
8010394e:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
80103950:	e8 eb 02 00 00       	call   80103c40 <myproc>
80103955:	8b 40 24             	mov    0x24(%eax),%eax
80103958:	85 c0                	test   %eax,%eax
8010395a:	0f 85 b0 00 00 00    	jne    80103a10 <piperead+0xf0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103960:	83 ec 08             	sub    $0x8,%esp
80103963:	56                   	push   %esi
80103964:	53                   	push   %ebx
80103965:	e8 a6 0a 00 00       	call   80104410 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010396a:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103970:	83 c4 10             	add    $0x10,%esp
80103973:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103979:	75 0a                	jne    80103985 <piperead+0x65>
8010397b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103981:	85 d2                	test   %edx,%edx
80103983:	75 cb                	jne    80103950 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103985:	8b 4d 10             	mov    0x10(%ebp),%ecx
80103988:	31 db                	xor    %ebx,%ebx
8010398a:	85 c9                	test   %ecx,%ecx
8010398c:	7f 56                	jg     801039e4 <piperead+0xc4>
8010398e:	eb 5c                	jmp    801039ec <piperead+0xcc>
80103990:	eb 2e                	jmp    801039c0 <piperead+0xa0>
80103992:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103998:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010399f:	00 
801039a0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801039a7:	00 
801039a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801039af:	00 
801039b0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801039b7:	00 
801039b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801039bf:	00 
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
801039c0:	8d 48 01             	lea    0x1(%eax),%ecx
801039c3:	25 ff 01 00 00       	and    $0x1ff,%eax
801039c8:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
801039ce:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
801039d3:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801039d6:	83 c3 01             	add    $0x1,%ebx
801039d9:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801039dc:	74 0e                	je     801039ec <piperead+0xcc>
801039de:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
    if(p->nread == p->nwrite)
801039e4:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
801039ea:	75 d4                	jne    801039c0 <piperead+0xa0>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801039ec:	83 ec 0c             	sub    $0xc,%esp
801039ef:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801039f5:	50                   	push   %eax
801039f6:	e8 d5 0a 00 00       	call   801044d0 <wakeup>
  release(&p->lock);
801039fb:	89 34 24             	mov    %esi,(%esp)
801039fe:	e8 7d 11 00 00       	call   80104b80 <release>
  return i;
80103a03:	83 c4 10             	add    $0x10,%esp
}
80103a06:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103a09:	89 d8                	mov    %ebx,%eax
80103a0b:	5b                   	pop    %ebx
80103a0c:	5e                   	pop    %esi
80103a0d:	5f                   	pop    %edi
80103a0e:	5d                   	pop    %ebp
80103a0f:	c3                   	ret
      release(&p->lock);
80103a10:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103a13:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103a18:	56                   	push   %esi
80103a19:	e8 62 11 00 00       	call   80104b80 <release>
      return -1;
80103a1e:	83 c4 10             	add    $0x10,%esp
}
80103a21:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103a24:	89 d8                	mov    %ebx,%eax
80103a26:	5b                   	pop    %ebx
80103a27:	5e                   	pop    %esi
80103a28:	5f                   	pop    %edi
80103a29:	5d                   	pop    %ebp
80103a2a:	c3                   	ret
80103a2b:	66 90                	xchg   %ax,%ax
80103a2d:	66 90                	xchg   %ax,%ax
80103a2f:	66 90                	xchg   %ax,%ax
80103a31:	66 90                	xchg   %ax,%ax
80103a33:	66 90                	xchg   %ax,%ax
80103a35:	66 90                	xchg   %ax,%ax
80103a37:	66 90                	xchg   %ax,%ax
80103a39:	66 90                	xchg   %ax,%ax
80103a3b:	66 90                	xchg   %ax,%ax
80103a3d:	66 90                	xchg   %ax,%ax
80103a3f:	90                   	nop

80103a40 <allocproc>:
//  If found, change state to EMBRYO and initialize
//  state required to run in the kernel.
//  Otherwise return 0.
static struct proc *
allocproc(void)
{
80103a40:	55                   	push   %ebp
80103a41:	89 e5                	mov    %esp,%ebp
80103a43:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103a44:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
{
80103a49:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
80103a4c:	68 40 2d 11 80       	push   $0x80112d40
80103a51:	e8 8a 11 00 00       	call   80104be0 <acquire>
80103a56:	83 c4 10             	add    $0x10,%esp
80103a59:	eb 17                	jmp    80103a72 <allocproc+0x32>
80103a5b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103a60:	81 c3 88 00 00 00    	add    $0x88,%ebx
80103a66:	81 fb 74 4f 11 80    	cmp    $0x80114f74,%ebx
80103a6c:	0f 84 96 00 00 00    	je     80103b08 <allocproc+0xc8>
    if (p->state == UNUSED)
80103a72:	8b 43 0c             	mov    0xc(%ebx),%eax
80103a75:	85 c0                	test   %eax,%eax
80103a77:	75 e7                	jne    80103a60 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103a79:	a1 04 b0 10 80       	mov    0x8010b004,%eax
  p->cputicks = 0;
  p->nice = 0;          /// f2
  p->is_privileged = 0; ////f2

  release(&ptable.lock);
80103a7e:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103a81:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->cputicks = 0;
80103a88:	c7 43 28 00 00 00 00 	movl   $0x0,0x28(%ebx)
  p->pid = nextpid++;
80103a8f:	89 43 10             	mov    %eax,0x10(%ebx)
80103a92:	8d 50 01             	lea    0x1(%eax),%edx
  p->nice = 0;          /// f2
80103a95:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
80103a9c:	00 00 00 
  p->is_privileged = 0; ////f2
80103a9f:	c7 83 84 00 00 00 00 	movl   $0x0,0x84(%ebx)
80103aa6:	00 00 00 
  release(&ptable.lock);
80103aa9:	68 40 2d 11 80       	push   $0x80112d40
  p->pid = nextpid++;
80103aae:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  release(&ptable.lock);
80103ab4:	e8 c7 10 00 00       	call   80104b80 <release>

  // Allocate kernel stack.
  if ((p->kstack = kalloc()) == 0)
80103ab9:	e8 d2 ed ff ff       	call   80102890 <kalloc>
80103abe:	83 c4 10             	add    $0x10,%esp
80103ac1:	89 43 08             	mov    %eax,0x8(%ebx)
80103ac4:	85 c0                	test   %eax,%eax
80103ac6:	74 59                	je     80103b21 <allocproc+0xe1>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103ac8:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint *)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context *)sp;
  memset(p->context, 0, sizeof *p->context);
80103ace:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103ad1:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103ad6:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint *)sp = (uint)trapret;
80103ad9:	c7 40 14 5f 5f 10 80 	movl   $0x80105f5f,0x14(%eax)
  p->context = (struct context *)sp;
80103ae0:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103ae3:	6a 14                	push   $0x14
80103ae5:	6a 00                	push   $0x0
80103ae7:	50                   	push   %eax
80103ae8:	e8 13 12 00 00       	call   80104d00 <memset>
  p->context->eip = (uint)forkret;
80103aed:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
80103af0:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103af3:	c7 40 10 30 3b 10 80 	movl   $0x80103b30,0x10(%eax)
}
80103afa:	89 d8                	mov    %ebx,%eax
80103afc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103aff:	c9                   	leave
80103b00:	c3                   	ret
80103b01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80103b08:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103b0b:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103b0d:	68 40 2d 11 80       	push   $0x80112d40
80103b12:	e8 69 10 00 00       	call   80104b80 <release>
  return 0;
80103b17:	83 c4 10             	add    $0x10,%esp
}
80103b1a:	89 d8                	mov    %ebx,%eax
80103b1c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103b1f:	c9                   	leave
80103b20:	c3                   	ret
    p->state = UNUSED;
80103b21:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  return 0;
80103b28:	31 db                	xor    %ebx,%ebx
80103b2a:	eb ee                	jmp    80103b1a <allocproc+0xda>
80103b2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103b30 <forkret>:
}

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void forkret(void)
{
80103b30:	55                   	push   %ebp
80103b31:	89 e5                	mov    %esp,%ebp
80103b33:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103b36:	68 40 2d 11 80       	push   $0x80112d40
80103b3b:	e8 40 10 00 00       	call   80104b80 <release>

  if (first)
80103b40:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80103b45:	83 c4 10             	add    $0x10,%esp
80103b48:	85 c0                	test   %eax,%eax
80103b4a:	75 04                	jne    80103b50 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103b4c:	c9                   	leave
80103b4d:	c3                   	ret
80103b4e:	66 90                	xchg   %ax,%ax
    first = 0;
80103b50:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
80103b57:	00 00 00 
    iinit(ROOTDEV);
80103b5a:	83 ec 0c             	sub    $0xc,%esp
80103b5d:	6a 01                	push   $0x1
80103b5f:	e8 7c db ff ff       	call   801016e0 <iinit>
    initlog(ROOTDEV);
80103b64:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103b6b:	e8 c0 f3 ff ff       	call   80102f30 <initlog>
}
80103b70:	83 c4 10             	add    $0x10,%esp
80103b73:	c9                   	leave
80103b74:	c3                   	ret
80103b75:	8d 76 00             	lea    0x0(%esi),%esi
80103b78:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103b7f:	00 

80103b80 <pinit>:
{
80103b80:	55                   	push   %ebp
80103b81:	89 e5                	mov    %esp,%ebp
80103b83:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103b86:	68 3a 7b 10 80       	push   $0x80107b3a
80103b8b:	68 40 2d 11 80       	push   $0x80112d40
80103b90:	e8 2b 0e 00 00       	call   801049c0 <initlock>
}
80103b95:	83 c4 10             	add    $0x10,%esp
80103b98:	c9                   	leave
80103b99:	c3                   	ret
80103b9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103ba0 <mycpu>:
{
80103ba0:	55                   	push   %ebp
80103ba1:	89 e5                	mov    %esp,%ebp
80103ba3:	56                   	push   %esi
80103ba4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103ba5:	9c                   	pushf
80103ba6:	58                   	pop    %eax
  if (readeflags() & FL_IF)
80103ba7:	f6 c4 02             	test   $0x2,%ah
80103baa:	75 65                	jne    80103c11 <mycpu+0x71>
  apicid = lapicid();
80103bac:	e8 4f ef ff ff       	call   80102b00 <lapicid>
  for (i = 0; i < ncpu; ++i)
80103bb1:	8b 1d a4 27 11 80    	mov    0x801127a4,%ebx
  apicid = lapicid();
80103bb7:	89 c6                	mov    %eax,%esi
  for (i = 0; i < ncpu; ++i)
80103bb9:	85 db                	test   %ebx,%ebx
80103bbb:	7e 47                	jle    80103c04 <mycpu+0x64>
80103bbd:	31 d2                	xor    %edx,%edx
80103bbf:	eb 26                	jmp    80103be7 <mycpu+0x47>
80103bc1:	eb 1d                	jmp    80103be0 <mycpu+0x40>
80103bc3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80103bc8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103bcf:	00 
80103bd0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103bd7:	00 
80103bd8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103bdf:	00 
80103be0:	83 c2 01             	add    $0x1,%edx
80103be3:	39 da                	cmp    %ebx,%edx
80103be5:	74 1d                	je     80103c04 <mycpu+0x64>
    if (cpus[i].apicid == apicid)
80103be7:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
80103bed:	0f b6 88 c0 27 11 80 	movzbl -0x7feed840(%eax),%ecx
80103bf4:	39 f1                	cmp    %esi,%ecx
80103bf6:	75 e8                	jne    80103be0 <mycpu+0x40>
}
80103bf8:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
80103bfb:	05 c0 27 11 80       	add    $0x801127c0,%eax
}
80103c00:	5b                   	pop    %ebx
80103c01:	5e                   	pop    %esi
80103c02:	5d                   	pop    %ebp
80103c03:	c3                   	ret
  panic("unknown apicid\n");
80103c04:	83 ec 0c             	sub    $0xc,%esp
80103c07:	68 41 7b 10 80       	push   $0x80107b41
80103c0c:	e8 8f c7 ff ff       	call   801003a0 <panic>
    panic("mycpu called with interrupts enabled\n");
80103c11:	83 ec 0c             	sub    $0xc,%esp
80103c14:	68 b8 7e 10 80       	push   $0x80107eb8
80103c19:	e8 82 c7 ff ff       	call   801003a0 <panic>
80103c1e:	66 90                	xchg   %ax,%ax

80103c20 <cpuid>:
{
80103c20:	55                   	push   %ebp
80103c21:	89 e5                	mov    %esp,%ebp
80103c23:	83 ec 08             	sub    $0x8,%esp
  return mycpu() - cpus;
80103c26:	e8 75 ff ff ff       	call   80103ba0 <mycpu>
}
80103c2b:	c9                   	leave
  return mycpu() - cpus;
80103c2c:	2d c0 27 11 80       	sub    $0x801127c0,%eax
80103c31:	c1 f8 04             	sar    $0x4,%eax
80103c34:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103c3a:	c3                   	ret
80103c3b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103c40 <myproc>:
{
80103c40:	55                   	push   %ebp
80103c41:	89 e5                	mov    %esp,%ebp
80103c43:	53                   	push   %ebx
80103c44:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103c47:	e8 34 0e 00 00       	call   80104a80 <pushcli>
  c = mycpu();
80103c4c:	e8 4f ff ff ff       	call   80103ba0 <mycpu>
  p = c->proc;
80103c51:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c57:	e8 74 0e 00 00       	call   80104ad0 <popcli>
}
80103c5c:	89 d8                	mov    %ebx,%eax
80103c5e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103c61:	c9                   	leave
80103c62:	c3                   	ret
80103c63:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80103c68:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103c6f:	00 

80103c70 <userinit>:
{
80103c70:	55                   	push   %ebp
80103c71:	89 e5                	mov    %esp,%ebp
80103c73:	53                   	push   %ebx
80103c74:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103c77:	e8 c4 fd ff ff       	call   80103a40 <allocproc>
80103c7c:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103c7e:	a3 74 4f 11 80       	mov    %eax,0x80114f74
  if ((p->pgdir = setupkvm()) == 0)
80103c83:	e8 18 39 00 00       	call   801075a0 <setupkvm>
80103c88:	89 43 04             	mov    %eax,0x4(%ebx)
80103c8b:	85 c0                	test   %eax,%eax
80103c8d:	0f 84 c7 00 00 00    	je     80103d5a <userinit+0xea>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103c93:	83 ec 04             	sub    $0x4,%esp
80103c96:	68 2c 00 00 00       	push   $0x2c
80103c9b:	68 60 b4 10 80       	push   $0x8010b460
80103ca0:	50                   	push   %eax
80103ca1:	e8 da 35 00 00       	call   80107280 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103ca6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103ca9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103caf:	6a 4c                	push   $0x4c
80103cb1:	6a 00                	push   $0x0
80103cb3:	ff 73 18             	push   0x18(%ebx)
80103cb6:	e8 45 10 00 00       	call   80104d00 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103cbb:	8b 43 18             	mov    0x18(%ebx),%eax
80103cbe:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103cc3:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103cc6:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103ccb:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103ccf:	8b 43 18             	mov    0x18(%ebx),%eax
80103cd2:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103cd6:	8b 43 18             	mov    0x18(%ebx),%eax
80103cd9:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103cdd:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103ce1:	8b 43 18             	mov    0x18(%ebx),%eax
80103ce4:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103ce8:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103cec:	8b 43 18             	mov    0x18(%ebx),%eax
80103cef:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103cf6:	8b 43 18             	mov    0x18(%ebx),%eax
80103cf9:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;       // beginning of initcode.S
80103d00:	8b 43 18             	mov    0x18(%ebx),%eax
80103d03:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103d0a:	8d 43 70             	lea    0x70(%ebx),%eax
  p->is_privileged = 0; /// f2
80103d0d:	c7 83 84 00 00 00 00 	movl   $0x0,0x84(%ebx)
80103d14:	00 00 00 
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103d17:	6a 10                	push   $0x10
80103d19:	68 6a 7b 10 80       	push   $0x80107b6a
80103d1e:	50                   	push   %eax
80103d1f:	e8 8c 11 00 00       	call   80104eb0 <safestrcpy>
  p->cwd = namei("/");
80103d24:	c7 04 24 73 7b 10 80 	movl   $0x80107b73,(%esp)
80103d2b:	e8 50 e5 ff ff       	call   80102280 <namei>
80103d30:	89 43 6c             	mov    %eax,0x6c(%ebx)
  acquire(&ptable.lock);
80103d33:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103d3a:	e8 a1 0e 00 00       	call   80104be0 <acquire>
  p->state = RUNNABLE;
80103d3f:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103d46:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103d4d:	e8 2e 0e 00 00       	call   80104b80 <release>
}
80103d52:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d55:	83 c4 10             	add    $0x10,%esp
80103d58:	c9                   	leave
80103d59:	c3                   	ret
    panic("userinit: out of memory?");
80103d5a:	83 ec 0c             	sub    $0xc,%esp
80103d5d:	68 51 7b 10 80       	push   $0x80107b51
80103d62:	e8 39 c6 ff ff       	call   801003a0 <panic>
80103d67:	90                   	nop
80103d68:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103d6f:	00 

80103d70 <growproc>:
{
80103d70:	55                   	push   %ebp
80103d71:	89 e5                	mov    %esp,%ebp
80103d73:	53                   	push   %ebx
80103d74:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103d77:	e8 04 0d 00 00       	call   80104a80 <pushcli>
  c = mycpu();
80103d7c:	e8 1f fe ff ff       	call   80103ba0 <mycpu>
  p = c->proc;
80103d81:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103d87:	e8 44 0d 00 00       	call   80104ad0 <popcli>
  if (n > 0)
80103d8c:	8b 55 08             	mov    0x8(%ebp),%edx
  sz = curproc->sz;
80103d8f:	8b 03                	mov    (%ebx),%eax
  if (n > 0)
80103d91:	85 d2                	test   %edx,%edx
80103d93:	7e 3b                	jle    80103dd0 <growproc+0x60>
    if (sz + n > KERNBASE)
80103d95:	8b 55 08             	mov    0x8(%ebp),%edx
80103d98:	01 c2                	add    %eax,%edx
80103d9a:	81 fa 00 00 00 80    	cmp    $0x80000000,%edx
80103da0:	77 4e                	ja     80103df0 <growproc+0x80>
    if ((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103da2:	83 ec 04             	sub    $0x4,%esp
80103da5:	52                   	push   %edx
80103da6:	50                   	push   %eax
80103da7:	ff 73 04             	push   0x4(%ebx)
80103daa:	e8 21 36 00 00       	call   801073d0 <allocuvm>
80103daf:	83 c4 10             	add    $0x10,%esp
80103db2:	85 c0                	test   %eax,%eax
80103db4:	74 3a                	je     80103df0 <growproc+0x80>
  switchuvm(curproc);
80103db6:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103db9:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103dbb:	53                   	push   %ebx
80103dbc:	e8 af 33 00 00       	call   80107170 <switchuvm>
  return 0;
80103dc1:	83 c4 10             	add    $0x10,%esp
80103dc4:	31 c0                	xor    %eax,%eax
}
80103dc6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103dc9:	c9                   	leave
80103dca:	c3                   	ret
80103dcb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  else if (n < 0)
80103dd0:	74 e4                	je     80103db6 <growproc+0x46>
    if ((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103dd2:	8b 55 08             	mov    0x8(%ebp),%edx
80103dd5:	83 ec 04             	sub    $0x4,%esp
80103dd8:	01 c2                	add    %eax,%edx
80103dda:	52                   	push   %edx
80103ddb:	50                   	push   %eax
80103ddc:	ff 73 04             	push   0x4(%ebx)
80103ddf:	e8 0c 37 00 00       	call   801074f0 <deallocuvm>
80103de4:	83 c4 10             	add    $0x10,%esp
80103de7:	85 c0                	test   %eax,%eax
80103de9:	75 cb                	jne    80103db6 <growproc+0x46>
80103deb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      return -1;
80103df0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103df5:	eb cf                	jmp    80103dc6 <growproc+0x56>
80103df7:	90                   	nop
80103df8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103dff:	00 

80103e00 <fork>:
{
80103e00:	55                   	push   %ebp
80103e01:	89 e5                	mov    %esp,%ebp
80103e03:	57                   	push   %edi
80103e04:	56                   	push   %esi
80103e05:	53                   	push   %ebx
80103e06:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103e09:	e8 72 0c 00 00       	call   80104a80 <pushcli>
  c = mycpu();
80103e0e:	e8 8d fd ff ff       	call   80103ba0 <mycpu>
  p = c->proc;
80103e13:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e19:	e8 b2 0c 00 00       	call   80104ad0 <popcli>
  if ((np = allocproc()) == 0)
80103e1e:	e8 1d fc ff ff       	call   80103a40 <allocproc>
80103e23:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103e26:	85 c0                	test   %eax,%eax
80103e28:	0f 84 f6 00 00 00    	je     80103f24 <fork+0x124>
  if ((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0)
80103e2e:	83 ec 08             	sub    $0x8,%esp
80103e31:	ff 33                	push   (%ebx)
80103e33:	89 c7                	mov    %eax,%edi
80103e35:	ff 73 04             	push   0x4(%ebx)
80103e38:	e8 53 38 00 00       	call   80107690 <copyuvm>
80103e3d:	83 c4 10             	add    $0x10,%esp
80103e40:	89 47 04             	mov    %eax,0x4(%edi)
80103e43:	85 c0                	test   %eax,%eax
80103e45:	0f 84 ba 00 00 00    	je     80103f05 <fork+0x105>
  np->sz = curproc->sz;
80103e4b:	8b 03                	mov    (%ebx),%eax
80103e4d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  *np->tf = *curproc->tf;
80103e50:	b9 13 00 00 00       	mov    $0x13,%ecx
  np->sz = curproc->sz;
80103e55:	89 02                	mov    %eax,(%edx)
  *np->tf = *curproc->tf;
80103e57:	8b 7a 18             	mov    0x18(%edx),%edi
  np->parent = curproc;
80103e5a:	89 5a 14             	mov    %ebx,0x14(%edx)
  *np->tf = *curproc->tf;
80103e5d:	8b 73 18             	mov    0x18(%ebx),%esi
80103e60:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for (i = 0; i < NOFILE; i++)
80103e62:	31 f6                	xor    %esi,%esi
  np->nice = curproc->nice;                   /// f2
80103e64:	8b 83 80 00 00 00    	mov    0x80(%ebx),%eax
80103e6a:	89 82 80 00 00 00    	mov    %eax,0x80(%edx)
  np->is_privileged = curproc->is_privileged; /// f2
80103e70:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
80103e76:	89 82 84 00 00 00    	mov    %eax,0x84(%edx)
  np->tf->eax = 0;
80103e7c:	8b 42 18             	mov    0x18(%edx),%eax
80103e7f:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for (i = 0; i < NOFILE; i++)
80103e86:	66 90                	xchg   %ax,%ax
80103e88:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103e8f:	00 
    if (curproc->ofile[i])
80103e90:	8b 44 b3 2c          	mov    0x2c(%ebx,%esi,4),%eax
80103e94:	85 c0                	test   %eax,%eax
80103e96:	74 13                	je     80103eab <fork+0xab>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103e98:	83 ec 0c             	sub    $0xc,%esp
80103e9b:	50                   	push   %eax
80103e9c:	e8 8f d0 ff ff       	call   80100f30 <filedup>
80103ea1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103ea4:	83 c4 10             	add    $0x10,%esp
80103ea7:	89 44 b2 2c          	mov    %eax,0x2c(%edx,%esi,4)
  for (i = 0; i < NOFILE; i++)
80103eab:	83 c6 01             	add    $0x1,%esi
80103eae:	83 fe 10             	cmp    $0x10,%esi
80103eb1:	75 dd                	jne    80103e90 <fork+0x90>
  np->cwd = idup(curproc->cwd);
80103eb3:	83 ec 0c             	sub    $0xc,%esp
80103eb6:	ff 73 6c             	push   0x6c(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103eb9:	83 c3 70             	add    $0x70,%ebx
  np->cwd = idup(curproc->cwd);
80103ebc:	e8 4f da ff ff       	call   80101910 <idup>
80103ec1:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103ec4:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103ec7:	89 47 6c             	mov    %eax,0x6c(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103eca:	8d 47 70             	lea    0x70(%edi),%eax
80103ecd:	6a 10                	push   $0x10
80103ecf:	53                   	push   %ebx
80103ed0:	50                   	push   %eax
80103ed1:	e8 da 0f 00 00       	call   80104eb0 <safestrcpy>
  pid = np->pid;
80103ed6:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103ed9:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103ee0:	e8 fb 0c 00 00       	call   80104be0 <acquire>
  np->state = RUNNABLE;
80103ee5:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103eec:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103ef3:	e8 88 0c 00 00       	call   80104b80 <release>
  return pid;
80103ef8:	83 c4 10             	add    $0x10,%esp
}
80103efb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103efe:	89 d8                	mov    %ebx,%eax
80103f00:	5b                   	pop    %ebx
80103f01:	5e                   	pop    %esi
80103f02:	5f                   	pop    %edi
80103f03:	5d                   	pop    %ebp
80103f04:	c3                   	ret
    kfree(np->kstack);
80103f05:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103f08:	83 ec 0c             	sub    $0xc,%esp
80103f0b:	ff 77 08             	push   0x8(%edi)
80103f0e:	e8 ad e7 ff ff       	call   801026c0 <kfree>
    np->kstack = 0;
80103f13:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    return -1;
80103f1a:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80103f1d:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
80103f24:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103f29:	eb d0                	jmp    80103efb <fork+0xfb>
80103f2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103f30 <scheduler>:
{
80103f30:	55                   	push   %ebp
80103f31:	89 e5                	mov    %esp,%ebp
80103f33:	57                   	push   %edi
80103f34:	56                   	push   %esi
80103f35:	53                   	push   %ebx
80103f36:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103f39:	e8 62 fc ff ff       	call   80103ba0 <mycpu>
  c->proc = 0;
80103f3e:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103f45:	00 00 00 
  struct cpu *c = mycpu();
80103f48:	89 c3                	mov    %eax,%ebx
  c->proc = 0;
80103f4a:	8d 70 04             	lea    0x4(%eax),%esi
80103f4d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103f50:	fb                   	sti
    acquire(&ptable.lock);
80103f51:	83 ec 0c             	sub    $0xc,%esp
    struct proc *best = 0; // f2
80103f54:	31 ff                	xor    %edi,%edi
    acquire(&ptable.lock);
80103f56:	68 40 2d 11 80       	push   $0x80112d40
80103f5b:	e8 80 0c 00 00       	call   80104be0 <acquire>
80103f60:	83 c4 10             	add    $0x10,%esp
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f63:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
80103f68:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103f6f:	00 
      if (p->state != RUNNABLE)
80103f70:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80103f74:	0f 85 86 00 00 00    	jne    80104000 <scheduler+0xd0>
      if (best == 0 || p->nice < best->nice)
80103f7a:	85 ff                	test   %edi,%edi
80103f7c:	75 1b                	jne    80103f99 <scheduler+0x69>
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f7e:	8d 90 88 00 00 00    	lea    0x88(%eax),%edx
        best = p;
80103f84:	89 c7                	mov    %eax,%edi
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f86:	3d ec 4e 11 80       	cmp    $0x80114eec,%eax
80103f8b:	0f 84 7f 00 00 00    	je     80104010 <scheduler+0xe0>
80103f91:	89 d0                	mov    %edx,%eax
      if (p->state != RUNNABLE)
80103f93:	83 7a 0c 03          	cmpl   $0x3,0xc(%edx)
80103f97:	75 67                	jne    80104000 <scheduler+0xd0>
      if (best == 0 || p->nice < best->nice)
80103f99:	8b 8f 80 00 00 00    	mov    0x80(%edi),%ecx
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f9f:	8d 90 88 00 00 00    	lea    0x88(%eax),%edx
      if (best == 0 || p->nice < best->nice)
80103fa5:	39 88 80 00 00 00    	cmp    %ecx,0x80(%eax)
80103fab:	7d 73                	jge    80104020 <scheduler+0xf0>
        best = p;
80103fad:	89 c7                	mov    %eax,%edi
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103faf:	3d ec 4e 11 80       	cmp    $0x80114eec,%eax
80103fb4:	75 db                	jne    80103f91 <scheduler+0x61>
      switchuvm(p);
80103fb6:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103fb9:	89 bb ac 00 00 00    	mov    %edi,0xac(%ebx)
      switchuvm(p);
80103fbf:	57                   	push   %edi
80103fc0:	e8 ab 31 00 00       	call   80107170 <switchuvm>
      p->state = RUNNING;
80103fc5:	c7 47 0c 04 00 00 00 	movl   $0x4,0xc(%edi)
      swtch(&(c->scheduler), p->context);
80103fcc:	58                   	pop    %eax
80103fcd:	5a                   	pop    %edx
80103fce:	ff 77 1c             	push   0x1c(%edi)
80103fd1:	56                   	push   %esi
80103fd2:	e8 44 0f 00 00       	call   80104f1b <swtch>
      switchkvm();
80103fd7:	e8 84 31 00 00       	call   80107160 <switchkvm>
      c->proc = 0;
80103fdc:	83 c4 10             	add    $0x10,%esp
80103fdf:	c7 83 ac 00 00 00 00 	movl   $0x0,0xac(%ebx)
80103fe6:	00 00 00 
    release(&ptable.lock);
80103fe9:	83 ec 0c             	sub    $0xc,%esp
80103fec:	68 40 2d 11 80       	push   $0x80112d40
80103ff1:	e8 8a 0b 00 00       	call   80104b80 <release>
  {
80103ff6:	83 c4 10             	add    $0x10,%esp
80103ff9:	e9 52 ff ff ff       	jmp    80103f50 <scheduler+0x20>
80103ffe:	66 90                	xchg   %ax,%ax
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104000:	05 88 00 00 00       	add    $0x88,%eax
80104005:	3d 74 4f 11 80       	cmp    $0x80114f74,%eax
8010400a:	0f 85 60 ff ff ff    	jne    80103f70 <scheduler+0x40>
    if (best != 0)
80104010:	85 ff                	test   %edi,%edi
80104012:	75 a2                	jne    80103fb6 <scheduler+0x86>
80104014:	eb d3                	jmp    80103fe9 <scheduler+0xb9>
80104016:	66 90                	xchg   %ax,%ax
80104018:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010401f:	00 
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104020:	3d ec 4e 11 80       	cmp    $0x80114eec,%eax
80104025:	0f 85 66 ff ff ff    	jne    80103f91 <scheduler+0x61>
    if (best != 0)
8010402b:	85 ff                	test   %edi,%edi
8010402d:	0f 85 83 ff ff ff    	jne    80103fb6 <scheduler+0x86>
80104033:	eb b4                	jmp    80103fe9 <scheduler+0xb9>
80104035:	8d 76 00             	lea    0x0(%esi),%esi
80104038:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010403f:	00 

80104040 <sched>:
{
80104040:	55                   	push   %ebp
80104041:	89 e5                	mov    %esp,%ebp
80104043:	56                   	push   %esi
80104044:	53                   	push   %ebx
  pushcli();
80104045:	e8 36 0a 00 00       	call   80104a80 <pushcli>
  c = mycpu();
8010404a:	e8 51 fb ff ff       	call   80103ba0 <mycpu>
  p = c->proc;
8010404f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104055:	e8 76 0a 00 00       	call   80104ad0 <popcli>
  if (!holding(&ptable.lock))
8010405a:	83 ec 0c             	sub    $0xc,%esp
8010405d:	68 40 2d 11 80       	push   $0x80112d40
80104062:	e8 c9 0a 00 00       	call   80104b30 <holding>
80104067:	83 c4 10             	add    $0x10,%esp
8010406a:	85 c0                	test   %eax,%eax
8010406c:	74 4f                	je     801040bd <sched+0x7d>
  if (mycpu()->ncli != 1)
8010406e:	e8 2d fb ff ff       	call   80103ba0 <mycpu>
80104073:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
8010407a:	75 68                	jne    801040e4 <sched+0xa4>
  if (p->state == RUNNING)
8010407c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80104080:	74 55                	je     801040d7 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104082:	9c                   	pushf
80104083:	58                   	pop    %eax
  if (readeflags() & FL_IF)
80104084:	f6 c4 02             	test   $0x2,%ah
80104087:	75 41                	jne    801040ca <sched+0x8a>
  intena = mycpu()->intena;
80104089:	e8 12 fb ff ff       	call   80103ba0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
8010408e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80104091:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80104097:	e8 04 fb ff ff       	call   80103ba0 <mycpu>
8010409c:	83 ec 08             	sub    $0x8,%esp
8010409f:	ff 70 04             	push   0x4(%eax)
801040a2:	53                   	push   %ebx
801040a3:	e8 73 0e 00 00       	call   80104f1b <swtch>
  mycpu()->intena = intena;
801040a8:	e8 f3 fa ff ff       	call   80103ba0 <mycpu>
}
801040ad:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
801040b0:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
801040b6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801040b9:	5b                   	pop    %ebx
801040ba:	5e                   	pop    %esi
801040bb:	5d                   	pop    %ebp
801040bc:	c3                   	ret
    panic("sched ptable.lock");
801040bd:	83 ec 0c             	sub    $0xc,%esp
801040c0:	68 75 7b 10 80       	push   $0x80107b75
801040c5:	e8 d6 c2 ff ff       	call   801003a0 <panic>
    panic("sched interruptible");
801040ca:	83 ec 0c             	sub    $0xc,%esp
801040cd:	68 a1 7b 10 80       	push   $0x80107ba1
801040d2:	e8 c9 c2 ff ff       	call   801003a0 <panic>
    panic("sched running");
801040d7:	83 ec 0c             	sub    $0xc,%esp
801040da:	68 93 7b 10 80       	push   $0x80107b93
801040df:	e8 bc c2 ff ff       	call   801003a0 <panic>
    panic("sched locks");
801040e4:	83 ec 0c             	sub    $0xc,%esp
801040e7:	68 87 7b 10 80       	push   $0x80107b87
801040ec:	e8 af c2 ff ff       	call   801003a0 <panic>
801040f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801040f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801040ff:	00 

80104100 <exit>:
{
80104100:	55                   	push   %ebp
80104101:	89 e5                	mov    %esp,%ebp
80104103:	57                   	push   %edi
80104104:	56                   	push   %esi
80104105:	53                   	push   %ebx
80104106:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
80104109:	e8 32 fb ff ff       	call   80103c40 <myproc>
  if (curproc == initproc)
8010410e:	39 05 74 4f 11 80    	cmp    %eax,0x80114f74
80104114:	0f 84 3f 01 00 00    	je     80104259 <exit+0x159>
8010411a:	89 c3                	mov    %eax,%ebx
8010411c:	8d 70 2c             	lea    0x2c(%eax),%esi
8010411f:	8d 78 6c             	lea    0x6c(%eax),%edi
80104122:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104128:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010412f:	00 
    if (curproc->ofile[fd])
80104130:	8b 06                	mov    (%esi),%eax
80104132:	85 c0                	test   %eax,%eax
80104134:	74 12                	je     80104148 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80104136:	83 ec 0c             	sub    $0xc,%esp
80104139:	50                   	push   %eax
8010413a:	e8 41 ce ff ff       	call   80100f80 <fileclose>
      curproc->ofile[fd] = 0;
8010413f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80104145:	83 c4 10             	add    $0x10,%esp
  for (fd = 0; fd < NOFILE; fd++)
80104148:	83 c6 04             	add    $0x4,%esi
8010414b:	39 f7                	cmp    %esi,%edi
8010414d:	75 e1                	jne    80104130 <exit+0x30>
  begin_op();
8010414f:	e8 8c ee ff ff       	call   80102fe0 <begin_op>
  iput(curproc->cwd);
80104154:	83 ec 0c             	sub    $0xc,%esp
80104157:	ff 73 6c             	push   0x6c(%ebx)
8010415a:	e8 31 d9 ff ff       	call   80101a90 <iput>
  end_op();
8010415f:	e8 ec ee ff ff       	call   80103050 <end_op>
  curproc->cwd = 0;
80104164:	c7 43 6c 00 00 00 00 	movl   $0x0,0x6c(%ebx)
  acquire(&ptable.lock);
8010416b:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80104172:	e8 69 0a 00 00       	call   80104be0 <acquire>
  wakeup1(curproc->parent);
80104177:	8b 53 14             	mov    0x14(%ebx),%edx
8010417a:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010417d:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
80104182:	eb 28                	jmp    801041ac <exit+0xac>
80104184:	eb 1a                	jmp    801041a0 <exit+0xa0>
80104186:	66 90                	xchg   %ax,%ax
80104188:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010418f:	00 
80104190:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104197:	00 
80104198:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010419f:	00 
801041a0:	05 88 00 00 00       	add    $0x88,%eax
801041a5:	3d 74 4f 11 80       	cmp    $0x80114f74,%eax
801041aa:	74 1e                	je     801041ca <exit+0xca>
    if (p->state == SLEEPING && p->chan == chan)
801041ac:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801041b0:	75 ee                	jne    801041a0 <exit+0xa0>
801041b2:	3b 50 20             	cmp    0x20(%eax),%edx
801041b5:	75 e9                	jne    801041a0 <exit+0xa0>
      p->state = RUNNABLE;
801041b7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801041be:	05 88 00 00 00       	add    $0x88,%eax
801041c3:	3d 74 4f 11 80       	cmp    $0x80114f74,%eax
801041c8:	75 e2                	jne    801041ac <exit+0xac>
      p->parent = initproc;
801041ca:	8b 0d 74 4f 11 80    	mov    0x80114f74,%ecx
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801041d0:	ba 74 2d 11 80       	mov    $0x80112d74,%edx
801041d5:	eb 17                	jmp    801041ee <exit+0xee>
801041d7:	90                   	nop
801041d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801041df:	00 
801041e0:	81 c2 88 00 00 00    	add    $0x88,%edx
801041e6:	81 fa 74 4f 11 80    	cmp    $0x80114f74,%edx
801041ec:	74 52                	je     80104240 <exit+0x140>
    if (p->parent == curproc)
801041ee:	39 5a 14             	cmp    %ebx,0x14(%edx)
801041f1:	75 ed                	jne    801041e0 <exit+0xe0>
      p->parent = initproc;
801041f3:	89 4a 14             	mov    %ecx,0x14(%edx)
      if (p->state == ZOMBIE)
801041f6:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
801041fa:	75 e4                	jne    801041e0 <exit+0xe0>
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801041fc:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
80104201:	eb 29                	jmp    8010422c <exit+0x12c>
80104203:	eb 1b                	jmp    80104220 <exit+0x120>
80104205:	8d 76 00             	lea    0x0(%esi),%esi
80104208:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010420f:	00 
80104210:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104217:	00 
80104218:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010421f:	00 
80104220:	05 88 00 00 00       	add    $0x88,%eax
80104225:	3d 74 4f 11 80       	cmp    $0x80114f74,%eax
8010422a:	74 b4                	je     801041e0 <exit+0xe0>
    if (p->state == SLEEPING && p->chan == chan)
8010422c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104230:	75 ee                	jne    80104220 <exit+0x120>
80104232:	3b 48 20             	cmp    0x20(%eax),%ecx
80104235:	75 e9                	jne    80104220 <exit+0x120>
      p->state = RUNNABLE;
80104237:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010423e:	eb e0                	jmp    80104220 <exit+0x120>
  curproc->state = ZOMBIE;
80104240:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80104247:	e8 f4 fd ff ff       	call   80104040 <sched>
  panic("zombie exit");
8010424c:	83 ec 0c             	sub    $0xc,%esp
8010424f:	68 c2 7b 10 80       	push   $0x80107bc2
80104254:	e8 47 c1 ff ff       	call   801003a0 <panic>
    panic("init exiting");
80104259:	83 ec 0c             	sub    $0xc,%esp
8010425c:	68 b5 7b 10 80       	push   $0x80107bb5
80104261:	e8 3a c1 ff ff       	call   801003a0 <panic>
80104266:	66 90                	xchg   %ax,%ax
80104268:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010426f:	00 

80104270 <wait>:
{
80104270:	55                   	push   %ebp
80104271:	89 e5                	mov    %esp,%ebp
80104273:	56                   	push   %esi
80104274:	53                   	push   %ebx
  pushcli();
80104275:	e8 06 08 00 00       	call   80104a80 <pushcli>
  c = mycpu();
8010427a:	e8 21 f9 ff ff       	call   80103ba0 <mycpu>
  p = c->proc;
8010427f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104285:	e8 46 08 00 00       	call   80104ad0 <popcli>
  acquire(&ptable.lock);
8010428a:	83 ec 0c             	sub    $0xc,%esp
8010428d:	68 40 2d 11 80       	push   $0x80112d40
80104292:	e8 49 09 00 00       	call   80104be0 <acquire>
80104297:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010429a:	31 c0                	xor    %eax,%eax
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010429c:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
801042a1:	eb 2b                	jmp    801042ce <wait+0x5e>
801042a3:	eb 1b                	jmp    801042c0 <wait+0x50>
801042a5:	8d 76 00             	lea    0x0(%esi),%esi
801042a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801042af:	00 
801042b0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801042b7:	00 
801042b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801042bf:	00 
801042c0:	81 c3 88 00 00 00    	add    $0x88,%ebx
801042c6:	81 fb 74 4f 11 80    	cmp    $0x80114f74,%ebx
801042cc:	74 1e                	je     801042ec <wait+0x7c>
      if (p->parent != curproc)
801042ce:	39 73 14             	cmp    %esi,0x14(%ebx)
801042d1:	75 ed                	jne    801042c0 <wait+0x50>
      if (p->state == ZOMBIE)
801042d3:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
801042d7:	74 67                	je     80104340 <wait+0xd0>
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801042d9:	81 c3 88 00 00 00    	add    $0x88,%ebx
      havekids = 1;
801042df:	b8 01 00 00 00       	mov    $0x1,%eax
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801042e4:	81 fb 74 4f 11 80    	cmp    $0x80114f74,%ebx
801042ea:	75 e2                	jne    801042ce <wait+0x5e>
    if (!havekids || curproc->killed)
801042ec:	85 c0                	test   %eax,%eax
801042ee:	0f 84 a2 00 00 00    	je     80104396 <wait+0x126>
801042f4:	8b 46 24             	mov    0x24(%esi),%eax
801042f7:	85 c0                	test   %eax,%eax
801042f9:	0f 85 97 00 00 00    	jne    80104396 <wait+0x126>
  pushcli();
801042ff:	e8 7c 07 00 00       	call   80104a80 <pushcli>
  c = mycpu();
80104304:	e8 97 f8 ff ff       	call   80103ba0 <mycpu>
  p = c->proc;
80104309:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010430f:	e8 bc 07 00 00       	call   80104ad0 <popcli>
  if (p == 0)
80104314:	85 db                	test   %ebx,%ebx
80104316:	0f 84 91 00 00 00    	je     801043ad <wait+0x13d>
  p->chan = chan;
8010431c:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
8010431f:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104326:	e8 15 fd ff ff       	call   80104040 <sched>
  p->chan = 0;
8010432b:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80104332:	e9 63 ff ff ff       	jmp    8010429a <wait+0x2a>
80104337:	90                   	nop
80104338:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010433f:	00 
        kfree(p->kstack);
80104340:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
80104343:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104346:	ff 73 08             	push   0x8(%ebx)
80104349:	e8 72 e3 ff ff       	call   801026c0 <kfree>
        p->kstack = 0;
8010434e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104355:	5a                   	pop    %edx
80104356:	ff 73 04             	push   0x4(%ebx)
80104359:	e8 c2 31 00 00       	call   80107520 <freevm>
        p->pid = 0;
8010435e:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104365:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010436c:	c6 43 70 00          	movb   $0x0,0x70(%ebx)
        p->killed = 0;
80104370:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104377:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
8010437e:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80104385:	e8 f6 07 00 00       	call   80104b80 <release>
        return pid;
8010438a:	83 c4 10             	add    $0x10,%esp
}
8010438d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104390:	89 f0                	mov    %esi,%eax
80104392:	5b                   	pop    %ebx
80104393:	5e                   	pop    %esi
80104394:	5d                   	pop    %ebp
80104395:	c3                   	ret
      release(&ptable.lock);
80104396:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104399:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
8010439e:	68 40 2d 11 80       	push   $0x80112d40
801043a3:	e8 d8 07 00 00       	call   80104b80 <release>
      return -1;
801043a8:	83 c4 10             	add    $0x10,%esp
801043ab:	eb e0                	jmp    8010438d <wait+0x11d>
    panic("sleep");
801043ad:	83 ec 0c             	sub    $0xc,%esp
801043b0:	68 ce 7b 10 80       	push   $0x80107bce
801043b5:	e8 e6 bf ff ff       	call   801003a0 <panic>
801043ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801043c0 <yield>:
{
801043c0:	55                   	push   %ebp
801043c1:	89 e5                	mov    %esp,%ebp
801043c3:	53                   	push   %ebx
801043c4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock); // DOC: yieldlock
801043c7:	68 40 2d 11 80       	push   $0x80112d40
801043cc:	e8 0f 08 00 00       	call   80104be0 <acquire>
  pushcli();
801043d1:	e8 aa 06 00 00       	call   80104a80 <pushcli>
  c = mycpu();
801043d6:	e8 c5 f7 ff ff       	call   80103ba0 <mycpu>
  p = c->proc;
801043db:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801043e1:	e8 ea 06 00 00       	call   80104ad0 <popcli>
  myproc()->state = RUNNABLE;
801043e6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
801043ed:	e8 4e fc ff ff       	call   80104040 <sched>
  release(&ptable.lock);
801043f2:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
801043f9:	e8 82 07 00 00       	call   80104b80 <release>
}
801043fe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104401:	83 c4 10             	add    $0x10,%esp
80104404:	c9                   	leave
80104405:	c3                   	ret
80104406:	66 90                	xchg   %ax,%ax
80104408:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010440f:	00 

80104410 <sleep>:
{
80104410:	55                   	push   %ebp
80104411:	89 e5                	mov    %esp,%ebp
80104413:	57                   	push   %edi
80104414:	56                   	push   %esi
80104415:	53                   	push   %ebx
80104416:	83 ec 0c             	sub    $0xc,%esp
80104419:	8b 7d 08             	mov    0x8(%ebp),%edi
8010441c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
8010441f:	e8 5c 06 00 00       	call   80104a80 <pushcli>
  c = mycpu();
80104424:	e8 77 f7 ff ff       	call   80103ba0 <mycpu>
  p = c->proc;
80104429:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010442f:	e8 9c 06 00 00       	call   80104ad0 <popcli>
  if (p == 0)
80104434:	85 db                	test   %ebx,%ebx
80104436:	0f 84 87 00 00 00    	je     801044c3 <sleep+0xb3>
  if (lk == 0)
8010443c:	85 f6                	test   %esi,%esi
8010443e:	74 76                	je     801044b6 <sleep+0xa6>
  if (lk != &ptable.lock)
80104440:	81 fe 40 2d 11 80    	cmp    $0x80112d40,%esi
80104446:	74 50                	je     80104498 <sleep+0x88>
    acquire(&ptable.lock); // DOC: sleeplock1
80104448:	83 ec 0c             	sub    $0xc,%esp
8010444b:	68 40 2d 11 80       	push   $0x80112d40
80104450:	e8 8b 07 00 00       	call   80104be0 <acquire>
    release(lk);
80104455:	89 34 24             	mov    %esi,(%esp)
80104458:	e8 23 07 00 00       	call   80104b80 <release>
  p->chan = chan;
8010445d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104460:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104467:	e8 d4 fb ff ff       	call   80104040 <sched>
  p->chan = 0;
8010446c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104473:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
8010447a:	e8 01 07 00 00       	call   80104b80 <release>
    acquire(lk);
8010447f:	83 c4 10             	add    $0x10,%esp
80104482:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104485:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104488:	5b                   	pop    %ebx
80104489:	5e                   	pop    %esi
8010448a:	5f                   	pop    %edi
8010448b:	5d                   	pop    %ebp
    acquire(lk);
8010448c:	e9 4f 07 00 00       	jmp    80104be0 <acquire>
80104491:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104498:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
8010449b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801044a2:	e8 99 fb ff ff       	call   80104040 <sched>
  p->chan = 0;
801044a7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
801044ae:	8d 65 f4             	lea    -0xc(%ebp),%esp
801044b1:	5b                   	pop    %ebx
801044b2:	5e                   	pop    %esi
801044b3:	5f                   	pop    %edi
801044b4:	5d                   	pop    %ebp
801044b5:	c3                   	ret
    panic("sleep without lk");
801044b6:	83 ec 0c             	sub    $0xc,%esp
801044b9:	68 d4 7b 10 80       	push   $0x80107bd4
801044be:	e8 dd be ff ff       	call   801003a0 <panic>
    panic("sleep");
801044c3:	83 ec 0c             	sub    $0xc,%esp
801044c6:	68 ce 7b 10 80       	push   $0x80107bce
801044cb:	e8 d0 be ff ff       	call   801003a0 <panic>

801044d0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void wakeup(void *chan)
{
801044d0:	55                   	push   %ebp
801044d1:	89 e5                	mov    %esp,%ebp
801044d3:	53                   	push   %ebx
801044d4:	83 ec 10             	sub    $0x10,%esp
801044d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801044da:	68 40 2d 11 80       	push   $0x80112d40
801044df:	e8 fc 06 00 00       	call   80104be0 <acquire>
801044e4:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801044e7:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
801044ec:	eb 1e                	jmp    8010450c <wakeup+0x3c>
801044ee:	66 90                	xchg   %ax,%ax
801044f0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801044f7:	00 
801044f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801044ff:	00 
80104500:	05 88 00 00 00       	add    $0x88,%eax
80104505:	3d 74 4f 11 80       	cmp    $0x80114f74,%eax
8010450a:	74 1e                	je     8010452a <wakeup+0x5a>
    if (p->state == SLEEPING && p->chan == chan)
8010450c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104510:	75 ee                	jne    80104500 <wakeup+0x30>
80104512:	3b 58 20             	cmp    0x20(%eax),%ebx
80104515:	75 e9                	jne    80104500 <wakeup+0x30>
      p->state = RUNNABLE;
80104517:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010451e:	05 88 00 00 00       	add    $0x88,%eax
80104523:	3d 74 4f 11 80       	cmp    $0x80114f74,%eax
80104528:	75 e2                	jne    8010450c <wakeup+0x3c>
  wakeup1(chan);
  release(&ptable.lock);
8010452a:	c7 45 08 40 2d 11 80 	movl   $0x80112d40,0x8(%ebp)
}
80104531:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104534:	c9                   	leave
  release(&ptable.lock);
80104535:	e9 46 06 00 00       	jmp    80104b80 <release>
8010453a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104540 <kill>:

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int kill(int pid)
{
80104540:	55                   	push   %ebp
80104541:	89 e5                	mov    %esp,%ebp
80104543:	53                   	push   %ebx
80104544:	83 ec 10             	sub    $0x10,%esp
80104547:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010454a:	68 40 2d 11 80       	push   $0x80112d40
8010454f:	e8 8c 06 00 00       	call   80104be0 <acquire>
80104554:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104557:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
8010455c:	eb 0e                	jmp    8010456c <kill+0x2c>
8010455e:	66 90                	xchg   %ax,%ax
80104560:	05 88 00 00 00       	add    $0x88,%eax
80104565:	3d 74 4f 11 80       	cmp    $0x80114f74,%eax
8010456a:	74 34                	je     801045a0 <kill+0x60>
  {
    if (p->pid == pid)
8010456c:	39 58 10             	cmp    %ebx,0x10(%eax)
8010456f:	75 ef                	jne    80104560 <kill+0x20>
    {
      p->killed = 1;
80104571:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if (p->state == SLEEPING)
80104578:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010457c:	75 07                	jne    80104585 <kill+0x45>
        p->state = RUNNABLE;
8010457e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104585:	83 ec 0c             	sub    $0xc,%esp
80104588:	68 40 2d 11 80       	push   $0x80112d40
8010458d:	e8 ee 05 00 00       	call   80104b80 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80104592:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
80104595:	83 c4 10             	add    $0x10,%esp
80104598:	31 c0                	xor    %eax,%eax
}
8010459a:	c9                   	leave
8010459b:	c3                   	ret
8010459c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
801045a0:	83 ec 0c             	sub    $0xc,%esp
801045a3:	68 40 2d 11 80       	push   $0x80112d40
801045a8:	e8 d3 05 00 00       	call   80104b80 <release>
}
801045ad:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
801045b0:	83 c4 10             	add    $0x10,%esp
801045b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801045b8:	c9                   	leave
801045b9:	c3                   	ret
801045ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801045c0 <can_access_procinfo>:

int can_access_procinfo(struct proc *caller, struct proc *target)
{
801045c0:	55                   	push   %ebp
801045c1:	89 e5                	mov    %esp,%ebp
801045c3:	8b 45 0c             	mov    0xc(%ebp),%eax
801045c6:	8b 55 08             	mov    0x8(%ebp),%edx
  while (target)
801045c9:	85 c0                	test   %eax,%eax
801045cb:	75 0a                	jne    801045d7 <can_access_procinfo+0x17>
801045cd:	eb 13                	jmp    801045e2 <can_access_procinfo+0x22>
801045cf:	90                   	nop
  {
    if (target == caller)
      return 1;
    target = target->parent;
801045d0:	8b 40 14             	mov    0x14(%eax),%eax
  while (target)
801045d3:	85 c0                	test   %eax,%eax
801045d5:	74 09                	je     801045e0 <can_access_procinfo+0x20>
    if (target == caller)
801045d7:	39 c2                	cmp    %eax,%edx
801045d9:	75 f5                	jne    801045d0 <can_access_procinfo+0x10>
      return 1;
801045db:	b8 01 00 00 00       	mov    $0x1,%eax
  }
  return 0;
}
801045e0:	5d                   	pop    %ebp
801045e1:	c3                   	ret
  return 0;
801045e2:	31 c0                	xor    %eax,%eax
}
801045e4:	5d                   	pop    %ebp
801045e5:	c3                   	ret
801045e6:	66 90                	xchg   %ax,%ax
801045e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801045ef:	00 

801045f0 <getprocinfo>:

int getprocinfo(int pid, struct procinfo *info)
{
801045f0:	55                   	push   %ebp
801045f1:	89 e5                	mov    %esp,%ebp
801045f3:	57                   	push   %edi
801045f4:	56                   	push   %esi
801045f5:	53                   	push   %ebx
801045f6:	83 ec 0c             	sub    $0xc,%esp
801045f9:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
801045fc:	e8 7f 04 00 00       	call   80104a80 <pushcli>
  c = mycpu();
80104601:	e8 9a f5 ff ff       	call   80103ba0 <mycpu>
  p = c->proc;
80104606:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
  popcli();
8010460c:	e8 bf 04 00 00       	call   80104ad0 <popcli>
  struct proc *p;
  struct proc *curproc = myproc();

  if (info == 0)
80104611:	85 f6                	test   %esi,%esi
80104613:	74 46                	je     8010465b <getprocinfo+0x6b>
    return -1;

  acquire(&ptable.lock);
80104615:	83 ec 0c             	sub    $0xc,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104618:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
  acquire(&ptable.lock);
8010461d:	68 40 2d 11 80       	push   $0x80112d40
80104622:	e8 b9 05 00 00       	call   80104be0 <acquire>
80104627:	83 c4 10             	add    $0x10,%esp
  {
    if (p->pid != pid || p->state == UNUSED)
8010462a:	8b 4b 10             	mov    0x10(%ebx),%ecx
8010462d:	3b 4d 08             	cmp    0x8(%ebp),%ecx
80104630:	75 36                	jne    80104668 <getprocinfo+0x78>
80104632:	8b 43 0c             	mov    0xc(%ebx),%eax
80104635:	85 c0                	test   %eax,%eax
80104637:	74 2f                	je     80104668 <getprocinfo+0x78>
80104639:	89 d8                	mov    %ebx,%eax
8010463b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if (target == caller)
80104640:	39 f8                	cmp    %edi,%eax
80104642:	74 3c                	je     80104680 <getprocinfo+0x90>
    target = target->parent;
80104644:	8b 40 14             	mov    0x14(%eax),%eax
  while (target)
80104647:	85 c0                	test   %eax,%eax
80104649:	75 f5                	jne    80104640 <getprocinfo+0x50>
      continue;

    if (!can_access_procinfo(curproc, p))
    {
      release(&ptable.lock);
8010464b:	83 ec 0c             	sub    $0xc,%esp
8010464e:	68 40 2d 11 80       	push   $0x80112d40
80104653:	e8 28 05 00 00       	call   80104b80 <release>
      return -1;
80104658:	83 c4 10             	add    $0x10,%esp
    return -1;
8010465b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104660:	e9 86 00 00 00       	jmp    801046eb <getprocinfo+0xfb>
80104665:	8d 76 00             	lea    0x0(%esi),%esi
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104668:	81 c3 88 00 00 00    	add    $0x88,%ebx
8010466e:	81 fb 74 4f 11 80    	cmp    $0x80114f74,%ebx
80104674:	75 b4                	jne    8010462a <getprocinfo+0x3a>
80104676:	eb d3                	jmp    8010464b <getprocinfo+0x5b>
80104678:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010467f:	00 
    }

    info->pid = p->pid;
80104680:	89 0e                	mov    %ecx,(%esi)
    info->ppid = p->parent ? p->parent->pid : 0;
80104682:	8b 43 14             	mov    0x14(%ebx),%eax
80104685:	85 c0                	test   %eax,%eax
80104687:	74 03                	je     8010468c <getprocinfo+0x9c>
80104689:	8b 40 10             	mov    0x10(%eax),%eax
8010468c:	89 46 04             	mov    %eax,0x4(%esi)
    info->sz = p->sz;
8010468f:	8b 03                	mov    (%ebx),%eax
80104691:	89 46 18             	mov    %eax,0x18(%esi)
    info->cputicks = p->cputicks;
80104694:	8b 43 28             	mov    0x28(%ebx),%eax
80104697:	89 46 1c             	mov    %eax,0x1c(%esi)
    info->nice = p->nice;
8010469a:	8b 83 80 00 00 00    	mov    0x80(%ebx),%eax
801046a0:	89 46 30             	mov    %eax,0x30(%esi)
    info->is_privileged = p->is_privileged;
801046a3:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
801046a9:	89 46 34             	mov    %eax,0x34(%esi)
    safestrcpy(info->state, procstatestr(p->state), sizeof(info->state));
801046ac:	8b 53 0c             	mov    0xc(%ebx),%edx
  return "UNKNOWN";
801046af:	b8 e5 7b 10 80       	mov    $0x80107be5,%eax
  if (state >= 0 && state < NELEM(states) && states[state])
801046b4:	83 fa 05             	cmp    $0x5,%edx
801046b7:	76 3f                	jbe    801046f8 <getprocinfo+0x108>
    safestrcpy(info->state, procstatestr(p->state), sizeof(info->state));
801046b9:	83 ec 04             	sub    $0x4,%esp
    safestrcpy(info->name, p->name, sizeof(info->name));
801046bc:	83 c3 70             	add    $0x70,%ebx
    safestrcpy(info->state, procstatestr(p->state), sizeof(info->state));
801046bf:	6a 10                	push   $0x10
801046c1:	50                   	push   %eax
801046c2:	8d 46 08             	lea    0x8(%esi),%eax
    safestrcpy(info->name, p->name, sizeof(info->name));
801046c5:	83 c6 20             	add    $0x20,%esi
    safestrcpy(info->state, procstatestr(p->state), sizeof(info->state));
801046c8:	50                   	push   %eax
801046c9:	e8 e2 07 00 00       	call   80104eb0 <safestrcpy>
    safestrcpy(info->name, p->name, sizeof(info->name));
801046ce:	83 c4 0c             	add    $0xc,%esp
801046d1:	6a 10                	push   $0x10
801046d3:	53                   	push   %ebx
801046d4:	56                   	push   %esi
801046d5:	e8 d6 07 00 00       	call   80104eb0 <safestrcpy>
    release(&ptable.lock);
801046da:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
801046e1:	e8 9a 04 00 00       	call   80104b80 <release>
    return 0;
801046e6:	83 c4 10             	add    $0x10,%esp
801046e9:	31 c0                	xor    %eax,%eax
  }
  release(&ptable.lock);
  return -1;
}
801046eb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801046ee:	5b                   	pop    %ebx
801046ef:	5e                   	pop    %esi
801046f0:	5f                   	pop    %edi
801046f1:	5d                   	pop    %ebp
801046f2:	c3                   	ret
801046f3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  if (state >= 0 && state < NELEM(states) && states[state])
801046f8:	8b 04 95 d8 81 10 80 	mov    -0x7fef7e28(,%edx,4),%eax
  return "UNKNOWN";
801046ff:	ba e5 7b 10 80       	mov    $0x80107be5,%edx
80104704:	85 c0                	test   %eax,%eax
80104706:	0f 44 c2             	cmove  %edx,%eax
80104709:	eb ae                	jmp    801046b9 <getprocinfo+0xc9>
8010470b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104710 <procdump>:
// PAGEBREAK: 36
//  Print a process listing to console.  For debugging.
//  Runs when user types ^P on console.
//  No lock to avoid wedging a stuck machine further.
void procdump(void)
{
80104710:	55                   	push   %ebp
80104711:	89 e5                	mov    %esp,%ebp
80104713:	57                   	push   %edi
80104714:	56                   	push   %esi
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if (p->state == SLEEPING)
    {
      getcallerpcs((uint *)p->context->ebp + 2, pc);
80104715:	8d 75 c0             	lea    -0x40(%ebp),%esi
{
80104718:	53                   	push   %ebx
80104719:	bb e4 2d 11 80       	mov    $0x80112de4,%ebx
8010471e:	83 ec 3c             	sub    $0x3c,%esp
80104721:	eb 27                	jmp    8010474a <procdump+0x3a>
80104723:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      for (i = 0; i < 10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104728:	83 ec 0c             	sub    $0xc,%esp
8010472b:	68 ca 7d 10 80       	push   $0x80107dca
80104730:	e8 9b bf ff ff       	call   801006d0 <cprintf>
80104735:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104738:	81 c3 88 00 00 00    	add    $0x88,%ebx
8010473e:	81 fb e4 4f 11 80    	cmp    $0x80114fe4,%ebx
80104744:	0f 84 86 00 00 00    	je     801047d0 <procdump+0xc0>
    if (p->state == UNUSED)
8010474a:	8b 43 9c             	mov    -0x64(%ebx),%eax
8010474d:	85 c0                	test   %eax,%eax
8010474f:	74 e7                	je     80104738 <procdump+0x28>
      state = "???";
80104751:	ba ed 7b 10 80       	mov    $0x80107bed,%edx
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104756:	83 f8 05             	cmp    $0x5,%eax
80104759:	77 11                	ja     8010476c <procdump+0x5c>
8010475b:	8b 14 85 c0 81 10 80 	mov    -0x7fef7e40(,%eax,4),%edx
      state = "???";
80104762:	b8 ed 7b 10 80       	mov    $0x80107bed,%eax
80104767:	85 d2                	test   %edx,%edx
80104769:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
8010476c:	53                   	push   %ebx
8010476d:	52                   	push   %edx
8010476e:	ff 73 a0             	push   -0x60(%ebx)
80104771:	68 f1 7b 10 80       	push   $0x80107bf1
80104776:	e8 55 bf ff ff       	call   801006d0 <cprintf>
    if (p->state == SLEEPING)
8010477b:	83 c4 10             	add    $0x10,%esp
8010477e:	83 7b 9c 02          	cmpl   $0x2,-0x64(%ebx)
80104782:	75 a4                	jne    80104728 <procdump+0x18>
      getcallerpcs((uint *)p->context->ebp + 2, pc);
80104784:	83 ec 08             	sub    $0x8,%esp
80104787:	89 f7                	mov    %esi,%edi
80104789:	56                   	push   %esi
8010478a:	8b 43 ac             	mov    -0x54(%ebx),%eax
8010478d:	8b 40 0c             	mov    0xc(%eax),%eax
80104790:	83 c0 08             	add    $0x8,%eax
80104793:	50                   	push   %eax
80104794:	e8 47 02 00 00       	call   801049e0 <getcallerpcs>
      for (i = 0; i < 10 && pc[i] != 0; i++)
80104799:	83 c4 10             	add    $0x10,%esp
8010479c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801047a0:	8b 07                	mov    (%edi),%eax
801047a2:	85 c0                	test   %eax,%eax
801047a4:	74 82                	je     80104728 <procdump+0x18>
        cprintf(" %p", pc[i]);
801047a6:	83 ec 08             	sub    $0x8,%esp
      for (i = 0; i < 10 && pc[i] != 0; i++)
801047a9:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
801047ac:	50                   	push   %eax
801047ad:	68 21 79 10 80       	push   $0x80107921
801047b2:	e8 19 bf ff ff       	call   801006d0 <cprintf>
      for (i = 0; i < 10 && pc[i] != 0; i++)
801047b7:	8d 45 e8             	lea    -0x18(%ebp),%eax
801047ba:	83 c4 10             	add    $0x10,%esp
801047bd:	39 c7                	cmp    %eax,%edi
801047bf:	75 df                	jne    801047a0 <procdump+0x90>
801047c1:	e9 62 ff ff ff       	jmp    80104728 <procdump+0x18>
801047c6:	66 90                	xchg   %ax,%ax
801047c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801047cf:	00 
  }
}
801047d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801047d3:	5b                   	pop    %ebx
801047d4:	5e                   	pop    %esi
801047d5:	5f                   	pop    %edi
801047d6:	5d                   	pop    %ebp
801047d7:	c3                   	ret
801047d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801047df:	00 

801047e0 <nice>:

int nice(int pid, int priority) // f2
{
801047e0:	55                   	push   %ebp
801047e1:	89 e5                	mov    %esp,%ebp
801047e3:	56                   	push   %esi
801047e4:	53                   	push   %ebx
801047e5:	8b 75 0c             	mov    0xc(%ebp),%esi
801047e8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;
  if (priority < -20 || priority > 19)
801047eb:	8d 46 14             	lea    0x14(%esi),%eax
801047ee:	83 f8 27             	cmp    $0x27,%eax
801047f1:	77 7d                	ja     80104870 <nice+0x90>
    return -1;
  acquire(&ptable.lock);
801047f3:	83 ec 0c             	sub    $0xc,%esp
801047f6:	68 40 2d 11 80       	push   $0x80112d40
801047fb:	e8 e0 03 00 00       	call   80104be0 <acquire>
80104800:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104803:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
80104808:	eb 22                	jmp    8010482c <nice+0x4c>
8010480a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104810:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104817:	00 
80104818:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010481f:	00 
80104820:	05 88 00 00 00       	add    $0x88,%eax
80104825:	3d 74 4f 11 80       	cmp    $0x80114f74,%eax
8010482a:	74 34                	je     80104860 <nice+0x80>
  {

    if (p->pid == pid)
8010482c:	39 58 10             	cmp    %ebx,0x10(%eax)
8010482f:	75 ef                	jne    80104820 <nice+0x40>
    {
      p->nice = (priority < 0) ? -priority : priority;
80104831:	89 f2                	mov    %esi,%edx
80104833:	f7 da                	neg    %edx
80104835:	0f 48 d6             	cmovs  %esi,%edx
      p->is_privileged = (priority < 0) ? 1 : 0;

      release(&ptable.lock);
80104838:	83 ec 0c             	sub    $0xc,%esp
      p->is_privileged = (priority < 0) ? 1 : 0;
8010483b:	c1 ee 1f             	shr    $0x1f,%esi
8010483e:	89 b0 84 00 00 00    	mov    %esi,0x84(%eax)
      p->nice = (priority < 0) ? -priority : priority;
80104844:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
      release(&ptable.lock);
8010484a:	68 40 2d 11 80       	push   $0x80112d40
8010484f:	e8 2c 03 00 00       	call   80104b80 <release>
      return 0;
80104854:	83 c4 10             	add    $0x10,%esp
80104857:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
80104859:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010485c:	5b                   	pop    %ebx
8010485d:	5e                   	pop    %esi
8010485e:	5d                   	pop    %ebp
8010485f:	c3                   	ret
  release(&ptable.lock);
80104860:	83 ec 0c             	sub    $0xc,%esp
80104863:	68 40 2d 11 80       	push   $0x80112d40
80104868:	e8 13 03 00 00       	call   80104b80 <release>
  return -1;
8010486d:	83 c4 10             	add    $0x10,%esp
    return -1;
80104870:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104875:	eb e2                	jmp    80104859 <nice+0x79>
80104877:	66 90                	xchg   %ax,%ax
80104879:	66 90                	xchg   %ax,%ax
8010487b:	66 90                	xchg   %ax,%ax
8010487d:	66 90                	xchg   %ax,%ax
8010487f:	90                   	nop

80104880 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104880:	55                   	push   %ebp
80104881:	89 e5                	mov    %esp,%ebp
80104883:	53                   	push   %ebx
80104884:	83 ec 0c             	sub    $0xc,%esp
80104887:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010488a:	68 53 7c 10 80       	push   $0x80107c53
8010488f:	8d 43 04             	lea    0x4(%ebx),%eax
80104892:	50                   	push   %eax
80104893:	e8 28 01 00 00       	call   801049c0 <initlock>
  lk->name = name;
80104898:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010489b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801048a1:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
801048a4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
801048ab:	89 43 38             	mov    %eax,0x38(%ebx)
}
801048ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801048b1:	c9                   	leave
801048b2:	c3                   	ret
801048b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801048b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801048bf:	00 

801048c0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801048c0:	55                   	push   %ebp
801048c1:	89 e5                	mov    %esp,%ebp
801048c3:	56                   	push   %esi
801048c4:	53                   	push   %ebx
801048c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801048c8:	8d 73 04             	lea    0x4(%ebx),%esi
801048cb:	83 ec 0c             	sub    $0xc,%esp
801048ce:	56                   	push   %esi
801048cf:	e8 0c 03 00 00       	call   80104be0 <acquire>
  while (lk->locked) {
801048d4:	8b 13                	mov    (%ebx),%edx
801048d6:	83 c4 10             	add    $0x10,%esp
801048d9:	85 d2                	test   %edx,%edx
801048db:	74 16                	je     801048f3 <acquiresleep+0x33>
801048dd:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
801048e0:	83 ec 08             	sub    $0x8,%esp
801048e3:	56                   	push   %esi
801048e4:	53                   	push   %ebx
801048e5:	e8 26 fb ff ff       	call   80104410 <sleep>
  while (lk->locked) {
801048ea:	8b 03                	mov    (%ebx),%eax
801048ec:	83 c4 10             	add    $0x10,%esp
801048ef:	85 c0                	test   %eax,%eax
801048f1:	75 ed                	jne    801048e0 <acquiresleep+0x20>
  }
  lk->locked = 1;
801048f3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
801048f9:	e8 42 f3 ff ff       	call   80103c40 <myproc>
801048fe:	8b 40 10             	mov    0x10(%eax),%eax
80104901:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104904:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104907:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010490a:	5b                   	pop    %ebx
8010490b:	5e                   	pop    %esi
8010490c:	5d                   	pop    %ebp
  release(&lk->lk);
8010490d:	e9 6e 02 00 00       	jmp    80104b80 <release>
80104912:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104918:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010491f:	00 

80104920 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104920:	55                   	push   %ebp
80104921:	89 e5                	mov    %esp,%ebp
80104923:	56                   	push   %esi
80104924:	53                   	push   %ebx
80104925:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104928:	8d 73 04             	lea    0x4(%ebx),%esi
8010492b:	83 ec 0c             	sub    $0xc,%esp
8010492e:	56                   	push   %esi
8010492f:	e8 ac 02 00 00       	call   80104be0 <acquire>
  lk->locked = 0;
80104934:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010493a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104941:	89 1c 24             	mov    %ebx,(%esp)
80104944:	e8 87 fb ff ff       	call   801044d0 <wakeup>
  release(&lk->lk);
80104949:	83 c4 10             	add    $0x10,%esp
8010494c:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010494f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104952:	5b                   	pop    %ebx
80104953:	5e                   	pop    %esi
80104954:	5d                   	pop    %ebp
  release(&lk->lk);
80104955:	e9 26 02 00 00       	jmp    80104b80 <release>
8010495a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104960 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104960:	55                   	push   %ebp
80104961:	89 e5                	mov    %esp,%ebp
80104963:	57                   	push   %edi
80104964:	31 ff                	xor    %edi,%edi
80104966:	56                   	push   %esi
80104967:	53                   	push   %ebx
80104968:	83 ec 18             	sub    $0x18,%esp
8010496b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010496e:	8d 73 04             	lea    0x4(%ebx),%esi
80104971:	56                   	push   %esi
80104972:	e8 69 02 00 00       	call   80104be0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104977:	8b 03                	mov    (%ebx),%eax
80104979:	83 c4 10             	add    $0x10,%esp
8010497c:	85 c0                	test   %eax,%eax
8010497e:	75 18                	jne    80104998 <holdingsleep+0x38>
  release(&lk->lk);
80104980:	83 ec 0c             	sub    $0xc,%esp
80104983:	56                   	push   %esi
80104984:	e8 f7 01 00 00       	call   80104b80 <release>
  return r;
}
80104989:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010498c:	89 f8                	mov    %edi,%eax
8010498e:	5b                   	pop    %ebx
8010498f:	5e                   	pop    %esi
80104990:	5f                   	pop    %edi
80104991:	5d                   	pop    %ebp
80104992:	c3                   	ret
80104993:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  r = lk->locked && (lk->pid == myproc()->pid);
80104998:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
8010499b:	e8 a0 f2 ff ff       	call   80103c40 <myproc>
801049a0:	39 58 10             	cmp    %ebx,0x10(%eax)
801049a3:	0f 94 c0             	sete   %al
801049a6:	0f b6 c0             	movzbl %al,%eax
801049a9:	89 c7                	mov    %eax,%edi
801049ab:	eb d3                	jmp    80104980 <holdingsleep+0x20>
801049ad:	66 90                	xchg   %ax,%ax
801049af:	66 90                	xchg   %ax,%ax
801049b1:	66 90                	xchg   %ax,%ax
801049b3:	66 90                	xchg   %ax,%ax
801049b5:	66 90                	xchg   %ax,%ax
801049b7:	66 90                	xchg   %ax,%ax
801049b9:	66 90                	xchg   %ax,%ax
801049bb:	66 90                	xchg   %ax,%ax
801049bd:	66 90                	xchg   %ax,%ax
801049bf:	90                   	nop

801049c0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801049c0:	55                   	push   %ebp
801049c1:	89 e5                	mov    %esp,%ebp
801049c3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801049c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801049c9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
801049cf:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
801049d2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801049d9:	5d                   	pop    %ebp
801049da:	c3                   	ret
801049db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801049e0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801049e0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801049e1:	31 d2                	xor    %edx,%edx
{
801049e3:	89 e5                	mov    %esp,%ebp
801049e5:	53                   	push   %ebx
  ebp = (uint*)v - 2;
801049e6:	8b 45 08             	mov    0x8(%ebp),%eax
{
801049e9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
801049ec:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
801049ef:	90                   	nop
801049f0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801049f7:	00 
801049f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801049ff:	00 
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104a00:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104a06:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104a0c:	77 1a                	ja     80104a28 <getcallerpcs+0x48>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104a0e:	8b 58 04             	mov    0x4(%eax),%ebx
80104a11:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104a14:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104a17:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104a19:	83 fa 0a             	cmp    $0xa,%edx
80104a1c:	75 e2                	jne    80104a00 <getcallerpcs+0x20>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80104a1e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a21:	c9                   	leave
80104a22:	c3                   	ret
80104a23:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80104a28:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104a2b:	83 c1 28             	add    $0x28,%ecx
80104a2e:	89 ca                	mov    %ecx,%edx
80104a30:	29 c2                	sub    %eax,%edx
80104a32:	83 e2 04             	and    $0x4,%edx
80104a35:	74 29                	je     80104a60 <getcallerpcs+0x80>
    pcs[i] = 0;
80104a37:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104a3d:	83 c0 04             	add    $0x4,%eax
80104a40:	39 c8                	cmp    %ecx,%eax
80104a42:	74 da                	je     80104a1e <getcallerpcs+0x3e>
80104a44:	eb 1a                	jmp    80104a60 <getcallerpcs+0x80>
80104a46:	66 90                	xchg   %ax,%ax
80104a48:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a4f:	00 
80104a50:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a57:	00 
80104a58:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a5f:	00 
    pcs[i] = 0;
80104a60:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104a66:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
80104a69:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
80104a70:	39 c8                	cmp    %ecx,%eax
80104a72:	75 ec                	jne    80104a60 <getcallerpcs+0x80>
80104a74:	eb a8                	jmp    80104a1e <getcallerpcs+0x3e>
80104a76:	66 90                	xchg   %ax,%ax
80104a78:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a7f:	00 

80104a80 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104a80:	55                   	push   %ebp
80104a81:	89 e5                	mov    %esp,%ebp
80104a83:	53                   	push   %ebx
80104a84:	83 ec 04             	sub    $0x4,%esp
80104a87:	9c                   	pushf
80104a88:	5b                   	pop    %ebx
  asm volatile("cli");
80104a89:	fa                   	cli
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80104a8a:	e8 11 f1 ff ff       	call   80103ba0 <mycpu>
80104a8f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104a95:	85 c0                	test   %eax,%eax
80104a97:	74 17                	je     80104ab0 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80104a99:	e8 02 f1 ff ff       	call   80103ba0 <mycpu>
80104a9e:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104aa5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104aa8:	c9                   	leave
80104aa9:	c3                   	ret
80104aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
80104ab0:	e8 eb f0 ff ff       	call   80103ba0 <mycpu>
80104ab5:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104abb:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104ac1:	eb d6                	jmp    80104a99 <pushcli+0x19>
80104ac3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104ac8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104acf:	00 

80104ad0 <popcli>:

void
popcli(void)
{
80104ad0:	55                   	push   %ebp
80104ad1:	89 e5                	mov    %esp,%ebp
80104ad3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104ad6:	9c                   	pushf
80104ad7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104ad8:	f6 c4 02             	test   $0x2,%ah
80104adb:	75 35                	jne    80104b12 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80104add:	e8 be f0 ff ff       	call   80103ba0 <mycpu>
80104ae2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104ae9:	78 34                	js     80104b1f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104aeb:	e8 b0 f0 ff ff       	call   80103ba0 <mycpu>
80104af0:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104af6:	85 d2                	test   %edx,%edx
80104af8:	74 06                	je     80104b00 <popcli+0x30>
    sti();
}
80104afa:	c9                   	leave
80104afb:	c3                   	ret
80104afc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104b00:	e8 9b f0 ff ff       	call   80103ba0 <mycpu>
80104b05:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104b0b:	85 c0                	test   %eax,%eax
80104b0d:	74 eb                	je     80104afa <popcli+0x2a>
  asm volatile("sti");
80104b0f:	fb                   	sti
}
80104b10:	c9                   	leave
80104b11:	c3                   	ret
    panic("popcli - interruptible");
80104b12:	83 ec 0c             	sub    $0xc,%esp
80104b15:	68 5e 7c 10 80       	push   $0x80107c5e
80104b1a:	e8 81 b8 ff ff       	call   801003a0 <panic>
    panic("popcli");
80104b1f:	83 ec 0c             	sub    $0xc,%esp
80104b22:	68 75 7c 10 80       	push   $0x80107c75
80104b27:	e8 74 b8 ff ff       	call   801003a0 <panic>
80104b2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104b30 <holding>:
{
80104b30:	55                   	push   %ebp
80104b31:	89 e5                	mov    %esp,%ebp
80104b33:	53                   	push   %ebx
80104b34:	31 db                	xor    %ebx,%ebx
80104b36:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104b39:	e8 42 ff ff ff       	call   80104a80 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104b3e:	8b 45 08             	mov    0x8(%ebp),%eax
80104b41:	8b 10                	mov    (%eax),%edx
80104b43:	85 d2                	test   %edx,%edx
80104b45:	75 11                	jne    80104b58 <holding+0x28>
  popcli();
80104b47:	e8 84 ff ff ff       	call   80104ad0 <popcli>
}
80104b4c:	89 d8                	mov    %ebx,%eax
80104b4e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b51:	c9                   	leave
80104b52:	c3                   	ret
80104b53:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  r = lock->locked && lock->cpu == mycpu();
80104b58:	8b 58 08             	mov    0x8(%eax),%ebx
80104b5b:	e8 40 f0 ff ff       	call   80103ba0 <mycpu>
80104b60:	39 c3                	cmp    %eax,%ebx
80104b62:	0f 94 c3             	sete   %bl
  popcli();
80104b65:	e8 66 ff ff ff       	call   80104ad0 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80104b6a:	0f b6 db             	movzbl %bl,%ebx
}
80104b6d:	89 d8                	mov    %ebx,%eax
80104b6f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b72:	c9                   	leave
80104b73:	c3                   	ret
80104b74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b78:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b7f:	00 

80104b80 <release>:
{
80104b80:	55                   	push   %ebp
80104b81:	89 e5                	mov    %esp,%ebp
80104b83:	56                   	push   %esi
80104b84:	53                   	push   %ebx
80104b85:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80104b88:	e8 f3 fe ff ff       	call   80104a80 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104b8d:	8b 03                	mov    (%ebx),%eax
80104b8f:	85 c0                	test   %eax,%eax
80104b91:	75 15                	jne    80104ba8 <release+0x28>
  popcli();
80104b93:	e8 38 ff ff ff       	call   80104ad0 <popcli>
    panic("release");
80104b98:	83 ec 0c             	sub    $0xc,%esp
80104b9b:	68 7c 7c 10 80       	push   $0x80107c7c
80104ba0:	e8 fb b7 ff ff       	call   801003a0 <panic>
80104ba5:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80104ba8:	8b 73 08             	mov    0x8(%ebx),%esi
80104bab:	e8 f0 ef ff ff       	call   80103ba0 <mycpu>
80104bb0:	39 c6                	cmp    %eax,%esi
80104bb2:	75 df                	jne    80104b93 <release+0x13>
  popcli();
80104bb4:	e8 17 ff ff ff       	call   80104ad0 <popcli>
  lk->pcs[0] = 0;
80104bb9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104bc0:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104bc7:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104bcc:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104bd2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104bd5:	5b                   	pop    %ebx
80104bd6:	5e                   	pop    %esi
80104bd7:	5d                   	pop    %ebp
  popcli();
80104bd8:	e9 f3 fe ff ff       	jmp    80104ad0 <popcli>
80104bdd:	8d 76 00             	lea    0x0(%esi),%esi

80104be0 <acquire>:
{
80104be0:	55                   	push   %ebp
80104be1:	89 e5                	mov    %esp,%ebp
80104be3:	56                   	push   %esi
80104be4:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104be5:	e8 96 fe ff ff       	call   80104a80 <pushcli>
  if(holding(lk))
80104bea:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80104bed:	e8 8e fe ff ff       	call   80104a80 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104bf2:	8b 03                	mov    (%ebx),%eax
80104bf4:	85 c0                	test   %eax,%eax
80104bf6:	0f 85 c4 00 00 00    	jne    80104cc0 <acquire+0xe0>
  popcli();
80104bfc:	e8 cf fe ff ff       	call   80104ad0 <popcli>
  asm volatile("lock; xchgl %0, %1" :
80104c01:	b8 01 00 00 00       	mov    $0x1,%eax
80104c06:	f0 87 03             	lock xchg %eax,(%ebx)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80104c09:	8b 55 08             	mov    0x8(%ebp),%edx
  while(xchg(&lk->locked, 1) != 0)
80104c0c:	85 c0                	test   %eax,%eax
80104c0e:	74 0c                	je     80104c1c <acquire+0x3c>
  asm volatile("lock; xchgl %0, %1" :
80104c10:	b8 01 00 00 00       	mov    $0x1,%eax
80104c15:	f0 87 02             	lock xchg %eax,(%edx)
80104c18:	85 c0                	test   %eax,%eax
80104c1a:	75 f4                	jne    80104c10 <acquire+0x30>
  __sync_synchronize();
80104c1c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104c21:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104c24:	e8 77 ef ff ff       	call   80103ba0 <mycpu>
  ebp = (uint*)v - 2;
80104c29:	89 ea                	mov    %ebp,%edx
  lk->cpu = mycpu();
80104c2b:	89 43 08             	mov    %eax,0x8(%ebx)
  for(i = 0; i < 10; i++){
80104c2e:	31 c0                	xor    %eax,%eax
80104c30:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c37:	00 
80104c38:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c3f:	00 
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104c40:	8d 8a 00 00 00 80    	lea    -0x80000000(%edx),%ecx
80104c46:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80104c4c:	77 22                	ja     80104c70 <acquire+0x90>
    pcs[i] = ebp[1];     // saved %eip
80104c4e:	8b 4a 04             	mov    0x4(%edx),%ecx
80104c51:	89 4c 83 0c          	mov    %ecx,0xc(%ebx,%eax,4)
  for(i = 0; i < 10; i++){
80104c55:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80104c58:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
80104c5a:	83 f8 0a             	cmp    $0xa,%eax
80104c5d:	75 e1                	jne    80104c40 <acquire+0x60>
}
80104c5f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c62:	5b                   	pop    %ebx
80104c63:	5e                   	pop    %esi
80104c64:	5d                   	pop    %ebp
80104c65:	c3                   	ret
80104c66:	66 90                	xchg   %ax,%ax
80104c68:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c6f:	00 
  for(; i < 10; i++)
80104c70:	8d 44 83 0c          	lea    0xc(%ebx,%eax,4),%eax
80104c74:	83 c3 34             	add    $0x34,%ebx
80104c77:	89 da                	mov    %ebx,%edx
80104c79:	29 c2                	sub    %eax,%edx
80104c7b:	83 e2 04             	and    $0x4,%edx
80104c7e:	74 20                	je     80104ca0 <acquire+0xc0>
    pcs[i] = 0;
80104c80:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104c86:	83 c0 04             	add    $0x4,%eax
80104c89:	39 d8                	cmp    %ebx,%eax
80104c8b:	74 d2                	je     80104c5f <acquire+0x7f>
80104c8d:	8d 76 00             	lea    0x0(%esi),%esi
80104c90:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c97:	00 
80104c98:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c9f:	00 
    pcs[i] = 0;
80104ca0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104ca6:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
80104ca9:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
80104cb0:	39 d8                	cmp    %ebx,%eax
80104cb2:	75 ec                	jne    80104ca0 <acquire+0xc0>
80104cb4:	eb a9                	jmp    80104c5f <acquire+0x7f>
80104cb6:	66 90                	xchg   %ax,%ax
80104cb8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104cbf:	00 
  r = lock->locked && lock->cpu == mycpu();
80104cc0:	8b 73 08             	mov    0x8(%ebx),%esi
80104cc3:	e8 d8 ee ff ff       	call   80103ba0 <mycpu>
80104cc8:	39 c6                	cmp    %eax,%esi
80104cca:	0f 85 2c ff ff ff    	jne    80104bfc <acquire+0x1c>
  popcli();
80104cd0:	e8 fb fd ff ff       	call   80104ad0 <popcli>
    panic("acquire");
80104cd5:	83 ec 0c             	sub    $0xc,%esp
80104cd8:	68 84 7c 10 80       	push   $0x80107c84
80104cdd:	e8 be b6 ff ff       	call   801003a0 <panic>
80104ce2:	66 90                	xchg   %ax,%ax
80104ce4:	66 90                	xchg   %ax,%ax
80104ce6:	66 90                	xchg   %ax,%ax
80104ce8:	66 90                	xchg   %ax,%ax
80104cea:	66 90                	xchg   %ax,%ax
80104cec:	66 90                	xchg   %ax,%ax
80104cee:	66 90                	xchg   %ax,%ax
80104cf0:	66 90                	xchg   %ax,%ax
80104cf2:	66 90                	xchg   %ax,%ax
80104cf4:	66 90                	xchg   %ax,%ax
80104cf6:	66 90                	xchg   %ax,%ax
80104cf8:	66 90                	xchg   %ax,%ax
80104cfa:	66 90                	xchg   %ax,%ax
80104cfc:	66 90                	xchg   %ax,%ax
80104cfe:	66 90                	xchg   %ax,%ax

80104d00 <memset>:
80104d00:	55                   	push   %ebp
80104d01:	89 e5                	mov    %esp,%ebp
80104d03:	57                   	push   %edi
80104d04:	8b 55 08             	mov    0x8(%ebp),%edx
80104d07:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104d0a:	89 d0                	mov    %edx,%eax
80104d0c:	09 c8                	or     %ecx,%eax
80104d0e:	a8 03                	test   $0x3,%al
80104d10:	75 1e                	jne    80104d30 <memset+0x30>
80104d12:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
80104d16:	c1 e9 02             	shr    $0x2,%ecx
80104d19:	89 d7                	mov    %edx,%edi
80104d1b:	69 c0 01 01 01 01    	imul   $0x1010101,%eax,%eax
80104d21:	fc                   	cld
80104d22:	f3 ab                	rep stos %eax,%es:(%edi)
80104d24:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104d27:	89 d0                	mov    %edx,%eax
80104d29:	c9                   	leave
80104d2a:	c3                   	ret
80104d2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104d30:	8b 45 0c             	mov    0xc(%ebp),%eax
80104d33:	89 d7                	mov    %edx,%edi
80104d35:	fc                   	cld
80104d36:	f3 aa                	rep stos %al,%es:(%edi)
80104d38:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104d3b:	89 d0                	mov    %edx,%eax
80104d3d:	c9                   	leave
80104d3e:	c3                   	ret
80104d3f:	90                   	nop

80104d40 <memcmp>:
80104d40:	55                   	push   %ebp
80104d41:	89 e5                	mov    %esp,%ebp
80104d43:	56                   	push   %esi
80104d44:	8b 75 10             	mov    0x10(%ebp),%esi
80104d47:	8b 45 08             	mov    0x8(%ebp),%eax
80104d4a:	53                   	push   %ebx
80104d4b:	8b 55 0c             	mov    0xc(%ebp),%edx
80104d4e:	85 f6                	test   %esi,%esi
80104d50:	74 2e                	je     80104d80 <memcmp+0x40>
80104d52:	01 c6                	add    %eax,%esi
80104d54:	eb 14                	jmp    80104d6a <memcmp+0x2a>
80104d56:	66 90                	xchg   %ax,%ax
80104d58:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104d5f:	00 
80104d60:	83 c0 01             	add    $0x1,%eax
80104d63:	83 c2 01             	add    $0x1,%edx
80104d66:	39 f0                	cmp    %esi,%eax
80104d68:	74 16                	je     80104d80 <memcmp+0x40>
80104d6a:	0f b6 08             	movzbl (%eax),%ecx
80104d6d:	0f b6 1a             	movzbl (%edx),%ebx
80104d70:	38 d9                	cmp    %bl,%cl
80104d72:	74 ec                	je     80104d60 <memcmp+0x20>
80104d74:	0f b6 c1             	movzbl %cl,%eax
80104d77:	29 d8                	sub    %ebx,%eax
80104d79:	5b                   	pop    %ebx
80104d7a:	5e                   	pop    %esi
80104d7b:	5d                   	pop    %ebp
80104d7c:	c3                   	ret
80104d7d:	8d 76 00             	lea    0x0(%esi),%esi
80104d80:	5b                   	pop    %ebx
80104d81:	31 c0                	xor    %eax,%eax
80104d83:	5e                   	pop    %esi
80104d84:	5d                   	pop    %ebp
80104d85:	c3                   	ret
80104d86:	66 90                	xchg   %ax,%ax
80104d88:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104d8f:	00 

80104d90 <memmove>:
80104d90:	55                   	push   %ebp
80104d91:	89 e5                	mov    %esp,%ebp
80104d93:	57                   	push   %edi
80104d94:	8b 55 08             	mov    0x8(%ebp),%edx
80104d97:	8b 45 10             	mov    0x10(%ebp),%eax
80104d9a:	56                   	push   %esi
80104d9b:	8b 75 0c             	mov    0xc(%ebp),%esi
80104d9e:	39 d6                	cmp    %edx,%esi
80104da0:	73 26                	jae    80104dc8 <memmove+0x38>
80104da2:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
80104da5:	39 ca                	cmp    %ecx,%edx
80104da7:	73 1f                	jae    80104dc8 <memmove+0x38>
80104da9:	85 c0                	test   %eax,%eax
80104dab:	74 0f                	je     80104dbc <memmove+0x2c>
80104dad:	83 e8 01             	sub    $0x1,%eax
80104db0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104db4:	88 0c 02             	mov    %cl,(%edx,%eax,1)
80104db7:	83 e8 01             	sub    $0x1,%eax
80104dba:	73 f4                	jae    80104db0 <memmove+0x20>
80104dbc:	5e                   	pop    %esi
80104dbd:	89 d0                	mov    %edx,%eax
80104dbf:	5f                   	pop    %edi
80104dc0:	5d                   	pop    %ebp
80104dc1:	c3                   	ret
80104dc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104dc8:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
80104dcb:	89 d7                	mov    %edx,%edi
80104dcd:	85 c0                	test   %eax,%eax
80104dcf:	74 eb                	je     80104dbc <memmove+0x2c>
80104dd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104dd8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104ddf:	00 
80104de0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
80104de1:	39 f1                	cmp    %esi,%ecx
80104de3:	75 fb                	jne    80104de0 <memmove+0x50>
80104de5:	5e                   	pop    %esi
80104de6:	89 d0                	mov    %edx,%eax
80104de8:	5f                   	pop    %edi
80104de9:	5d                   	pop    %ebp
80104dea:	c3                   	ret
80104deb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104df0 <memcpy>:
80104df0:	eb 9e                	jmp    80104d90 <memmove>
80104df2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104df8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104dff:	00 

80104e00 <strncmp>:
80104e00:	55                   	push   %ebp
80104e01:	89 e5                	mov    %esp,%ebp
80104e03:	53                   	push   %ebx
80104e04:	8b 55 10             	mov    0x10(%ebp),%edx
80104e07:	8b 45 08             	mov    0x8(%ebp),%eax
80104e0a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104e0d:	85 d2                	test   %edx,%edx
80104e0f:	75 16                	jne    80104e27 <strncmp+0x27>
80104e11:	eb 2d                	jmp    80104e40 <strncmp+0x40>
80104e13:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104e18:	3a 19                	cmp    (%ecx),%bl
80104e1a:	75 12                	jne    80104e2e <strncmp+0x2e>
80104e1c:	83 c0 01             	add    $0x1,%eax
80104e1f:	83 c1 01             	add    $0x1,%ecx
80104e22:	83 ea 01             	sub    $0x1,%edx
80104e25:	74 19                	je     80104e40 <strncmp+0x40>
80104e27:	0f b6 18             	movzbl (%eax),%ebx
80104e2a:	84 db                	test   %bl,%bl
80104e2c:	75 ea                	jne    80104e18 <strncmp+0x18>
80104e2e:	0f b6 00             	movzbl (%eax),%eax
80104e31:	0f b6 11             	movzbl (%ecx),%edx
80104e34:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e37:	c9                   	leave
80104e38:	29 d0                	sub    %edx,%eax
80104e3a:	c3                   	ret
80104e3b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104e40:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e43:	31 c0                	xor    %eax,%eax
80104e45:	c9                   	leave
80104e46:	c3                   	ret
80104e47:	90                   	nop
80104e48:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104e4f:	00 

80104e50 <strncpy>:
80104e50:	55                   	push   %ebp
80104e51:	89 e5                	mov    %esp,%ebp
80104e53:	53                   	push   %ebx
80104e54:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104e57:	8b 55 10             	mov    0x10(%ebp),%edx
80104e5a:	8b 45 08             	mov    0x8(%ebp),%eax
80104e5d:	eb 14                	jmp    80104e73 <strncpy+0x23>
80104e5f:	90                   	nop
80104e60:	0f b6 19             	movzbl (%ecx),%ebx
80104e63:	83 c1 01             	add    $0x1,%ecx
80104e66:	83 c0 01             	add    $0x1,%eax
80104e69:	88 58 ff             	mov    %bl,-0x1(%eax)
80104e6c:	84 db                	test   %bl,%bl
80104e6e:	74 10                	je     80104e80 <strncpy+0x30>
80104e70:	83 ea 01             	sub    $0x1,%edx
80104e73:	85 d2                	test   %edx,%edx
80104e75:	7f e9                	jg     80104e60 <strncpy+0x10>
80104e77:	8b 45 08             	mov    0x8(%ebp),%eax
80104e7a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e7d:	c9                   	leave
80104e7e:	c3                   	ret
80104e7f:	90                   	nop
80104e80:	8d 4c 10 ff          	lea    -0x1(%eax,%edx,1),%ecx
80104e84:	83 ea 01             	sub    $0x1,%edx
80104e87:	74 ee                	je     80104e77 <strncpy+0x27>
80104e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e90:	83 c0 01             	add    $0x1,%eax
80104e93:	89 ca                	mov    %ecx,%edx
80104e95:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
80104e99:	29 c2                	sub    %eax,%edx
80104e9b:	85 d2                	test   %edx,%edx
80104e9d:	7f f1                	jg     80104e90 <strncpy+0x40>
80104e9f:	8b 45 08             	mov    0x8(%ebp),%eax
80104ea2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ea5:	c9                   	leave
80104ea6:	c3                   	ret
80104ea7:	90                   	nop
80104ea8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104eaf:	00 

80104eb0 <safestrcpy>:
80104eb0:	55                   	push   %ebp
80104eb1:	89 e5                	mov    %esp,%ebp
80104eb3:	53                   	push   %ebx
80104eb4:	8b 55 10             	mov    0x10(%ebp),%edx
80104eb7:	8b 45 0c             	mov    0xc(%ebp),%eax
80104eba:	85 d2                	test   %edx,%edx
80104ebc:	7e 39                	jle    80104ef7 <safestrcpy+0x47>
80104ebe:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104ec2:	8b 55 08             	mov    0x8(%ebp),%edx
80104ec5:	eb 29                	jmp    80104ef0 <safestrcpy+0x40>
80104ec7:	eb 17                	jmp    80104ee0 <safestrcpy+0x30>
80104ec9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ed0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104ed7:	00 
80104ed8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104edf:	00 
80104ee0:	0f b6 08             	movzbl (%eax),%ecx
80104ee3:	83 c0 01             	add    $0x1,%eax
80104ee6:	83 c2 01             	add    $0x1,%edx
80104ee9:	88 4a ff             	mov    %cl,-0x1(%edx)
80104eec:	84 c9                	test   %cl,%cl
80104eee:	74 04                	je     80104ef4 <safestrcpy+0x44>
80104ef0:	39 d8                	cmp    %ebx,%eax
80104ef2:	75 ec                	jne    80104ee0 <safestrcpy+0x30>
80104ef4:	c6 02 00             	movb   $0x0,(%edx)
80104ef7:	8b 45 08             	mov    0x8(%ebp),%eax
80104efa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104efd:	c9                   	leave
80104efe:	c3                   	ret
80104eff:	90                   	nop

80104f00 <strlen>:
80104f00:	55                   	push   %ebp
80104f01:	31 c0                	xor    %eax,%eax
80104f03:	89 e5                	mov    %esp,%ebp
80104f05:	8b 55 08             	mov    0x8(%ebp),%edx
80104f08:	80 3a 00             	cmpb   $0x0,(%edx)
80104f0b:	74 0c                	je     80104f19 <strlen+0x19>
80104f0d:	8d 76 00             	lea    0x0(%esi),%esi
80104f10:	83 c0 01             	add    $0x1,%eax
80104f13:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104f17:	75 f7                	jne    80104f10 <strlen+0x10>
80104f19:	5d                   	pop    %ebp
80104f1a:	c3                   	ret

80104f1b <swtch>:
80104f1b:	8b 44 24 04          	mov    0x4(%esp),%eax
80104f1f:	8b 54 24 08          	mov    0x8(%esp),%edx
80104f23:	55                   	push   %ebp
80104f24:	53                   	push   %ebx
80104f25:	56                   	push   %esi
80104f26:	57                   	push   %edi
80104f27:	89 20                	mov    %esp,(%eax)
80104f29:	89 d4                	mov    %edx,%esp
80104f2b:	5f                   	pop    %edi
80104f2c:	5e                   	pop    %esi
80104f2d:	5b                   	pop    %ebx
80104f2e:	5d                   	pop    %ebp
80104f2f:	c3                   	ret

80104f30 <fetchint>:
// library system call function. The saved user %esp points
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int fetchint(uint addr, int *ip)
{
80104f30:	55                   	push   %ebp
80104f31:	89 e5                	mov    %esp,%ebp
80104f33:	53                   	push   %ebx
80104f34:	83 ec 04             	sub    $0x4,%esp
80104f37:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104f3a:	e8 01 ed ff ff       	call   80103c40 <myproc>

  if (addr >= curproc->sz || addr + 4 > curproc->sz)
80104f3f:	8b 00                	mov    (%eax),%eax
80104f41:	39 c3                	cmp    %eax,%ebx
80104f43:	73 1b                	jae    80104f60 <fetchint+0x30>
80104f45:	8d 53 04             	lea    0x4(%ebx),%edx
80104f48:	39 d0                	cmp    %edx,%eax
80104f4a:	72 14                	jb     80104f60 <fetchint+0x30>
    return -1;
  *ip = *(int *)(addr);
80104f4c:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f4f:	8b 13                	mov    (%ebx),%edx
80104f51:	89 10                	mov    %edx,(%eax)
  return 0;
80104f53:	31 c0                	xor    %eax,%eax
}
80104f55:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104f58:	c9                   	leave
80104f59:	c3                   	ret
80104f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80104f60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f65:	eb ee                	jmp    80104f55 <fetchint+0x25>
80104f67:	90                   	nop
80104f68:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104f6f:	00 

80104f70 <fetchstr>:

// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int fetchstr(uint addr, char **pp)
{
80104f70:	55                   	push   %ebp
80104f71:	89 e5                	mov    %esp,%ebp
80104f73:	53                   	push   %ebx
80104f74:	83 ec 04             	sub    $0x4,%esp
80104f77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104f7a:	e8 c1 ec ff ff       	call   80103c40 <myproc>

  if (addr >= curproc->sz)
80104f7f:	3b 18                	cmp    (%eax),%ebx
80104f81:	73 35                	jae    80104fb8 <fetchstr+0x48>
    return -1;
  *pp = (char *)addr;
80104f83:	8b 55 0c             	mov    0xc(%ebp),%edx
80104f86:	89 1a                	mov    %ebx,(%edx)
  ep = (char *)curproc->sz;
80104f88:	8b 10                	mov    (%eax),%edx
  for (s = *pp; s < ep; s++)
80104f8a:	39 d3                	cmp    %edx,%ebx
80104f8c:	73 2a                	jae    80104fb8 <fetchstr+0x48>
80104f8e:	89 d8                	mov    %ebx,%eax
80104f90:	eb 15                	jmp    80104fa7 <fetchstr+0x37>
80104f92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104f98:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104f9f:	00 
80104fa0:	83 c0 01             	add    $0x1,%eax
80104fa3:	39 d0                	cmp    %edx,%eax
80104fa5:	73 11                	jae    80104fb8 <fetchstr+0x48>
  {
    if (*s == 0)
80104fa7:	80 38 00             	cmpb   $0x0,(%eax)
80104faa:	75 f4                	jne    80104fa0 <fetchstr+0x30>
      return s - *pp;
80104fac:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80104fae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104fb1:	c9                   	leave
80104fb2:	c3                   	ret
80104fb3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104fb8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80104fbb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104fc0:	c9                   	leave
80104fc1:	c3                   	ret
80104fc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104fc8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104fcf:	00 

80104fd0 <argint>:

// Fetch the nth 32-bit system call argument.
int argint(int n, int *ip)
{
80104fd0:	55                   	push   %ebp
80104fd1:	89 e5                	mov    %esp,%ebp
80104fd3:	56                   	push   %esi
80104fd4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4 * n, ip);
80104fd5:	e8 66 ec ff ff       	call   80103c40 <myproc>
80104fda:	8b 55 08             	mov    0x8(%ebp),%edx
80104fdd:	8b 40 18             	mov    0x18(%eax),%eax
80104fe0:	8b 40 44             	mov    0x44(%eax),%eax
80104fe3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104fe6:	e8 55 ec ff ff       	call   80103c40 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4 * n, ip);
80104feb:	8d 73 04             	lea    0x4(%ebx),%esi
  if (addr >= curproc->sz || addr + 4 > curproc->sz)
80104fee:	8b 00                	mov    (%eax),%eax
80104ff0:	39 c6                	cmp    %eax,%esi
80104ff2:	73 1c                	jae    80105010 <argint+0x40>
80104ff4:	8d 53 08             	lea    0x8(%ebx),%edx
80104ff7:	39 d0                	cmp    %edx,%eax
80104ff9:	72 15                	jb     80105010 <argint+0x40>
  *ip = *(int *)(addr);
80104ffb:	8b 45 0c             	mov    0xc(%ebp),%eax
80104ffe:	8b 53 04             	mov    0x4(%ebx),%edx
80105001:	89 10                	mov    %edx,(%eax)
  return 0;
80105003:	31 c0                	xor    %eax,%eax
}
80105005:	5b                   	pop    %ebx
80105006:	5e                   	pop    %esi
80105007:	5d                   	pop    %ebp
80105008:	c3                   	ret
80105009:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105010:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4 * n, ip);
80105015:	eb ee                	jmp    80105005 <argint+0x35>
80105017:	90                   	nop
80105018:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010501f:	00 

80105020 <argptr>:

// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int argptr(int n, char **pp, int size)
{
80105020:	55                   	push   %ebp
80105021:	89 e5                	mov    %esp,%ebp
80105023:	57                   	push   %edi
80105024:	56                   	push   %esi
80105025:	53                   	push   %ebx
80105026:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
80105029:	e8 12 ec ff ff       	call   80103c40 <myproc>
8010502e:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4 * n, ip);
80105030:	e8 0b ec ff ff       	call   80103c40 <myproc>
80105035:	8b 55 08             	mov    0x8(%ebp),%edx
80105038:	8b 40 18             	mov    0x18(%eax),%eax
8010503b:	8b 40 44             	mov    0x44(%eax),%eax
8010503e:	8d 3c 90             	lea    (%eax,%edx,4),%edi
  struct proc *curproc = myproc();
80105041:	e8 fa eb ff ff       	call   80103c40 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4 * n, ip);
80105046:	8d 5f 04             	lea    0x4(%edi),%ebx
  if (addr >= curproc->sz || addr + 4 > curproc->sz)
80105049:	8b 00                	mov    (%eax),%eax
8010504b:	39 c3                	cmp    %eax,%ebx
8010504d:	73 31                	jae    80105080 <argptr+0x60>
8010504f:	8d 57 08             	lea    0x8(%edi),%edx
80105052:	39 d0                	cmp    %edx,%eax
80105054:	72 2a                	jb     80105080 <argptr+0x60>

  if (argint(n, &i) < 0)
    return -1;
  if (size < 0 || (uint)i >= curproc->sz || (uint)i + size > curproc->sz)
80105056:	8b 45 10             	mov    0x10(%ebp),%eax
80105059:	85 c0                	test   %eax,%eax
8010505b:	78 23                	js     80105080 <argptr+0x60>
  *ip = *(int *)(addr);
8010505d:	8b 57 04             	mov    0x4(%edi),%edx
  if (size < 0 || (uint)i >= curproc->sz || (uint)i + size > curproc->sz)
80105060:	8b 0e                	mov    (%esi),%ecx
80105062:	39 ca                	cmp    %ecx,%edx
80105064:	73 1a                	jae    80105080 <argptr+0x60>
80105066:	8b 45 10             	mov    0x10(%ebp),%eax
80105069:	01 d0                	add    %edx,%eax
8010506b:	39 c1                	cmp    %eax,%ecx
8010506d:	72 11                	jb     80105080 <argptr+0x60>
    return -1;
  *pp = (char *)i;
8010506f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105072:	89 10                	mov    %edx,(%eax)
  return 0;
80105074:	31 c0                	xor    %eax,%eax
}
80105076:	83 c4 0c             	add    $0xc,%esp
80105079:	5b                   	pop    %ebx
8010507a:	5e                   	pop    %esi
8010507b:	5f                   	pop    %edi
8010507c:	5d                   	pop    %ebp
8010507d:	c3                   	ret
8010507e:	66 90                	xchg   %ax,%ax
    return -1;
80105080:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105085:	eb ef                	jmp    80105076 <argptr+0x56>
80105087:	90                   	nop
80105088:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010508f:	00 

80105090 <argstr>:
// Fetch the nth word-sized system call argument as a string pointer.
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int argstr(int n, char **pp)
{
80105090:	55                   	push   %ebp
80105091:	89 e5                	mov    %esp,%ebp
80105093:	56                   	push   %esi
80105094:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4 * n, ip);
80105095:	e8 a6 eb ff ff       	call   80103c40 <myproc>
8010509a:	8b 55 08             	mov    0x8(%ebp),%edx
8010509d:	8b 40 18             	mov    0x18(%eax),%eax
801050a0:	8b 40 44             	mov    0x44(%eax),%eax
801050a3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801050a6:	e8 95 eb ff ff       	call   80103c40 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4 * n, ip);
801050ab:	8d 73 04             	lea    0x4(%ebx),%esi
  if (addr >= curproc->sz || addr + 4 > curproc->sz)
801050ae:	8b 00                	mov    (%eax),%eax
801050b0:	39 c6                	cmp    %eax,%esi
801050b2:	73 44                	jae    801050f8 <argstr+0x68>
801050b4:	8d 53 08             	lea    0x8(%ebx),%edx
801050b7:	39 d0                	cmp    %edx,%eax
801050b9:	72 3d                	jb     801050f8 <argstr+0x68>
  *ip = *(int *)(addr);
801050bb:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
801050be:	e8 7d eb ff ff       	call   80103c40 <myproc>
  if (addr >= curproc->sz)
801050c3:	3b 18                	cmp    (%eax),%ebx
801050c5:	73 31                	jae    801050f8 <argstr+0x68>
  *pp = (char *)addr;
801050c7:	8b 55 0c             	mov    0xc(%ebp),%edx
801050ca:	89 1a                	mov    %ebx,(%edx)
  ep = (char *)curproc->sz;
801050cc:	8b 10                	mov    (%eax),%edx
  for (s = *pp; s < ep; s++)
801050ce:	39 d3                	cmp    %edx,%ebx
801050d0:	73 26                	jae    801050f8 <argstr+0x68>
801050d2:	89 d8                	mov    %ebx,%eax
801050d4:	eb 11                	jmp    801050e7 <argstr+0x57>
801050d6:	66 90                	xchg   %ax,%ax
801050d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801050df:	00 
801050e0:	83 c0 01             	add    $0x1,%eax
801050e3:	39 d0                	cmp    %edx,%eax
801050e5:	73 11                	jae    801050f8 <argstr+0x68>
    if (*s == 0)
801050e7:	80 38 00             	cmpb   $0x0,(%eax)
801050ea:	75 f4                	jne    801050e0 <argstr+0x50>
      return s - *pp;
801050ec:	29 d8                	sub    %ebx,%eax
  int addr;
  if (argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
801050ee:	5b                   	pop    %ebx
801050ef:	5e                   	pop    %esi
801050f0:	5d                   	pop    %ebp
801050f1:	c3                   	ret
801050f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801050f8:	5b                   	pop    %ebx
    return -1;
801050f9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801050fe:	5e                   	pop    %esi
801050ff:	5d                   	pop    %ebp
80105100:	c3                   	ret
80105101:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105108:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010510f:	00 

80105110 <syscall>:
    [SYS_getprocinfo] sys_getprocinfo,
    [SYS_nice] sys_nice, // f2
};

void syscall(void)
{
80105110:	55                   	push   %ebp
80105111:	89 e5                	mov    %esp,%ebp
80105113:	53                   	push   %ebx
80105114:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80105117:	e8 24 eb ff ff       	call   80103c40 <myproc>
8010511c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
8010511e:	8b 40 18             	mov    0x18(%eax),%eax
80105121:	8b 40 1c             	mov    0x1c(%eax),%eax
  if (num > 0 && num < NELEM(syscalls) && syscalls[num])
80105124:	8d 50 ff             	lea    -0x1(%eax),%edx
80105127:	83 fa 16             	cmp    $0x16,%edx
8010512a:	77 24                	ja     80105150 <syscall+0x40>
8010512c:	8b 14 85 00 82 10 80 	mov    -0x7fef7e00(,%eax,4),%edx
80105133:	85 d2                	test   %edx,%edx
80105135:	74 19                	je     80105150 <syscall+0x40>
  {
    curproc->tf->eax = syscalls[num]();
80105137:	ff d2                	call   *%edx
80105139:	89 c2                	mov    %eax,%edx
8010513b:	8b 43 18             	mov    0x18(%ebx),%eax
8010513e:	89 50 1c             	mov    %edx,0x1c(%eax)
  {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80105141:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105144:	c9                   	leave
80105145:	c3                   	ret
80105146:	66 90                	xchg   %ax,%ax
80105148:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010514f:	00 
    cprintf("%d %s: unknown sys call %d\n",
80105150:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80105151:	8d 43 70             	lea    0x70(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80105154:	50                   	push   %eax
80105155:	ff 73 10             	push   0x10(%ebx)
80105158:	68 8c 7c 10 80       	push   $0x80107c8c
8010515d:	e8 6e b5 ff ff       	call   801006d0 <cprintf>
    curproc->tf->eax = -1;
80105162:	8b 43 18             	mov    0x18(%ebx),%eax
80105165:	83 c4 10             	add    $0x10,%esp
80105168:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
8010516f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105172:	c9                   	leave
80105173:	c3                   	ret
80105174:	66 90                	xchg   %ax,%ax
80105176:	66 90                	xchg   %ax,%ax
80105178:	66 90                	xchg   %ax,%ax
8010517a:	66 90                	xchg   %ax,%ax
8010517c:	66 90                	xchg   %ax,%ax
8010517e:	66 90                	xchg   %ax,%ax

80105180 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105180:	55                   	push   %ebp
80105181:	89 e5                	mov    %esp,%ebp
80105183:	57                   	push   %edi
80105184:	56                   	push   %esi
80105185:	53                   	push   %ebx
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105186:	8d 5d da             	lea    -0x26(%ebp),%ebx
{
80105189:	83 ec 34             	sub    $0x34,%esp
8010518c:	89 4d cc             	mov    %ecx,-0x34(%ebp)
8010518f:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105192:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80105195:	89 4d d0             	mov    %ecx,-0x30(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80105198:	53                   	push   %ebx
80105199:	50                   	push   %eax
8010519a:	e8 01 d1 ff ff       	call   801022a0 <nameiparent>
8010519f:	83 c4 10             	add    $0x10,%esp
801051a2:	85 c0                	test   %eax,%eax
801051a4:	74 5e                	je     80105204 <create+0x84>
    return 0;
  ilock(dp);
801051a6:	83 ec 0c             	sub    $0xc,%esp
801051a9:	89 c6                	mov    %eax,%esi
801051ab:	50                   	push   %eax
801051ac:	e8 8f c7 ff ff       	call   80101940 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
801051b1:	83 c4 0c             	add    $0xc,%esp
801051b4:	6a 00                	push   $0x0
801051b6:	53                   	push   %ebx
801051b7:	56                   	push   %esi
801051b8:	e8 03 cd ff ff       	call   80101ec0 <dirlookup>
801051bd:	83 c4 10             	add    $0x10,%esp
801051c0:	89 c7                	mov    %eax,%edi
801051c2:	85 c0                	test   %eax,%eax
801051c4:	74 4a                	je     80105210 <create+0x90>
    iunlockput(dp);
801051c6:	83 ec 0c             	sub    $0xc,%esp
801051c9:	56                   	push   %esi
801051ca:	e8 31 ca ff ff       	call   80101c00 <iunlockput>
    ilock(ip);
801051cf:	89 3c 24             	mov    %edi,(%esp)
801051d2:	e8 69 c7 ff ff       	call   80101940 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801051d7:	83 c4 10             	add    $0x10,%esp
801051da:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
801051df:	75 17                	jne    801051f8 <create+0x78>
801051e1:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
801051e6:	75 10                	jne    801051f8 <create+0x78>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801051e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801051eb:	89 f8                	mov    %edi,%eax
801051ed:	5b                   	pop    %ebx
801051ee:	5e                   	pop    %esi
801051ef:	5f                   	pop    %edi
801051f0:	5d                   	pop    %ebp
801051f1:	c3                   	ret
801051f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(ip);
801051f8:	83 ec 0c             	sub    $0xc,%esp
801051fb:	57                   	push   %edi
801051fc:	e8 ff c9 ff ff       	call   80101c00 <iunlockput>
    return 0;
80105201:	83 c4 10             	add    $0x10,%esp
}
80105204:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80105207:	31 ff                	xor    %edi,%edi
}
80105209:	5b                   	pop    %ebx
8010520a:	89 f8                	mov    %edi,%eax
8010520c:	5e                   	pop    %esi
8010520d:	5f                   	pop    %edi
8010520e:	5d                   	pop    %ebp
8010520f:	c3                   	ret
  if((ip = ialloc(dp->dev, type)) == 0)
80105210:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80105214:	83 ec 08             	sub    $0x8,%esp
80105217:	50                   	push   %eax
80105218:	ff 36                	push   (%esi)
8010521a:	e8 71 c5 ff ff       	call   80101790 <ialloc>
8010521f:	83 c4 10             	add    $0x10,%esp
80105222:	89 c7                	mov    %eax,%edi
80105224:	85 c0                	test   %eax,%eax
80105226:	0f 84 af 00 00 00    	je     801052db <create+0x15b>
  ilock(ip);
8010522c:	83 ec 0c             	sub    $0xc,%esp
8010522f:	50                   	push   %eax
80105230:	e8 0b c7 ff ff       	call   80101940 <ilock>
  ip->major = major;
80105235:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80105239:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
8010523d:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80105241:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80105245:	b8 01 00 00 00       	mov    $0x1,%eax
8010524a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
8010524e:	89 3c 24             	mov    %edi,(%esp)
80105251:	e8 1a c6 ff ff       	call   80101870 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105256:	83 c4 10             	add    $0x10,%esp
80105259:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
8010525e:	74 30                	je     80105290 <create+0x110>
  if(dirlink(dp, name, ip->inum) < 0)
80105260:	83 ec 04             	sub    $0x4,%esp
80105263:	ff 77 04             	push   0x4(%edi)
80105266:	53                   	push   %ebx
80105267:	56                   	push   %esi
80105268:	e8 53 cf ff ff       	call   801021c0 <dirlink>
8010526d:	83 c4 10             	add    $0x10,%esp
80105270:	85 c0                	test   %eax,%eax
80105272:	78 74                	js     801052e8 <create+0x168>
  iunlockput(dp);
80105274:	83 ec 0c             	sub    $0xc,%esp
80105277:	56                   	push   %esi
80105278:	e8 83 c9 ff ff       	call   80101c00 <iunlockput>
  return ip;
8010527d:	83 c4 10             	add    $0x10,%esp
}
80105280:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105283:	89 f8                	mov    %edi,%eax
80105285:	5b                   	pop    %ebx
80105286:	5e                   	pop    %esi
80105287:	5f                   	pop    %edi
80105288:	5d                   	pop    %ebp
80105289:	c3                   	ret
8010528a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80105290:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80105293:	66 83 46 56 01       	addw   $0x1,0x56(%esi)
    iupdate(dp);
80105298:	56                   	push   %esi
80105299:	e8 d2 c5 ff ff       	call   80101870 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010529e:	83 c4 0c             	add    $0xc,%esp
801052a1:	ff 77 04             	push   0x4(%edi)
801052a4:	68 c4 7c 10 80       	push   $0x80107cc4
801052a9:	57                   	push   %edi
801052aa:	e8 11 cf ff ff       	call   801021c0 <dirlink>
801052af:	83 c4 10             	add    $0x10,%esp
801052b2:	85 c0                	test   %eax,%eax
801052b4:	78 18                	js     801052ce <create+0x14e>
801052b6:	83 ec 04             	sub    $0x4,%esp
801052b9:	ff 76 04             	push   0x4(%esi)
801052bc:	68 c3 7c 10 80       	push   $0x80107cc3
801052c1:	57                   	push   %edi
801052c2:	e8 f9 ce ff ff       	call   801021c0 <dirlink>
801052c7:	83 c4 10             	add    $0x10,%esp
801052ca:	85 c0                	test   %eax,%eax
801052cc:	79 92                	jns    80105260 <create+0xe0>
      panic("create dots");
801052ce:	83 ec 0c             	sub    $0xc,%esp
801052d1:	68 b7 7c 10 80       	push   $0x80107cb7
801052d6:	e8 c5 b0 ff ff       	call   801003a0 <panic>
    panic("create: ialloc");
801052db:	83 ec 0c             	sub    $0xc,%esp
801052de:	68 a8 7c 10 80       	push   $0x80107ca8
801052e3:	e8 b8 b0 ff ff       	call   801003a0 <panic>
    panic("create: dirlink");
801052e8:	83 ec 0c             	sub    $0xc,%esp
801052eb:	68 c6 7c 10 80       	push   $0x80107cc6
801052f0:	e8 ab b0 ff ff       	call   801003a0 <panic>
801052f5:	8d 76 00             	lea    0x0(%esi),%esi
801052f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801052ff:	00 

80105300 <sys_dup>:
{
80105300:	55                   	push   %ebp
80105301:	89 e5                	mov    %esp,%ebp
80105303:	56                   	push   %esi
80105304:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105305:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105308:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010530b:	50                   	push   %eax
8010530c:	6a 00                	push   $0x0
8010530e:	e8 bd fc ff ff       	call   80104fd0 <argint>
80105313:	83 c4 10             	add    $0x10,%esp
80105316:	85 c0                	test   %eax,%eax
80105318:	78 36                	js     80105350 <sys_dup+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010531a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010531e:	77 30                	ja     80105350 <sys_dup+0x50>
80105320:	e8 1b e9 ff ff       	call   80103c40 <myproc>
80105325:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105328:	8b 74 90 2c          	mov    0x2c(%eax,%edx,4),%esi
8010532c:	85 f6                	test   %esi,%esi
8010532e:	74 20                	je     80105350 <sys_dup+0x50>
  struct proc *curproc = myproc();
80105330:	e8 0b e9 ff ff       	call   80103c40 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105335:	31 db                	xor    %ebx,%ebx
80105337:	90                   	nop
80105338:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010533f:	00 
    if(curproc->ofile[fd] == 0){
80105340:	8b 54 98 2c          	mov    0x2c(%eax,%ebx,4),%edx
80105344:	85 d2                	test   %edx,%edx
80105346:	74 18                	je     80105360 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
80105348:	83 c3 01             	add    $0x1,%ebx
8010534b:	83 fb 10             	cmp    $0x10,%ebx
8010534e:	75 f0                	jne    80105340 <sys_dup+0x40>
    return -1;
80105350:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105355:	eb 19                	jmp    80105370 <sys_dup+0x70>
80105357:	90                   	nop
80105358:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010535f:	00 
  filedup(f);
80105360:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105363:	89 74 98 2c          	mov    %esi,0x2c(%eax,%ebx,4)
  filedup(f);
80105367:	56                   	push   %esi
80105368:	e8 c3 bb ff ff       	call   80100f30 <filedup>
  return fd;
8010536d:	83 c4 10             	add    $0x10,%esp
}
80105370:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105373:	89 d8                	mov    %ebx,%eax
80105375:	5b                   	pop    %ebx
80105376:	5e                   	pop    %esi
80105377:	5d                   	pop    %ebp
80105378:	c3                   	ret
80105379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105380 <sys_read>:
{
80105380:	55                   	push   %ebp
80105381:	89 e5                	mov    %esp,%ebp
80105383:	56                   	push   %esi
80105384:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105385:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105388:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010538b:	53                   	push   %ebx
8010538c:	6a 00                	push   $0x0
8010538e:	e8 3d fc ff ff       	call   80104fd0 <argint>
80105393:	83 c4 10             	add    $0x10,%esp
80105396:	85 c0                	test   %eax,%eax
80105398:	78 5e                	js     801053f8 <sys_read+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010539a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010539e:	77 58                	ja     801053f8 <sys_read+0x78>
801053a0:	e8 9b e8 ff ff       	call   80103c40 <myproc>
801053a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801053a8:	8b 74 90 2c          	mov    0x2c(%eax,%edx,4),%esi
801053ac:	85 f6                	test   %esi,%esi
801053ae:	74 48                	je     801053f8 <sys_read+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801053b0:	83 ec 08             	sub    $0x8,%esp
801053b3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801053b6:	50                   	push   %eax
801053b7:	6a 02                	push   $0x2
801053b9:	e8 12 fc ff ff       	call   80104fd0 <argint>
801053be:	83 c4 10             	add    $0x10,%esp
801053c1:	85 c0                	test   %eax,%eax
801053c3:	78 33                	js     801053f8 <sys_read+0x78>
801053c5:	83 ec 04             	sub    $0x4,%esp
801053c8:	ff 75 f0             	push   -0x10(%ebp)
801053cb:	53                   	push   %ebx
801053cc:	6a 01                	push   $0x1
801053ce:	e8 4d fc ff ff       	call   80105020 <argptr>
801053d3:	83 c4 10             	add    $0x10,%esp
801053d6:	85 c0                	test   %eax,%eax
801053d8:	78 1e                	js     801053f8 <sys_read+0x78>
  return fileread(f, p, n);
801053da:	83 ec 04             	sub    $0x4,%esp
801053dd:	ff 75 f0             	push   -0x10(%ebp)
801053e0:	ff 75 f4             	push   -0xc(%ebp)
801053e3:	56                   	push   %esi
801053e4:	e8 c7 bc ff ff       	call   801010b0 <fileread>
801053e9:	83 c4 10             	add    $0x10,%esp
}
801053ec:	8d 65 f8             	lea    -0x8(%ebp),%esp
801053ef:	5b                   	pop    %ebx
801053f0:	5e                   	pop    %esi
801053f1:	5d                   	pop    %ebp
801053f2:	c3                   	ret
801053f3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
801053f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053fd:	eb ed                	jmp    801053ec <sys_read+0x6c>
801053ff:	90                   	nop

80105400 <sys_write>:
{
80105400:	55                   	push   %ebp
80105401:	89 e5                	mov    %esp,%ebp
80105403:	56                   	push   %esi
80105404:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105405:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105408:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010540b:	53                   	push   %ebx
8010540c:	6a 00                	push   $0x0
8010540e:	e8 bd fb ff ff       	call   80104fd0 <argint>
80105413:	83 c4 10             	add    $0x10,%esp
80105416:	85 c0                	test   %eax,%eax
80105418:	78 5e                	js     80105478 <sys_write+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010541a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010541e:	77 58                	ja     80105478 <sys_write+0x78>
80105420:	e8 1b e8 ff ff       	call   80103c40 <myproc>
80105425:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105428:	8b 74 90 2c          	mov    0x2c(%eax,%edx,4),%esi
8010542c:	85 f6                	test   %esi,%esi
8010542e:	74 48                	je     80105478 <sys_write+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105430:	83 ec 08             	sub    $0x8,%esp
80105433:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105436:	50                   	push   %eax
80105437:	6a 02                	push   $0x2
80105439:	e8 92 fb ff ff       	call   80104fd0 <argint>
8010543e:	83 c4 10             	add    $0x10,%esp
80105441:	85 c0                	test   %eax,%eax
80105443:	78 33                	js     80105478 <sys_write+0x78>
80105445:	83 ec 04             	sub    $0x4,%esp
80105448:	ff 75 f0             	push   -0x10(%ebp)
8010544b:	53                   	push   %ebx
8010544c:	6a 01                	push   $0x1
8010544e:	e8 cd fb ff ff       	call   80105020 <argptr>
80105453:	83 c4 10             	add    $0x10,%esp
80105456:	85 c0                	test   %eax,%eax
80105458:	78 1e                	js     80105478 <sys_write+0x78>
  return filewrite(f, p, n);
8010545a:	83 ec 04             	sub    $0x4,%esp
8010545d:	ff 75 f0             	push   -0x10(%ebp)
80105460:	ff 75 f4             	push   -0xc(%ebp)
80105463:	56                   	push   %esi
80105464:	e8 d7 bc ff ff       	call   80101140 <filewrite>
80105469:	83 c4 10             	add    $0x10,%esp
}
8010546c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010546f:	5b                   	pop    %ebx
80105470:	5e                   	pop    %esi
80105471:	5d                   	pop    %ebp
80105472:	c3                   	ret
80105473:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
80105478:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010547d:	eb ed                	jmp    8010546c <sys_write+0x6c>
8010547f:	90                   	nop

80105480 <sys_close>:
{
80105480:	55                   	push   %ebp
80105481:	89 e5                	mov    %esp,%ebp
80105483:	56                   	push   %esi
80105484:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105485:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105488:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010548b:	50                   	push   %eax
8010548c:	6a 00                	push   $0x0
8010548e:	e8 3d fb ff ff       	call   80104fd0 <argint>
80105493:	83 c4 10             	add    $0x10,%esp
80105496:	85 c0                	test   %eax,%eax
80105498:	78 3e                	js     801054d8 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010549a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010549e:	77 38                	ja     801054d8 <sys_close+0x58>
801054a0:	e8 9b e7 ff ff       	call   80103c40 <myproc>
801054a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801054a8:	8d 5a 08             	lea    0x8(%edx),%ebx
801054ab:	8b 74 98 0c          	mov    0xc(%eax,%ebx,4),%esi
801054af:	85 f6                	test   %esi,%esi
801054b1:	74 25                	je     801054d8 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
801054b3:	e8 88 e7 ff ff       	call   80103c40 <myproc>
  fileclose(f);
801054b8:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
801054bb:	c7 44 98 0c 00 00 00 	movl   $0x0,0xc(%eax,%ebx,4)
801054c2:	00 
  fileclose(f);
801054c3:	56                   	push   %esi
801054c4:	e8 b7 ba ff ff       	call   80100f80 <fileclose>
  return 0;
801054c9:	83 c4 10             	add    $0x10,%esp
801054cc:	31 c0                	xor    %eax,%eax
}
801054ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
801054d1:	5b                   	pop    %ebx
801054d2:	5e                   	pop    %esi
801054d3:	5d                   	pop    %ebp
801054d4:	c3                   	ret
801054d5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801054d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054dd:	eb ef                	jmp    801054ce <sys_close+0x4e>
801054df:	90                   	nop

801054e0 <sys_fstat>:
{
801054e0:	55                   	push   %ebp
801054e1:	89 e5                	mov    %esp,%ebp
801054e3:	56                   	push   %esi
801054e4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801054e5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
801054e8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801054eb:	53                   	push   %ebx
801054ec:	6a 00                	push   $0x0
801054ee:	e8 dd fa ff ff       	call   80104fd0 <argint>
801054f3:	83 c4 10             	add    $0x10,%esp
801054f6:	85 c0                	test   %eax,%eax
801054f8:	78 46                	js     80105540 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801054fa:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801054fe:	77 40                	ja     80105540 <sys_fstat+0x60>
80105500:	e8 3b e7 ff ff       	call   80103c40 <myproc>
80105505:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105508:	8b 74 90 2c          	mov    0x2c(%eax,%edx,4),%esi
8010550c:	85 f6                	test   %esi,%esi
8010550e:	74 30                	je     80105540 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105510:	83 ec 04             	sub    $0x4,%esp
80105513:	6a 14                	push   $0x14
80105515:	53                   	push   %ebx
80105516:	6a 01                	push   $0x1
80105518:	e8 03 fb ff ff       	call   80105020 <argptr>
8010551d:	83 c4 10             	add    $0x10,%esp
80105520:	85 c0                	test   %eax,%eax
80105522:	78 1c                	js     80105540 <sys_fstat+0x60>
  return filestat(f, st);
80105524:	83 ec 08             	sub    $0x8,%esp
80105527:	ff 75 f4             	push   -0xc(%ebp)
8010552a:	56                   	push   %esi
8010552b:	e8 30 bb ff ff       	call   80101060 <filestat>
80105530:	83 c4 10             	add    $0x10,%esp
}
80105533:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105536:	5b                   	pop    %ebx
80105537:	5e                   	pop    %esi
80105538:	5d                   	pop    %ebp
80105539:	c3                   	ret
8010553a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105540:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105545:	eb ec                	jmp    80105533 <sys_fstat+0x53>
80105547:	90                   	nop
80105548:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010554f:	00 

80105550 <sys_link>:
{
80105550:	55                   	push   %ebp
80105551:	89 e5                	mov    %esp,%ebp
80105553:	57                   	push   %edi
80105554:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105555:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105558:	53                   	push   %ebx
80105559:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010555c:	50                   	push   %eax
8010555d:	6a 00                	push   $0x0
8010555f:	e8 2c fb ff ff       	call   80105090 <argstr>
80105564:	83 c4 10             	add    $0x10,%esp
80105567:	85 c0                	test   %eax,%eax
80105569:	0f 88 fb 00 00 00    	js     8010566a <sys_link+0x11a>
8010556f:	83 ec 08             	sub    $0x8,%esp
80105572:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105575:	50                   	push   %eax
80105576:	6a 01                	push   $0x1
80105578:	e8 13 fb ff ff       	call   80105090 <argstr>
8010557d:	83 c4 10             	add    $0x10,%esp
80105580:	85 c0                	test   %eax,%eax
80105582:	0f 88 e2 00 00 00    	js     8010566a <sys_link+0x11a>
  begin_op();
80105588:	e8 53 da ff ff       	call   80102fe0 <begin_op>
  if((ip = namei(old)) == 0){
8010558d:	83 ec 0c             	sub    $0xc,%esp
80105590:	ff 75 d4             	push   -0x2c(%ebp)
80105593:	e8 e8 cc ff ff       	call   80102280 <namei>
80105598:	83 c4 10             	add    $0x10,%esp
8010559b:	89 c3                	mov    %eax,%ebx
8010559d:	85 c0                	test   %eax,%eax
8010559f:	0f 84 df 00 00 00    	je     80105684 <sys_link+0x134>
  ilock(ip);
801055a5:	83 ec 0c             	sub    $0xc,%esp
801055a8:	50                   	push   %eax
801055a9:	e8 92 c3 ff ff       	call   80101940 <ilock>
  if(ip->type == T_DIR){
801055ae:	83 c4 10             	add    $0x10,%esp
801055b1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801055b6:	0f 84 b5 00 00 00    	je     80105671 <sys_link+0x121>
  iupdate(ip);
801055bc:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
801055bf:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
801055c4:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
801055c7:	53                   	push   %ebx
801055c8:	e8 a3 c2 ff ff       	call   80101870 <iupdate>
  iunlock(ip);
801055cd:	89 1c 24             	mov    %ebx,(%esp)
801055d0:	e8 6b c4 ff ff       	call   80101a40 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
801055d5:	58                   	pop    %eax
801055d6:	5a                   	pop    %edx
801055d7:	57                   	push   %edi
801055d8:	ff 75 d0             	push   -0x30(%ebp)
801055db:	e8 c0 cc ff ff       	call   801022a0 <nameiparent>
801055e0:	83 c4 10             	add    $0x10,%esp
801055e3:	89 c6                	mov    %eax,%esi
801055e5:	85 c0                	test   %eax,%eax
801055e7:	74 5b                	je     80105644 <sys_link+0xf4>
  ilock(dp);
801055e9:	83 ec 0c             	sub    $0xc,%esp
801055ec:	50                   	push   %eax
801055ed:	e8 4e c3 ff ff       	call   80101940 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801055f2:	8b 03                	mov    (%ebx),%eax
801055f4:	83 c4 10             	add    $0x10,%esp
801055f7:	39 06                	cmp    %eax,(%esi)
801055f9:	75 3d                	jne    80105638 <sys_link+0xe8>
801055fb:	83 ec 04             	sub    $0x4,%esp
801055fe:	ff 73 04             	push   0x4(%ebx)
80105601:	57                   	push   %edi
80105602:	56                   	push   %esi
80105603:	e8 b8 cb ff ff       	call   801021c0 <dirlink>
80105608:	83 c4 10             	add    $0x10,%esp
8010560b:	85 c0                	test   %eax,%eax
8010560d:	78 29                	js     80105638 <sys_link+0xe8>
  iunlockput(dp);
8010560f:	83 ec 0c             	sub    $0xc,%esp
80105612:	56                   	push   %esi
80105613:	e8 e8 c5 ff ff       	call   80101c00 <iunlockput>
  iput(ip);
80105618:	89 1c 24             	mov    %ebx,(%esp)
8010561b:	e8 70 c4 ff ff       	call   80101a90 <iput>
  end_op();
80105620:	e8 2b da ff ff       	call   80103050 <end_op>
  return 0;
80105625:	83 c4 10             	add    $0x10,%esp
80105628:	31 c0                	xor    %eax,%eax
}
8010562a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010562d:	5b                   	pop    %ebx
8010562e:	5e                   	pop    %esi
8010562f:	5f                   	pop    %edi
80105630:	5d                   	pop    %ebp
80105631:	c3                   	ret
80105632:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105638:	83 ec 0c             	sub    $0xc,%esp
8010563b:	56                   	push   %esi
8010563c:	e8 bf c5 ff ff       	call   80101c00 <iunlockput>
    goto bad;
80105641:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105644:	83 ec 0c             	sub    $0xc,%esp
80105647:	53                   	push   %ebx
80105648:	e8 f3 c2 ff ff       	call   80101940 <ilock>
  ip->nlink--;
8010564d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105652:	89 1c 24             	mov    %ebx,(%esp)
80105655:	e8 16 c2 ff ff       	call   80101870 <iupdate>
  iunlockput(ip);
8010565a:	89 1c 24             	mov    %ebx,(%esp)
8010565d:	e8 9e c5 ff ff       	call   80101c00 <iunlockput>
  end_op();
80105662:	e8 e9 d9 ff ff       	call   80103050 <end_op>
  return -1;
80105667:	83 c4 10             	add    $0x10,%esp
    return -1;
8010566a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010566f:	eb b9                	jmp    8010562a <sys_link+0xda>
    iunlockput(ip);
80105671:	83 ec 0c             	sub    $0xc,%esp
80105674:	53                   	push   %ebx
80105675:	e8 86 c5 ff ff       	call   80101c00 <iunlockput>
    end_op();
8010567a:	e8 d1 d9 ff ff       	call   80103050 <end_op>
    return -1;
8010567f:	83 c4 10             	add    $0x10,%esp
80105682:	eb e6                	jmp    8010566a <sys_link+0x11a>
    end_op();
80105684:	e8 c7 d9 ff ff       	call   80103050 <end_op>
    return -1;
80105689:	eb df                	jmp    8010566a <sys_link+0x11a>
8010568b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105690 <sys_unlink>:
{
80105690:	55                   	push   %ebp
80105691:	89 e5                	mov    %esp,%ebp
80105693:	57                   	push   %edi
80105694:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80105695:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105698:	53                   	push   %ebx
80105699:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
8010569c:	50                   	push   %eax
8010569d:	6a 00                	push   $0x0
8010569f:	e8 ec f9 ff ff       	call   80105090 <argstr>
801056a4:	83 c4 10             	add    $0x10,%esp
801056a7:	85 c0                	test   %eax,%eax
801056a9:	0f 88 54 01 00 00    	js     80105803 <sys_unlink+0x173>
  begin_op();
801056af:	e8 2c d9 ff ff       	call   80102fe0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801056b4:	8d 5d ca             	lea    -0x36(%ebp),%ebx
801056b7:	83 ec 08             	sub    $0x8,%esp
801056ba:	53                   	push   %ebx
801056bb:	ff 75 c0             	push   -0x40(%ebp)
801056be:	e8 dd cb ff ff       	call   801022a0 <nameiparent>
801056c3:	83 c4 10             	add    $0x10,%esp
801056c6:	89 45 b4             	mov    %eax,-0x4c(%ebp)
801056c9:	85 c0                	test   %eax,%eax
801056cb:	0f 84 58 01 00 00    	je     80105829 <sys_unlink+0x199>
  ilock(dp);
801056d1:	8b 7d b4             	mov    -0x4c(%ebp),%edi
801056d4:	83 ec 0c             	sub    $0xc,%esp
801056d7:	57                   	push   %edi
801056d8:	e8 63 c2 ff ff       	call   80101940 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801056dd:	58                   	pop    %eax
801056de:	5a                   	pop    %edx
801056df:	68 c4 7c 10 80       	push   $0x80107cc4
801056e4:	53                   	push   %ebx
801056e5:	e8 b6 c7 ff ff       	call   80101ea0 <namecmp>
801056ea:	83 c4 10             	add    $0x10,%esp
801056ed:	85 c0                	test   %eax,%eax
801056ef:	0f 84 fb 00 00 00    	je     801057f0 <sys_unlink+0x160>
801056f5:	83 ec 08             	sub    $0x8,%esp
801056f8:	68 c3 7c 10 80       	push   $0x80107cc3
801056fd:	53                   	push   %ebx
801056fe:	e8 9d c7 ff ff       	call   80101ea0 <namecmp>
80105703:	83 c4 10             	add    $0x10,%esp
80105706:	85 c0                	test   %eax,%eax
80105708:	0f 84 e2 00 00 00    	je     801057f0 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010570e:	83 ec 04             	sub    $0x4,%esp
80105711:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105714:	50                   	push   %eax
80105715:	53                   	push   %ebx
80105716:	57                   	push   %edi
80105717:	e8 a4 c7 ff ff       	call   80101ec0 <dirlookup>
8010571c:	83 c4 10             	add    $0x10,%esp
8010571f:	89 c3                	mov    %eax,%ebx
80105721:	85 c0                	test   %eax,%eax
80105723:	0f 84 c7 00 00 00    	je     801057f0 <sys_unlink+0x160>
  ilock(ip);
80105729:	83 ec 0c             	sub    $0xc,%esp
8010572c:	50                   	push   %eax
8010572d:	e8 0e c2 ff ff       	call   80101940 <ilock>
  if(ip->nlink < 1)
80105732:	83 c4 10             	add    $0x10,%esp
80105735:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010573a:	0f 8e fd 00 00 00    	jle    8010583d <sys_unlink+0x1ad>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105740:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105743:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105748:	74 66                	je     801057b0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
8010574a:	83 ec 04             	sub    $0x4,%esp
8010574d:	6a 10                	push   $0x10
8010574f:	6a 00                	push   $0x0
80105751:	57                   	push   %edi
80105752:	e8 a9 f5 ff ff       	call   80104d00 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105757:	6a 10                	push   $0x10
80105759:	ff 75 c4             	push   -0x3c(%ebp)
8010575c:	57                   	push   %edi
8010575d:	ff 75 b4             	push   -0x4c(%ebp)
80105760:	e8 1b c6 ff ff       	call   80101d80 <writei>
80105765:	83 c4 20             	add    $0x20,%esp
80105768:	83 f8 10             	cmp    $0x10,%eax
8010576b:	0f 85 d9 00 00 00    	jne    8010584a <sys_unlink+0x1ba>
  if(ip->type == T_DIR){
80105771:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105776:	0f 84 94 00 00 00    	je     80105810 <sys_unlink+0x180>
  iunlockput(dp);
8010577c:	83 ec 0c             	sub    $0xc,%esp
8010577f:	ff 75 b4             	push   -0x4c(%ebp)
80105782:	e8 79 c4 ff ff       	call   80101c00 <iunlockput>
  ip->nlink--;
80105787:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010578c:	89 1c 24             	mov    %ebx,(%esp)
8010578f:	e8 dc c0 ff ff       	call   80101870 <iupdate>
  iunlockput(ip);
80105794:	89 1c 24             	mov    %ebx,(%esp)
80105797:	e8 64 c4 ff ff       	call   80101c00 <iunlockput>
  end_op();
8010579c:	e8 af d8 ff ff       	call   80103050 <end_op>
  return 0;
801057a1:	83 c4 10             	add    $0x10,%esp
801057a4:	31 c0                	xor    %eax,%eax
}
801057a6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801057a9:	5b                   	pop    %ebx
801057aa:	5e                   	pop    %esi
801057ab:	5f                   	pop    %edi
801057ac:	5d                   	pop    %ebp
801057ad:	c3                   	ret
801057ae:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801057b0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801057b4:	76 94                	jbe    8010574a <sys_unlink+0xba>
801057b6:	be 20 00 00 00       	mov    $0x20,%esi
801057bb:	eb 0b                	jmp    801057c8 <sys_unlink+0x138>
801057bd:	8d 76 00             	lea    0x0(%esi),%esi
801057c0:	83 c6 10             	add    $0x10,%esi
801057c3:	3b 73 58             	cmp    0x58(%ebx),%esi
801057c6:	73 82                	jae    8010574a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801057c8:	6a 10                	push   $0x10
801057ca:	56                   	push   %esi
801057cb:	57                   	push   %edi
801057cc:	53                   	push   %ebx
801057cd:	e8 ae c4 ff ff       	call   80101c80 <readi>
801057d2:	83 c4 10             	add    $0x10,%esp
801057d5:	83 f8 10             	cmp    $0x10,%eax
801057d8:	75 56                	jne    80105830 <sys_unlink+0x1a0>
    if(de.inum != 0)
801057da:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801057df:	74 df                	je     801057c0 <sys_unlink+0x130>
    iunlockput(ip);
801057e1:	83 ec 0c             	sub    $0xc,%esp
801057e4:	53                   	push   %ebx
801057e5:	e8 16 c4 ff ff       	call   80101c00 <iunlockput>
    goto bad;
801057ea:	83 c4 10             	add    $0x10,%esp
801057ed:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
801057f0:	83 ec 0c             	sub    $0xc,%esp
801057f3:	ff 75 b4             	push   -0x4c(%ebp)
801057f6:	e8 05 c4 ff ff       	call   80101c00 <iunlockput>
  end_op();
801057fb:	e8 50 d8 ff ff       	call   80103050 <end_op>
  return -1;
80105800:	83 c4 10             	add    $0x10,%esp
    return -1;
80105803:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105808:	eb 9c                	jmp    801057a6 <sys_unlink+0x116>
8010580a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
80105810:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80105813:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105816:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
8010581b:	50                   	push   %eax
8010581c:	e8 4f c0 ff ff       	call   80101870 <iupdate>
80105821:	83 c4 10             	add    $0x10,%esp
80105824:	e9 53 ff ff ff       	jmp    8010577c <sys_unlink+0xec>
    end_op();
80105829:	e8 22 d8 ff ff       	call   80103050 <end_op>
    return -1;
8010582e:	eb d3                	jmp    80105803 <sys_unlink+0x173>
      panic("isdirempty: readi");
80105830:	83 ec 0c             	sub    $0xc,%esp
80105833:	68 e8 7c 10 80       	push   $0x80107ce8
80105838:	e8 63 ab ff ff       	call   801003a0 <panic>
    panic("unlink: nlink < 1");
8010583d:	83 ec 0c             	sub    $0xc,%esp
80105840:	68 d6 7c 10 80       	push   $0x80107cd6
80105845:	e8 56 ab ff ff       	call   801003a0 <panic>
    panic("unlink: writei");
8010584a:	83 ec 0c             	sub    $0xc,%esp
8010584d:	68 fa 7c 10 80       	push   $0x80107cfa
80105852:	e8 49 ab ff ff       	call   801003a0 <panic>
80105857:	90                   	nop
80105858:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010585f:	00 

80105860 <sys_open>:

int
sys_open(void)
{
80105860:	55                   	push   %ebp
80105861:	89 e5                	mov    %esp,%ebp
80105863:	57                   	push   %edi
80105864:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105865:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105868:	53                   	push   %ebx
80105869:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010586c:	50                   	push   %eax
8010586d:	6a 00                	push   $0x0
8010586f:	e8 1c f8 ff ff       	call   80105090 <argstr>
80105874:	83 c4 10             	add    $0x10,%esp
80105877:	85 c0                	test   %eax,%eax
80105879:	0f 88 8e 00 00 00    	js     8010590d <sys_open+0xad>
8010587f:	83 ec 08             	sub    $0x8,%esp
80105882:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105885:	50                   	push   %eax
80105886:	6a 01                	push   $0x1
80105888:	e8 43 f7 ff ff       	call   80104fd0 <argint>
8010588d:	83 c4 10             	add    $0x10,%esp
80105890:	85 c0                	test   %eax,%eax
80105892:	78 79                	js     8010590d <sys_open+0xad>
    return -1;

  begin_op();
80105894:	e8 47 d7 ff ff       	call   80102fe0 <begin_op>

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80105899:	8b 45 e0             	mov    -0x20(%ebp),%eax
  if(omode & O_CREATE){
8010589c:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801058a0:	75 76                	jne    80105918 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801058a2:	83 ec 0c             	sub    $0xc,%esp
801058a5:	50                   	push   %eax
801058a6:	e8 d5 c9 ff ff       	call   80102280 <namei>
801058ab:	83 c4 10             	add    $0x10,%esp
801058ae:	89 c7                	mov    %eax,%edi
801058b0:	85 c0                	test   %eax,%eax
801058b2:	74 7e                	je     80105932 <sys_open+0xd2>
      end_op();
      return -1;
    }
    ilock(ip);
801058b4:	83 ec 0c             	sub    $0xc,%esp
801058b7:	50                   	push   %eax
801058b8:	e8 83 c0 ff ff       	call   80101940 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801058bd:	83 c4 10             	add    $0x10,%esp
801058c0:	66 83 7f 50 01       	cmpw   $0x1,0x50(%edi)
801058c5:	0f 84 bd 00 00 00    	je     80105988 <sys_open+0x128>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801058cb:	e8 f0 b5 ff ff       	call   80100ec0 <filealloc>
801058d0:	89 c6                	mov    %eax,%esi
801058d2:	85 c0                	test   %eax,%eax
801058d4:	74 26                	je     801058fc <sys_open+0x9c>
  struct proc *curproc = myproc();
801058d6:	e8 65 e3 ff ff       	call   80103c40 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801058db:	31 db                	xor    %ebx,%ebx
801058dd:	8d 76 00             	lea    0x0(%esi),%esi
    if(curproc->ofile[fd] == 0){
801058e0:	8b 54 98 2c          	mov    0x2c(%eax,%ebx,4),%edx
801058e4:	85 d2                	test   %edx,%edx
801058e6:	74 58                	je     80105940 <sys_open+0xe0>
  for(fd = 0; fd < NOFILE; fd++){
801058e8:	83 c3 01             	add    $0x1,%ebx
801058eb:	83 fb 10             	cmp    $0x10,%ebx
801058ee:	75 f0                	jne    801058e0 <sys_open+0x80>
    if(f)
      fileclose(f);
801058f0:	83 ec 0c             	sub    $0xc,%esp
801058f3:	56                   	push   %esi
801058f4:	e8 87 b6 ff ff       	call   80100f80 <fileclose>
801058f9:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
801058fc:	83 ec 0c             	sub    $0xc,%esp
801058ff:	57                   	push   %edi
80105900:	e8 fb c2 ff ff       	call   80101c00 <iunlockput>
    end_op();
80105905:	e8 46 d7 ff ff       	call   80103050 <end_op>
    return -1;
8010590a:	83 c4 10             	add    $0x10,%esp
    return -1;
8010590d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105912:	eb 65                	jmp    80105979 <sys_open+0x119>
80105914:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105918:	83 ec 0c             	sub    $0xc,%esp
8010591b:	31 c9                	xor    %ecx,%ecx
8010591d:	ba 02 00 00 00       	mov    $0x2,%edx
80105922:	6a 00                	push   $0x0
80105924:	e8 57 f8 ff ff       	call   80105180 <create>
    if(ip == 0){
80105929:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
8010592c:	89 c7                	mov    %eax,%edi
    if(ip == 0){
8010592e:	85 c0                	test   %eax,%eax
80105930:	75 99                	jne    801058cb <sys_open+0x6b>
      end_op();
80105932:	e8 19 d7 ff ff       	call   80103050 <end_op>
      return -1;
80105937:	eb d4                	jmp    8010590d <sys_open+0xad>
80105939:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105940:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105943:	89 74 98 2c          	mov    %esi,0x2c(%eax,%ebx,4)
  iunlock(ip);
80105947:	57                   	push   %edi
80105948:	e8 f3 c0 ff ff       	call   80101a40 <iunlock>
  end_op();
8010594d:	e8 fe d6 ff ff       	call   80103050 <end_op>

  f->type = FD_INODE;
80105952:	c7 06 02 00 00 00    	movl   $0x2,(%esi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105958:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010595b:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
8010595e:	89 7e 10             	mov    %edi,0x10(%esi)
  f->readable = !(omode & O_WRONLY);
80105961:	89 d0                	mov    %edx,%eax
  f->off = 0;
80105963:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%esi)
  f->readable = !(omode & O_WRONLY);
8010596a:	f7 d0                	not    %eax
8010596c:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010596f:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105972:	88 46 08             	mov    %al,0x8(%esi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105975:	0f 95 46 09          	setne  0x9(%esi)
  return fd;
}
80105979:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010597c:	89 d8                	mov    %ebx,%eax
8010597e:	5b                   	pop    %ebx
8010597f:	5e                   	pop    %esi
80105980:	5f                   	pop    %edi
80105981:	5d                   	pop    %ebp
80105982:	c3                   	ret
80105983:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105988:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010598b:	85 c9                	test   %ecx,%ecx
8010598d:	0f 84 38 ff ff ff    	je     801058cb <sys_open+0x6b>
80105993:	e9 64 ff ff ff       	jmp    801058fc <sys_open+0x9c>
80105998:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010599f:	00 

801059a0 <sys_mkdir>:

int
sys_mkdir(void)
{
801059a0:	55                   	push   %ebp
801059a1:	89 e5                	mov    %esp,%ebp
801059a3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801059a6:	e8 35 d6 ff ff       	call   80102fe0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801059ab:	83 ec 08             	sub    $0x8,%esp
801059ae:	8d 45 f4             	lea    -0xc(%ebp),%eax
801059b1:	50                   	push   %eax
801059b2:	6a 00                	push   $0x0
801059b4:	e8 d7 f6 ff ff       	call   80105090 <argstr>
801059b9:	83 c4 10             	add    $0x10,%esp
801059bc:	85 c0                	test   %eax,%eax
801059be:	78 30                	js     801059f0 <sys_mkdir+0x50>
801059c0:	83 ec 0c             	sub    $0xc,%esp
801059c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059c6:	31 c9                	xor    %ecx,%ecx
801059c8:	ba 01 00 00 00       	mov    $0x1,%edx
801059cd:	6a 00                	push   $0x0
801059cf:	e8 ac f7 ff ff       	call   80105180 <create>
801059d4:	83 c4 10             	add    $0x10,%esp
801059d7:	85 c0                	test   %eax,%eax
801059d9:	74 15                	je     801059f0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801059db:	83 ec 0c             	sub    $0xc,%esp
801059de:	50                   	push   %eax
801059df:	e8 1c c2 ff ff       	call   80101c00 <iunlockput>
  end_op();
801059e4:	e8 67 d6 ff ff       	call   80103050 <end_op>
  return 0;
801059e9:	83 c4 10             	add    $0x10,%esp
801059ec:	31 c0                	xor    %eax,%eax
}
801059ee:	c9                   	leave
801059ef:	c3                   	ret
    end_op();
801059f0:	e8 5b d6 ff ff       	call   80103050 <end_op>
    return -1;
801059f5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801059fa:	c9                   	leave
801059fb:	c3                   	ret
801059fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105a00 <sys_mknod>:

int
sys_mknod(void)
{
80105a00:	55                   	push   %ebp
80105a01:	89 e5                	mov    %esp,%ebp
80105a03:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105a06:	e8 d5 d5 ff ff       	call   80102fe0 <begin_op>
  if((argstr(0, &path)) < 0 ||
80105a0b:	83 ec 08             	sub    $0x8,%esp
80105a0e:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105a11:	50                   	push   %eax
80105a12:	6a 00                	push   $0x0
80105a14:	e8 77 f6 ff ff       	call   80105090 <argstr>
80105a19:	83 c4 10             	add    $0x10,%esp
80105a1c:	85 c0                	test   %eax,%eax
80105a1e:	78 60                	js     80105a80 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105a20:	83 ec 08             	sub    $0x8,%esp
80105a23:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105a26:	50                   	push   %eax
80105a27:	6a 01                	push   $0x1
80105a29:	e8 a2 f5 ff ff       	call   80104fd0 <argint>
  if((argstr(0, &path)) < 0 ||
80105a2e:	83 c4 10             	add    $0x10,%esp
80105a31:	85 c0                	test   %eax,%eax
80105a33:	78 4b                	js     80105a80 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105a35:	83 ec 08             	sub    $0x8,%esp
80105a38:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a3b:	50                   	push   %eax
80105a3c:	6a 02                	push   $0x2
80105a3e:	e8 8d f5 ff ff       	call   80104fd0 <argint>
     argint(1, &major) < 0 ||
80105a43:	83 c4 10             	add    $0x10,%esp
80105a46:	85 c0                	test   %eax,%eax
80105a48:	78 36                	js     80105a80 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105a4a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80105a4e:	83 ec 0c             	sub    $0xc,%esp
80105a51:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105a55:	ba 03 00 00 00       	mov    $0x3,%edx
80105a5a:	50                   	push   %eax
80105a5b:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105a5e:	e8 1d f7 ff ff       	call   80105180 <create>
     argint(2, &minor) < 0 ||
80105a63:	83 c4 10             	add    $0x10,%esp
80105a66:	85 c0                	test   %eax,%eax
80105a68:	74 16                	je     80105a80 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105a6a:	83 ec 0c             	sub    $0xc,%esp
80105a6d:	50                   	push   %eax
80105a6e:	e8 8d c1 ff ff       	call   80101c00 <iunlockput>
  end_op();
80105a73:	e8 d8 d5 ff ff       	call   80103050 <end_op>
  return 0;
80105a78:	83 c4 10             	add    $0x10,%esp
80105a7b:	31 c0                	xor    %eax,%eax
}
80105a7d:	c9                   	leave
80105a7e:	c3                   	ret
80105a7f:	90                   	nop
    end_op();
80105a80:	e8 cb d5 ff ff       	call   80103050 <end_op>
    return -1;
80105a85:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a8a:	c9                   	leave
80105a8b:	c3                   	ret
80105a8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105a90 <sys_chdir>:

int
sys_chdir(void)
{
80105a90:	55                   	push   %ebp
80105a91:	89 e5                	mov    %esp,%ebp
80105a93:	56                   	push   %esi
80105a94:	53                   	push   %ebx
80105a95:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105a98:	e8 a3 e1 ff ff       	call   80103c40 <myproc>
80105a9d:	89 c6                	mov    %eax,%esi
  
  begin_op();
80105a9f:	e8 3c d5 ff ff       	call   80102fe0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105aa4:	83 ec 08             	sub    $0x8,%esp
80105aa7:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105aaa:	50                   	push   %eax
80105aab:	6a 00                	push   $0x0
80105aad:	e8 de f5 ff ff       	call   80105090 <argstr>
80105ab2:	83 c4 10             	add    $0x10,%esp
80105ab5:	85 c0                	test   %eax,%eax
80105ab7:	78 77                	js     80105b30 <sys_chdir+0xa0>
80105ab9:	83 ec 0c             	sub    $0xc,%esp
80105abc:	ff 75 f4             	push   -0xc(%ebp)
80105abf:	e8 bc c7 ff ff       	call   80102280 <namei>
80105ac4:	83 c4 10             	add    $0x10,%esp
80105ac7:	89 c3                	mov    %eax,%ebx
80105ac9:	85 c0                	test   %eax,%eax
80105acb:	74 63                	je     80105b30 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80105acd:	83 ec 0c             	sub    $0xc,%esp
80105ad0:	50                   	push   %eax
80105ad1:	e8 6a be ff ff       	call   80101940 <ilock>
  if(ip->type != T_DIR){
80105ad6:	83 c4 10             	add    $0x10,%esp
80105ad9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105ade:	75 30                	jne    80105b10 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105ae0:	83 ec 0c             	sub    $0xc,%esp
80105ae3:	53                   	push   %ebx
80105ae4:	e8 57 bf ff ff       	call   80101a40 <iunlock>
  iput(curproc->cwd);
80105ae9:	58                   	pop    %eax
80105aea:	ff 76 6c             	push   0x6c(%esi)
80105aed:	e8 9e bf ff ff       	call   80101a90 <iput>
  end_op();
80105af2:	e8 59 d5 ff ff       	call   80103050 <end_op>
  curproc->cwd = ip;
80105af7:	89 5e 6c             	mov    %ebx,0x6c(%esi)
  return 0;
80105afa:	83 c4 10             	add    $0x10,%esp
80105afd:	31 c0                	xor    %eax,%eax
}
80105aff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105b02:	5b                   	pop    %ebx
80105b03:	5e                   	pop    %esi
80105b04:	5d                   	pop    %ebp
80105b05:	c3                   	ret
80105b06:	66 90                	xchg   %ax,%ax
80105b08:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105b0f:	00 
    iunlockput(ip);
80105b10:	83 ec 0c             	sub    $0xc,%esp
80105b13:	53                   	push   %ebx
80105b14:	e8 e7 c0 ff ff       	call   80101c00 <iunlockput>
    end_op();
80105b19:	e8 32 d5 ff ff       	call   80103050 <end_op>
    return -1;
80105b1e:	83 c4 10             	add    $0x10,%esp
    return -1;
80105b21:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b26:	eb d7                	jmp    80105aff <sys_chdir+0x6f>
80105b28:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105b2f:	00 
    end_op();
80105b30:	e8 1b d5 ff ff       	call   80103050 <end_op>
    return -1;
80105b35:	eb ea                	jmp    80105b21 <sys_chdir+0x91>
80105b37:	90                   	nop
80105b38:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105b3f:	00 

80105b40 <sys_exec>:

int
sys_exec(void)
{
80105b40:	55                   	push   %ebp
80105b41:	89 e5                	mov    %esp,%ebp
80105b43:	57                   	push   %edi
80105b44:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105b45:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
80105b4b:	53                   	push   %ebx
80105b4c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105b52:	50                   	push   %eax
80105b53:	6a 00                	push   $0x0
80105b55:	e8 36 f5 ff ff       	call   80105090 <argstr>
80105b5a:	83 c4 10             	add    $0x10,%esp
80105b5d:	85 c0                	test   %eax,%eax
80105b5f:	0f 88 85 00 00 00    	js     80105bea <sys_exec+0xaa>
80105b65:	83 ec 08             	sub    $0x8,%esp
80105b68:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105b6e:	50                   	push   %eax
80105b6f:	6a 01                	push   $0x1
80105b71:	e8 5a f4 ff ff       	call   80104fd0 <argint>
80105b76:	83 c4 10             	add    $0x10,%esp
80105b79:	85 c0                	test   %eax,%eax
80105b7b:	78 6d                	js     80105bea <sys_exec+0xaa>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105b7d:	83 ec 04             	sub    $0x4,%esp
80105b80:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
80105b86:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105b88:	68 80 00 00 00       	push   $0x80
80105b8d:	6a 00                	push   $0x0
80105b8f:	56                   	push   %esi
80105b90:	e8 6b f1 ff ff       	call   80104d00 <memset>
80105b95:	83 c4 10             	add    $0x10,%esp
80105b98:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105b9f:	00 
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105ba0:	83 ec 08             	sub    $0x8,%esp
80105ba3:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80105ba9:	50                   	push   %eax
80105baa:	8d 04 9d 00 00 00 00 	lea    0x0(,%ebx,4),%eax
80105bb1:	03 85 60 ff ff ff    	add    -0xa0(%ebp),%eax
80105bb7:	50                   	push   %eax
80105bb8:	e8 73 f3 ff ff       	call   80104f30 <fetchint>
80105bbd:	83 c4 10             	add    $0x10,%esp
80105bc0:	85 c0                	test   %eax,%eax
80105bc2:	78 26                	js     80105bea <sys_exec+0xaa>
      return -1;
    if(uarg == 0){
80105bc4:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105bca:	85 c0                	test   %eax,%eax
80105bcc:	74 32                	je     80105c00 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105bce:	83 ec 08             	sub    $0x8,%esp
80105bd1:	8d 14 9e             	lea    (%esi,%ebx,4),%edx
80105bd4:	52                   	push   %edx
80105bd5:	50                   	push   %eax
80105bd6:	e8 95 f3 ff ff       	call   80104f70 <fetchstr>
80105bdb:	83 c4 10             	add    $0x10,%esp
80105bde:	85 c0                	test   %eax,%eax
80105be0:	78 08                	js     80105bea <sys_exec+0xaa>
  for(i=0;; i++){
80105be2:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105be5:	83 fb 20             	cmp    $0x20,%ebx
80105be8:	75 b6                	jne    80105ba0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
80105bea:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80105bed:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105bf2:	5b                   	pop    %ebx
80105bf3:	5e                   	pop    %esi
80105bf4:	5f                   	pop    %edi
80105bf5:	5d                   	pop    %ebp
80105bf6:	c3                   	ret
80105bf7:	90                   	nop
80105bf8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105bff:	00 
      argv[i] = 0;
80105c00:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105c07:	00 00 00 00 
  return exec(path, argv);
80105c0b:	83 ec 08             	sub    $0x8,%esp
80105c0e:	56                   	push   %esi
80105c0f:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
80105c15:	e8 f6 ae ff ff       	call   80100b10 <exec>
80105c1a:	83 c4 10             	add    $0x10,%esp
}
80105c1d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c20:	5b                   	pop    %ebx
80105c21:	5e                   	pop    %esi
80105c22:	5f                   	pop    %edi
80105c23:	5d                   	pop    %ebp
80105c24:	c3                   	ret
80105c25:	8d 76 00             	lea    0x0(%esi),%esi
80105c28:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105c2f:	00 

80105c30 <sys_pipe>:

int
sys_pipe(void)
{
80105c30:	55                   	push   %ebp
80105c31:	89 e5                	mov    %esp,%ebp
80105c33:	57                   	push   %edi
80105c34:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105c35:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105c38:	53                   	push   %ebx
80105c39:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105c3c:	6a 08                	push   $0x8
80105c3e:	50                   	push   %eax
80105c3f:	6a 00                	push   $0x0
80105c41:	e8 da f3 ff ff       	call   80105020 <argptr>
80105c46:	83 c4 10             	add    $0x10,%esp
80105c49:	85 c0                	test   %eax,%eax
80105c4b:	0f 88 93 00 00 00    	js     80105ce4 <sys_pipe+0xb4>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105c51:	83 ec 08             	sub    $0x8,%esp
80105c54:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105c57:	50                   	push   %eax
80105c58:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105c5b:	50                   	push   %eax
80105c5c:	e8 1f da ff ff       	call   80103680 <pipealloc>
80105c61:	83 c4 10             	add    $0x10,%esp
80105c64:	85 c0                	test   %eax,%eax
80105c66:	78 7c                	js     80105ce4 <sys_pipe+0xb4>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105c68:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105c6b:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105c6d:	e8 ce df ff ff       	call   80103c40 <myproc>
    if(curproc->ofile[fd] == 0){
80105c72:	8b 74 98 2c          	mov    0x2c(%eax,%ebx,4),%esi
80105c76:	85 f6                	test   %esi,%esi
80105c78:	74 16                	je     80105c90 <sys_pipe+0x60>
80105c7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105c80:	83 c3 01             	add    $0x1,%ebx
80105c83:	83 fb 10             	cmp    $0x10,%ebx
80105c86:	74 45                	je     80105ccd <sys_pipe+0x9d>
    if(curproc->ofile[fd] == 0){
80105c88:	8b 74 98 2c          	mov    0x2c(%eax,%ebx,4),%esi
80105c8c:	85 f6                	test   %esi,%esi
80105c8e:	75 f0                	jne    80105c80 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80105c90:	8d 73 08             	lea    0x8(%ebx),%esi
80105c93:	89 7c b0 0c          	mov    %edi,0xc(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105c97:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80105c9a:	e8 a1 df ff ff       	call   80103c40 <myproc>
80105c9f:	89 c2                	mov    %eax,%edx
  for(fd = 0; fd < NOFILE; fd++){
80105ca1:	31 c0                	xor    %eax,%eax
80105ca3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80105ca8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105caf:	00 
    if(curproc->ofile[fd] == 0){
80105cb0:	8b 4c 82 2c          	mov    0x2c(%edx,%eax,4),%ecx
80105cb4:	85 c9                	test   %ecx,%ecx
80105cb6:	74 38                	je     80105cf0 <sys_pipe+0xc0>
  for(fd = 0; fd < NOFILE; fd++){
80105cb8:	83 c0 01             	add    $0x1,%eax
80105cbb:	83 f8 10             	cmp    $0x10,%eax
80105cbe:	75 f0                	jne    80105cb0 <sys_pipe+0x80>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80105cc0:	e8 7b df ff ff       	call   80103c40 <myproc>
80105cc5:	c7 44 b0 0c 00 00 00 	movl   $0x0,0xc(%eax,%esi,4)
80105ccc:	00 
    fileclose(rf);
80105ccd:	83 ec 0c             	sub    $0xc,%esp
80105cd0:	ff 75 e0             	push   -0x20(%ebp)
80105cd3:	e8 a8 b2 ff ff       	call   80100f80 <fileclose>
    fileclose(wf);
80105cd8:	58                   	pop    %eax
80105cd9:	ff 75 e4             	push   -0x1c(%ebp)
80105cdc:	e8 9f b2 ff ff       	call   80100f80 <fileclose>
    return -1;
80105ce1:	83 c4 10             	add    $0x10,%esp
    return -1;
80105ce4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ce9:	eb 16                	jmp    80105d01 <sys_pipe+0xd1>
80105ceb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      curproc->ofile[fd] = f;
80105cf0:	89 7c 82 2c          	mov    %edi,0x2c(%edx,%eax,4)
  }
  fd[0] = fd0;
80105cf4:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105cf7:	89 1a                	mov    %ebx,(%edx)
  fd[1] = fd1;
80105cf9:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105cfc:	89 42 04             	mov    %eax,0x4(%edx)
  return 0;
80105cff:	31 c0                	xor    %eax,%eax
}
80105d01:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d04:	5b                   	pop    %ebx
80105d05:	5e                   	pop    %esi
80105d06:	5f                   	pop    %edi
80105d07:	5d                   	pop    %ebp
80105d08:	c3                   	ret
80105d09:	66 90                	xchg   %ax,%ax
80105d0b:	66 90                	xchg   %ax,%ax
80105d0d:	66 90                	xchg   %ax,%ax
80105d0f:	90                   	nop

80105d10 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int sys_fork(void)
{
  return fork();
80105d10:	e9 eb e0 ff ff       	jmp    80103e00 <fork>
80105d15:	8d 76 00             	lea    0x0(%esi),%esi
80105d18:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105d1f:	00 

80105d20 <sys_exit>:
}

int sys_exit(void)
{
80105d20:	55                   	push   %ebp
80105d21:	89 e5                	mov    %esp,%ebp
80105d23:	83 ec 08             	sub    $0x8,%esp
  exit();
80105d26:	e8 d5 e3 ff ff       	call   80104100 <exit>
  return 0; // not reached
}
80105d2b:	31 c0                	xor    %eax,%eax
80105d2d:	c9                   	leave
80105d2e:	c3                   	ret
80105d2f:	90                   	nop

80105d30 <sys_wait>:

int sys_wait(void)
{
  return wait();
80105d30:	e9 3b e5 ff ff       	jmp    80104270 <wait>
80105d35:	8d 76 00             	lea    0x0(%esi),%esi
80105d38:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105d3f:	00 

80105d40 <sys_kill>:
}

int sys_kill(void)
{
80105d40:	55                   	push   %ebp
80105d41:	89 e5                	mov    %esp,%ebp
80105d43:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if (argint(0, &pid) < 0)
80105d46:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105d49:	50                   	push   %eax
80105d4a:	6a 00                	push   $0x0
80105d4c:	e8 7f f2 ff ff       	call   80104fd0 <argint>
80105d51:	83 c4 10             	add    $0x10,%esp
80105d54:	85 c0                	test   %eax,%eax
80105d56:	78 18                	js     80105d70 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105d58:	83 ec 0c             	sub    $0xc,%esp
80105d5b:	ff 75 f4             	push   -0xc(%ebp)
80105d5e:	e8 dd e7 ff ff       	call   80104540 <kill>
80105d63:	83 c4 10             	add    $0x10,%esp
}
80105d66:	c9                   	leave
80105d67:	c3                   	ret
80105d68:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105d6f:	00 
80105d70:	c9                   	leave
    return -1;
80105d71:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105d76:	c3                   	ret
80105d77:	90                   	nop
80105d78:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105d7f:	00 

80105d80 <sys_getpid>:

int sys_getpid(void)
{
80105d80:	55                   	push   %ebp
80105d81:	89 e5                	mov    %esp,%ebp
80105d83:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105d86:	e8 b5 de ff ff       	call   80103c40 <myproc>
80105d8b:	8b 40 10             	mov    0x10(%eax),%eax
}
80105d8e:	c9                   	leave
80105d8f:	c3                   	ret

80105d90 <sys_getprocinfo>:

int sys_getprocinfo(void)
{
80105d90:	55                   	push   %ebp
80105d91:	89 e5                	mov    %esp,%ebp
80105d93:	83 ec 20             	sub    $0x20,%esp
  int pid;
  struct procinfo *info;

  if (argint(0, &pid) < 0)
80105d96:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105d99:	50                   	push   %eax
80105d9a:	6a 00                	push   $0x0
80105d9c:	e8 2f f2 ff ff       	call   80104fd0 <argint>
80105da1:	83 c4 10             	add    $0x10,%esp
80105da4:	85 c0                	test   %eax,%eax
80105da6:	78 30                	js     80105dd8 <sys_getprocinfo+0x48>
    return -1;
  if (argptr(1, (char **)&info, sizeof(*info)) < 0)
80105da8:	83 ec 04             	sub    $0x4,%esp
80105dab:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105dae:	6a 38                	push   $0x38
80105db0:	50                   	push   %eax
80105db1:	6a 01                	push   $0x1
80105db3:	e8 68 f2 ff ff       	call   80105020 <argptr>
80105db8:	83 c4 10             	add    $0x10,%esp
80105dbb:	85 c0                	test   %eax,%eax
80105dbd:	78 19                	js     80105dd8 <sys_getprocinfo+0x48>
    return -1;
  return getprocinfo(pid, info);
80105dbf:	83 ec 08             	sub    $0x8,%esp
80105dc2:	ff 75 f4             	push   -0xc(%ebp)
80105dc5:	ff 75 f0             	push   -0x10(%ebp)
80105dc8:	e8 23 e8 ff ff       	call   801045f0 <getprocinfo>
80105dcd:	83 c4 10             	add    $0x10,%esp
}
80105dd0:	c9                   	leave
80105dd1:	c3                   	ret
80105dd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105dd8:	c9                   	leave
    return -1;
80105dd9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105dde:	c3                   	ret
80105ddf:	90                   	nop

80105de0 <sys_sbrk>:

int sys_sbrk(void)
{
80105de0:	55                   	push   %ebp
80105de1:	89 e5                	mov    %esp,%ebp
80105de3:	53                   	push   %ebx
  int addr;
  int n;

  if (argint(0, &n) < 0)
80105de4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105de7:	83 ec 1c             	sub    $0x1c,%esp
  if (argint(0, &n) < 0)
80105dea:	50                   	push   %eax
80105deb:	6a 00                	push   $0x0
80105ded:	e8 de f1 ff ff       	call   80104fd0 <argint>
80105df2:	83 c4 10             	add    $0x10,%esp
80105df5:	85 c0                	test   %eax,%eax
80105df7:	78 27                	js     80105e20 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105df9:	e8 42 de ff ff       	call   80103c40 <myproc>
  if (growproc(n) < 0)
80105dfe:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105e01:	8b 18                	mov    (%eax),%ebx
  if (growproc(n) < 0)
80105e03:	ff 75 f4             	push   -0xc(%ebp)
80105e06:	e8 65 df ff ff       	call   80103d70 <growproc>
80105e0b:	83 c4 10             	add    $0x10,%esp
80105e0e:	85 c0                	test   %eax,%eax
80105e10:	78 0e                	js     80105e20 <sys_sbrk+0x40>
  addr = myproc()->sz;
80105e12:	89 d8                	mov    %ebx,%eax
    return -1;
  return addr;
}
80105e14:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105e17:	c9                   	leave
80105e18:	c3                   	ret
80105e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105e20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e25:	eb ed                	jmp    80105e14 <sys_sbrk+0x34>
80105e27:	90                   	nop
80105e28:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105e2f:	00 

80105e30 <sys_sleep>:

int sys_sleep(void)
{
80105e30:	55                   	push   %ebp
80105e31:	89 e5                	mov    %esp,%ebp
80105e33:	53                   	push   %ebx
  int n;
  uint ticks0;

  if (argint(0, &n) < 0)
80105e34:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105e37:	83 ec 1c             	sub    $0x1c,%esp
  if (argint(0, &n) < 0)
80105e3a:	50                   	push   %eax
80105e3b:	6a 00                	push   $0x0
80105e3d:	e8 8e f1 ff ff       	call   80104fd0 <argint>
80105e42:	83 c4 10             	add    $0x10,%esp
80105e45:	85 c0                	test   %eax,%eax
80105e47:	78 64                	js     80105ead <sys_sleep+0x7d>
    return -1;
  acquire(&tickslock);
80105e49:	83 ec 0c             	sub    $0xc,%esp
80105e4c:	68 a0 4f 11 80       	push   $0x80114fa0
80105e51:	e8 8a ed ff ff       	call   80104be0 <acquire>
  ticks0 = ticks;
  while (ticks - ticks0 < n)
80105e56:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105e59:	83 c4 10             	add    $0x10,%esp
80105e5c:	85 d2                	test   %edx,%edx
80105e5e:	74 58                	je     80105eb8 <sys_sleep+0x88>
  ticks0 = ticks;
80105e60:	8b 1d 80 4f 11 80    	mov    0x80114f80,%ebx
80105e66:	eb 29                	jmp    80105e91 <sys_sleep+0x61>
80105e68:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105e6f:	00 
    if (myproc()->killed)
    {
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105e70:	83 ec 08             	sub    $0x8,%esp
80105e73:	68 a0 4f 11 80       	push   $0x80114fa0
80105e78:	68 80 4f 11 80       	push   $0x80114f80
80105e7d:	e8 8e e5 ff ff       	call   80104410 <sleep>
  while (ticks - ticks0 < n)
80105e82:	a1 80 4f 11 80       	mov    0x80114f80,%eax
80105e87:	83 c4 10             	add    $0x10,%esp
80105e8a:	29 d8                	sub    %ebx,%eax
80105e8c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105e8f:	73 27                	jae    80105eb8 <sys_sleep+0x88>
    if (myproc()->killed)
80105e91:	e8 aa dd ff ff       	call   80103c40 <myproc>
80105e96:	8b 40 24             	mov    0x24(%eax),%eax
80105e99:	85 c0                	test   %eax,%eax
80105e9b:	74 d3                	je     80105e70 <sys_sleep+0x40>
      release(&tickslock);
80105e9d:	83 ec 0c             	sub    $0xc,%esp
80105ea0:	68 a0 4f 11 80       	push   $0x80114fa0
80105ea5:	e8 d6 ec ff ff       	call   80104b80 <release>
      return -1;
80105eaa:	83 c4 10             	add    $0x10,%esp
    return -1;
80105ead:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105eb2:	eb 16                	jmp    80105eca <sys_sleep+0x9a>
80105eb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  release(&tickslock);
80105eb8:	83 ec 0c             	sub    $0xc,%esp
80105ebb:	68 a0 4f 11 80       	push   $0x80114fa0
80105ec0:	e8 bb ec ff ff       	call   80104b80 <release>
  return 0;
80105ec5:	83 c4 10             	add    $0x10,%esp
80105ec8:	31 c0                	xor    %eax,%eax
}
80105eca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105ecd:	c9                   	leave
80105ece:	c3                   	ret
80105ecf:	90                   	nop

80105ed0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int sys_uptime(void)
{
80105ed0:	55                   	push   %ebp
80105ed1:	89 e5                	mov    %esp,%ebp
80105ed3:	53                   	push   %ebx
80105ed4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105ed7:	68 a0 4f 11 80       	push   $0x80114fa0
80105edc:	e8 ff ec ff ff       	call   80104be0 <acquire>
  xticks = ticks;
80105ee1:	8b 1d 80 4f 11 80    	mov    0x80114f80,%ebx
  release(&tickslock);
80105ee7:	c7 04 24 a0 4f 11 80 	movl   $0x80114fa0,(%esp)
80105eee:	e8 8d ec ff ff       	call   80104b80 <release>
  return xticks;
}
80105ef3:	89 d8                	mov    %ebx,%eax
80105ef5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105ef8:	c9                   	leave
80105ef9:	c3                   	ret
80105efa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105f00 <sys_nice>:

int sys_nice(void)
{
80105f00:	55                   	push   %ebp
80105f01:	89 e5                	mov    %esp,%ebp
80105f03:	83 ec 20             	sub    $0x20,%esp
  int pid, priority;
  if (argint(0, &pid) < 0)
80105f06:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105f09:	50                   	push   %eax
80105f0a:	6a 00                	push   $0x0
80105f0c:	e8 bf f0 ff ff       	call   80104fd0 <argint>
80105f11:	83 c4 10             	add    $0x10,%esp
80105f14:	85 c0                	test   %eax,%eax
80105f16:	78 28                	js     80105f40 <sys_nice+0x40>
    return -1;
  if (argint(1, &priority) < 0)
80105f18:	83 ec 08             	sub    $0x8,%esp
80105f1b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f1e:	50                   	push   %eax
80105f1f:	6a 01                	push   $0x1
80105f21:	e8 aa f0 ff ff       	call   80104fd0 <argint>
80105f26:	83 c4 10             	add    $0x10,%esp
80105f29:	85 c0                	test   %eax,%eax
80105f2b:	78 13                	js     80105f40 <sys_nice+0x40>
    return -1;
  return nice(pid, priority);
80105f2d:	83 ec 08             	sub    $0x8,%esp
80105f30:	ff 75 f4             	push   -0xc(%ebp)
80105f33:	ff 75 f0             	push   -0x10(%ebp)
80105f36:	e8 a5 e8 ff ff       	call   801047e0 <nice>
80105f3b:	83 c4 10             	add    $0x10,%esp
80105f3e:	c9                   	leave
80105f3f:	c3                   	ret
80105f40:	c9                   	leave
    return -1;
80105f41:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f46:	c3                   	ret

80105f47 <alltraps>:
80105f47:	1e                   	push   %ds
80105f48:	06                   	push   %es
80105f49:	0f a0                	push   %fs
80105f4b:	0f a8                	push   %gs
80105f4d:	60                   	pusha
80105f4e:	66 b8 10 00          	mov    $0x10,%ax
80105f52:	8e d8                	mov    %eax,%ds
80105f54:	8e c0                	mov    %eax,%es
80105f56:	54                   	push   %esp
80105f57:	e8 04 01 00 00       	call   80106060 <trap>
80105f5c:	83 c4 04             	add    $0x4,%esp

80105f5f <trapret>:
80105f5f:	61                   	popa
80105f60:	0f a9                	pop    %gs
80105f62:	0f a1                	pop    %fs
80105f64:	07                   	pop    %es
80105f65:	1f                   	pop    %ds
80105f66:	83 c4 08             	add    $0x8,%esp
80105f69:	cf                   	iret
80105f6a:	66 90                	xchg   %ax,%ax
80105f6c:	66 90                	xchg   %ax,%ax
80105f6e:	66 90                	xchg   %ax,%ax
80105f70:	66 90                	xchg   %ax,%ax
80105f72:	66 90                	xchg   %ax,%ax
80105f74:	66 90                	xchg   %ax,%ax
80105f76:	66 90                	xchg   %ax,%ax
80105f78:	66 90                	xchg   %ax,%ax
80105f7a:	66 90                	xchg   %ax,%ax
80105f7c:	66 90                	xchg   %ax,%ax
80105f7e:	66 90                	xchg   %ax,%ax

80105f80 <tvinit>:
extern uint vectors[]; // in vectors.S: array of 256 entry pointers
struct spinlock tickslock;
uint ticks;

void tvinit(void)
{
80105f80:	55                   	push   %ebp
  int i;

  for (i = 0; i < 256; i++)
80105f81:	31 c0                	xor    %eax,%eax
{
80105f83:	89 e5                	mov    %esp,%ebp
80105f85:	83 ec 08             	sub    $0x8,%esp
80105f88:	eb 36                	jmp    80105fc0 <tvinit+0x40>
80105f8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105f90:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105f97:	00 
80105f98:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105f9f:	00 
80105fa0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105fa7:	00 
80105fa8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105faf:	00 
80105fb0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105fb7:	00 
80105fb8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105fbf:	00 
    SETGATE(idt[i], 0, SEG_KCODE << 3, vectors[i], 0);
80105fc0:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
80105fc7:	c7 04 c5 e2 4f 11 80 	movl   $0x8e000008,-0x7feeb01e(,%eax,8)
80105fce:	08 00 00 8e 
80105fd2:	66 89 14 c5 e0 4f 11 	mov    %dx,-0x7feeb020(,%eax,8)
80105fd9:	80 
80105fda:	c1 ea 10             	shr    $0x10,%edx
80105fdd:	66 89 14 c5 e6 4f 11 	mov    %dx,-0x7feeb01a(,%eax,8)
80105fe4:	80 
  for (i = 0; i < 256; i++)
80105fe5:	83 c0 01             	add    $0x1,%eax
80105fe8:	3d 00 01 00 00       	cmp    $0x100,%eax
80105fed:	75 d1                	jne    80105fc0 <tvinit+0x40>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE << 3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
80105fef:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE << 3, vectors[T_SYSCALL], DPL_USER);
80105ff2:	a1 08 b1 10 80       	mov    0x8010b108,%eax
80105ff7:	c7 05 e2 51 11 80 08 	movl   $0xef000008,0x801151e2
80105ffe:	00 00 ef 
  initlock(&tickslock, "time");
80106001:	68 09 7d 10 80       	push   $0x80107d09
80106006:	68 a0 4f 11 80       	push   $0x80114fa0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE << 3, vectors[T_SYSCALL], DPL_USER);
8010600b:	66 a3 e0 51 11 80    	mov    %ax,0x801151e0
80106011:	c1 e8 10             	shr    $0x10,%eax
80106014:	66 a3 e6 51 11 80    	mov    %ax,0x801151e6
  initlock(&tickslock, "time");
8010601a:	e8 a1 e9 ff ff       	call   801049c0 <initlock>
}
8010601f:	83 c4 10             	add    $0x10,%esp
80106022:	c9                   	leave
80106023:	c3                   	ret
80106024:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106028:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010602f:	00 

80106030 <idtinit>:

void idtinit(void)
{
80106030:	55                   	push   %ebp
  pd[0] = size-1;
80106031:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80106036:	89 e5                	mov    %esp,%ebp
80106038:	83 ec 10             	sub    $0x10,%esp
8010603b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010603f:	b8 e0 4f 11 80       	mov    $0x80114fe0,%eax
80106044:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106048:	c1 e8 10             	shr    $0x10,%eax
8010604b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
8010604f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106052:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106055:	c9                   	leave
80106056:	c3                   	ret
80106057:	90                   	nop
80106058:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010605f:	00 

80106060 <trap>:

// PAGEBREAK: 41
void trap(struct trapframe *tf)
{
80106060:	55                   	push   %ebp
80106061:	89 e5                	mov    %esp,%ebp
80106063:	57                   	push   %edi
80106064:	56                   	push   %esi
80106065:	53                   	push   %ebx
80106066:	83 ec 1c             	sub    $0x1c,%esp
80106069:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (tf->trapno == T_SYSCALL)
8010606c:	8b 43 30             	mov    0x30(%ebx),%eax
8010606f:	83 f8 40             	cmp    $0x40,%eax
80106072:	0f 84 68 01 00 00    	je     801061e0 <trap+0x180>
    if (myproc()->killed)
      exit();
    return;
  }

  switch (tf->trapno)
80106078:	83 e8 20             	sub    $0x20,%eax
8010607b:	83 f8 1f             	cmp    $0x1f,%eax
8010607e:	0f 87 7c 00 00 00    	ja     80106100 <trap+0xa0>
80106084:	ff 24 85 60 82 10 80 	jmp    *-0x7fef7da0(,%eax,4)
8010608b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80106090:	e8 7b c3 ff ff       	call   80102410 <ideintr>
    lapiceoi();
80106095:	e8 86 ca ff ff       	call   80102b20 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if (myproc() && myproc()->killed && (tf->cs & 3) == DPL_USER)
8010609a:	e8 a1 db ff ff       	call   80103c40 <myproc>
8010609f:	85 c0                	test   %eax,%eax
801060a1:	74 1a                	je     801060bd <trap+0x5d>
801060a3:	e8 98 db ff ff       	call   80103c40 <myproc>
801060a8:	8b 50 24             	mov    0x24(%eax),%edx
801060ab:	85 d2                	test   %edx,%edx
801060ad:	74 0e                	je     801060bd <trap+0x5d>
801060af:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801060b3:	f7 d0                	not    %eax
801060b5:	a8 03                	test   $0x3,%al
801060b7:	0f 84 fb 01 00 00    	je     801062b8 <trap+0x258>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if (myproc() && myproc()->state == RUNNING &&
801060bd:	e8 7e db ff ff       	call   80103c40 <myproc>
801060c2:	85 c0                	test   %eax,%eax
801060c4:	74 0f                	je     801060d5 <trap+0x75>
801060c6:	e8 75 db ff ff       	call   80103c40 <myproc>
801060cb:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
801060cf:	0f 84 ab 00 00 00    	je     80106180 <trap+0x120>
      tf->trapno == T_IRQ0 + IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if (myproc() && myproc()->killed && (tf->cs & 3) == DPL_USER)
801060d5:	e8 66 db ff ff       	call   80103c40 <myproc>
801060da:	85 c0                	test   %eax,%eax
801060dc:	74 1a                	je     801060f8 <trap+0x98>
801060de:	e8 5d db ff ff       	call   80103c40 <myproc>
801060e3:	8b 40 24             	mov    0x24(%eax),%eax
801060e6:	85 c0                	test   %eax,%eax
801060e8:	74 0e                	je     801060f8 <trap+0x98>
801060ea:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801060ee:	f7 d0                	not    %eax
801060f0:	a8 03                	test   $0x3,%al
801060f2:	0f 84 15 01 00 00    	je     8010620d <trap+0x1ad>
    exit();
}
801060f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801060fb:	5b                   	pop    %ebx
801060fc:	5e                   	pop    %esi
801060fd:	5f                   	pop    %edi
801060fe:	5d                   	pop    %ebp
801060ff:	c3                   	ret
    if (myproc() == 0 || (tf->cs & 3) == 0)
80106100:	e8 3b db ff ff       	call   80103c40 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106105:	8b 73 38             	mov    0x38(%ebx),%esi
80106108:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    if (myproc() == 0 || (tf->cs & 3) == 0)
8010610b:	85 c0                	test   %eax,%eax
8010610d:	0f 84 d0 01 00 00    	je     801062e3 <trap+0x283>
80106113:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80106117:	0f 84 c6 01 00 00    	je     801062e3 <trap+0x283>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010611d:	0f 20 d7             	mov    %cr2,%edi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106120:	e8 fb da ff ff       	call   80103c20 <cpuid>
80106125:	8b 4b 30             	mov    0x30(%ebx),%ecx
80106128:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010612b:	8b 43 34             	mov    0x34(%ebx),%eax
8010612e:	89 4d dc             	mov    %ecx,-0x24(%ebp)
80106131:	89 45 e0             	mov    %eax,-0x20(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80106134:	e8 07 db ff ff       	call   80103c40 <myproc>
80106139:	8d 70 70             	lea    0x70(%eax),%esi
8010613c:	e8 ff da ff ff       	call   80103c40 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106141:	57                   	push   %edi
80106142:	ff 75 e4             	push   -0x1c(%ebp)
80106145:	8b 55 d8             	mov    -0x28(%ebp),%edx
80106148:	52                   	push   %edx
80106149:	ff 75 e0             	push   -0x20(%ebp)
8010614c:	8b 4d dc             	mov    -0x24(%ebp),%ecx
8010614f:	51                   	push   %ecx
80106150:	56                   	push   %esi
80106151:	ff 70 10             	push   0x10(%eax)
80106154:	68 38 7f 10 80       	push   $0x80107f38
80106159:	e8 72 a5 ff ff       	call   801006d0 <cprintf>
    myproc()->killed = 1;
8010615e:	83 c4 20             	add    $0x20,%esp
80106161:	e8 da da ff ff       	call   80103c40 <myproc>
80106166:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if (myproc() && myproc()->killed && (tf->cs & 3) == DPL_USER)
8010616d:	e8 ce da ff ff       	call   80103c40 <myproc>
80106172:	85 c0                	test   %eax,%eax
80106174:	0f 85 29 ff ff ff    	jne    801060a3 <trap+0x43>
8010617a:	e9 3e ff ff ff       	jmp    801060bd <trap+0x5d>
8010617f:	90                   	nop
  if (myproc() && myproc()->state == RUNNING &&
80106180:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106184:	0f 85 4b ff ff ff    	jne    801060d5 <trap+0x75>
    yield();
8010618a:	e8 31 e2 ff ff       	call   801043c0 <yield>
8010618f:	e9 41 ff ff ff       	jmp    801060d5 <trap+0x75>
80106194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106198:	8b 4b 38             	mov    0x38(%ebx),%ecx
8010619b:	0f b7 53 3c          	movzwl 0x3c(%ebx),%edx
8010619f:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801061a2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801061a5:	e8 76 da ff ff       	call   80103c20 <cpuid>
801061aa:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801061ad:	51                   	push   %ecx
801061ae:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801061b1:	52                   	push   %edx
801061b2:	50                   	push   %eax
801061b3:	68 e0 7e 10 80       	push   $0x80107ee0
801061b8:	e8 13 a5 ff ff       	call   801006d0 <cprintf>
    lapiceoi();
801061bd:	e8 5e c9 ff ff       	call   80102b20 <lapiceoi>
    break;
801061c2:	83 c4 10             	add    $0x10,%esp
  if (myproc() && myproc()->killed && (tf->cs & 3) == DPL_USER)
801061c5:	e8 76 da ff ff       	call   80103c40 <myproc>
801061ca:	85 c0                	test   %eax,%eax
801061cc:	0f 85 d1 fe ff ff    	jne    801060a3 <trap+0x43>
801061d2:	e9 e6 fe ff ff       	jmp    801060bd <trap+0x5d>
801061d7:	90                   	nop
801061d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801061df:	00 
    if (myproc()->killed)
801061e0:	e8 5b da ff ff       	call   80103c40 <myproc>
801061e5:	8b 70 24             	mov    0x24(%eax),%esi
801061e8:	85 f6                	test   %esi,%esi
801061ea:	0f 85 d8 00 00 00    	jne    801062c8 <trap+0x268>
    myproc()->tf = tf;
801061f0:	e8 4b da ff ff       	call   80103c40 <myproc>
801061f5:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
801061f8:	e8 13 ef ff ff       	call   80105110 <syscall>
    if (myproc()->killed)
801061fd:	e8 3e da ff ff       	call   80103c40 <myproc>
80106202:	8b 48 24             	mov    0x24(%eax),%ecx
80106205:	85 c9                	test   %ecx,%ecx
80106207:	0f 84 eb fe ff ff    	je     801060f8 <trap+0x98>
}
8010620d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106210:	5b                   	pop    %ebx
80106211:	5e                   	pop    %esi
80106212:	5f                   	pop    %edi
80106213:	5d                   	pop    %ebp
      exit();
80106214:	e9 e7 de ff ff       	jmp    80104100 <exit>
80106219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80106220:	e8 6b 02 00 00       	call   80106490 <uartintr>
    lapiceoi();
80106225:	e8 f6 c8 ff ff       	call   80102b20 <lapiceoi>
  if (myproc() && myproc()->killed && (tf->cs & 3) == DPL_USER)
8010622a:	e8 11 da ff ff       	call   80103c40 <myproc>
8010622f:	85 c0                	test   %eax,%eax
80106231:	0f 85 6c fe ff ff    	jne    801060a3 <trap+0x43>
80106237:	e9 81 fe ff ff       	jmp    801060bd <trap+0x5d>
8010623c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80106240:	e8 9b c7 ff ff       	call   801029e0 <kbdintr>
    lapiceoi();
80106245:	e8 d6 c8 ff ff       	call   80102b20 <lapiceoi>
  if (myproc() && myproc()->killed && (tf->cs & 3) == DPL_USER)
8010624a:	e8 f1 d9 ff ff       	call   80103c40 <myproc>
8010624f:	85 c0                	test   %eax,%eax
80106251:	0f 85 4c fe ff ff    	jne    801060a3 <trap+0x43>
80106257:	e9 61 fe ff ff       	jmp    801060bd <trap+0x5d>
8010625c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (myproc() && myproc()->state == RUNNING)
80106260:	e8 db d9 ff ff       	call   80103c40 <myproc>
80106265:	85 c0                	test   %eax,%eax
80106267:	74 0b                	je     80106274 <trap+0x214>
80106269:	e8 d2 d9 ff ff       	call   80103c40 <myproc>
8010626e:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80106272:	74 64                	je     801062d8 <trap+0x278>
    if (cpuid() == 0)
80106274:	e8 a7 d9 ff ff       	call   80103c20 <cpuid>
80106279:	85 c0                	test   %eax,%eax
8010627b:	0f 85 14 fe ff ff    	jne    80106095 <trap+0x35>
      acquire(&tickslock);
80106281:	83 ec 0c             	sub    $0xc,%esp
80106284:	68 a0 4f 11 80       	push   $0x80114fa0
80106289:	e8 52 e9 ff ff       	call   80104be0 <acquire>
      ticks++;
8010628e:	83 05 80 4f 11 80 01 	addl   $0x1,0x80114f80
      wakeup(&ticks);
80106295:	c7 04 24 80 4f 11 80 	movl   $0x80114f80,(%esp)
8010629c:	e8 2f e2 ff ff       	call   801044d0 <wakeup>
      release(&tickslock);
801062a1:	c7 04 24 a0 4f 11 80 	movl   $0x80114fa0,(%esp)
801062a8:	e8 d3 e8 ff ff       	call   80104b80 <release>
801062ad:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
801062b0:	e9 e0 fd ff ff       	jmp    80106095 <trap+0x35>
801062b5:	8d 76 00             	lea    0x0(%esi),%esi
    exit();
801062b8:	e8 43 de ff ff       	call   80104100 <exit>
801062bd:	e9 fb fd ff ff       	jmp    801060bd <trap+0x5d>
801062c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
801062c8:	e8 33 de ff ff       	call   80104100 <exit>
801062cd:	e9 1e ff ff ff       	jmp    801061f0 <trap+0x190>
801062d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      myproc()->cputicks++; // Incremented CPU ticks on timer interrupts
801062d8:	e8 63 d9 ff ff       	call   80103c40 <myproc>
801062dd:	83 40 28 01          	addl   $0x1,0x28(%eax)
801062e1:	eb 91                	jmp    80106274 <trap+0x214>
801062e3:	0f 20 d2             	mov    %cr2,%edx
801062e6:	89 55 e0             	mov    %edx,-0x20(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801062e9:	e8 32 d9 ff ff       	call   80103c20 <cpuid>
801062ee:	8b 55 e0             	mov    -0x20(%ebp),%edx
801062f1:	83 ec 0c             	sub    $0xc,%esp
801062f4:	52                   	push   %edx
801062f5:	ff 75 e4             	push   -0x1c(%ebp)
801062f8:	50                   	push   %eax
801062f9:	ff 73 30             	push   0x30(%ebx)
801062fc:	68 04 7f 10 80       	push   $0x80107f04
80106301:	e8 ca a3 ff ff       	call   801006d0 <cprintf>
      panic("trap");
80106306:	83 c4 14             	add    $0x14,%esp
80106309:	68 0e 7d 10 80       	push   $0x80107d0e
8010630e:	e8 8d a0 ff ff       	call   801003a0 <panic>
80106313:	66 90                	xchg   %ax,%ax
80106315:	66 90                	xchg   %ax,%ax
80106317:	66 90                	xchg   %ax,%ax
80106319:	66 90                	xchg   %ax,%ax
8010631b:	66 90                	xchg   %ax,%ax
8010631d:	66 90                	xchg   %ax,%ax
8010631f:	90                   	nop

80106320 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106320:	a1 e0 57 11 80       	mov    0x801157e0,%eax
80106325:	85 c0                	test   %eax,%eax
80106327:	74 17                	je     80106340 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106329:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010632e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
8010632f:	a8 01                	test   $0x1,%al
80106331:	74 0d                	je     80106340 <uartgetc+0x20>
80106333:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106338:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80106339:	0f b6 c0             	movzbl %al,%eax
8010633c:	c3                   	ret
8010633d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106340:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106345:	c3                   	ret
80106346:	66 90                	xchg   %ax,%ax
80106348:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010634f:	00 

80106350 <uartinit>:
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106350:	31 c0                	xor    %eax,%eax
80106352:	ba fa 03 00 00       	mov    $0x3fa,%edx
80106357:	ee                   	out    %al,(%dx)
80106358:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010635d:	ba fb 03 00 00       	mov    $0x3fb,%edx
80106362:	ee                   	out    %al,(%dx)
80106363:	b8 0c 00 00 00       	mov    $0xc,%eax
80106368:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010636d:	ee                   	out    %al,(%dx)
8010636e:	31 c0                	xor    %eax,%eax
80106370:	ba f9 03 00 00       	mov    $0x3f9,%edx
80106375:	ee                   	out    %al,(%dx)
80106376:	b8 03 00 00 00       	mov    $0x3,%eax
8010637b:	ba fb 03 00 00       	mov    $0x3fb,%edx
80106380:	ee                   	out    %al,(%dx)
80106381:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106386:	31 c0                	xor    %eax,%eax
80106388:	ee                   	out    %al,(%dx)
80106389:	b8 01 00 00 00       	mov    $0x1,%eax
8010638e:	ba f9 03 00 00       	mov    $0x3f9,%edx
80106393:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106394:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106399:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
8010639a:	3c ff                	cmp    $0xff,%al
8010639c:	0f 84 8e 00 00 00    	je     80106430 <uartinit+0xe0>
{
801063a2:	55                   	push   %ebp
801063a3:	ba fa 03 00 00       	mov    $0x3fa,%edx
801063a8:	89 e5                	mov    %esp,%ebp
801063aa:	57                   	push   %edi
801063ab:	56                   	push   %esi
801063ac:	53                   	push   %ebx
801063ad:	83 ec 24             	sub    $0x24,%esp
  uart = 1;
801063b0:	c7 05 e0 57 11 80 01 	movl   $0x1,0x801157e0
801063b7:	00 00 00 
801063ba:	ec                   	in     (%dx),%al
801063bb:	ba f8 03 00 00       	mov    $0x3f8,%edx
801063c0:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
801063c1:	6a 00                	push   $0x0
  for(p="xv6...\n"; *p; p++)
801063c3:	bf 13 7d 10 80       	mov    $0x80107d13,%edi
  ioapicenable(IRQ_COM1, 0);
801063c8:	6a 04                	push   $0x4
801063ca:	e8 b1 c2 ff ff       	call   80102680 <ioapicenable>
801063cf:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
801063d2:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
801063d6:	66 90                	xchg   %ax,%ax
801063d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801063df:	00 
  if(!uart)
801063e0:	a1 e0 57 11 80       	mov    0x801157e0,%eax
801063e5:	bb 80 00 00 00       	mov    $0x80,%ebx
801063ea:	85 c0                	test   %eax,%eax
801063ec:	75 14                	jne    80106402 <uartinit+0xb2>
801063ee:	eb 26                	jmp    80106416 <uartinit+0xc6>
    microdelay(10);
801063f0:	83 ec 0c             	sub    $0xc,%esp
801063f3:	6a 0a                	push   $0xa
801063f5:	e8 46 c7 ff ff       	call   80102b40 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801063fa:	83 c4 10             	add    $0x10,%esp
801063fd:	83 eb 01             	sub    $0x1,%ebx
80106400:	74 0a                	je     8010640c <uartinit+0xbc>
80106402:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106407:	ec                   	in     (%dx),%al
80106408:	a8 20                	test   $0x20,%al
8010640a:	74 e4                	je     801063f0 <uartinit+0xa0>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010640c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
80106410:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106415:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
80106416:	0f b6 47 01          	movzbl 0x1(%edi),%eax
8010641a:	83 c7 01             	add    $0x1,%edi
8010641d:	88 45 e7             	mov    %al,-0x19(%ebp)
80106420:	81 ff 1a 7d 10 80    	cmp    $0x80107d1a,%edi
80106426:	75 b8                	jne    801063e0 <uartinit+0x90>
}
80106428:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010642b:	5b                   	pop    %ebx
8010642c:	5e                   	pop    %esi
8010642d:	5f                   	pop    %edi
8010642e:	5d                   	pop    %ebp
8010642f:	c3                   	ret
80106430:	c3                   	ret
80106431:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106438:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010643f:	00 

80106440 <uartputc>:
  if(!uart)
80106440:	a1 e0 57 11 80       	mov    0x801157e0,%eax
80106445:	85 c0                	test   %eax,%eax
80106447:	74 3f                	je     80106488 <uartputc+0x48>
{
80106449:	55                   	push   %ebp
8010644a:	89 e5                	mov    %esp,%ebp
8010644c:	56                   	push   %esi
8010644d:	53                   	push   %ebx
8010644e:	bb 80 00 00 00       	mov    $0x80,%ebx
80106453:	eb 15                	jmp    8010646a <uartputc+0x2a>
80106455:	8d 76 00             	lea    0x0(%esi),%esi
    microdelay(10);
80106458:	83 ec 0c             	sub    $0xc,%esp
8010645b:	6a 0a                	push   $0xa
8010645d:	e8 de c6 ff ff       	call   80102b40 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106462:	83 c4 10             	add    $0x10,%esp
80106465:	83 eb 01             	sub    $0x1,%ebx
80106468:	74 0a                	je     80106474 <uartputc+0x34>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010646a:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010646f:	ec                   	in     (%dx),%al
80106470:	a8 20                	test   $0x20,%al
80106472:	74 e4                	je     80106458 <uartputc+0x18>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106474:	8b 45 08             	mov    0x8(%ebp),%eax
80106477:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010647c:	ee                   	out    %al,(%dx)
}
8010647d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106480:	5b                   	pop    %ebx
80106481:	5e                   	pop    %esi
80106482:	5d                   	pop    %ebp
80106483:	c3                   	ret
80106484:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106488:	c3                   	ret
80106489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106490 <uartintr>:

void
uartintr(void)
{
80106490:	55                   	push   %ebp
80106491:	89 e5                	mov    %esp,%ebp
80106493:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106496:	68 20 63 10 80       	push   $0x80106320
8010649b:	e8 30 a4 ff ff       	call   801008d0 <consoleintr>
}
801064a0:	83 c4 10             	add    $0x10,%esp
801064a3:	c9                   	leave
801064a4:	c3                   	ret

801064a5 <vector0>:
801064a5:	6a 00                	push   $0x0
801064a7:	6a 00                	push   $0x0
801064a9:	e9 99 fa ff ff       	jmp    80105f47 <alltraps>

801064ae <vector1>:
801064ae:	6a 00                	push   $0x0
801064b0:	6a 01                	push   $0x1
801064b2:	e9 90 fa ff ff       	jmp    80105f47 <alltraps>

801064b7 <vector2>:
801064b7:	6a 00                	push   $0x0
801064b9:	6a 02                	push   $0x2
801064bb:	e9 87 fa ff ff       	jmp    80105f47 <alltraps>

801064c0 <vector3>:
801064c0:	6a 00                	push   $0x0
801064c2:	6a 03                	push   $0x3
801064c4:	e9 7e fa ff ff       	jmp    80105f47 <alltraps>

801064c9 <vector4>:
801064c9:	6a 00                	push   $0x0
801064cb:	6a 04                	push   $0x4
801064cd:	e9 75 fa ff ff       	jmp    80105f47 <alltraps>

801064d2 <vector5>:
801064d2:	6a 00                	push   $0x0
801064d4:	6a 05                	push   $0x5
801064d6:	e9 6c fa ff ff       	jmp    80105f47 <alltraps>

801064db <vector6>:
801064db:	6a 00                	push   $0x0
801064dd:	6a 06                	push   $0x6
801064df:	e9 63 fa ff ff       	jmp    80105f47 <alltraps>

801064e4 <vector7>:
801064e4:	6a 00                	push   $0x0
801064e6:	6a 07                	push   $0x7
801064e8:	e9 5a fa ff ff       	jmp    80105f47 <alltraps>

801064ed <vector8>:
801064ed:	6a 08                	push   $0x8
801064ef:	e9 53 fa ff ff       	jmp    80105f47 <alltraps>

801064f4 <vector9>:
801064f4:	6a 00                	push   $0x0
801064f6:	6a 09                	push   $0x9
801064f8:	e9 4a fa ff ff       	jmp    80105f47 <alltraps>

801064fd <vector10>:
801064fd:	6a 0a                	push   $0xa
801064ff:	e9 43 fa ff ff       	jmp    80105f47 <alltraps>

80106504 <vector11>:
80106504:	6a 0b                	push   $0xb
80106506:	e9 3c fa ff ff       	jmp    80105f47 <alltraps>

8010650b <vector12>:
8010650b:	6a 0c                	push   $0xc
8010650d:	e9 35 fa ff ff       	jmp    80105f47 <alltraps>

80106512 <vector13>:
80106512:	6a 0d                	push   $0xd
80106514:	e9 2e fa ff ff       	jmp    80105f47 <alltraps>

80106519 <vector14>:
80106519:	6a 0e                	push   $0xe
8010651b:	e9 27 fa ff ff       	jmp    80105f47 <alltraps>

80106520 <vector15>:
80106520:	6a 00                	push   $0x0
80106522:	6a 0f                	push   $0xf
80106524:	e9 1e fa ff ff       	jmp    80105f47 <alltraps>

80106529 <vector16>:
80106529:	6a 00                	push   $0x0
8010652b:	6a 10                	push   $0x10
8010652d:	e9 15 fa ff ff       	jmp    80105f47 <alltraps>

80106532 <vector17>:
80106532:	6a 11                	push   $0x11
80106534:	e9 0e fa ff ff       	jmp    80105f47 <alltraps>

80106539 <vector18>:
80106539:	6a 00                	push   $0x0
8010653b:	6a 12                	push   $0x12
8010653d:	e9 05 fa ff ff       	jmp    80105f47 <alltraps>

80106542 <vector19>:
80106542:	6a 00                	push   $0x0
80106544:	6a 13                	push   $0x13
80106546:	e9 fc f9 ff ff       	jmp    80105f47 <alltraps>

8010654b <vector20>:
8010654b:	6a 00                	push   $0x0
8010654d:	6a 14                	push   $0x14
8010654f:	e9 f3 f9 ff ff       	jmp    80105f47 <alltraps>

80106554 <vector21>:
80106554:	6a 00                	push   $0x0
80106556:	6a 15                	push   $0x15
80106558:	e9 ea f9 ff ff       	jmp    80105f47 <alltraps>

8010655d <vector22>:
8010655d:	6a 00                	push   $0x0
8010655f:	6a 16                	push   $0x16
80106561:	e9 e1 f9 ff ff       	jmp    80105f47 <alltraps>

80106566 <vector23>:
80106566:	6a 00                	push   $0x0
80106568:	6a 17                	push   $0x17
8010656a:	e9 d8 f9 ff ff       	jmp    80105f47 <alltraps>

8010656f <vector24>:
8010656f:	6a 00                	push   $0x0
80106571:	6a 18                	push   $0x18
80106573:	e9 cf f9 ff ff       	jmp    80105f47 <alltraps>

80106578 <vector25>:
80106578:	6a 00                	push   $0x0
8010657a:	6a 19                	push   $0x19
8010657c:	e9 c6 f9 ff ff       	jmp    80105f47 <alltraps>

80106581 <vector26>:
80106581:	6a 00                	push   $0x0
80106583:	6a 1a                	push   $0x1a
80106585:	e9 bd f9 ff ff       	jmp    80105f47 <alltraps>

8010658a <vector27>:
8010658a:	6a 00                	push   $0x0
8010658c:	6a 1b                	push   $0x1b
8010658e:	e9 b4 f9 ff ff       	jmp    80105f47 <alltraps>

80106593 <vector28>:
80106593:	6a 00                	push   $0x0
80106595:	6a 1c                	push   $0x1c
80106597:	e9 ab f9 ff ff       	jmp    80105f47 <alltraps>

8010659c <vector29>:
8010659c:	6a 00                	push   $0x0
8010659e:	6a 1d                	push   $0x1d
801065a0:	e9 a2 f9 ff ff       	jmp    80105f47 <alltraps>

801065a5 <vector30>:
801065a5:	6a 00                	push   $0x0
801065a7:	6a 1e                	push   $0x1e
801065a9:	e9 99 f9 ff ff       	jmp    80105f47 <alltraps>

801065ae <vector31>:
801065ae:	6a 00                	push   $0x0
801065b0:	6a 1f                	push   $0x1f
801065b2:	e9 90 f9 ff ff       	jmp    80105f47 <alltraps>

801065b7 <vector32>:
801065b7:	6a 00                	push   $0x0
801065b9:	6a 20                	push   $0x20
801065bb:	e9 87 f9 ff ff       	jmp    80105f47 <alltraps>

801065c0 <vector33>:
801065c0:	6a 00                	push   $0x0
801065c2:	6a 21                	push   $0x21
801065c4:	e9 7e f9 ff ff       	jmp    80105f47 <alltraps>

801065c9 <vector34>:
801065c9:	6a 00                	push   $0x0
801065cb:	6a 22                	push   $0x22
801065cd:	e9 75 f9 ff ff       	jmp    80105f47 <alltraps>

801065d2 <vector35>:
801065d2:	6a 00                	push   $0x0
801065d4:	6a 23                	push   $0x23
801065d6:	e9 6c f9 ff ff       	jmp    80105f47 <alltraps>

801065db <vector36>:
801065db:	6a 00                	push   $0x0
801065dd:	6a 24                	push   $0x24
801065df:	e9 63 f9 ff ff       	jmp    80105f47 <alltraps>

801065e4 <vector37>:
801065e4:	6a 00                	push   $0x0
801065e6:	6a 25                	push   $0x25
801065e8:	e9 5a f9 ff ff       	jmp    80105f47 <alltraps>

801065ed <vector38>:
801065ed:	6a 00                	push   $0x0
801065ef:	6a 26                	push   $0x26
801065f1:	e9 51 f9 ff ff       	jmp    80105f47 <alltraps>

801065f6 <vector39>:
801065f6:	6a 00                	push   $0x0
801065f8:	6a 27                	push   $0x27
801065fa:	e9 48 f9 ff ff       	jmp    80105f47 <alltraps>

801065ff <vector40>:
801065ff:	6a 00                	push   $0x0
80106601:	6a 28                	push   $0x28
80106603:	e9 3f f9 ff ff       	jmp    80105f47 <alltraps>

80106608 <vector41>:
80106608:	6a 00                	push   $0x0
8010660a:	6a 29                	push   $0x29
8010660c:	e9 36 f9 ff ff       	jmp    80105f47 <alltraps>

80106611 <vector42>:
80106611:	6a 00                	push   $0x0
80106613:	6a 2a                	push   $0x2a
80106615:	e9 2d f9 ff ff       	jmp    80105f47 <alltraps>

8010661a <vector43>:
8010661a:	6a 00                	push   $0x0
8010661c:	6a 2b                	push   $0x2b
8010661e:	e9 24 f9 ff ff       	jmp    80105f47 <alltraps>

80106623 <vector44>:
80106623:	6a 00                	push   $0x0
80106625:	6a 2c                	push   $0x2c
80106627:	e9 1b f9 ff ff       	jmp    80105f47 <alltraps>

8010662c <vector45>:
8010662c:	6a 00                	push   $0x0
8010662e:	6a 2d                	push   $0x2d
80106630:	e9 12 f9 ff ff       	jmp    80105f47 <alltraps>

80106635 <vector46>:
80106635:	6a 00                	push   $0x0
80106637:	6a 2e                	push   $0x2e
80106639:	e9 09 f9 ff ff       	jmp    80105f47 <alltraps>

8010663e <vector47>:
8010663e:	6a 00                	push   $0x0
80106640:	6a 2f                	push   $0x2f
80106642:	e9 00 f9 ff ff       	jmp    80105f47 <alltraps>

80106647 <vector48>:
80106647:	6a 00                	push   $0x0
80106649:	6a 30                	push   $0x30
8010664b:	e9 f7 f8 ff ff       	jmp    80105f47 <alltraps>

80106650 <vector49>:
80106650:	6a 00                	push   $0x0
80106652:	6a 31                	push   $0x31
80106654:	e9 ee f8 ff ff       	jmp    80105f47 <alltraps>

80106659 <vector50>:
80106659:	6a 00                	push   $0x0
8010665b:	6a 32                	push   $0x32
8010665d:	e9 e5 f8 ff ff       	jmp    80105f47 <alltraps>

80106662 <vector51>:
80106662:	6a 00                	push   $0x0
80106664:	6a 33                	push   $0x33
80106666:	e9 dc f8 ff ff       	jmp    80105f47 <alltraps>

8010666b <vector52>:
8010666b:	6a 00                	push   $0x0
8010666d:	6a 34                	push   $0x34
8010666f:	e9 d3 f8 ff ff       	jmp    80105f47 <alltraps>

80106674 <vector53>:
80106674:	6a 00                	push   $0x0
80106676:	6a 35                	push   $0x35
80106678:	e9 ca f8 ff ff       	jmp    80105f47 <alltraps>

8010667d <vector54>:
8010667d:	6a 00                	push   $0x0
8010667f:	6a 36                	push   $0x36
80106681:	e9 c1 f8 ff ff       	jmp    80105f47 <alltraps>

80106686 <vector55>:
80106686:	6a 00                	push   $0x0
80106688:	6a 37                	push   $0x37
8010668a:	e9 b8 f8 ff ff       	jmp    80105f47 <alltraps>

8010668f <vector56>:
8010668f:	6a 00                	push   $0x0
80106691:	6a 38                	push   $0x38
80106693:	e9 af f8 ff ff       	jmp    80105f47 <alltraps>

80106698 <vector57>:
80106698:	6a 00                	push   $0x0
8010669a:	6a 39                	push   $0x39
8010669c:	e9 a6 f8 ff ff       	jmp    80105f47 <alltraps>

801066a1 <vector58>:
801066a1:	6a 00                	push   $0x0
801066a3:	6a 3a                	push   $0x3a
801066a5:	e9 9d f8 ff ff       	jmp    80105f47 <alltraps>

801066aa <vector59>:
801066aa:	6a 00                	push   $0x0
801066ac:	6a 3b                	push   $0x3b
801066ae:	e9 94 f8 ff ff       	jmp    80105f47 <alltraps>

801066b3 <vector60>:
801066b3:	6a 00                	push   $0x0
801066b5:	6a 3c                	push   $0x3c
801066b7:	e9 8b f8 ff ff       	jmp    80105f47 <alltraps>

801066bc <vector61>:
801066bc:	6a 00                	push   $0x0
801066be:	6a 3d                	push   $0x3d
801066c0:	e9 82 f8 ff ff       	jmp    80105f47 <alltraps>

801066c5 <vector62>:
801066c5:	6a 00                	push   $0x0
801066c7:	6a 3e                	push   $0x3e
801066c9:	e9 79 f8 ff ff       	jmp    80105f47 <alltraps>

801066ce <vector63>:
801066ce:	6a 00                	push   $0x0
801066d0:	6a 3f                	push   $0x3f
801066d2:	e9 70 f8 ff ff       	jmp    80105f47 <alltraps>

801066d7 <vector64>:
801066d7:	6a 00                	push   $0x0
801066d9:	6a 40                	push   $0x40
801066db:	e9 67 f8 ff ff       	jmp    80105f47 <alltraps>

801066e0 <vector65>:
801066e0:	6a 00                	push   $0x0
801066e2:	6a 41                	push   $0x41
801066e4:	e9 5e f8 ff ff       	jmp    80105f47 <alltraps>

801066e9 <vector66>:
801066e9:	6a 00                	push   $0x0
801066eb:	6a 42                	push   $0x42
801066ed:	e9 55 f8 ff ff       	jmp    80105f47 <alltraps>

801066f2 <vector67>:
801066f2:	6a 00                	push   $0x0
801066f4:	6a 43                	push   $0x43
801066f6:	e9 4c f8 ff ff       	jmp    80105f47 <alltraps>

801066fb <vector68>:
801066fb:	6a 00                	push   $0x0
801066fd:	6a 44                	push   $0x44
801066ff:	e9 43 f8 ff ff       	jmp    80105f47 <alltraps>

80106704 <vector69>:
80106704:	6a 00                	push   $0x0
80106706:	6a 45                	push   $0x45
80106708:	e9 3a f8 ff ff       	jmp    80105f47 <alltraps>

8010670d <vector70>:
8010670d:	6a 00                	push   $0x0
8010670f:	6a 46                	push   $0x46
80106711:	e9 31 f8 ff ff       	jmp    80105f47 <alltraps>

80106716 <vector71>:
80106716:	6a 00                	push   $0x0
80106718:	6a 47                	push   $0x47
8010671a:	e9 28 f8 ff ff       	jmp    80105f47 <alltraps>

8010671f <vector72>:
8010671f:	6a 00                	push   $0x0
80106721:	6a 48                	push   $0x48
80106723:	e9 1f f8 ff ff       	jmp    80105f47 <alltraps>

80106728 <vector73>:
80106728:	6a 00                	push   $0x0
8010672a:	6a 49                	push   $0x49
8010672c:	e9 16 f8 ff ff       	jmp    80105f47 <alltraps>

80106731 <vector74>:
80106731:	6a 00                	push   $0x0
80106733:	6a 4a                	push   $0x4a
80106735:	e9 0d f8 ff ff       	jmp    80105f47 <alltraps>

8010673a <vector75>:
8010673a:	6a 00                	push   $0x0
8010673c:	6a 4b                	push   $0x4b
8010673e:	e9 04 f8 ff ff       	jmp    80105f47 <alltraps>

80106743 <vector76>:
80106743:	6a 00                	push   $0x0
80106745:	6a 4c                	push   $0x4c
80106747:	e9 fb f7 ff ff       	jmp    80105f47 <alltraps>

8010674c <vector77>:
8010674c:	6a 00                	push   $0x0
8010674e:	6a 4d                	push   $0x4d
80106750:	e9 f2 f7 ff ff       	jmp    80105f47 <alltraps>

80106755 <vector78>:
80106755:	6a 00                	push   $0x0
80106757:	6a 4e                	push   $0x4e
80106759:	e9 e9 f7 ff ff       	jmp    80105f47 <alltraps>

8010675e <vector79>:
8010675e:	6a 00                	push   $0x0
80106760:	6a 4f                	push   $0x4f
80106762:	e9 e0 f7 ff ff       	jmp    80105f47 <alltraps>

80106767 <vector80>:
80106767:	6a 00                	push   $0x0
80106769:	6a 50                	push   $0x50
8010676b:	e9 d7 f7 ff ff       	jmp    80105f47 <alltraps>

80106770 <vector81>:
80106770:	6a 00                	push   $0x0
80106772:	6a 51                	push   $0x51
80106774:	e9 ce f7 ff ff       	jmp    80105f47 <alltraps>

80106779 <vector82>:
80106779:	6a 00                	push   $0x0
8010677b:	6a 52                	push   $0x52
8010677d:	e9 c5 f7 ff ff       	jmp    80105f47 <alltraps>

80106782 <vector83>:
80106782:	6a 00                	push   $0x0
80106784:	6a 53                	push   $0x53
80106786:	e9 bc f7 ff ff       	jmp    80105f47 <alltraps>

8010678b <vector84>:
8010678b:	6a 00                	push   $0x0
8010678d:	6a 54                	push   $0x54
8010678f:	e9 b3 f7 ff ff       	jmp    80105f47 <alltraps>

80106794 <vector85>:
80106794:	6a 00                	push   $0x0
80106796:	6a 55                	push   $0x55
80106798:	e9 aa f7 ff ff       	jmp    80105f47 <alltraps>

8010679d <vector86>:
8010679d:	6a 00                	push   $0x0
8010679f:	6a 56                	push   $0x56
801067a1:	e9 a1 f7 ff ff       	jmp    80105f47 <alltraps>

801067a6 <vector87>:
801067a6:	6a 00                	push   $0x0
801067a8:	6a 57                	push   $0x57
801067aa:	e9 98 f7 ff ff       	jmp    80105f47 <alltraps>

801067af <vector88>:
801067af:	6a 00                	push   $0x0
801067b1:	6a 58                	push   $0x58
801067b3:	e9 8f f7 ff ff       	jmp    80105f47 <alltraps>

801067b8 <vector89>:
801067b8:	6a 00                	push   $0x0
801067ba:	6a 59                	push   $0x59
801067bc:	e9 86 f7 ff ff       	jmp    80105f47 <alltraps>

801067c1 <vector90>:
801067c1:	6a 00                	push   $0x0
801067c3:	6a 5a                	push   $0x5a
801067c5:	e9 7d f7 ff ff       	jmp    80105f47 <alltraps>

801067ca <vector91>:
801067ca:	6a 00                	push   $0x0
801067cc:	6a 5b                	push   $0x5b
801067ce:	e9 74 f7 ff ff       	jmp    80105f47 <alltraps>

801067d3 <vector92>:
801067d3:	6a 00                	push   $0x0
801067d5:	6a 5c                	push   $0x5c
801067d7:	e9 6b f7 ff ff       	jmp    80105f47 <alltraps>

801067dc <vector93>:
801067dc:	6a 00                	push   $0x0
801067de:	6a 5d                	push   $0x5d
801067e0:	e9 62 f7 ff ff       	jmp    80105f47 <alltraps>

801067e5 <vector94>:
801067e5:	6a 00                	push   $0x0
801067e7:	6a 5e                	push   $0x5e
801067e9:	e9 59 f7 ff ff       	jmp    80105f47 <alltraps>

801067ee <vector95>:
801067ee:	6a 00                	push   $0x0
801067f0:	6a 5f                	push   $0x5f
801067f2:	e9 50 f7 ff ff       	jmp    80105f47 <alltraps>

801067f7 <vector96>:
801067f7:	6a 00                	push   $0x0
801067f9:	6a 60                	push   $0x60
801067fb:	e9 47 f7 ff ff       	jmp    80105f47 <alltraps>

80106800 <vector97>:
80106800:	6a 00                	push   $0x0
80106802:	6a 61                	push   $0x61
80106804:	e9 3e f7 ff ff       	jmp    80105f47 <alltraps>

80106809 <vector98>:
80106809:	6a 00                	push   $0x0
8010680b:	6a 62                	push   $0x62
8010680d:	e9 35 f7 ff ff       	jmp    80105f47 <alltraps>

80106812 <vector99>:
80106812:	6a 00                	push   $0x0
80106814:	6a 63                	push   $0x63
80106816:	e9 2c f7 ff ff       	jmp    80105f47 <alltraps>

8010681b <vector100>:
8010681b:	6a 00                	push   $0x0
8010681d:	6a 64                	push   $0x64
8010681f:	e9 23 f7 ff ff       	jmp    80105f47 <alltraps>

80106824 <vector101>:
80106824:	6a 00                	push   $0x0
80106826:	6a 65                	push   $0x65
80106828:	e9 1a f7 ff ff       	jmp    80105f47 <alltraps>

8010682d <vector102>:
8010682d:	6a 00                	push   $0x0
8010682f:	6a 66                	push   $0x66
80106831:	e9 11 f7 ff ff       	jmp    80105f47 <alltraps>

80106836 <vector103>:
80106836:	6a 00                	push   $0x0
80106838:	6a 67                	push   $0x67
8010683a:	e9 08 f7 ff ff       	jmp    80105f47 <alltraps>

8010683f <vector104>:
8010683f:	6a 00                	push   $0x0
80106841:	6a 68                	push   $0x68
80106843:	e9 ff f6 ff ff       	jmp    80105f47 <alltraps>

80106848 <vector105>:
80106848:	6a 00                	push   $0x0
8010684a:	6a 69                	push   $0x69
8010684c:	e9 f6 f6 ff ff       	jmp    80105f47 <alltraps>

80106851 <vector106>:
80106851:	6a 00                	push   $0x0
80106853:	6a 6a                	push   $0x6a
80106855:	e9 ed f6 ff ff       	jmp    80105f47 <alltraps>

8010685a <vector107>:
8010685a:	6a 00                	push   $0x0
8010685c:	6a 6b                	push   $0x6b
8010685e:	e9 e4 f6 ff ff       	jmp    80105f47 <alltraps>

80106863 <vector108>:
80106863:	6a 00                	push   $0x0
80106865:	6a 6c                	push   $0x6c
80106867:	e9 db f6 ff ff       	jmp    80105f47 <alltraps>

8010686c <vector109>:
8010686c:	6a 00                	push   $0x0
8010686e:	6a 6d                	push   $0x6d
80106870:	e9 d2 f6 ff ff       	jmp    80105f47 <alltraps>

80106875 <vector110>:
80106875:	6a 00                	push   $0x0
80106877:	6a 6e                	push   $0x6e
80106879:	e9 c9 f6 ff ff       	jmp    80105f47 <alltraps>

8010687e <vector111>:
8010687e:	6a 00                	push   $0x0
80106880:	6a 6f                	push   $0x6f
80106882:	e9 c0 f6 ff ff       	jmp    80105f47 <alltraps>

80106887 <vector112>:
80106887:	6a 00                	push   $0x0
80106889:	6a 70                	push   $0x70
8010688b:	e9 b7 f6 ff ff       	jmp    80105f47 <alltraps>

80106890 <vector113>:
80106890:	6a 00                	push   $0x0
80106892:	6a 71                	push   $0x71
80106894:	e9 ae f6 ff ff       	jmp    80105f47 <alltraps>

80106899 <vector114>:
80106899:	6a 00                	push   $0x0
8010689b:	6a 72                	push   $0x72
8010689d:	e9 a5 f6 ff ff       	jmp    80105f47 <alltraps>

801068a2 <vector115>:
801068a2:	6a 00                	push   $0x0
801068a4:	6a 73                	push   $0x73
801068a6:	e9 9c f6 ff ff       	jmp    80105f47 <alltraps>

801068ab <vector116>:
801068ab:	6a 00                	push   $0x0
801068ad:	6a 74                	push   $0x74
801068af:	e9 93 f6 ff ff       	jmp    80105f47 <alltraps>

801068b4 <vector117>:
801068b4:	6a 00                	push   $0x0
801068b6:	6a 75                	push   $0x75
801068b8:	e9 8a f6 ff ff       	jmp    80105f47 <alltraps>

801068bd <vector118>:
801068bd:	6a 00                	push   $0x0
801068bf:	6a 76                	push   $0x76
801068c1:	e9 81 f6 ff ff       	jmp    80105f47 <alltraps>

801068c6 <vector119>:
801068c6:	6a 00                	push   $0x0
801068c8:	6a 77                	push   $0x77
801068ca:	e9 78 f6 ff ff       	jmp    80105f47 <alltraps>

801068cf <vector120>:
801068cf:	6a 00                	push   $0x0
801068d1:	6a 78                	push   $0x78
801068d3:	e9 6f f6 ff ff       	jmp    80105f47 <alltraps>

801068d8 <vector121>:
801068d8:	6a 00                	push   $0x0
801068da:	6a 79                	push   $0x79
801068dc:	e9 66 f6 ff ff       	jmp    80105f47 <alltraps>

801068e1 <vector122>:
801068e1:	6a 00                	push   $0x0
801068e3:	6a 7a                	push   $0x7a
801068e5:	e9 5d f6 ff ff       	jmp    80105f47 <alltraps>

801068ea <vector123>:
801068ea:	6a 00                	push   $0x0
801068ec:	6a 7b                	push   $0x7b
801068ee:	e9 54 f6 ff ff       	jmp    80105f47 <alltraps>

801068f3 <vector124>:
801068f3:	6a 00                	push   $0x0
801068f5:	6a 7c                	push   $0x7c
801068f7:	e9 4b f6 ff ff       	jmp    80105f47 <alltraps>

801068fc <vector125>:
801068fc:	6a 00                	push   $0x0
801068fe:	6a 7d                	push   $0x7d
80106900:	e9 42 f6 ff ff       	jmp    80105f47 <alltraps>

80106905 <vector126>:
80106905:	6a 00                	push   $0x0
80106907:	6a 7e                	push   $0x7e
80106909:	e9 39 f6 ff ff       	jmp    80105f47 <alltraps>

8010690e <vector127>:
8010690e:	6a 00                	push   $0x0
80106910:	6a 7f                	push   $0x7f
80106912:	e9 30 f6 ff ff       	jmp    80105f47 <alltraps>

80106917 <vector128>:
80106917:	6a 00                	push   $0x0
80106919:	68 80 00 00 00       	push   $0x80
8010691e:	e9 24 f6 ff ff       	jmp    80105f47 <alltraps>

80106923 <vector129>:
80106923:	6a 00                	push   $0x0
80106925:	68 81 00 00 00       	push   $0x81
8010692a:	e9 18 f6 ff ff       	jmp    80105f47 <alltraps>

8010692f <vector130>:
8010692f:	6a 00                	push   $0x0
80106931:	68 82 00 00 00       	push   $0x82
80106936:	e9 0c f6 ff ff       	jmp    80105f47 <alltraps>

8010693b <vector131>:
8010693b:	6a 00                	push   $0x0
8010693d:	68 83 00 00 00       	push   $0x83
80106942:	e9 00 f6 ff ff       	jmp    80105f47 <alltraps>

80106947 <vector132>:
80106947:	6a 00                	push   $0x0
80106949:	68 84 00 00 00       	push   $0x84
8010694e:	e9 f4 f5 ff ff       	jmp    80105f47 <alltraps>

80106953 <vector133>:
80106953:	6a 00                	push   $0x0
80106955:	68 85 00 00 00       	push   $0x85
8010695a:	e9 e8 f5 ff ff       	jmp    80105f47 <alltraps>

8010695f <vector134>:
8010695f:	6a 00                	push   $0x0
80106961:	68 86 00 00 00       	push   $0x86
80106966:	e9 dc f5 ff ff       	jmp    80105f47 <alltraps>

8010696b <vector135>:
8010696b:	6a 00                	push   $0x0
8010696d:	68 87 00 00 00       	push   $0x87
80106972:	e9 d0 f5 ff ff       	jmp    80105f47 <alltraps>

80106977 <vector136>:
80106977:	6a 00                	push   $0x0
80106979:	68 88 00 00 00       	push   $0x88
8010697e:	e9 c4 f5 ff ff       	jmp    80105f47 <alltraps>

80106983 <vector137>:
80106983:	6a 00                	push   $0x0
80106985:	68 89 00 00 00       	push   $0x89
8010698a:	e9 b8 f5 ff ff       	jmp    80105f47 <alltraps>

8010698f <vector138>:
8010698f:	6a 00                	push   $0x0
80106991:	68 8a 00 00 00       	push   $0x8a
80106996:	e9 ac f5 ff ff       	jmp    80105f47 <alltraps>

8010699b <vector139>:
8010699b:	6a 00                	push   $0x0
8010699d:	68 8b 00 00 00       	push   $0x8b
801069a2:	e9 a0 f5 ff ff       	jmp    80105f47 <alltraps>

801069a7 <vector140>:
801069a7:	6a 00                	push   $0x0
801069a9:	68 8c 00 00 00       	push   $0x8c
801069ae:	e9 94 f5 ff ff       	jmp    80105f47 <alltraps>

801069b3 <vector141>:
801069b3:	6a 00                	push   $0x0
801069b5:	68 8d 00 00 00       	push   $0x8d
801069ba:	e9 88 f5 ff ff       	jmp    80105f47 <alltraps>

801069bf <vector142>:
801069bf:	6a 00                	push   $0x0
801069c1:	68 8e 00 00 00       	push   $0x8e
801069c6:	e9 7c f5 ff ff       	jmp    80105f47 <alltraps>

801069cb <vector143>:
801069cb:	6a 00                	push   $0x0
801069cd:	68 8f 00 00 00       	push   $0x8f
801069d2:	e9 70 f5 ff ff       	jmp    80105f47 <alltraps>

801069d7 <vector144>:
801069d7:	6a 00                	push   $0x0
801069d9:	68 90 00 00 00       	push   $0x90
801069de:	e9 64 f5 ff ff       	jmp    80105f47 <alltraps>

801069e3 <vector145>:
801069e3:	6a 00                	push   $0x0
801069e5:	68 91 00 00 00       	push   $0x91
801069ea:	e9 58 f5 ff ff       	jmp    80105f47 <alltraps>

801069ef <vector146>:
801069ef:	6a 00                	push   $0x0
801069f1:	68 92 00 00 00       	push   $0x92
801069f6:	e9 4c f5 ff ff       	jmp    80105f47 <alltraps>

801069fb <vector147>:
801069fb:	6a 00                	push   $0x0
801069fd:	68 93 00 00 00       	push   $0x93
80106a02:	e9 40 f5 ff ff       	jmp    80105f47 <alltraps>

80106a07 <vector148>:
80106a07:	6a 00                	push   $0x0
80106a09:	68 94 00 00 00       	push   $0x94
80106a0e:	e9 34 f5 ff ff       	jmp    80105f47 <alltraps>

80106a13 <vector149>:
80106a13:	6a 00                	push   $0x0
80106a15:	68 95 00 00 00       	push   $0x95
80106a1a:	e9 28 f5 ff ff       	jmp    80105f47 <alltraps>

80106a1f <vector150>:
80106a1f:	6a 00                	push   $0x0
80106a21:	68 96 00 00 00       	push   $0x96
80106a26:	e9 1c f5 ff ff       	jmp    80105f47 <alltraps>

80106a2b <vector151>:
80106a2b:	6a 00                	push   $0x0
80106a2d:	68 97 00 00 00       	push   $0x97
80106a32:	e9 10 f5 ff ff       	jmp    80105f47 <alltraps>

80106a37 <vector152>:
80106a37:	6a 00                	push   $0x0
80106a39:	68 98 00 00 00       	push   $0x98
80106a3e:	e9 04 f5 ff ff       	jmp    80105f47 <alltraps>

80106a43 <vector153>:
80106a43:	6a 00                	push   $0x0
80106a45:	68 99 00 00 00       	push   $0x99
80106a4a:	e9 f8 f4 ff ff       	jmp    80105f47 <alltraps>

80106a4f <vector154>:
80106a4f:	6a 00                	push   $0x0
80106a51:	68 9a 00 00 00       	push   $0x9a
80106a56:	e9 ec f4 ff ff       	jmp    80105f47 <alltraps>

80106a5b <vector155>:
80106a5b:	6a 00                	push   $0x0
80106a5d:	68 9b 00 00 00       	push   $0x9b
80106a62:	e9 e0 f4 ff ff       	jmp    80105f47 <alltraps>

80106a67 <vector156>:
80106a67:	6a 00                	push   $0x0
80106a69:	68 9c 00 00 00       	push   $0x9c
80106a6e:	e9 d4 f4 ff ff       	jmp    80105f47 <alltraps>

80106a73 <vector157>:
80106a73:	6a 00                	push   $0x0
80106a75:	68 9d 00 00 00       	push   $0x9d
80106a7a:	e9 c8 f4 ff ff       	jmp    80105f47 <alltraps>

80106a7f <vector158>:
80106a7f:	6a 00                	push   $0x0
80106a81:	68 9e 00 00 00       	push   $0x9e
80106a86:	e9 bc f4 ff ff       	jmp    80105f47 <alltraps>

80106a8b <vector159>:
80106a8b:	6a 00                	push   $0x0
80106a8d:	68 9f 00 00 00       	push   $0x9f
80106a92:	e9 b0 f4 ff ff       	jmp    80105f47 <alltraps>

80106a97 <vector160>:
80106a97:	6a 00                	push   $0x0
80106a99:	68 a0 00 00 00       	push   $0xa0
80106a9e:	e9 a4 f4 ff ff       	jmp    80105f47 <alltraps>

80106aa3 <vector161>:
80106aa3:	6a 00                	push   $0x0
80106aa5:	68 a1 00 00 00       	push   $0xa1
80106aaa:	e9 98 f4 ff ff       	jmp    80105f47 <alltraps>

80106aaf <vector162>:
80106aaf:	6a 00                	push   $0x0
80106ab1:	68 a2 00 00 00       	push   $0xa2
80106ab6:	e9 8c f4 ff ff       	jmp    80105f47 <alltraps>

80106abb <vector163>:
80106abb:	6a 00                	push   $0x0
80106abd:	68 a3 00 00 00       	push   $0xa3
80106ac2:	e9 80 f4 ff ff       	jmp    80105f47 <alltraps>

80106ac7 <vector164>:
80106ac7:	6a 00                	push   $0x0
80106ac9:	68 a4 00 00 00       	push   $0xa4
80106ace:	e9 74 f4 ff ff       	jmp    80105f47 <alltraps>

80106ad3 <vector165>:
80106ad3:	6a 00                	push   $0x0
80106ad5:	68 a5 00 00 00       	push   $0xa5
80106ada:	e9 68 f4 ff ff       	jmp    80105f47 <alltraps>

80106adf <vector166>:
80106adf:	6a 00                	push   $0x0
80106ae1:	68 a6 00 00 00       	push   $0xa6
80106ae6:	e9 5c f4 ff ff       	jmp    80105f47 <alltraps>

80106aeb <vector167>:
80106aeb:	6a 00                	push   $0x0
80106aed:	68 a7 00 00 00       	push   $0xa7
80106af2:	e9 50 f4 ff ff       	jmp    80105f47 <alltraps>

80106af7 <vector168>:
80106af7:	6a 00                	push   $0x0
80106af9:	68 a8 00 00 00       	push   $0xa8
80106afe:	e9 44 f4 ff ff       	jmp    80105f47 <alltraps>

80106b03 <vector169>:
80106b03:	6a 00                	push   $0x0
80106b05:	68 a9 00 00 00       	push   $0xa9
80106b0a:	e9 38 f4 ff ff       	jmp    80105f47 <alltraps>

80106b0f <vector170>:
80106b0f:	6a 00                	push   $0x0
80106b11:	68 aa 00 00 00       	push   $0xaa
80106b16:	e9 2c f4 ff ff       	jmp    80105f47 <alltraps>

80106b1b <vector171>:
80106b1b:	6a 00                	push   $0x0
80106b1d:	68 ab 00 00 00       	push   $0xab
80106b22:	e9 20 f4 ff ff       	jmp    80105f47 <alltraps>

80106b27 <vector172>:
80106b27:	6a 00                	push   $0x0
80106b29:	68 ac 00 00 00       	push   $0xac
80106b2e:	e9 14 f4 ff ff       	jmp    80105f47 <alltraps>

80106b33 <vector173>:
80106b33:	6a 00                	push   $0x0
80106b35:	68 ad 00 00 00       	push   $0xad
80106b3a:	e9 08 f4 ff ff       	jmp    80105f47 <alltraps>

80106b3f <vector174>:
80106b3f:	6a 00                	push   $0x0
80106b41:	68 ae 00 00 00       	push   $0xae
80106b46:	e9 fc f3 ff ff       	jmp    80105f47 <alltraps>

80106b4b <vector175>:
80106b4b:	6a 00                	push   $0x0
80106b4d:	68 af 00 00 00       	push   $0xaf
80106b52:	e9 f0 f3 ff ff       	jmp    80105f47 <alltraps>

80106b57 <vector176>:
80106b57:	6a 00                	push   $0x0
80106b59:	68 b0 00 00 00       	push   $0xb0
80106b5e:	e9 e4 f3 ff ff       	jmp    80105f47 <alltraps>

80106b63 <vector177>:
80106b63:	6a 00                	push   $0x0
80106b65:	68 b1 00 00 00       	push   $0xb1
80106b6a:	e9 d8 f3 ff ff       	jmp    80105f47 <alltraps>

80106b6f <vector178>:
80106b6f:	6a 00                	push   $0x0
80106b71:	68 b2 00 00 00       	push   $0xb2
80106b76:	e9 cc f3 ff ff       	jmp    80105f47 <alltraps>

80106b7b <vector179>:
80106b7b:	6a 00                	push   $0x0
80106b7d:	68 b3 00 00 00       	push   $0xb3
80106b82:	e9 c0 f3 ff ff       	jmp    80105f47 <alltraps>

80106b87 <vector180>:
80106b87:	6a 00                	push   $0x0
80106b89:	68 b4 00 00 00       	push   $0xb4
80106b8e:	e9 b4 f3 ff ff       	jmp    80105f47 <alltraps>

80106b93 <vector181>:
80106b93:	6a 00                	push   $0x0
80106b95:	68 b5 00 00 00       	push   $0xb5
80106b9a:	e9 a8 f3 ff ff       	jmp    80105f47 <alltraps>

80106b9f <vector182>:
80106b9f:	6a 00                	push   $0x0
80106ba1:	68 b6 00 00 00       	push   $0xb6
80106ba6:	e9 9c f3 ff ff       	jmp    80105f47 <alltraps>

80106bab <vector183>:
80106bab:	6a 00                	push   $0x0
80106bad:	68 b7 00 00 00       	push   $0xb7
80106bb2:	e9 90 f3 ff ff       	jmp    80105f47 <alltraps>

80106bb7 <vector184>:
80106bb7:	6a 00                	push   $0x0
80106bb9:	68 b8 00 00 00       	push   $0xb8
80106bbe:	e9 84 f3 ff ff       	jmp    80105f47 <alltraps>

80106bc3 <vector185>:
80106bc3:	6a 00                	push   $0x0
80106bc5:	68 b9 00 00 00       	push   $0xb9
80106bca:	e9 78 f3 ff ff       	jmp    80105f47 <alltraps>

80106bcf <vector186>:
80106bcf:	6a 00                	push   $0x0
80106bd1:	68 ba 00 00 00       	push   $0xba
80106bd6:	e9 6c f3 ff ff       	jmp    80105f47 <alltraps>

80106bdb <vector187>:
80106bdb:	6a 00                	push   $0x0
80106bdd:	68 bb 00 00 00       	push   $0xbb
80106be2:	e9 60 f3 ff ff       	jmp    80105f47 <alltraps>

80106be7 <vector188>:
80106be7:	6a 00                	push   $0x0
80106be9:	68 bc 00 00 00       	push   $0xbc
80106bee:	e9 54 f3 ff ff       	jmp    80105f47 <alltraps>

80106bf3 <vector189>:
80106bf3:	6a 00                	push   $0x0
80106bf5:	68 bd 00 00 00       	push   $0xbd
80106bfa:	e9 48 f3 ff ff       	jmp    80105f47 <alltraps>

80106bff <vector190>:
80106bff:	6a 00                	push   $0x0
80106c01:	68 be 00 00 00       	push   $0xbe
80106c06:	e9 3c f3 ff ff       	jmp    80105f47 <alltraps>

80106c0b <vector191>:
80106c0b:	6a 00                	push   $0x0
80106c0d:	68 bf 00 00 00       	push   $0xbf
80106c12:	e9 30 f3 ff ff       	jmp    80105f47 <alltraps>

80106c17 <vector192>:
80106c17:	6a 00                	push   $0x0
80106c19:	68 c0 00 00 00       	push   $0xc0
80106c1e:	e9 24 f3 ff ff       	jmp    80105f47 <alltraps>

80106c23 <vector193>:
80106c23:	6a 00                	push   $0x0
80106c25:	68 c1 00 00 00       	push   $0xc1
80106c2a:	e9 18 f3 ff ff       	jmp    80105f47 <alltraps>

80106c2f <vector194>:
80106c2f:	6a 00                	push   $0x0
80106c31:	68 c2 00 00 00       	push   $0xc2
80106c36:	e9 0c f3 ff ff       	jmp    80105f47 <alltraps>

80106c3b <vector195>:
80106c3b:	6a 00                	push   $0x0
80106c3d:	68 c3 00 00 00       	push   $0xc3
80106c42:	e9 00 f3 ff ff       	jmp    80105f47 <alltraps>

80106c47 <vector196>:
80106c47:	6a 00                	push   $0x0
80106c49:	68 c4 00 00 00       	push   $0xc4
80106c4e:	e9 f4 f2 ff ff       	jmp    80105f47 <alltraps>

80106c53 <vector197>:
80106c53:	6a 00                	push   $0x0
80106c55:	68 c5 00 00 00       	push   $0xc5
80106c5a:	e9 e8 f2 ff ff       	jmp    80105f47 <alltraps>

80106c5f <vector198>:
80106c5f:	6a 00                	push   $0x0
80106c61:	68 c6 00 00 00       	push   $0xc6
80106c66:	e9 dc f2 ff ff       	jmp    80105f47 <alltraps>

80106c6b <vector199>:
80106c6b:	6a 00                	push   $0x0
80106c6d:	68 c7 00 00 00       	push   $0xc7
80106c72:	e9 d0 f2 ff ff       	jmp    80105f47 <alltraps>

80106c77 <vector200>:
80106c77:	6a 00                	push   $0x0
80106c79:	68 c8 00 00 00       	push   $0xc8
80106c7e:	e9 c4 f2 ff ff       	jmp    80105f47 <alltraps>

80106c83 <vector201>:
80106c83:	6a 00                	push   $0x0
80106c85:	68 c9 00 00 00       	push   $0xc9
80106c8a:	e9 b8 f2 ff ff       	jmp    80105f47 <alltraps>

80106c8f <vector202>:
80106c8f:	6a 00                	push   $0x0
80106c91:	68 ca 00 00 00       	push   $0xca
80106c96:	e9 ac f2 ff ff       	jmp    80105f47 <alltraps>

80106c9b <vector203>:
80106c9b:	6a 00                	push   $0x0
80106c9d:	68 cb 00 00 00       	push   $0xcb
80106ca2:	e9 a0 f2 ff ff       	jmp    80105f47 <alltraps>

80106ca7 <vector204>:
80106ca7:	6a 00                	push   $0x0
80106ca9:	68 cc 00 00 00       	push   $0xcc
80106cae:	e9 94 f2 ff ff       	jmp    80105f47 <alltraps>

80106cb3 <vector205>:
80106cb3:	6a 00                	push   $0x0
80106cb5:	68 cd 00 00 00       	push   $0xcd
80106cba:	e9 88 f2 ff ff       	jmp    80105f47 <alltraps>

80106cbf <vector206>:
80106cbf:	6a 00                	push   $0x0
80106cc1:	68 ce 00 00 00       	push   $0xce
80106cc6:	e9 7c f2 ff ff       	jmp    80105f47 <alltraps>

80106ccb <vector207>:
80106ccb:	6a 00                	push   $0x0
80106ccd:	68 cf 00 00 00       	push   $0xcf
80106cd2:	e9 70 f2 ff ff       	jmp    80105f47 <alltraps>

80106cd7 <vector208>:
80106cd7:	6a 00                	push   $0x0
80106cd9:	68 d0 00 00 00       	push   $0xd0
80106cde:	e9 64 f2 ff ff       	jmp    80105f47 <alltraps>

80106ce3 <vector209>:
80106ce3:	6a 00                	push   $0x0
80106ce5:	68 d1 00 00 00       	push   $0xd1
80106cea:	e9 58 f2 ff ff       	jmp    80105f47 <alltraps>

80106cef <vector210>:
80106cef:	6a 00                	push   $0x0
80106cf1:	68 d2 00 00 00       	push   $0xd2
80106cf6:	e9 4c f2 ff ff       	jmp    80105f47 <alltraps>

80106cfb <vector211>:
80106cfb:	6a 00                	push   $0x0
80106cfd:	68 d3 00 00 00       	push   $0xd3
80106d02:	e9 40 f2 ff ff       	jmp    80105f47 <alltraps>

80106d07 <vector212>:
80106d07:	6a 00                	push   $0x0
80106d09:	68 d4 00 00 00       	push   $0xd4
80106d0e:	e9 34 f2 ff ff       	jmp    80105f47 <alltraps>

80106d13 <vector213>:
80106d13:	6a 00                	push   $0x0
80106d15:	68 d5 00 00 00       	push   $0xd5
80106d1a:	e9 28 f2 ff ff       	jmp    80105f47 <alltraps>

80106d1f <vector214>:
80106d1f:	6a 00                	push   $0x0
80106d21:	68 d6 00 00 00       	push   $0xd6
80106d26:	e9 1c f2 ff ff       	jmp    80105f47 <alltraps>

80106d2b <vector215>:
80106d2b:	6a 00                	push   $0x0
80106d2d:	68 d7 00 00 00       	push   $0xd7
80106d32:	e9 10 f2 ff ff       	jmp    80105f47 <alltraps>

80106d37 <vector216>:
80106d37:	6a 00                	push   $0x0
80106d39:	68 d8 00 00 00       	push   $0xd8
80106d3e:	e9 04 f2 ff ff       	jmp    80105f47 <alltraps>

80106d43 <vector217>:
80106d43:	6a 00                	push   $0x0
80106d45:	68 d9 00 00 00       	push   $0xd9
80106d4a:	e9 f8 f1 ff ff       	jmp    80105f47 <alltraps>

80106d4f <vector218>:
80106d4f:	6a 00                	push   $0x0
80106d51:	68 da 00 00 00       	push   $0xda
80106d56:	e9 ec f1 ff ff       	jmp    80105f47 <alltraps>

80106d5b <vector219>:
80106d5b:	6a 00                	push   $0x0
80106d5d:	68 db 00 00 00       	push   $0xdb
80106d62:	e9 e0 f1 ff ff       	jmp    80105f47 <alltraps>

80106d67 <vector220>:
80106d67:	6a 00                	push   $0x0
80106d69:	68 dc 00 00 00       	push   $0xdc
80106d6e:	e9 d4 f1 ff ff       	jmp    80105f47 <alltraps>

80106d73 <vector221>:
80106d73:	6a 00                	push   $0x0
80106d75:	68 dd 00 00 00       	push   $0xdd
80106d7a:	e9 c8 f1 ff ff       	jmp    80105f47 <alltraps>

80106d7f <vector222>:
80106d7f:	6a 00                	push   $0x0
80106d81:	68 de 00 00 00       	push   $0xde
80106d86:	e9 bc f1 ff ff       	jmp    80105f47 <alltraps>

80106d8b <vector223>:
80106d8b:	6a 00                	push   $0x0
80106d8d:	68 df 00 00 00       	push   $0xdf
80106d92:	e9 b0 f1 ff ff       	jmp    80105f47 <alltraps>

80106d97 <vector224>:
80106d97:	6a 00                	push   $0x0
80106d99:	68 e0 00 00 00       	push   $0xe0
80106d9e:	e9 a4 f1 ff ff       	jmp    80105f47 <alltraps>

80106da3 <vector225>:
80106da3:	6a 00                	push   $0x0
80106da5:	68 e1 00 00 00       	push   $0xe1
80106daa:	e9 98 f1 ff ff       	jmp    80105f47 <alltraps>

80106daf <vector226>:
80106daf:	6a 00                	push   $0x0
80106db1:	68 e2 00 00 00       	push   $0xe2
80106db6:	e9 8c f1 ff ff       	jmp    80105f47 <alltraps>

80106dbb <vector227>:
80106dbb:	6a 00                	push   $0x0
80106dbd:	68 e3 00 00 00       	push   $0xe3
80106dc2:	e9 80 f1 ff ff       	jmp    80105f47 <alltraps>

80106dc7 <vector228>:
80106dc7:	6a 00                	push   $0x0
80106dc9:	68 e4 00 00 00       	push   $0xe4
80106dce:	e9 74 f1 ff ff       	jmp    80105f47 <alltraps>

80106dd3 <vector229>:
80106dd3:	6a 00                	push   $0x0
80106dd5:	68 e5 00 00 00       	push   $0xe5
80106dda:	e9 68 f1 ff ff       	jmp    80105f47 <alltraps>

80106ddf <vector230>:
80106ddf:	6a 00                	push   $0x0
80106de1:	68 e6 00 00 00       	push   $0xe6
80106de6:	e9 5c f1 ff ff       	jmp    80105f47 <alltraps>

80106deb <vector231>:
80106deb:	6a 00                	push   $0x0
80106ded:	68 e7 00 00 00       	push   $0xe7
80106df2:	e9 50 f1 ff ff       	jmp    80105f47 <alltraps>

80106df7 <vector232>:
80106df7:	6a 00                	push   $0x0
80106df9:	68 e8 00 00 00       	push   $0xe8
80106dfe:	e9 44 f1 ff ff       	jmp    80105f47 <alltraps>

80106e03 <vector233>:
80106e03:	6a 00                	push   $0x0
80106e05:	68 e9 00 00 00       	push   $0xe9
80106e0a:	e9 38 f1 ff ff       	jmp    80105f47 <alltraps>

80106e0f <vector234>:
80106e0f:	6a 00                	push   $0x0
80106e11:	68 ea 00 00 00       	push   $0xea
80106e16:	e9 2c f1 ff ff       	jmp    80105f47 <alltraps>

80106e1b <vector235>:
80106e1b:	6a 00                	push   $0x0
80106e1d:	68 eb 00 00 00       	push   $0xeb
80106e22:	e9 20 f1 ff ff       	jmp    80105f47 <alltraps>

80106e27 <vector236>:
80106e27:	6a 00                	push   $0x0
80106e29:	68 ec 00 00 00       	push   $0xec
80106e2e:	e9 14 f1 ff ff       	jmp    80105f47 <alltraps>

80106e33 <vector237>:
80106e33:	6a 00                	push   $0x0
80106e35:	68 ed 00 00 00       	push   $0xed
80106e3a:	e9 08 f1 ff ff       	jmp    80105f47 <alltraps>

80106e3f <vector238>:
80106e3f:	6a 00                	push   $0x0
80106e41:	68 ee 00 00 00       	push   $0xee
80106e46:	e9 fc f0 ff ff       	jmp    80105f47 <alltraps>

80106e4b <vector239>:
80106e4b:	6a 00                	push   $0x0
80106e4d:	68 ef 00 00 00       	push   $0xef
80106e52:	e9 f0 f0 ff ff       	jmp    80105f47 <alltraps>

80106e57 <vector240>:
80106e57:	6a 00                	push   $0x0
80106e59:	68 f0 00 00 00       	push   $0xf0
80106e5e:	e9 e4 f0 ff ff       	jmp    80105f47 <alltraps>

80106e63 <vector241>:
80106e63:	6a 00                	push   $0x0
80106e65:	68 f1 00 00 00       	push   $0xf1
80106e6a:	e9 d8 f0 ff ff       	jmp    80105f47 <alltraps>

80106e6f <vector242>:
80106e6f:	6a 00                	push   $0x0
80106e71:	68 f2 00 00 00       	push   $0xf2
80106e76:	e9 cc f0 ff ff       	jmp    80105f47 <alltraps>

80106e7b <vector243>:
80106e7b:	6a 00                	push   $0x0
80106e7d:	68 f3 00 00 00       	push   $0xf3
80106e82:	e9 c0 f0 ff ff       	jmp    80105f47 <alltraps>

80106e87 <vector244>:
80106e87:	6a 00                	push   $0x0
80106e89:	68 f4 00 00 00       	push   $0xf4
80106e8e:	e9 b4 f0 ff ff       	jmp    80105f47 <alltraps>

80106e93 <vector245>:
80106e93:	6a 00                	push   $0x0
80106e95:	68 f5 00 00 00       	push   $0xf5
80106e9a:	e9 a8 f0 ff ff       	jmp    80105f47 <alltraps>

80106e9f <vector246>:
80106e9f:	6a 00                	push   $0x0
80106ea1:	68 f6 00 00 00       	push   $0xf6
80106ea6:	e9 9c f0 ff ff       	jmp    80105f47 <alltraps>

80106eab <vector247>:
80106eab:	6a 00                	push   $0x0
80106ead:	68 f7 00 00 00       	push   $0xf7
80106eb2:	e9 90 f0 ff ff       	jmp    80105f47 <alltraps>

80106eb7 <vector248>:
80106eb7:	6a 00                	push   $0x0
80106eb9:	68 f8 00 00 00       	push   $0xf8
80106ebe:	e9 84 f0 ff ff       	jmp    80105f47 <alltraps>

80106ec3 <vector249>:
80106ec3:	6a 00                	push   $0x0
80106ec5:	68 f9 00 00 00       	push   $0xf9
80106eca:	e9 78 f0 ff ff       	jmp    80105f47 <alltraps>

80106ecf <vector250>:
80106ecf:	6a 00                	push   $0x0
80106ed1:	68 fa 00 00 00       	push   $0xfa
80106ed6:	e9 6c f0 ff ff       	jmp    80105f47 <alltraps>

80106edb <vector251>:
80106edb:	6a 00                	push   $0x0
80106edd:	68 fb 00 00 00       	push   $0xfb
80106ee2:	e9 60 f0 ff ff       	jmp    80105f47 <alltraps>

80106ee7 <vector252>:
80106ee7:	6a 00                	push   $0x0
80106ee9:	68 fc 00 00 00       	push   $0xfc
80106eee:	e9 54 f0 ff ff       	jmp    80105f47 <alltraps>

80106ef3 <vector253>:
80106ef3:	6a 00                	push   $0x0
80106ef5:	68 fd 00 00 00       	push   $0xfd
80106efa:	e9 48 f0 ff ff       	jmp    80105f47 <alltraps>

80106eff <vector254>:
80106eff:	6a 00                	push   $0x0
80106f01:	68 fe 00 00 00       	push   $0xfe
80106f06:	e9 3c f0 ff ff       	jmp    80105f47 <alltraps>

80106f0b <vector255>:
80106f0b:	6a 00                	push   $0x0
80106f0d:	68 ff 00 00 00       	push   $0xff
80106f12:	e9 30 f0 ff ff       	jmp    80105f47 <alltraps>
80106f17:	66 90                	xchg   %ax,%ax
80106f19:	66 90                	xchg   %ax,%ax
80106f1b:	66 90                	xchg   %ax,%ax
80106f1d:	66 90                	xchg   %ax,%ax
80106f1f:	90                   	nop

80106f20 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106f20:	55                   	push   %ebp
80106f21:	89 e5                	mov    %esp,%ebp
80106f23:	57                   	push   %edi
80106f24:	56                   	push   %esi
80106f25:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106f26:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
80106f2c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106f32:	83 ec 1c             	sub    $0x1c,%esp
  for(; a  < oldsz; a += PGSIZE){
80106f35:	39 d3                	cmp    %edx,%ebx
80106f37:	73 6c                	jae    80106fa5 <deallocuvm.part.0+0x85>
80106f39:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80106f3c:	89 c6                	mov    %eax,%esi
80106f3e:	89 d7                	mov    %edx,%edi
80106f40:	eb 28                	jmp    80106f6a <deallocuvm.part.0+0x4a>
80106f42:	eb 1c                	jmp    80106f60 <deallocuvm.part.0+0x40>
80106f44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106f48:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106f4f:	00 
80106f50:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106f57:	00 
80106f58:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106f5f:	00 
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106f60:	8d 5a 01             	lea    0x1(%edx),%ebx
80106f63:	c1 e3 16             	shl    $0x16,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106f66:	39 fb                	cmp    %edi,%ebx
80106f68:	73 38                	jae    80106fa2 <deallocuvm.part.0+0x82>
  pde = &pgdir[PDX(va)];
80106f6a:	89 da                	mov    %ebx,%edx
80106f6c:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80106f6f:	8b 04 96             	mov    (%esi,%edx,4),%eax
80106f72:	a8 01                	test   $0x1,%al
80106f74:	74 ea                	je     80106f60 <deallocuvm.part.0+0x40>
  return &pgtab[PTX(va)];
80106f76:	89 d9                	mov    %ebx,%ecx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106f78:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106f7d:	c1 e9 0a             	shr    $0xa,%ecx
80106f80:	81 e1 fc 0f 00 00    	and    $0xffc,%ecx
80106f86:	8d 84 08 00 00 00 80 	lea    -0x80000000(%eax,%ecx,1),%eax
    if(!pte)
80106f8d:	85 c0                	test   %eax,%eax
80106f8f:	74 cf                	je     80106f60 <deallocuvm.part.0+0x40>
    else if((*pte & PTE_P) != 0){
80106f91:	8b 10                	mov    (%eax),%edx
80106f93:	f6 c2 01             	test   $0x1,%dl
80106f96:	75 18                	jne    80106fb0 <deallocuvm.part.0+0x90>
  for(; a  < oldsz; a += PGSIZE){
80106f98:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106f9e:	39 fb                	cmp    %edi,%ebx
80106fa0:	72 c8                	jb     80106f6a <deallocuvm.part.0+0x4a>
80106fa2:	8b 4d e0             	mov    -0x20(%ebp),%ecx
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106fa5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106fa8:	89 c8                	mov    %ecx,%eax
80106faa:	5b                   	pop    %ebx
80106fab:	5e                   	pop    %esi
80106fac:	5f                   	pop    %edi
80106fad:	5d                   	pop    %ebp
80106fae:	c3                   	ret
80106faf:	90                   	nop
      if(pa == 0)
80106fb0:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106fb6:	74 26                	je     80106fde <deallocuvm.part.0+0xbe>
      kfree(v);
80106fb8:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80106fbb:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106fc1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106fc4:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
80106fca:	52                   	push   %edx
80106fcb:	e8 f0 b6 ff ff       	call   801026c0 <kfree>
      *pte = 0;
80106fd0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  for(; a  < oldsz; a += PGSIZE){
80106fd3:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
80106fd6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80106fdc:	eb 88                	jmp    80106f66 <deallocuvm.part.0+0x46>
        panic("kfree");
80106fde:	83 ec 0c             	sub    $0xc,%esp
80106fe1:	68 b0 7a 10 80       	push   $0x80107ab0
80106fe6:	e8 b5 93 ff ff       	call   801003a0 <panic>
80106feb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80106ff0 <mappages>:
{
80106ff0:	55                   	push   %ebp
80106ff1:	89 e5                	mov    %esp,%ebp
80106ff3:	57                   	push   %edi
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106ff4:	8d 7c 0a ff          	lea    -0x1(%edx,%ecx,1),%edi
{
80106ff8:	56                   	push   %esi
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106ff9:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80106fff:	89 c6                	mov    %eax,%esi
{
80107001:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80107002:	89 d3                	mov    %edx,%ebx
80107004:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
8010700a:	83 ec 1c             	sub    $0x1c,%esp
8010700d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107010:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80107013:	29 d9                	sub    %ebx,%ecx
80107015:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80107018:	eb 42                	jmp    8010705c <mappages+0x6c>
8010701a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107020:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107022:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107027:	c1 ea 0a             	shr    $0xa,%edx
8010702a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107030:	8d 94 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%edx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107037:	85 d2                	test   %edx,%edx
80107039:	74 6d                	je     801070a8 <mappages+0xb8>
    if(*pte & PTE_P)
8010703b:	f6 02 01             	testb  $0x1,(%edx)
8010703e:	0f 85 7e 00 00 00    	jne    801070c2 <mappages+0xd2>
    *pte = pa | perm | PTE_P;
80107044:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107047:	01 d8                	add    %ebx,%eax
80107049:	0b 45 0c             	or     0xc(%ebp),%eax
8010704c:	83 c8 01             	or     $0x1,%eax
8010704f:	89 02                	mov    %eax,(%edx)
    if(a == last)
80107051:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
80107054:	74 62                	je     801070b8 <mappages+0xc8>
    a += PGSIZE;
80107056:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  pde = &pgdir[PDX(va)];
8010705c:	89 d8                	mov    %ebx,%eax
8010705e:	c1 e8 16             	shr    $0x16,%eax
80107061:	8d 3c 86             	lea    (%esi,%eax,4),%edi
  if(*pde & PTE_P){
80107064:	8b 07                	mov    (%edi),%eax
80107066:	a8 01                	test   $0x1,%al
80107068:	75 b6                	jne    80107020 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
8010706a:	e8 21 b8 ff ff       	call   80102890 <kalloc>
8010706f:	85 c0                	test   %eax,%eax
80107071:	74 35                	je     801070a8 <mappages+0xb8>
    memset(pgtab, 0, PGSIZE);
80107073:	83 ec 04             	sub    $0x4,%esp
80107076:	68 00 10 00 00       	push   $0x1000
8010707b:	6a 00                	push   $0x0
8010707d:	50                   	push   %eax
8010707e:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107081:	e8 7a dc ff ff       	call   80104d00 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107086:	8b 55 dc             	mov    -0x24(%ebp),%edx
  return &pgtab[PTX(va)];
80107089:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010708c:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80107092:	83 c8 07             	or     $0x7,%eax
80107095:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
80107097:	89 d8                	mov    %ebx,%eax
80107099:	c1 e8 0a             	shr    $0xa,%eax
8010709c:	25 fc 0f 00 00       	and    $0xffc,%eax
801070a1:	01 c2                	add    %eax,%edx
801070a3:	eb 96                	jmp    8010703b <mappages+0x4b>
801070a5:	8d 76 00             	lea    0x0(%esi),%esi
}
801070a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801070ab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801070b0:	5b                   	pop    %ebx
801070b1:	5e                   	pop    %esi
801070b2:	5f                   	pop    %edi
801070b3:	5d                   	pop    %ebp
801070b4:	c3                   	ret
801070b5:	8d 76 00             	lea    0x0(%esi),%esi
801070b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801070bb:	31 c0                	xor    %eax,%eax
}
801070bd:	5b                   	pop    %ebx
801070be:	5e                   	pop    %esi
801070bf:	5f                   	pop    %edi
801070c0:	5d                   	pop    %ebp
801070c1:	c3                   	ret
      panic("remap");
801070c2:	83 ec 0c             	sub    $0xc,%esp
801070c5:	68 1b 7d 10 80       	push   $0x80107d1b
801070ca:	e8 d1 92 ff ff       	call   801003a0 <panic>
801070cf:	90                   	nop

801070d0 <seginit>:
{
801070d0:	55                   	push   %ebp
801070d1:	89 e5                	mov    %esp,%ebp
801070d3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
801070d6:	e8 45 cb ff ff       	call   80103c20 <cpuid>
  pd[0] = size-1;
801070db:	ba 2f 00 00 00       	mov    $0x2f,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801070e0:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
801070e6:	c7 80 38 28 11 80 ff 	movl   $0xffff,-0x7feed7c8(%eax)
801070ed:	ff 00 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801070f0:	c7 80 40 28 11 80 ff 	movl   $0xffff,-0x7feed7c0(%eax)
801070f7:	ff 00 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801070fa:	c7 80 48 28 11 80 ff 	movl   $0xffff,-0x7feed7b8(%eax)
80107101:	ff 00 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107104:	c7 80 50 28 11 80 ff 	movl   $0xffff,-0x7feed7b0(%eax)
8010710b:	ff 00 00 
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010710e:	c7 80 3c 28 11 80 00 	movl   $0xcf9a00,-0x7feed7c4(%eax)
80107115:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107118:	c7 80 44 28 11 80 00 	movl   $0xcf9200,-0x7feed7bc(%eax)
8010711f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107122:	c7 80 4c 28 11 80 00 	movl   $0xcffa00,-0x7feed7b4(%eax)
80107129:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
8010712c:	c7 80 54 28 11 80 00 	movl   $0xcff200,-0x7feed7ac(%eax)
80107133:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80107136:	05 30 28 11 80       	add    $0x80112830,%eax
8010713b:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  pd[1] = (uint)p;
8010713f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107143:	c1 e8 10             	shr    $0x10,%eax
80107146:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
8010714a:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010714d:	0f 01 10             	lgdtl  (%eax)
}
80107150:	c9                   	leave
80107151:	c3                   	ret
80107152:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107158:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010715f:	00 

80107160 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107160:	a1 e4 57 11 80       	mov    0x801157e4,%eax
80107165:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010716a:	0f 22 d8             	mov    %eax,%cr3
}
8010716d:	c3                   	ret
8010716e:	66 90                	xchg   %ax,%ax

80107170 <switchuvm>:
{
80107170:	55                   	push   %ebp
80107171:	89 e5                	mov    %esp,%ebp
80107173:	57                   	push   %edi
80107174:	56                   	push   %esi
80107175:	53                   	push   %ebx
80107176:	83 ec 1c             	sub    $0x1c,%esp
80107179:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
8010717c:	85 db                	test   %ebx,%ebx
8010717e:	0f 84 c9 00 00 00    	je     8010724d <switchuvm+0xdd>
  if(p->kstack == 0)
80107184:	8b 43 08             	mov    0x8(%ebx),%eax
80107187:	85 c0                	test   %eax,%eax
80107189:	0f 84 d8 00 00 00    	je     80107267 <switchuvm+0xf7>
  if(p->pgdir == 0)
8010718f:	8b 43 04             	mov    0x4(%ebx),%eax
80107192:	85 c0                	test   %eax,%eax
80107194:	0f 84 c0 00 00 00    	je     8010725a <switchuvm+0xea>
  pushcli();
8010719a:	e8 e1 d8 ff ff       	call   80104a80 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010719f:	e8 fc c9 ff ff       	call   80103ba0 <mycpu>
801071a4:	89 c6                	mov    %eax,%esi
801071a6:	e8 f5 c9 ff ff       	call   80103ba0 <mycpu>
801071ab:	8d 78 08             	lea    0x8(%eax),%edi
801071ae:	e8 ed c9 ff ff       	call   80103ba0 <mycpu>
801071b3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801071b6:	e8 e5 c9 ff ff       	call   80103ba0 <mycpu>
801071bb:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801071be:	ba 67 00 00 00       	mov    $0x67,%edx
801071c3:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
801071ca:	83 c0 08             	add    $0x8,%eax
801071cd:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801071d4:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801071d9:	83 c1 08             	add    $0x8,%ecx
801071dc:	c1 e8 18             	shr    $0x18,%eax
801071df:	c1 e9 10             	shr    $0x10,%ecx
801071e2:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
801071e8:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
801071ee:	b9 99 40 00 00       	mov    $0x4099,%ecx
801071f3:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801071fa:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
801071ff:	e8 9c c9 ff ff       	call   80103ba0 <mycpu>
80107204:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010720b:	e8 90 c9 ff ff       	call   80103ba0 <mycpu>
80107210:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80107214:	8b 73 08             	mov    0x8(%ebx),%esi
80107217:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010721d:	e8 7e c9 ff ff       	call   80103ba0 <mycpu>
80107222:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107225:	e8 76 c9 ff ff       	call   80103ba0 <mycpu>
8010722a:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
8010722e:	b8 28 00 00 00       	mov    $0x28,%eax
80107233:	0f 00 d8             	ltr    %eax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80107236:	8b 43 04             	mov    0x4(%ebx),%eax
80107239:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010723e:	0f 22 d8             	mov    %eax,%cr3
}
80107241:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107244:	5b                   	pop    %ebx
80107245:	5e                   	pop    %esi
80107246:	5f                   	pop    %edi
80107247:	5d                   	pop    %ebp
  popcli();
80107248:	e9 83 d8 ff ff       	jmp    80104ad0 <popcli>
    panic("switchuvm: no process");
8010724d:	83 ec 0c             	sub    $0xc,%esp
80107250:	68 21 7d 10 80       	push   $0x80107d21
80107255:	e8 46 91 ff ff       	call   801003a0 <panic>
    panic("switchuvm: no pgdir");
8010725a:	83 ec 0c             	sub    $0xc,%esp
8010725d:	68 4c 7d 10 80       	push   $0x80107d4c
80107262:	e8 39 91 ff ff       	call   801003a0 <panic>
    panic("switchuvm: no kstack");
80107267:	83 ec 0c             	sub    $0xc,%esp
8010726a:	68 37 7d 10 80       	push   $0x80107d37
8010726f:	e8 2c 91 ff ff       	call   801003a0 <panic>
80107274:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107278:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010727f:	00 

80107280 <inituvm>:
{
80107280:	55                   	push   %ebp
80107281:	89 e5                	mov    %esp,%ebp
80107283:	57                   	push   %edi
80107284:	56                   	push   %esi
80107285:	53                   	push   %ebx
80107286:	83 ec 1c             	sub    $0x1c,%esp
80107289:	8b 45 08             	mov    0x8(%ebp),%eax
8010728c:	8b 75 10             	mov    0x10(%ebp),%esi
8010728f:	8b 7d 0c             	mov    0xc(%ebp),%edi
80107292:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80107295:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010729b:	77 49                	ja     801072e6 <inituvm+0x66>
  mem = kalloc();
8010729d:	e8 ee b5 ff ff       	call   80102890 <kalloc>
  memset(mem, 0, PGSIZE);
801072a2:	83 ec 04             	sub    $0x4,%esp
801072a5:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
801072aa:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
801072ac:	6a 00                	push   $0x0
801072ae:	50                   	push   %eax
801072af:	e8 4c da ff ff       	call   80104d00 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
801072b4:	58                   	pop    %eax
801072b5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801072bb:	5a                   	pop    %edx
801072bc:	6a 06                	push   $0x6
801072be:	b9 00 10 00 00       	mov    $0x1000,%ecx
801072c3:	31 d2                	xor    %edx,%edx
801072c5:	50                   	push   %eax
801072c6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801072c9:	e8 22 fd ff ff       	call   80106ff0 <mappages>
  memmove(mem, init, sz);
801072ce:	83 c4 10             	add    $0x10,%esp
801072d1:	89 75 10             	mov    %esi,0x10(%ebp)
801072d4:	89 7d 0c             	mov    %edi,0xc(%ebp)
801072d7:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801072da:	8d 65 f4             	lea    -0xc(%ebp),%esp
801072dd:	5b                   	pop    %ebx
801072de:	5e                   	pop    %esi
801072df:	5f                   	pop    %edi
801072e0:	5d                   	pop    %ebp
  memmove(mem, init, sz);
801072e1:	e9 aa da ff ff       	jmp    80104d90 <memmove>
    panic("inituvm: more than a page");
801072e6:	83 ec 0c             	sub    $0xc,%esp
801072e9:	68 60 7d 10 80       	push   $0x80107d60
801072ee:	e8 ad 90 ff ff       	call   801003a0 <panic>
801072f3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801072f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801072ff:	00 

80107300 <loaduvm>:
{
80107300:	55                   	push   %ebp
80107301:	89 e5                	mov    %esp,%ebp
80107303:	57                   	push   %edi
80107304:	56                   	push   %esi
80107305:	53                   	push   %ebx
80107306:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80107309:	8b 75 0c             	mov    0xc(%ebp),%esi
{
8010730c:	8b 7d 18             	mov    0x18(%ebp),%edi
  if((uint) addr % PGSIZE != 0)
8010730f:	81 e6 ff 0f 00 00    	and    $0xfff,%esi
80107315:	0f 85 a2 00 00 00    	jne    801073bd <loaduvm+0xbd>
  for(i = 0; i < sz; i += PGSIZE){
8010731b:	85 ff                	test   %edi,%edi
8010731d:	74 7d                	je     8010739c <loaduvm+0x9c>
8010731f:	90                   	nop
  pde = &pgdir[PDX(va)];
80107320:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107323:	8b 55 08             	mov    0x8(%ebp),%edx
80107326:	01 f0                	add    %esi,%eax
  pde = &pgdir[PDX(va)];
80107328:	89 c1                	mov    %eax,%ecx
8010732a:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
8010732d:	8b 0c 8a             	mov    (%edx,%ecx,4),%ecx
80107330:	f6 c1 01             	test   $0x1,%cl
80107333:	75 13                	jne    80107348 <loaduvm+0x48>
      panic("loaduvm: address should exist");
80107335:	83 ec 0c             	sub    $0xc,%esp
80107338:	68 7a 7d 10 80       	push   $0x80107d7a
8010733d:	e8 5e 90 ff ff       	call   801003a0 <panic>
80107342:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107348:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010734b:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80107351:	25 fc 0f 00 00       	and    $0xffc,%eax
80107356:	8d 8c 01 00 00 00 80 	lea    -0x80000000(%ecx,%eax,1),%ecx
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
8010735d:	85 c9                	test   %ecx,%ecx
8010735f:	74 d4                	je     80107335 <loaduvm+0x35>
    if(sz - i < PGSIZE)
80107361:	89 fb                	mov    %edi,%ebx
80107363:	b8 00 10 00 00       	mov    $0x1000,%eax
80107368:	29 f3                	sub    %esi,%ebx
8010736a:	39 c3                	cmp    %eax,%ebx
8010736c:	0f 47 d8             	cmova  %eax,%ebx
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010736f:	53                   	push   %ebx
80107370:	8b 45 14             	mov    0x14(%ebp),%eax
80107373:	01 f0                	add    %esi,%eax
80107375:	50                   	push   %eax
    pa = PTE_ADDR(*pte);
80107376:	8b 01                	mov    (%ecx),%eax
80107378:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010737d:	05 00 00 00 80       	add    $0x80000000,%eax
80107382:	50                   	push   %eax
80107383:	ff 75 10             	push   0x10(%ebp)
80107386:	e8 f5 a8 ff ff       	call   80101c80 <readi>
8010738b:	83 c4 10             	add    $0x10,%esp
8010738e:	39 d8                	cmp    %ebx,%eax
80107390:	75 1e                	jne    801073b0 <loaduvm+0xb0>
  for(i = 0; i < sz; i += PGSIZE){
80107392:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107398:	39 fe                	cmp    %edi,%esi
8010739a:	72 84                	jb     80107320 <loaduvm+0x20>
}
8010739c:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010739f:	31 c0                	xor    %eax,%eax
}
801073a1:	5b                   	pop    %ebx
801073a2:	5e                   	pop    %esi
801073a3:	5f                   	pop    %edi
801073a4:	5d                   	pop    %ebp
801073a5:	c3                   	ret
801073a6:	66 90                	xchg   %ax,%ax
801073a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801073af:	00 
801073b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801073b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801073b8:	5b                   	pop    %ebx
801073b9:	5e                   	pop    %esi
801073ba:	5f                   	pop    %edi
801073bb:	5d                   	pop    %ebp
801073bc:	c3                   	ret
    panic("loaduvm: addr must be page aligned");
801073bd:	83 ec 0c             	sub    $0xc,%esp
801073c0:	68 7c 7f 10 80       	push   $0x80107f7c
801073c5:	e8 d6 8f ff ff       	call   801003a0 <panic>
801073ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801073d0 <allocuvm>:
{
801073d0:	55                   	push   %ebp
801073d1:	89 e5                	mov    %esp,%ebp
801073d3:	57                   	push   %edi
801073d4:	56                   	push   %esi
801073d5:	53                   	push   %ebx
801073d6:	83 ec 1c             	sub    $0x1c,%esp
801073d9:	8b 75 10             	mov    0x10(%ebp),%esi
  if(newsz >= KERNBASE)
801073dc:	85 f6                	test   %esi,%esi
801073de:	0f 88 99 00 00 00    	js     8010747d <allocuvm+0xad>
801073e4:	89 f2                	mov    %esi,%edx
  if(newsz < oldsz)
801073e6:	3b 75 0c             	cmp    0xc(%ebp),%esi
801073e9:	0f 82 a1 00 00 00    	jb     80107490 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
801073ef:	8b 45 0c             	mov    0xc(%ebp),%eax
801073f2:	05 ff 0f 00 00       	add    $0xfff,%eax
801073f7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801073fc:	89 c7                	mov    %eax,%edi
  for(; a < newsz; a += PGSIZE){
801073fe:	39 f0                	cmp    %esi,%eax
80107400:	0f 83 8d 00 00 00    	jae    80107493 <allocuvm+0xc3>
80107406:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80107409:	eb 45                	jmp    80107450 <allocuvm+0x80>
8010740b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
80107410:	83 ec 04             	sub    $0x4,%esp
80107413:	68 00 10 00 00       	push   $0x1000
80107418:	6a 00                	push   $0x0
8010741a:	50                   	push   %eax
8010741b:	e8 e0 d8 ff ff       	call   80104d00 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107420:	58                   	pop    %eax
80107421:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107427:	5a                   	pop    %edx
80107428:	6a 06                	push   $0x6
8010742a:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010742f:	89 fa                	mov    %edi,%edx
80107431:	50                   	push   %eax
80107432:	8b 45 08             	mov    0x8(%ebp),%eax
80107435:	e8 b6 fb ff ff       	call   80106ff0 <mappages>
8010743a:	83 c4 10             	add    $0x10,%esp
8010743d:	83 f8 ff             	cmp    $0xffffffff,%eax
80107440:	74 5e                	je     801074a0 <allocuvm+0xd0>
  for(; a < newsz; a += PGSIZE){
80107442:	81 c7 00 10 00 00    	add    $0x1000,%edi
80107448:	39 f7                	cmp    %esi,%edi
8010744a:	0f 83 88 00 00 00    	jae    801074d8 <allocuvm+0x108>
    mem = kalloc();
80107450:	e8 3b b4 ff ff       	call   80102890 <kalloc>
80107455:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80107457:	85 c0                	test   %eax,%eax
80107459:	75 b5                	jne    80107410 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
8010745b:	83 ec 0c             	sub    $0xc,%esp
8010745e:	68 98 7d 10 80       	push   $0x80107d98
80107463:	e8 68 92 ff ff       	call   801006d0 <cprintf>
  if(newsz >= oldsz)
80107468:	83 c4 10             	add    $0x10,%esp
8010746b:	3b 75 0c             	cmp    0xc(%ebp),%esi
8010746e:	74 0d                	je     8010747d <allocuvm+0xad>
80107470:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107473:	8b 45 08             	mov    0x8(%ebp),%eax
80107476:	89 f2                	mov    %esi,%edx
80107478:	e8 a3 fa ff ff       	call   80106f20 <deallocuvm.part.0>
    return 0;
8010747d:	31 d2                	xor    %edx,%edx
}
8010747f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107482:	89 d0                	mov    %edx,%eax
80107484:	5b                   	pop    %ebx
80107485:	5e                   	pop    %esi
80107486:	5f                   	pop    %edi
80107487:	5d                   	pop    %ebp
80107488:	c3                   	ret
80107489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80107490:	8b 55 0c             	mov    0xc(%ebp),%edx
}
80107493:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107496:	89 d0                	mov    %edx,%eax
80107498:	5b                   	pop    %ebx
80107499:	5e                   	pop    %esi
8010749a:	5f                   	pop    %edi
8010749b:	5d                   	pop    %ebp
8010749c:	c3                   	ret
8010749d:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
801074a0:	83 ec 0c             	sub    $0xc,%esp
801074a3:	68 b0 7d 10 80       	push   $0x80107db0
801074a8:	e8 23 92 ff ff       	call   801006d0 <cprintf>
  if(newsz >= oldsz)
801074ad:	83 c4 10             	add    $0x10,%esp
801074b0:	3b 75 0c             	cmp    0xc(%ebp),%esi
801074b3:	74 0d                	je     801074c2 <allocuvm+0xf2>
801074b5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801074b8:	8b 45 08             	mov    0x8(%ebp),%eax
801074bb:	89 f2                	mov    %esi,%edx
801074bd:	e8 5e fa ff ff       	call   80106f20 <deallocuvm.part.0>
      kfree(mem);
801074c2:	83 ec 0c             	sub    $0xc,%esp
801074c5:	53                   	push   %ebx
801074c6:	e8 f5 b1 ff ff       	call   801026c0 <kfree>
      return 0;
801074cb:	83 c4 10             	add    $0x10,%esp
    return 0;
801074ce:	31 d2                	xor    %edx,%edx
801074d0:	eb ad                	jmp    8010747f <allocuvm+0xaf>
801074d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801074d8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
}
801074db:	8d 65 f4             	lea    -0xc(%ebp),%esp
801074de:	5b                   	pop    %ebx
801074df:	5e                   	pop    %esi
801074e0:	89 d0                	mov    %edx,%eax
801074e2:	5f                   	pop    %edi
801074e3:	5d                   	pop    %ebp
801074e4:	c3                   	ret
801074e5:	8d 76 00             	lea    0x0(%esi),%esi
801074e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801074ef:	00 

801074f0 <deallocuvm>:
{
801074f0:	55                   	push   %ebp
801074f1:	89 e5                	mov    %esp,%ebp
801074f3:	8b 55 0c             	mov    0xc(%ebp),%edx
801074f6:	8b 4d 10             	mov    0x10(%ebp),%ecx
801074f9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
801074fc:	39 d1                	cmp    %edx,%ecx
801074fe:	73 10                	jae    80107510 <deallocuvm+0x20>
}
80107500:	5d                   	pop    %ebp
80107501:	e9 1a fa ff ff       	jmp    80106f20 <deallocuvm.part.0>
80107506:	66 90                	xchg   %ax,%ax
80107508:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010750f:	00 
80107510:	89 d0                	mov    %edx,%eax
80107512:	5d                   	pop    %ebp
80107513:	c3                   	ret
80107514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107518:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010751f:	00 

80107520 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107520:	55                   	push   %ebp
80107521:	89 e5                	mov    %esp,%ebp
80107523:	57                   	push   %edi
80107524:	56                   	push   %esi
80107525:	53                   	push   %ebx
80107526:	83 ec 0c             	sub    $0xc,%esp
80107529:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010752c:	85 f6                	test   %esi,%esi
8010752e:	74 59                	je     80107589 <freevm+0x69>
  if(newsz >= oldsz)
80107530:	31 c9                	xor    %ecx,%ecx
80107532:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107537:	89 f0                	mov    %esi,%eax
80107539:	89 f3                	mov    %esi,%ebx
8010753b:	e8 e0 f9 ff ff       	call   80106f20 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107540:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107546:	eb 0f                	jmp    80107557 <freevm+0x37>
80107548:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010754f:	00 
80107550:	83 c3 04             	add    $0x4,%ebx
80107553:	39 fb                	cmp    %edi,%ebx
80107555:	74 23                	je     8010757a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107557:	8b 03                	mov    (%ebx),%eax
80107559:	a8 01                	test   $0x1,%al
8010755b:	74 f3                	je     80107550 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010755d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107562:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107565:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107568:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010756d:	50                   	push   %eax
8010756e:	e8 4d b1 ff ff       	call   801026c0 <kfree>
80107573:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107576:	39 fb                	cmp    %edi,%ebx
80107578:	75 dd                	jne    80107557 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010757a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010757d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107580:	5b                   	pop    %ebx
80107581:	5e                   	pop    %esi
80107582:	5f                   	pop    %edi
80107583:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107584:	e9 37 b1 ff ff       	jmp    801026c0 <kfree>
    panic("freevm: no pgdir");
80107589:	83 ec 0c             	sub    $0xc,%esp
8010758c:	68 cc 7d 10 80       	push   $0x80107dcc
80107591:	e8 0a 8e ff ff       	call   801003a0 <panic>
80107596:	66 90                	xchg   %ax,%ax
80107598:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010759f:	00 

801075a0 <setupkvm>:
{
801075a0:	55                   	push   %ebp
801075a1:	89 e5                	mov    %esp,%ebp
801075a3:	56                   	push   %esi
801075a4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
801075a5:	e8 e6 b2 ff ff       	call   80102890 <kalloc>
801075aa:	85 c0                	test   %eax,%eax
801075ac:	74 5e                	je     8010760c <setupkvm+0x6c>
  memset(pgdir, 0, PGSIZE);
801075ae:	83 ec 04             	sub    $0x4,%esp
801075b1:	89 c6                	mov    %eax,%esi
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801075b3:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
801075b8:	68 00 10 00 00       	push   $0x1000
801075bd:	6a 00                	push   $0x0
801075bf:	50                   	push   %eax
801075c0:	e8 3b d7 ff ff       	call   80104d00 <memset>
801075c5:	83 c4 10             	add    $0x10,%esp
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801075c8:	8b 43 04             	mov    0x4(%ebx),%eax
801075cb:	83 ec 08             	sub    $0x8,%esp
801075ce:	8b 4b 08             	mov    0x8(%ebx),%ecx
801075d1:	8b 13                	mov    (%ebx),%edx
801075d3:	ff 73 0c             	push   0xc(%ebx)
801075d6:	50                   	push   %eax
801075d7:	29 c1                	sub    %eax,%ecx
801075d9:	89 f0                	mov    %esi,%eax
801075db:	e8 10 fa ff ff       	call   80106ff0 <mappages>
801075e0:	83 c4 10             	add    $0x10,%esp
801075e3:	83 f8 ff             	cmp    $0xffffffff,%eax
801075e6:	74 18                	je     80107600 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801075e8:	83 c3 10             	add    $0x10,%ebx
801075eb:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
801075f1:	75 d5                	jne    801075c8 <setupkvm+0x28>
}
801075f3:	8d 65 f8             	lea    -0x8(%ebp),%esp
801075f6:	89 f0                	mov    %esi,%eax
801075f8:	5b                   	pop    %ebx
801075f9:	5e                   	pop    %esi
801075fa:	5d                   	pop    %ebp
801075fb:	c3                   	ret
801075fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80107600:	83 ec 0c             	sub    $0xc,%esp
80107603:	56                   	push   %esi
80107604:	e8 17 ff ff ff       	call   80107520 <freevm>
      return 0;
80107609:	83 c4 10             	add    $0x10,%esp
}
8010760c:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
8010760f:	31 f6                	xor    %esi,%esi
}
80107611:	89 f0                	mov    %esi,%eax
80107613:	5b                   	pop    %ebx
80107614:	5e                   	pop    %esi
80107615:	5d                   	pop    %ebp
80107616:	c3                   	ret
80107617:	90                   	nop
80107618:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010761f:	00 

80107620 <kvmalloc>:
{
80107620:	55                   	push   %ebp
80107621:	89 e5                	mov    %esp,%ebp
80107623:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107626:	e8 75 ff ff ff       	call   801075a0 <setupkvm>
8010762b:	a3 e4 57 11 80       	mov    %eax,0x801157e4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107630:	05 00 00 00 80       	add    $0x80000000,%eax
80107635:	0f 22 d8             	mov    %eax,%cr3
}
80107638:	c9                   	leave
80107639:	c3                   	ret
8010763a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107640 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107640:	55                   	push   %ebp
80107641:	89 e5                	mov    %esp,%ebp
80107643:	83 ec 08             	sub    $0x8,%esp
80107646:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107649:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
8010764c:	89 c1                	mov    %eax,%ecx
8010764e:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107651:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107654:	f6 c2 01             	test   $0x1,%dl
80107657:	75 17                	jne    80107670 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80107659:	83 ec 0c             	sub    $0xc,%esp
8010765c:	68 dd 7d 10 80       	push   $0x80107ddd
80107661:	e8 3a 8d ff ff       	call   801003a0 <panic>
80107666:	66 90                	xchg   %ax,%ax
80107668:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010766f:	00 
  return &pgtab[PTX(va)];
80107670:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107673:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107679:	25 fc 0f 00 00       	and    $0xffc,%eax
8010767e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
80107685:	85 c0                	test   %eax,%eax
80107687:	74 d0                	je     80107659 <clearpteu+0x19>
  *pte &= ~PTE_U;
80107689:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010768c:	c9                   	leave
8010768d:	c3                   	ret
8010768e:	66 90                	xchg   %ax,%ax

80107690 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107690:	55                   	push   %ebp
80107691:	89 e5                	mov    %esp,%ebp
80107693:	57                   	push   %edi
80107694:	56                   	push   %esi
80107695:	53                   	push   %ebx
80107696:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107699:	e8 02 ff ff ff       	call   801075a0 <setupkvm>
8010769e:	85 c0                	test   %eax,%eax
801076a0:	0f 84 e1 00 00 00    	je     80107787 <copyuvm+0xf7>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801076a6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801076a9:	89 c2                	mov    %eax,%edx
801076ab:	85 c9                	test   %ecx,%ecx
801076ad:	0f 84 b5 00 00 00    	je     80107768 <copyuvm+0xd8>
801076b3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801076b6:	31 ff                	xor    %edi,%edi
801076b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801076bf:	00 
  if(*pde & PTE_P){
801076c0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
801076c3:	89 f8                	mov    %edi,%eax
801076c5:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
801076c8:	8b 04 81             	mov    (%ecx,%eax,4),%eax
801076cb:	a8 01                	test   $0x1,%al
801076cd:	75 11                	jne    801076e0 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
801076cf:	83 ec 0c             	sub    $0xc,%esp
801076d2:	68 e7 7d 10 80       	push   $0x80107de7
801076d7:	e8 c4 8c ff ff       	call   801003a0 <panic>
801076dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
801076e0:	89 fa                	mov    %edi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801076e2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
801076e7:	c1 ea 0a             	shr    $0xa,%edx
801076ea:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801076f0:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801076f7:	85 c0                	test   %eax,%eax
801076f9:	74 d4                	je     801076cf <copyuvm+0x3f>
    if(!(*pte & PTE_P))
801076fb:	8b 30                	mov    (%eax),%esi
801076fd:	f7 c6 01 00 00 00    	test   $0x1,%esi
80107703:	0f 84 98 00 00 00    	je     801077a1 <copyuvm+0x111>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
80107709:	e8 82 b1 ff ff       	call   80102890 <kalloc>
8010770e:	89 c3                	mov    %eax,%ebx
80107710:	85 c0                	test   %eax,%eax
80107712:	74 64                	je     80107778 <copyuvm+0xe8>
    pa = PTE_ADDR(*pte);
80107714:	89 f0                	mov    %esi,%eax
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107716:	83 ec 04             	sub    $0x4,%esp
    flags = PTE_FLAGS(*pte);
80107719:	81 e6 ff 0f 00 00    	and    $0xfff,%esi
    pa = PTE_ADDR(*pte);
8010771f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107724:	68 00 10 00 00       	push   $0x1000
80107729:	05 00 00 00 80       	add    $0x80000000,%eax
8010772e:	50                   	push   %eax
8010772f:	53                   	push   %ebx
80107730:	e8 5b d6 ff ff       	call   80104d90 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107735:	58                   	pop    %eax
80107736:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010773c:	5a                   	pop    %edx
8010773d:	56                   	push   %esi
8010773e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107743:	89 fa                	mov    %edi,%edx
80107745:	50                   	push   %eax
80107746:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107749:	e8 a2 f8 ff ff       	call   80106ff0 <mappages>
8010774e:	83 c4 10             	add    $0x10,%esp
80107751:	83 f8 ff             	cmp    $0xffffffff,%eax
80107754:	74 3a                	je     80107790 <copyuvm+0x100>
  for(i = 0; i < sz; i += PGSIZE){
80107756:	81 c7 00 10 00 00    	add    $0x1000,%edi
8010775c:	3b 7d 0c             	cmp    0xc(%ebp),%edi
8010775f:	0f 82 5b ff ff ff    	jb     801076c0 <copyuvm+0x30>
80107765:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  return d;

bad:
  freevm(d);
  return 0;
}
80107768:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010776b:	89 d0                	mov    %edx,%eax
8010776d:	5b                   	pop    %ebx
8010776e:	5e                   	pop    %esi
8010776f:	5f                   	pop    %edi
80107770:	5d                   	pop    %ebp
80107771:	c3                   	ret
80107772:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107778:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  freevm(d);
8010777b:	83 ec 0c             	sub    $0xc,%esp
8010777e:	52                   	push   %edx
8010777f:	e8 9c fd ff ff       	call   80107520 <freevm>
  return 0;
80107784:	83 c4 10             	add    $0x10,%esp
    return 0;
80107787:	31 d2                	xor    %edx,%edx
80107789:	eb dd                	jmp    80107768 <copyuvm+0xd8>
8010778b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      kfree(mem);
80107790:	83 ec 0c             	sub    $0xc,%esp
80107793:	53                   	push   %ebx
80107794:	e8 27 af ff ff       	call   801026c0 <kfree>
      goto bad;
80107799:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010779c:	83 c4 10             	add    $0x10,%esp
8010779f:	eb da                	jmp    8010777b <copyuvm+0xeb>
      panic("copyuvm: page not present");
801077a1:	83 ec 0c             	sub    $0xc,%esp
801077a4:	68 01 7e 10 80       	push   $0x80107e01
801077a9:	e8 f2 8b ff ff       	call   801003a0 <panic>
801077ae:	66 90                	xchg   %ax,%ax

801077b0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801077b0:	55                   	push   %ebp
801077b1:	89 e5                	mov    %esp,%ebp
801077b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
801077b6:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
801077b9:	89 c1                	mov    %eax,%ecx
801077bb:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
801077be:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
801077c1:	f6 c2 01             	test   $0x1,%dl
801077c4:	0f 84 f0 00 00 00    	je     801078ba <uva2ka.cold>
  return &pgtab[PTX(va)];
801077ca:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801077cd:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
801077d3:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
801077d4:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
801077d9:	8b 94 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%edx
  return (char*)P2V(PTE_ADDR(*pte));
801077e0:	89 d0                	mov    %edx,%eax
801077e2:	f7 d2                	not    %edx
801077e4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801077e9:	05 00 00 00 80       	add    $0x80000000,%eax
801077ee:	83 e2 05             	and    $0x5,%edx
801077f1:	ba 00 00 00 00       	mov    $0x0,%edx
801077f6:	0f 45 c2             	cmovne %edx,%eax
}
801077f9:	c3                   	ret
801077fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107800 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107800:	55                   	push   %ebp
80107801:	89 e5                	mov    %esp,%ebp
80107803:	57                   	push   %edi
80107804:	56                   	push   %esi
80107805:	53                   	push   %ebx
80107806:	83 ec 0c             	sub    $0xc,%esp
80107809:	8b 75 14             	mov    0x14(%ebp),%esi
8010780c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010780f:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107812:	85 f6                	test   %esi,%esi
80107814:	75 49                	jne    8010785f <copyout+0x5f>
80107816:	e9 95 00 00 00       	jmp    801078b0 <copyout+0xb0>
8010781b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  return (char*)P2V(PTE_ADDR(*pte));
80107820:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
80107825:	05 00 00 00 80       	add    $0x80000000,%eax
8010782a:	74 6e                	je     8010789a <copyout+0x9a>
      return -1;
    n = PGSIZE - (va - va0);
8010782c:	89 fb                	mov    %edi,%ebx
8010782e:	29 cb                	sub    %ecx,%ebx
80107830:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
80107836:	39 f3                	cmp    %esi,%ebx
80107838:	0f 47 de             	cmova  %esi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
8010783b:	29 f9                	sub    %edi,%ecx
8010783d:	83 ec 04             	sub    $0x4,%esp
80107840:	01 c8                	add    %ecx,%eax
80107842:	53                   	push   %ebx
80107843:	52                   	push   %edx
80107844:	89 55 10             	mov    %edx,0x10(%ebp)
80107847:	50                   	push   %eax
80107848:	e8 43 d5 ff ff       	call   80104d90 <memmove>
    len -= n;
    buf += n;
8010784d:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
80107850:	8d 8f 00 10 00 00    	lea    0x1000(%edi),%ecx
  while(len > 0){
80107856:	83 c4 10             	add    $0x10,%esp
    buf += n;
80107859:	01 da                	add    %ebx,%edx
  while(len > 0){
8010785b:	29 de                	sub    %ebx,%esi
8010785d:	74 51                	je     801078b0 <copyout+0xb0>
  if(*pde & PTE_P){
8010785f:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
80107862:	89 c8                	mov    %ecx,%eax
    va0 = (uint)PGROUNDDOWN(va);
80107864:	89 cf                	mov    %ecx,%edi
  pde = &pgdir[PDX(va)];
80107866:	c1 e8 16             	shr    $0x16,%eax
    va0 = (uint)PGROUNDDOWN(va);
80107869:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
8010786f:	8b 04 83             	mov    (%ebx,%eax,4),%eax
80107872:	a8 01                	test   $0x1,%al
80107874:	0f 84 47 00 00 00    	je     801078c1 <copyout.cold>
  return &pgtab[PTX(va)];
8010787a:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010787c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107881:	c1 eb 0c             	shr    $0xc,%ebx
80107884:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
8010788a:	8b 84 98 00 00 00 80 	mov    -0x80000000(%eax,%ebx,4),%eax
  if((*pte & PTE_U) == 0)
80107891:	89 c3                	mov    %eax,%ebx
80107893:	f7 d3                	not    %ebx
80107895:	83 e3 05             	and    $0x5,%ebx
80107898:	74 86                	je     80107820 <copyout+0x20>
  }
  return 0;
}
8010789a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010789d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801078a2:	5b                   	pop    %ebx
801078a3:	5e                   	pop    %esi
801078a4:	5f                   	pop    %edi
801078a5:	5d                   	pop    %ebp
801078a6:	c3                   	ret
801078a7:	90                   	nop
801078a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801078af:	00 
801078b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801078b3:	31 c0                	xor    %eax,%eax
}
801078b5:	5b                   	pop    %ebx
801078b6:	5e                   	pop    %esi
801078b7:	5f                   	pop    %edi
801078b8:	5d                   	pop    %ebp
801078b9:	c3                   	ret

801078ba <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
801078ba:	a1 00 00 00 00       	mov    0x0,%eax
801078bf:	0f 0b                	ud2

801078c1 <copyout.cold>:
801078c1:	a1 00 00 00 00       	mov    0x0,%eax
801078c6:	0f 0b                	ud2
