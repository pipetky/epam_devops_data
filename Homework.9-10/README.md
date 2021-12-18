### Processes
1. Run a sleep command three times at different intervals
```
superadmin@PipetkyBook:~$ sleep 1000 &
[1] 52831
superadmin@PipetkyBook:~$ sleep 2000 &
[2] 52834
superadmin@PipetkyBook:~$ sleep 3000 &
[3] 52836
```
2. Send a SIGSTOP signal to all of them in three different ways.
```
superadmin@PipetkyBook:~$ kill -SIGSTOP 52831

[1]+  Остановлен    sleep 1000
superadmin@PipetkyBook:~$ kill -19 52834

[2]+  Остановлен    sleep 2000
superadmin@PipetkyBook:~$ kill -s SIGSTOP 52836

[3]+  Остановлен    sleep 3000
```
3. Check their statuses with a job command
```
superadmin@PipetkyBook:~$ jobs 1 2 3
[1]   Остановлен    sleep 1000
[2]-  Остановлен    sleep 2000
[3]+  Остановлен    sleep 3000
```
4. Terminate one of them. (Any)
```
superadmin@PipetkyBook:~$ kill -SIGTERM $(jobs -p 1)
```
5. To other send a SIGCONT in two different ways.
```
superadmin@PipetkyBook:~$ kill -s SIGCONT $(jobs -p 2)
superadmin@PipetkyBook:~$ kill -15 $(jobs -p 3)

```
6. Kill one by PID and the second one by job ID
```
superadmin@PipetkyBook:~$ kill 52834
superadmin@PipetkyBook:~$ kill -9 $(jobs -p 3)
```
### systemd
1. Write two daemons: one should be a simple daemon and do sleep 10 after a start and 
then do echo 1 > /tmp/homework, the second one should be oneshot and do echo 2 > 
/tmp/homework without any sleep
2. Make the second depended on the first one (should start only after the first)
3. Write a timer for the second one and configure it to run on 01.01.2019 at 00:00
4. Start all daemons and timer, check their statuses, timer list and /tmp/homework
5. Stop all daemons and timer
```
[root@localhost superadmin]# cat /etc/systemd/system/first.service 
[Unit]
Description=The first daemon for homework 9-10

[Service]
Type=simple
ExecStart=/bin/bash -c "sleep 10 && echo 1 > /tmp/homework"

[Install]
WantedBy=multi-user.target
[root@localhost superadmin]# cat /etc/systemd/system/second.service 
[Unit]
Description=The second daemon for homework 9-10
Requires=first.Service

[Service]
Type=oneshot
ExecStart=/bin/bash -c "echo 2 > /tmp/homework"

[Install]
WantedBy=multi-user.target
[root@localhost superadmin]# cat /etc/systemd/system/second.timer 
[Unit]
Description=Timer for second service
Requires=second.service

[Timer]
Unit=second.service
OnCalendar=2019-01-01 00:00

[Install]
WantedBy=timers.target
[root@localhost superadmin]# systemctl start first
[root@localhost superadmin]# systemctl start second
[root@localhost superadmin]# systemctl start second.timer
[root@localhost superadmin]# systemctl status first
● first.service - The first daemon for homework 9-10
   Loaded: loaded (/etc/systemd/system/first.service; disabled; vendor preset: disabled)
   Active: inactive (dead)

Dec 15 23:36:41 localhost.localdomain systemd[1]: Started The first daemon for homework 9-10.
[root@localhost superadmin]# systemctl status second
● second.service - The second daemon for homework 9-10
   Loaded: loaded (/etc/systemd/system/second.service; disabled; vendor preset: disabled)
   Active: inactive (dead) since Wed 2021-12-15 23:36:57 MSK; 19s ago
  Process: 1537 ExecStart=/bin/bash -c echo 2 > /tmp/homework (code=exited, status=0/SUCCESS)
 Main PID: 1537 (code=exited, status=0/SUCCESS)

Dec 15 23:36:57 localhost.localdomain systemd[1]: Starting The second daemon for homework 9-10...
Dec 15 23:36:57 localhost.localdomain systemd[1]: Started The second daemon for homework 9-10.
[root@localhost superadmin]# systemctl list-timers second.timer
NEXT LEFT LAST PASSED UNIT         ACTIVATES
n/a  n/a  n/a  n/a    second.timer second.service

1 timers listed.
Pass --all to see loaded but inactive timers, too.
[root@localhost superadmin]# cat /tmp/homework 
2
```
### cron/anacron
1. Create an anacron job which executes a script with echo Hello > /opt/hello and runs 
every 2 days
```
[root@localhost superadmin]# echo "2 0 Homework.9-10 echo Hello > /opt/hello" >> /etc/anacrontab 
[root@localhost superadmin]# anacron -T
[root@localhost superadmin]# cat /etc/anacrontab 
# /etc/anacrontab: configuration file for anacron

# See anacron(8) and anacrontab(5) for details.

SHELL=/bin/sh
PATH=/sbin:/bin:/usr/sbin:/usr/bin
MAILTO=root
# the maximal random delay added to the base delay of the jobs
RANDOM_DELAY=45
# the jobs will be started during the following hours only
START_HOURS_RANGE=3-22

#period in days   delay in minutes   job-identifier   command
1       5       cron.daily              nice run-parts /etc/cron.daily
7       25      cron.weekly             nice run-parts /etc/cron.weekly
@monthly 45     cron.monthly            nice run-parts /etc/cron.monthly
2 0 Homework.9-10 echo Hello > /opt/hello

```
2. Create a cron job which executes the same command (will be better to create a script for 
this) and runs it in 1 minute after system boot.
```
[root@localhost superadmin]# crontab -l
@reboot /bin/bash -c "sleep 60 && /home/superadmin/./hello.sh"
[root@localhost superadmin]# cat hello.sh 
echo Hello > /opt/hello
[root@localhost superadmin]# chmod +x hello.sh
```

3. Restart your virtual machine and check previous job proper execution
```
[superadmin@localhost ~]$ ls /opt/
[superadmin@localhost ~]$ date
Sat Dec 18 13:58:09 MSK 2021
[superadmin@localhost ~]$ ls /opt/
hello
[superadmin@localhost ~]$ date
Sat Dec 18 14:01:28 MSK 2021
[superadmin@localhost ~]$ cat /opt/hello 
Hello
[superadmin@localhost ~]$ 
```
-----
### lsof
1. Run a sleep command, redirect stdout and stderr into two different files (both of them will 
be empty).
2. Find with the lsof command which files this process uses, also find from which file it gain 
stdin.
```
[root@localhost superadmin]# lsof -p 1619 |grep 0u
sleep   1619 root    0u   CHR  136,0       0t0        3 /dev/pts/0
```
**It gains stdin from /dev/pts/0 and uses the following file:**  
```
[root@localhost superadmin]# lsof -p 1619 |grep REG
sleep   1619 root  txt    REG  253,0     33128 50658485 /usr/bin/sleep
sleep   1619 root  mem    REG  253,0 106172832 50333163 /usr/lib/locale/locale-archive
sleep   1619 root  mem    REG  253,0   2156272    34873 /usr/lib64/libc-2.17.so
sleep   1619 root  mem    REG  253,0    163312    34866 /usr/lib64/ld-2.17.so
sleep   1619 root    1w   REG  253,0         0    21761 /home/superadmin/stdout
sleep   1619 root    2w   REG  253,0         0    21807 /home/superadmin/stderr
```
3. List all ESTABLISHED TCP connections ONLY with lsof
```
[root@localhost superadmin]# lsof -i -sTCP:ESTABLISHED
COMMAND  PID       USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
sshd    1476       root    3u  IPv4  17150      0t0  TCP localhost.localdomain:ssh->192.168.41.2:52676 (ESTABLISHED)
sshd    1479 superadmin    3u  IPv4  17150      0t0  TCP localhost.localdomain:ssh->192.168.41.2:52676 (ESTABLISHED)
```