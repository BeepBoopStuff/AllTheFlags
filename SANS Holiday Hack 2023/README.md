![SANS 2024 Header](https://github.com/BeepBoopStuff/AllTheFlags/blob/a18e53b071317eb6c624e07373b111921afe15f3/SANS%20Holiday%20Hack%202024/sans_banner.jpg)
# SANS Holiday Hack 2023
## Challenge #1: Linux 101
![Linux101 Overview](https://github.com/BeepBoopStuff/AllTheFlags/blob/49b558a23822652672f15831564e769548035216/SANS%20Holiday%20Hack%202023/linux_101/Linux_101_header.png)

The North Pole 🎁 Present Maker:
All the presents on this system have been stolen by trolls. Capture trolls by following instructions here and 🎁's will appear in the green bar below. Run the command "hintme" to receive a hint.

### Before we Dive in.
As with a past year, I think 2020, this is the using Linux command line tutorial.

### The Challenge
#### TASK-1: Perform a directory listing of your home directory to find a troll and retrieve a present!
```bash
elf@51d9124a0b27:~$ ls
HELP  troll_19315479765589239  workshop
```
#### TASK-2: Now find the troll inside the troll.
```bash
elf@51d9124a0b27:~$ cat troll_19315479765589239
troll_24187022596776786
```
#### TASK-3: Great, now remove the troll in your home directory.
```bash
elf@51d9124a0b27:~$ rm troll_19315479765589239
```
#### TASK-4: Print the present working directory using a command.
```bash
elf@51d9124a0b27:~$ pwd
/home/elf
```
#### TASK-5: Good job but it looks like another troll hid itself in your home directory. Find the hidden troll!
```bash
elf@51d9124a0b27:~$ ls -a
.  ..  .bash_history  .bash_logout  .bashrc  .profile  .troll_5074624024543078  HELP  workshop
```
#### TASK-6: Excellent, now find the troll in your command history.
```bash
elf@51d9124a0b27:~$ history
    1  echo troll_9394554126440791
    2  ls
    3  clear
    4  ls
    5  ls troll_19315479765589239
    6  cat troll_19315479765589239
    7  rm troll_19315479765589239
    8  pwd
    9  ls -a
   10  history
```
#### TASK-7: Find the troll in your environment variables.
```bash
elf@51d9124a0b27:~$ env
SHELL=/bin/bash
TMUX=/tmp/tmux-1050/default,18,0
HOSTNAME=51d9124a0b27
RESOURCE_ID=2c467052-b4d9-4cdf-8a1d-aefb9382a1f1
GREENSTATUSPREFIX=presents
PWD=/home/elf
LOGNAME=elf
SESSNAME=Troll Wrangler
z_TROLL=troll_20249649541603754
HOME=/home/elf
LANG=C.UTF-8
LS_COLORS=rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:
HHCUSERNAME=BeepBoopStuff
AREA=cisantassurfshack
BPUSERHOME=/home/elf
LESSCLOSE=/usr/bin/lesspipe %s %s
TERM=screen
LESSOPEN=| /usr/bin/lesspipe %s
USER=elf
TOKENS=linux101
TMUX_PANE=%2
BPUSER=elf
SHLVL=3
LC_ALL=C.UTF-8
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
MAIL=/var/mail/elf
LOCATION=7,8
_=/usr/bin/env
```
#### TASK-8: Next, head into the workshop.
```bash
elf@51d9124a0b27:~$ ls
HELP  workshop
elf@51d9124a0b27:~$ cd workshop/
```
#### TASK-9: A troll is hiding in one of the workshop toolboxes. Use "grep" while ignoring case to find which toolbox the troll is in.
```bash
elf@51d9124a0b27:~/workshop$ grep -i "troll" *
grep: electrical: Is a directory
toolbox_191.txt:tRoLl.4056180441832623
```
#### TASK-10: A troll is blocking the present_engine from starting. Run the present_engine binary to retrieve this troll.
```bash
elf@51d9124a0b27:~/workshop$ chmod +x present_engine
elf@51d9124a0b27:~/workshop$ ./present_engine
troll.898906189498077
```
#### TASK-11: Trolls have blown the fuses in /home/elf/workshop/electrical. cd into electrical and rename blown_fuse0 to fuse0.
```bash
elf@51d9124a0b27:~/workshop$ cd electrical/
elf@51d9124a0b27:~/workshop/electrical$ ls
blown_fuse0
elf@51d9124a0b27:~/workshop/electrical$ mv blown_fuse0 fuse0
```
#### TASK-12: Now, make a symbolic link (symlink) named fuse1 that points to fuse0
```bash
elf@51d9124a0b27:~/workshop/electrical$ ln -s fuse0 fuse1
```
#### TASK-13: Make a copy of fuse1 named fuse2.
```bash
elf@51d9124a0b27:~/workshop/electrical$ cp fuse1 fuse2
```
#### TASK-14: We need to make sure trolls don't come back. Add the characters "TROLL_REPELLENT" into the file fuse2.
```bash
elf@51d9124a0b27:~/workshop/electrical$ echo "TROLL_REPELLENT" >> fuse2
```
#### TASK-15: Find the troll somewhere in /opt/troll_den.
```bash
elf@51d9124a0b27:~/workshop/electrical$ cd /opt/troll_den/
elf@51d9124a0b27:/opt/troll_den$ find . -iname "troll*"
./apps/showcase/src/main/resources/tRoLl.6253159819943018
```
#### TASK-16: Find the file somewhere in /opt/troll_den that is owned by the user troll.
```bash
elf@51d9124a0b27:/opt/troll_den$ find . -type f -user troll
./apps/showcase/src/main/resources/template/ajaxErrorContainers/tr0LL_9528909612014411
```
#### TASK-17: Find the file created by trolls that is greater than 108 kilobytes and less than 110 kilobytes located somewhere in /opt/troll_den.
```bash
elf@51d9124a0b27:/opt/troll_den$ find . -type f -size +108k -size -110k
./plugins/portlet-mocks/src/test/java/org/apache/t_r_o_l_l_2579728047101724
```
#### TASK-18: List running processes to find another troll.
```bash
elf@51d9124a0b27:/opt/troll_den$ ps -aux
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
init           1  0.0  0.0  20112 16252 pts/0    Ss+  Jun22   0:00 /usr/bin/python3 /usr/local/bin/tmuxp load ./mysession.yaml
elf        30516  0.4  0.1  31520 26484 pts/2    S+   00:06   0:00 /usr/bin/python3 /14516_troll
elf        30962  0.0  0.0   7672  3152 pts/3    R+   00:07   0:00 ps -aux
```
#### TASK-19: The 14516_troll process is listening on a TCP port. Use a command to have the only listening port display to the screen.
```bash
elf@51d9124a0b27:/opt/troll_den$ netstat -l
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State      
tcp        0      0 0.0.0.0:54321           0.0.0.0:*               LISTEN     
Active UNIX domain sockets (only servers)
Proto RefCnt Flags       Type       State         I-Node   Path
unix  2      [ ACC ]     STREAM     LISTENING     258379   /tmp/tmux-1050/default
```
#### TASK-20: The service listening on port 54321 is an HTTP server. Interact with this server to retrieve the last troll.
```bash
elf@51d9124a0b27:/opt/troll_den$ curl http://127.0.0.1:54321
troll.73180338045875
```
#### TASK-21: Your final task is to stop the 14516_troll process to collect the remaining presents.
From Task-18 we can find the PID for the 14516_troll process.
```bash
elf@51d9124a0b27:/opt/troll_den$ ps -aux
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
init           1  0.0  0.0  20112 16252 pts/0    Ss+  Jun22   0:00 /usr/bin/python3 /usr/local/bin/tmuxp load ./mysession.yaml
elf        30516  0.4  0.1  31520 26484 pts/2    S+   00:06   0:00 /usr/bin/python3 /14516_troll
elf        30962  0.0  0.0   7672  3152 pts/3    R+   00:07   0:00 ps -aux
```
Using thhe found PID we can then kill the process.
```bash
elf@0f34a7e2bd44:~/workshop/electrical$ kill 3510
```

### Final Thoughts
We did it! This one is always kind of easy as long as you know basic Linux commands.

![Linux101 Completed](https://github.com/BeepBoopStuff/AllTheFlags/blob/49b558a23822652672f15831564e769548035216/SANS%20Holiday%20Hack%202023/linux_101/Linux_101_complete.png)
