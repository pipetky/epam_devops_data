### Task 1: Users and groups
Используйте команды: groupadd, useradd, passwd, chage и другие.  
Создайте группу sales с GID 4000 и пользователей bob, alice, eve c основной группой sales.  
```
[root@localhost superadmin]# groupadd -g 4000 sales
[root@localhost superadmin]# adduser -g sales bob && adduser -g sales alice && adduser -g sales eve
```
Измените пользователям пароли.
```
[root@localhost superadmin]# passwd bob
Changing password for user bob.
New password: 
Retype new password: 
passwd: all authentication tokens updated successfully.
[root@localhost superadmin]# passwd alice
Changing password for user alice.
New password: 
Retype new password: 
passwd: all authentication tokens updated successfully.
[root@localhost superadmin]# passwd eve
Changing password for user eve.
New password: 
Retype new password: 
passwd: all authentication tokens updated successfully.
```
Все новые аккаунты должны обязательно менять свои пароли 
каждый 30 дней.
```
[root@localhost superadmin]# sed -in 's/PASS_MAX_DAYS.*/PASS_MAX_DAYS  30/' /etc/login.defs 
```
Новые аккаунты группы sales должны истечь по окончанию 90 
дней срока, а bob должен изменять его пароль каждые 15 
дней.
** С такой формулировкой сделать невозможно или я не знаю как, делаю с такой: 
Все существующие аккаунты группы sales должны истечь по окончанию 90 
дней срока, а bob должен изменять его пароль каждые 15 
дней. **
```
[root@localhost superadmin]# for user in $(grep 4000 /etc/passwd | awk -F: '{print $1}') ;do usermod -e  $(date +"%Y-%m-%d" -d "+90 days") $user; done
[root@localhost superadmin]# chage -M 15 bob
[root@localhost superadmin]# chage -l bob
Last password change                                    : password must be changed
Password expires                                        : password must be changed
Password inactive                                       : password must be changed
Account expires                                         : Mar 15, 2022
Minimum number of days between password change          : 0
Maximum number of days between password change          : 15
Number of days of warning before password expires       : 7
```
Дополнительно:
Заставьте пользователей сменить пароль после первого 
логина.
```
[root@localhost superadmin]# chage -d 0 bob
[root@localhost superadmin]# chage -d 0 alice
[root@localhost superadmin]# chage -d 0 eve
```
Предварительный шаг:
Исследуйте файл /etc/login.defs.
Исследуйте, как работает команда date и как её использовать 
совместно с chage.
### Task 2: Controlling access to files with Linux 
###### file system permissions
Используйте команды: su, mkdir, chown, chmod и другие.
Создайте трёх пользователей glen, antony, lesly.
У вас должна быть директория /home/students, где эти три 
пользователя могут работать совместно с файлами.
Должен быть возможен только пользовательский и групповой 
доступ, создание и удаление файлов в /home/students. 
Файлы, созданные в этой директории, должны автоматически 
присваиваться группе студентов students.
```
[root@localhost home]# groupadd students
[root@localhost home]# useradd -g students glen
[root@localhost home]# useradd -g students antony
[root@localhost home]# useradd -g students lesly
[root@localhost home]# mkdir students
[root@localhost home]# chmod 770 students/
[root@localhost home]# chgrp students students/
[root@localhost home]# chmod g+s students/
[root@localhost home]# ls -la
total 0
drwxr-xr-x. 10 root       root       114 Dec 15 00:44 .
dr-xr-xr-x. 17 root       root       224 Nov 25 19:10 ..
drwx------.  2 antony     students    62 Dec 15 00:44 antony
drwx------.  2 glen       students    62 Dec 15 00:44 glen
drwx------.  2 lesly      students    62 Dec 15 00:44 lesly
drwxrws---.  2 root       students     6 Dec 15 00:44 students
drwx------.  3 superadmin superadmin 229 Dec  2 13:51 superadmin
[root@localhost home]# echo "umask 0007" >> /home/antony/.bashrc 
[root@localhost home]# echo "umask 0007" >> /home/glen/.bashrc 
[root@localhost home]# echo "umask 0007" >> /home/lesly/.bashrc 
[root@localhost home]# su antony
[antony@localhost home]$ rm students/file 
[antony@localhost home]$ touch students/file
[antony@localhost home]$ ls -la students/
total 0
drwxrws---.  2 root   students  18 Dec 15 00:50 .
drwxr-xr-x. 10 root   root     114 Dec 15 00:44 ..
-rw-rw----.  1 antony students   0 Dec 15 00:50 file
[antony@localhost home]$ exit
exit
[root@localhost home]# su lesly/
su: user lesly/ does not exist
[root@localhost home]# su lesly
[lesly@localhost home]$ rm students/file 
[lesly@localhost home]$ ls students/
[lesly@localhost home]$ 
```
Предварительный шаг:
Исследуйте, для чего нужны файлы .bashrc и .profile.
### Task3: ACL
Детективное агентство Бейкер Стрит создает коллекцию 
совместного доступа для хранения файлов дел, в которых 
члены группы bakerstreet будут иметь права на чтение и 
запись.
Ведущий детектив, Шерлок Холмс, решил, что члены группы 
scotlandyard также должны иметь возможность читать и 
писать в общую директорию. Тем не менее, Холмс считает, что 
инспектор Джонс является достаточно растерянным, и поэтому 
он должен иметь доступ только для чтения. 
Миссис Хадсон только начала осваивать Linux и смогла создать 
общую директорию и скопировать туда несколько файлов. Но 
сейчас время чаепития, и она попросила вас закончить работу.
Ваша задача - завершить настройку директории общего 
доступа. 
Директория и всё её содержимое должно принадлежать группе
bakerstreet, при этом файлы должны обновляться для чтения 
и записи для владельца и группы (bakerstreet). У других 
пользователей не должно быть никаких разрешений. 
Вам также необходимо предоставить доступы на чтение и 
запись для группы scotlandyard, за исключением Jones, 
который может только читать документы.
Убедитесь, что ваша настройка применима к существующим и 
будущим файлам. После установки всех разрешений в 
директории проверьте от каждого пользователя все его 
возможные доступы.
Используйте команды: touch, mkdir, chgrp, chmod, getfacl, setfacl
и другие. 
Создайте общую директорию /share/cases.
Создайте группу bakerstreet с пользователями holmes, 
watson.
Создайте группу scotlandyard с пользователями lestrade, 
gregson, jones.
Задайте всем пользователям безопасные пароли.
```
[root@localhost superadmin]# mkdir -p /share/cases
[root@localhost superadmin]# groupadd bakerstreet
[root@localhost superadmin]# useradd -g bakerstreet holmes
[root@localhost superadmin]# useradd -g bakerstreet watson
[root@localhost superadmin]# groupadd scotlandyard
[root@localhost superadmin]# useradd -g scotlandyard lestrade
[root@localhost superadmin]# useradd -g scotlandyard gregson
[root@localhost superadmin]# useradd -g scotlandyard jones
[root@localhost superadmin]# chgrp bakerstreet /share/cases/
[root@localhost superadmin]# chmod 770 /share/cases/
[root@localhost superadmin]# chmod g+s /share/cases/
[root@localhost superadmin]# setfacl -m g:scotlandyard:rwx /share/cases/
[root@localhost superadmin]# setfacl -m u:jones:rx /share/cases/
[root@localhost superadmin]# touch /share/cases/murders.txt
[root@localhost superadmin]# touch /share/cases/moriarty.txt

[root@localhost superadmin]# ls -la /share/cases/
total 0
drwxrws---+ 2 root bakerstreet 45 Dec 15 16:23 .
drwxr-xr-x. 3 root root        19 Dec 15 11:47 ..
-rw-rw----+ 1 root bakerstreet  0 Dec 15 16:23 moriarty.txt
-rw-rw----+ 1 root bakerstreet  0 Dec 15 16:22 murders.txt

[root@localhost superadmin]# getfacl /share/cases/murders.txt 
getfacl: Removing leading '/' from absolute path names
# file: share/cases/murders.txt
# owner: root
# group: bakerstreet
user::rw-
user:jones:r-x                  #effective:r--
group::rwx                      #effective:rw-
group:scotlandyard:rwx          #effective:rw-
mask::rw-
other::---

[root@localhost superadmin]# su jones
[jones@localhost superadmin]$ echo "test" >> /share/cases/murders.txt 
bash: /share/cases/murders.txt: Permission denied

[root@localhost superadmin]# su holmes
[holmes@localhost superadmin]$ echo "some victim" >> /share/cases/murders.txt
[holmes@localhost superadmin]$ cat /share/cases/murders.txt 
some victim

[root@localhost superadmin]# su lestrade
[lestrade@localhost superadmin]$ echo "another_victim" >> /share/cases/murders.txt
[lestrade@localhost superadmin]$ cat /share/cases/murders.txt 
some victim
another_victim
```
Предварительный шаг:
От суперпользователя создайте папку /share/cases и создайте 
внутри 2 файла murders.txt и moriarty.txt.
