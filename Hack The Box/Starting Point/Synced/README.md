# Synced

![](assets/8SW607xSMon7em9gPHmxY6QMHqYIqIJV3mLHNwn_bPY=.png)

# Initial Recon

IP address: 10.129.228.37

```shellscript
$ ping 10.129.228.37
PING 10.129.228.37 (10.129.228.37) 56(84) bytes of data.
64 bytes from 10.129.228.37: icmp_seq=1 ttl=63 time=28.4 ms
64 bytes from 10.129.228.37: icmp_seq=2 ttl=63 time=29.0 ms
64 bytes from 10.129.228.37: icmp_seq=3 ttl=63 time=29.1 ms
64 bytes from 10.129.228.37: icmp_seq=4 ttl=63 time=26.7 ms
^C
--- 10.129.228.37 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3004ms
rtt min/avg/max/mdev = 26.663/28.286/29.096/0.975 ms
```

Looks like we can chat with the box and it is probably Linux from the TTL. Okay let's do a port scan.

```
Nmap scan report for 10.129.228.37
Host is up, received reset ttl 63 (0.027s latency).
Scanned at 2025-01-16 15:44:32 EST for 11s

PORT    STATE SERVICE REASON         VERSION
873/tcp open  rsync   syn-ack ttl 63 (protocol version 31)
Warning: OSScan results may be unreliable because we could not find at least 1 open and 1 closed port
Device type: general purpose
Running: Linux 4.X|5.X
OS CPE: cpe:/o:linux:linux_kernel:4 cpe:/o:linux:linux_kernel:5
OS details: Linux 4.15 - 5.19
TCP/IP fingerprint:
OS:SCAN(V=7.95%E=4%D=1/16%OT=873%CT=%CU=41661%PV=Y%DS=2%DC=T%G=N%TM=67896FB
OS:B%P=x86_64-pc-linux-gnu)SEQ(SP=103%GCD=1%ISR=10C%TI=Z%CI=Z%II=I%TS=A)OPS
OS:(O1=M53CST11NW7%O2=M53CST11NW7%O3=M53CNNT11NW7%O4=M53CST11NW7%O5=M53CST1
OS:1NW7%O6=M53CST11)WIN(W1=FE88%W2=FE88%W3=FE88%W4=FE88%W5=FE88%W6=FE88)ECN
OS:(R=Y%DF=Y%T=40%W=FAF0%O=M53CNNSNW7%CC=Y%Q=)T1(R=Y%DF=Y%T=40%S=O%A=S+%F=A
OS:S%RD=0%Q=)T2(R=N)T3(R=N)T4(R=Y%DF=Y%T=40%W=0%S=A%A=Z%F=R%O=%RD=0%Q=)T5(R
OS:=Y%DF=Y%T=40%W=0%S=Z%A=S+%F=AR%O=%RD=0%Q=)T6(R=Y%DF=Y%T=40%W=0%S=A%A=Z%F
OS:=R%O=%RD=0%Q=)T7(R=Y%DF=Y%T=40%W=0%S=Z%A=S+%F=AR%O=%RD=0%Q=)U1(R=Y%DF=N%
OS:T=40%IPL=164%UN=0%RIPL=G%RID=G%RIPCK=G%RUCK=G%RUD=G)IE(R=Y%DFI=N%T=40%CD
OS:=S)

Uptime guess: 46.117 days (since Sun Dec  1 12:56:49 2024)
Network Distance: 2 hops
TCP Sequence Prediction: Difficulty=259 (Good luck!)
IP ID Sequence Generation: All zeros

TRACEROUTE (using port 80/tcp)
HOP RTT      ADDRESS
1   26.09 ms 10.10.14.1
2   26.20 ms 10.129.228.37

NSE: Script Post-scanning.
NSE: Starting runlevel 1 (of 3) scan.
Initiating NSE at 15:44
Completed NSE at 15:44, 0.00s elapsed
NSE: Starting runlevel 2 (of 3) scan.
Initiating NSE at 15:44
Completed NSE at 15:44, 0.00s elapsed
NSE: Starting runlevel 3 (of 3) scan.
Initiating NSE at 15:44
Completed NSE at 15:44, 0.00s elapsed
Read data files from: /usr/share/nmap
OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 11.09 seconds
           Raw packets sent: 37 (2.374KB) | Rcvd: 27 (1.802KB)
```

# Rsync (873/TCP)

We can use the rsync command to list directories and see if creds are required.

```shellscript
$ rsync -av --list-only rsync://10.129.228.37
public          Anonymous Share
```

We can take a look at the public folder

```shellscript
$ rsync -av --list-only rsync://10.129.228.37/public
receiving incremental file list
drwxr-xr-x          4,096 2022/10/24 18:02:23 .
-rw-r--r--             33 2022/10/24 17:32:03 flag.txt
```

We found the flag, we should be able to download the file via rsync

```shellscript
$ rsync -av rsync://10.129.228.37/public/flag.txt ./.
receiving incremental file list
flag.txt

sent 43 bytes  received 135 bytes  18.74 bytes/sec
total size is 33  speedup is 0.19
```
