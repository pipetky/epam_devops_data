### Задача:
Установить, настроить и запустить Hadoop Сore в минимальной конфигурации. Для этого потребуется подготовить 2 виртуальные машины: VM1 - headnode; VM2 - worker. Понимание принципов работы Hadoop и его компонентов для успешной сдачи задания не требуется.
Все инструкции и команды для каждого шага задания должны быть сохранены в файле.
#### Детальная формулировка:
1. Установить CentOS на 2 виртуальные машины:
	VM1: 2CPU, 2-4G памяти, системный диск на 15-20G и дополнительные 2 диска по 5G
	VM2: 2CPU, 2-4G памяти, системный диск на 15-20G и дополнительные 2 диска по 5G
Все дальнейшие действия будут выполняться на обеих машинах, если не сказано иначе.
2. При установке CentOS создать дополнительного пользователя exam и настроить для него использование sudo без пароля. Все последующие действия необходимо выполнять от этого пользователя, если не указано иное.
```
[exam@localhost ~]$ echo "exam ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers
```
**vm1:**<br>
```
[exam@localhost ~]$ sudo nmcli con mod eth0 ipv4.addresses 192.168.3.100/22 ipv4.gateway 192.168.0.28 ipv4.dns "192.168.0.2 192.168.0.4" ipv4.method manual connection.autoconnect yes && sudo nmcli con up eth0
[exam@localhost ~]$ sudo sed -i s/localhost/headnode/ /etc/hostname
```
**vm2**<br>
```
[exam@localhost ~]$ sudo nmcli con mod eth0 ipv4.addresses 192.168.3.101/22 ipv4.gateway 192.168.0.28 ipv4.dns "192.168.0.2 192.168.0.4" ipv4.method manual connection.autoconnect yes && sudo nmcli con up eth0
[exam@localhost ~]$ sudo sed -i s/localhost/worker/ /etc/hostname
```
3. Установить OpenJDK8 из репозитория CentOS.
```
[exam@headnode ~]$ sudo yum install -y java-1.8.0-openjdk wget
[exam@headnode ~]$ wget https://archive.apache.org/dist/hadoop/common/hadoop-3.1.2/hadoop-3.1.2.tar.gz
```
4. Скачать архив с Hadoop версии 3.1.2 (https://hadoop.apache.org/release/3.1.2.html)
```
[exam@headnode ~]$ wget https://archive.apache.org/dist/hadoop/common/hadoop-3.1.2/hadoop-3.1.2.tar.gz
```
5. Распаковать содержимое архива в /opt/hadoop-3.1.2/
```
[exam@headnode ~]$ sudo tar xvzf hadoop-3.1.2.tar.gz -C /opt/
```
6. Сделать симлинк /usr/local/hadoop/current/ на директорию /opt/hadoop-3.1.2/
```
[exam@headnode ~]$ sudo mkdir /usr/local/hadoop && sudo ln -s /opt/hadoop-3.1.2 /usr/local/hadoop/current
```
7. Создать пользователей hadoop, yarn и hdfs, а также группу hadoop, в которую необходимо добавить всех этих пользователей
```
[exam@headnode ~]$ sudo groupadd hadoop
[exam@headnode ~]$ sudo adduser -g hadoop hadoop && sudo adduser -g hadoop yarn && sudo adduser -g hadoop hdfs

```
8. Создать для обоих дополнительных дисков разделы размером в 100% диска.
```
[exam@headnode ~]$ sudo parted /dev/vdb
(parted) mklabel gpt 
(parted) mkpart primary 0% 100%
[exam@headnode ~]$ sudo parted /dev/vdc
(parted) mklabel gpt 
(parted) mkpart primary 0% 100%
```
9. Инициализировать разделы из п.8 в качестве физических томов для LVM.
```
[exam@headnode ~]$ sudo pvcreate /dev/vdb1
  Physical volume "/dev/vdb1" successfully created.
[exam@headnode ~]$ sudo pvcreate /dev/vdc1
  Physical volume "/dev/vdc1" successfully created.
```
10. Создать две группы LVM и добавить в каждую из них по одному физическому тому из п.9.
```
[exam@headnode ~]$ sudo vgcreate vg1 /dev/vdb1
  Volume group "vg1" successfully created
[exam@headnode ~]$ sudo vgcreate vg2 /dev/vdc1
  Volume group "vg2" successfully created
```
11. В каждой из групп из п.10 создать логический том LVM размером 100% группы.
```
[exam@headnode ~]$ sudo lvcreate -l 100%FREE -n lv1 vg1
  Logical volume "lv1" created.
[exam@headnode ~]$ sudo lvcreate -l 100%FREE -n lv2 vg2
  Logical volume "lv2" created.
```
12. На каждом логическом томе LVM создать файловую систему ext4.
```
[exam@headnode ~]$ sudo mkfs.ext4 /dev/mapper/vg1-lv1 
mke2fs 1.42.9 (28-Dec-2013)
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
Stride=0 blocks, Stripe width=0 blocks
327680 inodes, 1309696 blocks
65484 blocks (5.00%) reserved for the super user
First data block=0
Maximum filesystem blocks=1342177280
40 block groups
32768 blocks per group, 32768 fragments per group
8192 inodes per group
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (32768 blocks): done
Writing superblocks and filesystem accounting information: done 
```
```
[exam@headnode ~]$ sudo mkfs.ext4 /dev/mapper/vg2-lv2 
mke2fs 1.42.9 (28-Dec-2013)
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
Stride=0 blocks, Stripe width=0 blocks
327680 inodes, 1309696 blocks
65484 blocks (5.00%) reserved for the super user
First data block=0
Maximum filesystem blocks=1342177280
40 block groups
32768 blocks per group, 32768 fragments per group
8192 inodes per group
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (32768 blocks): done
Writing superblocks and filesystem accounting information: done 
```
13. Создать директории и использовать их в качестве точек монтирования файловых систем из п.12:
	/opt/mount1
	/opt/mount2
```
[exam@headnode ~]$ sudo mkdir /opt/mount1
[exam@headnode ~]$ sudo mkdir /opt/mount2
```
14. Настроить систему так, чтобы монтирование происходило автоматически при запуске системы. Произвести монтирование новых файловых систем.
```
[exam@headnode ~]$ cat /etc/fstab 

#
# /etc/fstab
# Created by anaconda on Mon Jan 17 09:09:30 2022
#
# Accessible filesystems, by reference, are maintained under '/dev/disk'
# See man pages fstab(5), findfs(8), mount(8) and/or blkid(8) for more info
#
/dev/mapper/centos-root /                       xfs     defaults        0 0
UUID=b74d8e1d-8084-4747-81cd-65dd18d0f409 /boot                   xfs     defaults        0 0
/dev/mapper/centos-swap swap                    swap    defaults        0 0
/dev/mapper/vg1-lv1     /opt/mount1     ext4     defaults     0 0
/dev/mapper/vg2-lv2     /opt/mount2     ext4     defaults     0 0
```

#### Для VM1 (шаги 15-16):
15. После монтирования создать 2 директории для хранения файлов Namenode сервиса HDFS:
	/opt/mount1/namenode-dir
	/opt/mount2/namenode-dir
```
[exam@headnode ~]$ sudo mkdir /opt/mount1/namenode-dir /opt/mount2/namenode-dir
```
16. Сделать пользователя hdfs и группу hadoop владельцами этих директорий.
```
[exam@headnode ~]$ sudo chown hdfs:hadoop /opt/mount[1..2]/namenode-dir
```
#### Для VM2 (шаги 17-20):
17. После монтирования создать 2 директории для хранения файлов Datanode сервиса HDFS:
	/opt/mount1/datanode-dir
	/opt/mount2/datanode-dir
```
[exam@worker ~]$ sudo mkdir /opt/mount1/datanode-dir /opt/mount2/datanode-dir
```
18. Сделать пользователя hdfs и группу hadoop владельцами директорий из п.17.
```
[exam@worker ~]$ sudo chown hdfs:hadoop /opt/mount[1..2]/datanode-dir
```
19. Создать дополнительные 4 директории для Nodemanager сервиса YARN:
	/opt/mount1/nodemanager-local-dir
	/opt/mount2/nodemanager-local-dir
	/opt/mount1/nodemanager-log-dir
	/opt/mount2/nodemanager-log-dir
```
[exam@worker ~]$ sudo mkdir /opt/mount1/nodemanager-local-dir /opt/mount2/nodemanager-local-dir /opt/mount1/nodemanager-log-dir /opt/mount2/nodemanager-log-dir
```
20. Сделать пользователя yarn и группу hadoop владельцами директорий из п.19.
```
[exam@worker ~]$ sudo chown yarn:hadoop /opt/mount[1..2]/nodemanager-local-dir
[exam@worker ~]$ sudo chown yarn:hadoop /opt/mount[1..2]/nodemanager-log-dir
```
#### Для обеих машин:
21. Настроить доступ по SSH, используя ключи для пользователя hadoop.
```
[exam@worker ~]$ sudo -u hadoop ssh-keygen
[exam@headnode ~]$ sudo cat /home/hadoop/.ssh/id_rsa.pub | ssh exam@192.168.3.101 "sudo tee -a /home/hadoop/.ssh/authorized_keys"
```
22. Добавить VM1 и VM2 в /etc/hosts.
```
[exam@headnode ~]$ echo "192.168.3.100 headnode" | sudo tee -a /etc/hosts
[exam@headnode ~]$ echo "192.168.3.101 worker" | sudo tee -a /etc/hosts
```
23. Скачать файлы по ссылкам в /usr/local/hadoop/current/etc/hadoop/{hadoop-env.sh,core-site.xml,hdfs-site.xml,yarn-site.xml}. При помощи sed заменить заглушки на необходимые значения 
	hadoop-env.sh (https://gist.github.com/rdaadr/2f42f248f02aeda18105805493bb0e9b)
```
[exam@headnode ~]$ sudo wget -O /usr/local/hadoop/current/etc/hadoop/hadoop-env.sh https://gist.githubusercontent.com/rdaadr/2f42f248f02aeda18105805493bb0e9b/raw/6303e424373b3459bcf3720b253c01373666fe7c/hadoop-env.sh
```
Необходимо определить переменные JAVA_HOME (путь до директории с OpenJDK8, установленную в п.3), HADOOP_HOME (необходимо указать путь к симлинку из п.6) и HADOOP_HEAPSIZE_MAX (укажите значение в 512M)
```
[root@headnode exam]# sed -i -e 's|^export JAVA_HOME=.*$|export JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk|' -e 's|^export HADOOP_HOME=.*$|export HADOOP_HOME=/usr/local/hadoop/current|' -e 's|^export HADOOP_HEAPSIZE_MAX=.*$|export HADOOP_HEAPSIZE_MAX=512M|' /usr/local/hadoop/current/etc/hadoop/hadoop-env.sh
```

core-site.xml (https://gist.github.com/rdaadr/64b9abd1700e15f04147ea48bc72b3c7)

```
[exam@headnode ~]$ sudo wget -O /usr/local/hadoop/current/etc/hadoop/core-site.xml https://gist.githubusercontent.com/rdaadr/64b9abd1700e15f04147ea48bc72b3c7/raw/2d416bf137cba81b107508153621ee548e2c877d/core-site.xml
```
Необходимо указать имя хоста, на котором будет запущена HDFS Namenode (VM1)
```
[root@headnode exam]# sed -i 's|%HDFS_NAMENODE_HOSTNAME%|headnode|' /usr/local/hadoop/current/etc/hadoop/core-site.xml
```
hdfs-site.xml (https://gist.github.com/rdaadr/2bedf24fd2721bad276e416b57d63e38)
```
[exam@headnode ~]$ sudo wget -O /usr/local/hadoop/current/etc/hadoop/hdfs-site.xml https://gist.githubusercontent.com/rdaadr/2bedf24fd2721bad276e416b57d63e38/raw/640ee95adafa31a70869b54767104b826964af48/hdfs-site.xml
```
Необходимо указать директории namenode-dir, а также datanode-dir, каждый раз через запятую (например, /opt/mount1/namenode-dir,/opt/mount2/namenode-dir)
```
[root@headnode exam]# sed -i -e 's|%NAMENODE_DIRS%|/opt/mount1/namenode-dir,/opt/mount2/namenode-dir|' -e 's|%DATANODE_DIRS%|/opt/mount1/datanode-dir,/opt/mount2/datanode-dir|' /usr/local/hadoop/current/etc/hadoop/hdfs-site.xml
```
yarn-site.xml (https://gist.github.com/Stupnikov-NA/ba87c0072cd51aa85c9ee6334cc99158)
```
[exam@headnode ~]$ sudo wget -O /usr/local/hadoop/current/etc/hadoop/yarn-site.xml https://gist.githubusercontent.com/Stupnikov-NA/ba87c0072cd51aa85c9ee6334cc99158/raw/bda0f760878d97213196d634be9b53a089e796ea/yarn-site.xml
```
Необходимо подставить имя хоста, на котором будет развернут YARN Resource Manager (VM1), а также пути до директорий nodemanager-local-dir и nodemanager-log-dir (если необходимо указать несколько директорий, то необходимо их разделить запятыми)
```
[root@headnode exam]# sed -i -e 's|%YARN_RESOURCE_MANAGER_HOSTNAME%|headnode|' -e 's|%NODE_MANAGER_LOCAL_DIR%|/opt/mount1/nodemanager-local-dir,/opt/mount2/nodemanager-local-dir|' -e 's|%NODE_MANAGER_LOG_DIR%|/opt/mount1/nodemanager-log-dir,/opt/mount2/nodemanager-log-dir|' /usr/local/hadoop/current/etc/hadoop/yarn-site.xml 
```
24. Задать переменную окружения HADOOP_HOME через /etc/profile
```
[exam@headnode ~]$ echo "HADOOP_HOME=/usr/local/hadoop/current" | sudo tee -a /etc/profile.d/hadoop.sh
```
#### Для VM1 (шаги 25-26):
25. Произвести форматирование HDFS (от имени пользователя hdfs):
	$HADOOP_HOME/bin/hdfs namenode -format cluster1
```

[exam@headnode ~]$ sudo mkdir /var/log/hadoop
[exam@headnode ~]$ sudo chown hadoop:hadoop /var/log/hadoop/
[exam@headnode ~]$ sudo chmod 775 /var/log/hadoop/
[root@headnode exam]# sed -i 's|^# export HADOOP_LOG_DIR.*$|export HADOOP_LOG_DIR=/var/log/hadoop|' /usr/local/hadoop/current/etc/hadoop/hadoop-env.sh
```
```
[exam@headnode ~]$ sudo -u hdfs $HADOOP_HOME/bin/hdfs namenode -format cluster1
```
26. Запустить демоны сервисов Hadoop:
Для запуска Namenode (от имени пользователя hdfs):
	$HADOOP_HOME/bin/hdfs --daemon start namenode
```
[exam@headnode ~]$ sudo -u hdfs $HADOOP_HOME/bin/hdfs --daemon start namenode
```
Для запуска Resource Manager (от имени пользователя yarn):
	$HADOOP_HOME/bin/yarn --daemon start resourcemanager
```
[exam@headnode ~]$ sudo -u yarn $HADOOP_HOME/bin/yarn --daemon start resourcemanager
```
#### Для VM2 (шаг 27):
27. Запустить демоны сервисов:
Для запуска Datanode (от имени hdfs):
	$HADOOP_HOME/bin/hdfs --daemon start datanode
```
[exam@worker ~]$ sudo -u hdfs $HADOOP_HOME/bin/hdfs --daemon start datanode
```
Для запуска Node Manager (от имени yarn):
	$HADOOP_HOME/bin/yarn --daemon start nodemanager
```
[exam@worker ~]$ sudo -u yarn $HADOOP_HOME/bin/yarn --daemon start nodemanager
```
28. Проверить доступность Web-интефейсов HDFS Namenode и YARN Resource Manager по портам 9870 и 8088 соответственно (VM1). << порты должны быть доступны с хостовой системы.
```
[exam@headnode ~]$ sudo firewall-cmd --zone=public --permanent --add-port=9870/tcp
success
[exam@headnode ~]$ sudo firewall-cmd --zone=public --permanent --add-port=8088/tcp
success
[exam@headnode ~]$ sudo firewall-cmd --reload
[exam@worker ~]$ sudo firewall-cmd --zone=public --permanent --add-port=9864/tcp
success
[exam@worker ~]$ sudo firewall-cmd --reload
```
29. Настроить управление запуском каждого компонента Hadoop при помощи systemd (используя юниты-сервисы).
```
[exam@headnode ~]$ cat /etc/systemd/system/resourcemanager.service
[Unit]
Description=Hadoop resourcemanager
After=network.target network-online.target

[Service]
User=yarn
Group=hadoop
Type=fork
ExecStart=/usr/local/hadoop/current/bin/yarn resourcemanager
Restart=on-failure

[Install]
WantedBy=multi-user.target
```
```
[exam@headnode ~]$ cat /etc/systemd/system/namenode.service
[Unit]
Description=Hadoop namenode
After=network.target network-online.target

[Service]
User=hdfs
Group=hadoop
Type=fork
ExecStart=/usr/local/hadoop/current/bin/hdfs namenode
Restart=on-failure

[Install]
WantedBy=multi-user.target
[exam@headnode ~]$ sudo systemctl enable namenode
Created symlink from /etc/systemd/system/multi-user.target.wants/namenode.service to /etc/systemd/system/namenode.service.
[exam@headnode ~]$ sudo systemctl enable resourcemanager
Created symlink from /etc/systemd/system/multi-user.target.wants/resourcemanager.service to /etc/systemd/system/resourcemanager.service.
```
