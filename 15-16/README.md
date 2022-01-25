1. Imagine you was asked to add new partition to your host for backup purposes. To simulate appearance of new physical disk in your server, please create new disk in Virtual Box (5 GB) and attach it to your virtual machine.
Also imagine your system started experiencing RAM leak in one of the applications, thus while developers try to debug and fix it, you need to mitigate OutOfMemory errors; you will do it by adding some swap space.
/dev/sdc - 5GB disk, that you just attached to the VM (in your case it may appear as /dev/sdb, /dev/sdc or other, it doesn't matter)
```
[root@localhost superadmin]# lsblk
NAME            MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda               8:0    0   32G  0 disk 
├─sda1            8:1    0    1G  0 part /boot
└─sda2            8:2    0   31G  0 part 
  ├─centos-root 253:0    0 27.8G  0 lvm  /
  └─centos-swap 253:1    0  3.2G  0 lvm  [SWAP]
sr0              11:0    1  4.4G  0 rom  
vda             252:0    0    5G  0 disk 
```
1.1. Create a 2GB   !!! GPT !!!   partition on /dev/sdc of type "Linux filesystem" (means all the following partitions created in the following steps on /dev/sdc will be GPT as well)
```
[root@localhost superadmin]# parted /dev/vda
GNU Parted 3.1
Using /dev/vda
Welcome to GNU Parted! Type 'help' to view a list of commands.
(parted) p                                                                
Error: /dev/vda: unrecognised disk label
Model: Virtio Block Device (virtblk)                                      
Disk /dev/vda: 5369MB
Sector size (logical/physical): 512B/512B
Partition Table: unknown
Disk Flags: 
(parted) mklabel gpt                                                      
(parted) mkpart primary xfs 0 2048MB                                      
Warning: The resulting partition is not properly aligned for best performance.

```
1.2. Create a 512MB partition on /dev/sdc of type "Linux swap"
```
(parted) mkpart primary linux-swap 2048MB 2560MB
Warning: The resulting partition is not properly aligned for best performance.
```
1.3. Format the 2GB partition with an XFS file system
```
[root@localhost superadmin]# mkfs.xfs /dev/vda1
meta-data=/dev/vda1              isize=512    agcount=4, agsize=124999 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=0, sparse=0
data     =                       bsize=4096   blocks=499995, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
```
1.4. Initialize 512MB partition as swap space
```
[root@localhost superadmin]# mkswap /dev/vda2
Setting up swapspace version 1, size = 11712 KiB
no label, UUID=eba95963-78d3-40e1-ac3c-0da46fd319b0
```
1.5. Configure the newly created XFS file system to persistently mount at /backup
```
mkdir /backup
[root@localhost superadmin]# echo "/dev/vda1     /backup     xfs     defaults     0 0" >> /etc/fstab
```
1.6. Configure the newly created swap space to be enabled at boot
```
[root@localhost superadmin]# cat /etc/fstab 

#
# /etc/fstab
# Created by anaconda on Thu Nov 25 19:05:25 2021
#
# Accessible filesystems, by reference, are maintained under '/dev/disk'
# See man pages fstab(5), findfs(8), mount(8) and/or blkid(8) for more info
#
/dev/mapper/centos-root /                       xfs     defaults        0 0
UUID=125c0ab9-c2f4-4f5a-920f-c083824a0ede /boot                   xfs     defaults        0 0
#/dev/mapper/centos-swap swap                    swap    defaults        0 0
/dev/vda2 swap                    swap    defaults        0 0
/dev/vda1     /backup     xfs     defaults     0 0

```
1.7. Reboot your host and verify that /dev/sdc1 is mounted at /backup and that your swap partition  (/dev/sdc2) is enabled
```
[root@localhost superadmin]# lsblk
NAME            MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda               8:0    0    32G  0 disk 
├─sda1            8:1    0     1G  0 part /boot
└─sda2            8:2    0    31G  0 part 
  ├─centos-root 253:0    0  27.8G  0 lvm  /
  └─centos-swap 253:1    0   3.2G  0 lvm  
sr0              11:0    1   4.4G  0 rom  
vda             252:0    0     5G  0 disk 
├─vda1          252:1    0   1.9G  0 part /backup
└─vda2          252:2    0 488.3M  0 part [SWAP]
```
2. LVM. Imagine you're running out of space on your root device. As we found out during the lesson default CentOS installation should already have LVM, means you can easily extend size of your root device. So what are you waiting for? Just do it!
2.1. Create 2GB partition on /dev/sdc of type "Linux LVM"
```
(parted) mkpart primary xfs 2560MB 4608MB
```
2.2. Initialize the partition as a physical volume (PV)
```
[root@localhost superadmin]# pvcreate /dev/vda3
  Physical volume "/dev/vda3" successfully created.
```
2.3. Extend the volume group (VG) of your root device using your newly created PV
```
[root@localhost superadmin]# vgextend centos /dev/vda3
  Volume group "centos" successfully extended
```
2.4. Extend your root logical volume (LV) by 1GB, leaving other 1GB unassigned
```
[root@localhost superadmin]# lvextend -L+1024MB /dev/centos/root 
  Size of logical volume centos/root changed from 27.79 GiB (7115 extents) to 28.79 GiB (7371 extents).
  Logical volume centos/root successfully resized.
```
2.5. Check current disk space usage of your root device
```
[root@localhost superadmin]# df -h
Filesystem               Size  Used Avail Use% Mounted on
devtmpfs                 1.9G     0  1.9G   0% /dev
tmpfs                    1.9G     0  1.9G   0% /dev/shm
tmpfs                    1.9G  8.5M  1.9G   1% /run
tmpfs                    1.9G     0  1.9G   0% /sys/fs/cgroup
/dev/mapper/centos-root   29G  1.7G   28G   6% /
/dev/vda1                1.9G   33M  1.9G   2% /backup
/dev/sda1               1014M  194M  821M  20% /boot
tmpfs                    379M     0  379M   0% /run/user/1000

```
2.6. Extend your root device filesystem to be able to use additional free space of root LV  
```
[root@localhost superadmin]# xfs_growfs /dev/centos/root
meta-data=/dev/mapper/centos-root isize=512    agcount=4, agsize=1821440 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=0 spinodes=0
data     =                       bsize=4096   blocks=7285760, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal               bsize=4096   blocks=3557, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
data blocks changed from 7285760 to 7547904
```
2.7. Verify that after reboot your root device is still 1GB bigger than at 2.5.  
I don't know where to fint it, it increased after lvextend, you can compare 1.7 and 2.5

```
[root@localhost superadmin]# vgs
  VG     #PV #LV #SN Attr   VSize  VFree  
  centos   2   2   0 wz--n- 32.90g 932.00m
[root@localhost superadmin]# df -h
Filesystem               Size  Used Avail Use% Mounted on
devtmpfs                 1.9G     0  1.9G   0% /dev
tmpfs                    1.9G     0  1.9G   0% /dev/shm
tmpfs                    1.9G   17M  1.9G   1% /run
tmpfs                    1.9G     0  1.9G   0% /sys/fs/cgroup
/dev/mapper/centos-root   29G  1.9G   27G   7% /
/dev/vda1                1.9G   33M  1.9G   2% /backup
/dev/sda1               1014M  215M  800M  22% /boot
tmpfs                    379M     0  379M   0% /run/user/1000
[root@localhost superadmin]# lvextend -L+900MB /dev/centos/root
  Size of logical volume centos/root changed from 28.79 GiB (7371 extents) to 29.67 GiB (7596 extents).
  Logical volume centos/root successfully resized.
[root@localhost superadmin]# df -h
Filesystem               Size  Used Avail Use% Mounted on
devtmpfs                 1.9G     0  1.9G   0% /dev
tmpfs                    1.9G     0  1.9G   0% /dev/shm
tmpfs                    1.9G   17M  1.9G   1% /run
tmpfs                    1.9G     0  1.9G   0% /sys/fs/cgroup
/dev/mapper/centos-root   29G  1.9G   27G   7% /
/dev/vda1                1.9G   33M  1.9G   2% /backup
/dev/sda1               1014M  215M  800M  22% /boot
tmpfs                    379M     0  379M   0% /run/user/1000
[root@localhost superadmin]# xfs_growfs /dev/centos/root
meta-data=/dev/mapper/centos-root isize=512    agcount=5, agsize=1821440 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=0 spinodes=0
data     =                       bsize=4096   blocks=7547904, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal               bsize=4096   blocks=3557, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
data blocks changed from 7547904 to 7778304
[root@localhost superadmin]# df -h
Filesystem               Size  Used Avail Use% Mounted on
devtmpfs                 1.9G     0  1.9G   0% /dev
tmpfs                    1.9G     0  1.9G   0% /dev/shm
tmpfs                    1.9G   17M  1.9G   1% /run
tmpfs                    1.9G     0  1.9G   0% /sys/fs/cgroup
/dev/mapper/centos-root   30G  1.9G   28G   7% /
/dev/vda1                1.9G   33M  1.9G   2% /backup
/dev/sda1               1014M  215M  800M  22% /boot
tmpfs                    379M     0  379M   0% /run/user/1000
```