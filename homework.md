1. Внутри директории /usr/share/man (хранилище встроенной документации) находятся каталоги, разбитые по секциям разделов помощи (man1, man2, man3) и по языкам (es, fr, ru).
Используя команду ls, необходимо вывести на экран все файлы, которые расположены в секционных директориях /usr/share/man/manX и содержат слово "config" в имени. Одним вызовом ls найти все файлы, содержащие слово "system" в каталогах /usr/share/man/man1 и /usr/share/man/man7
**Ответ:**
```
[superadmin@localhost ~]$ ls /usr/share/man/man[0-9] |grep config
pkg-config.1.gz
config.5ssl.gz
config-util.5.gz
selinux_config.5.gz
ssh_config.5.gz
sshd_config.5.gz
x509v3_config.5ssl.gz
authconfig.8.gz
authconfig-tui.8.gz
chkconfig.8.gz
grub2-mkconfig.8.gz
iprconfig.8.gz
lvm-config.8.gz
lvmconfig.8.gz
lvm-dumpconfig.8.gz
sg_get_config.8.gz
sys-unconfig.8.gz

```
```
[superadmin@localhost ~]$ ls /usr/share/man/man[1,7] |grep system
systemctl.1.gz
systemd.1.gz
systemd-analyze.1.gz
systemd-ask-password.1.gz
systemd-bootchart.1.gz
systemd-cat.1.gz
systemd-cgls.1.gz
systemd-cgtop.1.gz
systemd-delta.1.gz
systemd-detect-virt.1.gz
systemd-escape.1.gz
systemd-firstboot.1.gz
systemd-firstboot.service.1.gz
systemd-inhibit.1.gz
systemd-machine-id-commit.1.gz
systemd-machine-id-setup.1.gz
systemd-notify.1.gz
systemd-nspawn.1.gz
systemd-path.1.gz
systemd-run.1.gz
systemd-tty-ask-password-agent.1.gz
lvmsystemid.7.gz
systemd.directives.7.gz
systemd.generator.7.gz
systemd.index.7.gz
systemd.journal-fields.7.gz
systemd.special.7.gz
systemd.time.7.gz
```
2. Самостоятельно изучить команду find, предназначенную для поиска файлов/папок по заданным условиям (man find, find --help).
Найти в директории /usr/share/man все файлы, которые содержат слово "help" в имени, найти там же все файлы, имя которых начинается на "conf".
Какие действия мы можем выполнить с файлами, найденными командой find (не запуская других команд)? Приведите любой пример с комментарием.<br/>
**Ответ:**
```
[superadmin@localhost ~]$ find  /usr/share/man/ -type f -iname "*help*"
/usr/share/man/man1/help.1.gz
/usr/share/man/man5/firewalld.helper.5.gz
/usr/share/man/man8/mkhomedir_helper.8.gz
/usr/share/man/man8/pwhistory_helper.8.gz
/usr/share/man/man8/ssh-pkcs11-helper.8.gz
```
```
[superadmin@localhost ~]$ find  /usr/share/man/ -type f -iname "conf*"
/usr/share/man/man5/config.5ssl.gz
/usr/share/man/man5/config-util.5.gz
```
Добавив -delete можем удалить найденные файлы

3. При помощи команд head и tail, выведите последние 2 строки файла /etc/fstab и первые 7 строк файла /etc/yum.conf
Что произойдёт, если мы запросим больше строк, чем есть в файле? Попробуйте выполнить это на примере, используя команду wc (word cound) для подсчёта количества строк в файле.<br/>
**Ответ:**
```
[superadmin@localhost ~]$ head -n 7 /etc/yum.conf 
[main]
cachedir=/var/cache/yum/$basearch/$releasever
keepcache=0
debuglevel=2
logfile=/var/log/yum.log
exactarch=1
obsoletes=1
```
```
[superadmin@localhost ~]$ tail -n 2 /etc/fstab 
UUID=125c0ab9-c2f4-4f5a-920f-c083824a0ede /boot                   xfs     defaults        0 0
/dev/mapper/centos-swap swap                    swap    defaults        0 0
```
Ничего особенного не произойдет, просто выведется весь файл
```
[superadmin@localhost ~]$ wc -l /etc/yum.conf 
26 /etc/yum.conf
[superadmin@localhost ~]$ head -n 27 /etc/yum.conf 
[main]
cachedir=/var/cache/yum/$basearch/$releasever
keepcache=0
debuglevel=2
logfile=/var/log/yum.log
exactarch=1
obsoletes=1
gpgcheck=1
plugins=1
installonly_limit=5
bugtracker_url=http://bugs.centos.org/set_project.php?project_id=23&ref=http://bugs.centos.org/bug_report_page.php?category=yum
distroverpkg=centos-release


#  This is the default, if you make this bigger yum won't see if the metadata
# is newer on the remote and so you'll "gain" the bandwidth of not having to
# download the new metadata and "pay" for it by yum not having correct
# information.
#  It is esp. important, to have correct metadata, for distributions like
# Fedora which don't keep old packages around. If you don't like this checking
# interupting your command line usage, it's much better to have something
# manually check the metadata once an hour (yum-updatesd will do this).
# metadata_expire=90m

# PUT YOUR REPOS HERE OR IN separate files named file.repo
# in /etc/yum.repos.d

```
4. Создайте в домашней директории файлы file_name1.md, file_name2.md и file_name3.md. Используя {}, переименуйте:
file_name1.md в file_name1.textdoc
file_name2.md в file_name2
file_name3.md в file_name3.md.latest
file_name1.textdoc в file_name1.txt<br/>
**Ответ:**
```
[superadmin@localhost ~]$ touch ~/file_name{1..3}.md
[superadmin@localhost ~]$ ls
file_name1.md  file_name2.md  file_name3.md
[superadmin@localhost ~]$ mv file_name1.md file_name1.textdoc
[superadmin@localhost ~]$ mv file_name2.md file_name2
[superadmin@localhost ~]$ mv file_name3.md file_name3.md.latest
[superadmin@localhost ~]$ mv file_name1.textdoc file_name1.txt
[superadmin@localhost ~]$ ls
file_name1.txt  file_name2  file_name3.md.latest
```

5. Перейдите в директорию /mnt. Напишите как можно больше различных вариантов команды cd, с помощью которых вы можете вернуться обратно в домашнюю директорию вашего пользователя. Различные относительные пути также считаются разными вариантами.<br/>
**Ответ:**
```
[superadmin@localhost ~]$ cd /mnt

cd
cd ~/
cd /home/superadmin
cd ../home/superadmin
cd -
```
6. Создайте одной командой в домашней директории 3 папки new, in-process, processed. При этом in-process должна содержать в себе еще 3 папки tread0, tread1, tread2.
Далее создайте 100 файлов формата data[[:digit:]][[:digit:]] в папке new
Скопируйте 34 файла в tread0 и по 33 в tread1 и tread2 соответственно. Выведете содержимое каталога in-process одной командой
После этого переместите все файлы из каталогов tread в processed одной командой. Выведете содержимое каталога in-process и processed опять же одной командой
Сравните количество файлов в каталогах new и processed при помощи изученных ранее команд, если они равны удалите файлы из new<br/>
\*\* Сравнение количества и удаление сделано при помощи условия<br/>

**Ответ:**
```
[superadmin@localhost ~]$ mkdir -p new processed in-process/tread0 in-process/tread1 in-process/tread2
[superadmin@localhost ~]$ touch new/data{0..9}{0..9}
[superadmin@localhost ~]$ cp new/data{00..33} in-process/tread0/
[superadmin@localhost ~]$ cp new/data{34..66} in-process/tread1/
[superadmin@localhost ~]$ cp new/data{67..99} in-process/tread2/
[superadmin@localhost ~]$ ls -R in-process/
in-process/:
tread0  tread1  tread2

in-process/tread0:
data00  data03  data06  data09  data12  data15  data18  data21  data24  data27  data30  data33
data01  data04  data07  data10  data13  data16  data19  data22  data25  data28  data31
data02  data05  data08  data11  data14  data17  data20  data23  data26  data29  data32

in-process/tread1:
data34  data37  data40  data43  data46  data49  data52  data55  data58  data61  data64
data35  data38  data41  data44  data47  data50  data53  data56  data59  data62  data65
data36  data39  data42  data45  data48  data51  data54  data57  data60  data63  data66

in-process/tread2:
data67  data70  data73  data76  data79  data82  data85  data88  data91  data94  data97
data68  data71  data74  data77  data80  data83  data86  data89  data92  data95  data98
data69  data72  data75  data78  data81  data84  data87  data90  data93  data96  data99

[superadmin@localhost ~]$ mv in-process/tread*/* processed/
[superadmin@localhost ~]$ ls -R in-process/ processed/
in-process/:
tread0  tread1  tread2

in-process/tread0:

in-process/tread1:

in-process/tread2:

processed/:
data00  data07  data14  data21  data28  data35  data42  data49  data56  data63  data70  data77  data84  data91  data98
data01  data08  data15  data22  data29  data36  data43  data50  data57  data64  data71  data78  data85  data92  data99
data02  data09  data16  data23  data30  data37  data44  data51  data58  data65  data72  data79  data86  data93
data03  data10  data17  data24  data31  data38  data45  data52  data59  data66  data73  data80  data87  data94
data04  data11  data18  data25  data32  data39  data46  data53  data60  data67  data74  data81  data88  data95
data05  data12  data19  data26  data33  data40  data47  data54  data61  data68  data75  data82  data89  data96
data06  data13  data20  data27  data34  data41  data48  data55  data62  data69  data76  data83  data90  data97

if [[ $(ls processed/ | wc -l) -eq $(ls new/ | wc -l) ]]; then rm new/*; fi
```

7. \* Получить разворачивание фигурных скобок для выражения. Согласно стандартному поведению bash, стандартного для <br/>CentOS 7, скобки в приведённом ниже выражении развёрнуты не будут. Необходимо найти способ получить ожидаемый вывод.
a=1; b=3
echo file{$a..$b}
Необходимо предоставить модицицированную команду, результатом которой является следующий вывод: 
file1 file2 file3<br/>
**Ответ:**
```
[superadmin@localhost ~]$ eval echo file{$a..$b}
file1 file2 file3
```