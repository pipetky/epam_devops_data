## Boot process

1. enable recovery options for grub, update main configuration file and find new item in grub2 config in /boot.
```
[root@localhost superadmin]# cp /boot/grub2/grub.cfg .
[root@localhost superadmin]# sed -i s/GRUB_DISABLE_RECOVERY/#GRUB_DISABLE_RECOVERY/ /etc/default/grub

[root@localhost superadmin]# grub2-mkconfig -o /boot/grub2/grub.cfg 
Generating grub configuration file ...
Found linux image: /boot/vmlinuz-3.10.0-1160.49.1.el7.x86_64
Found initrd image: /boot/initramfs-3.10.0-1160.49.1.el7.x86_64.img
Found linux image: /boot/vmlinuz-3.10.0-1160.el7.x86_64
Found initrd image: /boot/initramfs-3.10.0-1160.el7.x86_64.img
Found linux image: /boot/vmlinuz-0-rescue-08355e48174c452ab8bed7e6257e46bf
Found initrd image: /boot/initramfs-0-rescue-08355e48174c452ab8bed7e6257e46bf.img
done
```
```
[root@localhost superadmin]# diff /boot/grub2/grub.cfg grub.cfg 
103,117d102
< menuentry 'CentOS Linux (3.10.0-1160.49.1.el7.x86_64) 7 (Core) (recovery mode)' --class centos --class gnu-linux --class gnu --class os --unrestricted $menuentry_id_option 'gnulinux-3.10.0-1160.49.1.el7.x86_64-recovery-48b68eb4-368b-4c84-9602-9d7e952d5291' {
< 	load_video
< 	set gfxpayload=keep
< 	insmod gzio
< 	insmod part_msdos
< 	insmod xfs
< 	set root='hd0,msdos1'
< 	if [ x$feature_platform_search_hint = xy ]; then
< 	  search --no-floppy --fs-uuid --set=root --hint-bios=hd0,msdos1 --hint-efi=hd0,msdos1 --hint-baremetal=ahci0,msdos1 --hint='hd0,msdos1'  125c0ab9-c2f4-4f5a-920f-c083824a0ede
< 	else
< 	  search --no-floppy --fs-uuid --set=root 125c0ab9-c2f4-4f5a-920f-c083824a0ede
< 	fi
< 	linux16 /vmlinuz-3.10.0-1160.49.1.el7.x86_64 root=/dev/mapper/centos-root ro single crashkernel=auto rd.lvm.lv=centos/root rd.lvm.lv=centos/swap rhgb quiet
< 	initrd16 /initramfs-3.10.0-1160.49.1.el7.x86_64.img
< }
133,147d117
< menuentry 'CentOS Linux (3.10.0-1160.el7.x86_64) 7 (Core) (recovery mode)' --class centos --class gnu-linux --class gnu --class os --unrestricted $menuentry_id_option 'gnulinux-3.10.0-1160.el7.x86_64-recovery-48b68eb4-368b-4c84-9602-9d7e952d5291' {
< 	load_video
< 	set gfxpayload=keep
< 	insmod gzio
< 	insmod part_msdos
< 	insmod xfs
< 	set root='hd0,msdos1'
< 	if [ x$feature_platform_search_hint = xy ]; then
< 	  search --no-floppy --fs-uuid --set=root --hint-bios=hd0,msdos1 --hint-efi=hd0,msdos1 --hint-baremetal=ahci0,msdos1 --hint='hd0,msdos1'  125c0ab9-c2f4-4f5a-920f-c083824a0ede
< 	else
< 	  search --no-floppy --fs-uuid --set=root 125c0ab9-c2f4-4f5a-920f-c083824a0ede
< 	fi
< 	linux16 /vmlinuz-3.10.0-1160.el7.x86_64 root=/dev/mapper/centos-root ro single crashkernel=auto rd.lvm.lv=centos/root rd.lvm.lv=centos/swap rhgb quiet
< 	initrd16 /initramfs-3.10.0-1160.el7.x86_64.img
< }
160,173d129
< 	initrd16 /initramfs-0-rescue-08355e48174c452ab8bed7e6257e46bf.img
< }
< menuentry 'CentOS Linux (0-rescue-08355e48174c452ab8bed7e6257e46bf) 7 (Core) (recovery mode)' --class centos --class gnu-linux --class gnu --class os --unrestricted $menuentry_id_option 'gnulinux-0-rescue-08355e48174c452ab8bed7e6257e46bf-recovery-48b68eb4-368b-4c84-9602-9d7e952d5291' {
< 	load_video
< 	insmod gzio
< 	insmod part_msdos
< 	insmod xfs
< 	set root='hd0,msdos1'
< 	if [ x$feature_platform_search_hint = xy ]; then
< 	  search --no-floppy --fs-uuid --set=root --hint-bios=hd0,msdos1 --hint-efi=hd0,msdos1 --hint-baremetal=ahci0,msdos1 --hint='hd0,msdos1'  125c0ab9-c2f4-4f5a-920f-c083824a0ede
< 	else
< 	  search --no-floppy --fs-uuid --set=root 125c0ab9-c2f4-4f5a-920f-c083824a0ede
< 	fi
< 	linux16 /vmlinuz-0-rescue-08355e48174c452ab8bed7e6257e46bf root=/dev/mapper/centos-root ro single crashkernel=auto rd.lvm.lv=centos/root rd.lvm.lv=centos/swap rhgb quiet

```
2. modify option vm.dirty_ratio:
   - using echo utility
   - using sysctl utility
   - using sysctl configuration files

```
[root@localhost superadmin]# cat /proc/sys/vm/dirty_ratio
30

[root@localhost superadmin]# echo 40 > /proc/sys/vm/dirty_ratio
[root@localhost superadmin]# cat /proc/sys/vm/dirty_ratio
40

[root@localhost superadmin]# sysctl vm.dirty_ratio=50
[root@localhost superadmin]# cat /proc/sys/vm/dirty_ratio
50

[root@localhost superadmin]# echo "vm.dirty_ratio=60" >> /etc/sysctl.conf
[root@localhost superadmin]# sysctl -p
vm.dirty_ratio = 60
[root@localhost superadmin]# cat /proc/sys/vm/dirty_ratio
60

```

* extra
1. Inspect initrd file contents. Find all files that are related to XFS filesystem and give a short description for every file.
```
[root@localhost boot]# lsinitrd /boot/initramfs-3.10.0-1160.49.1.el7.x86_64.img |grep xfs |grep -v ^d | awk '{print $9}'
usr/lib/modules/3.10.0-1160.49.1.el7.x86_64/kernel/fs/xfs/xfs.ko.xz - kernel module
usr/sbin/fsck.xfs - program to check and repair an XFS filesystem.
usr/sbin/xfs_db - debug an XFS filesystem. xfs_db is used to examine an XFS filesystem.
usr/sbin/xfs_metadump - is a debugging tool that copies the metadata from an XFS filesystem to a file.
usr/sbin/xfs_repair - repairs corrupt or damaged XFS filesystems.

```
2. Study dracut utility that is used for rebuilding initrd image. Give an example for adding driver/kernel module for your initrd and recreating it.
For example, i want to add zfs module. I've just installed zfs on the system.
```
[root@localhost ~]# cat /etc/dracut.conf.d/00-custom.conf 
add_drivers+=" zfs "
[root@localhost ~]# lsinitrd /boot/initramfs-3.10.0-1160.49.1.el7.x86_64.img |grep zfs
[root@localhost ~]# cp /boot/initramfs-3.10.0-1160.49.1.el7.x86_64.img /boot/initramfs-3.10.0-1160.49.1.el7.x86_64.img.bak
[root@localhost ~]# dracut -f
[root@localhost ~]# lsinitrd /boot/initramfs-3.10.0-1160.49.1.el7.x86_64.img |grep zfs
-rw-r--r--   1 root     root       582212 Jan 15 07:27 usr/lib/modules/3.10.0-1160.49.1.el7.x86_64/extra/zfs.ko.xz
-rw-r--r--   1 root     root          158 Nov 12  2018 usr/lib/modules-load.d/zfs.conf

```
3. Explain the difference between ordinary and rescue initrd images.
Rescue images are made with --no-hostonly option, and with 'rescue' module added.

## Selinux

Disable selinux using kernel cmdline
```
[root@localhost superadmin]# vi /etc/grub2.cfg 
[root@localhost superadmin]# cat /etc/default/grub 
GRUB_TIMEOUT=5
GRUB_DISTRIBUTOR="$(sed 's, release .*$,,g' /etc/system-release)"
GRUB_DEFAULT=saved
GRUB_DISABLE_SUBMENU=true
GRUB_TERMINAL_OUTPUT="console"
GRUB_CMDLINE_LINUX="crashkernel=auto rd.lvm.lv=centos/root rd.lvm.lv=centos/swap rhgb quiet"
#GRUB_DISABLE_RECOVERY="true"
[root@localhost superadmin]# vi /etc/default/grub 
[root@localhost superadmin]# cat /etc/default/grub 
GRUB_TIMEOUT=5
GRUB_DISTRIBUTOR="$(sed 's, release .*$,,g' /etc/system-release)"
GRUB_DEFAULT=saved
GRUB_DISABLE_SUBMENU=true
GRUB_TERMINAL_OUTPUT="console"
GRUB_CMDLINE_LINUX="crashkernel=auto rd.lvm.lv=centos/root rd.lvm.lv=centos/swap rhgb quiet selinux=0"
#GRUB_DISABLE_RECOVERY="true"

[root@localhost superadmin]# grub2-mkconfig -o /boot/grub2/grub.cfg
Generating grub configuration file ...
Found linux image: /boot/vmlinuz-3.10.0-1160.49.1.el7.x86_64
Found initrd image: /boot/initramfs-3.10.0-1160.49.1.el7.x86_64.img
Found linux image: /boot/vmlinuz-3.10.0-1160.el7.x86_64
Found initrd image: /boot/initramfs-3.10.0-1160.el7.x86_64.img
Found linux image: /boot/vmlinuz-0-rescue-08355e48174c452ab8bed7e6257e46bf
Found initrd image: /boot/initramfs-0-rescue-08355e48174c452ab8bed7e6257e46bf.img
done

```
**After reboot:**
```
[root@localhost superadmin]# sestatus
SELinux status:                 disabled
```

## Firewalls

1. Add rule using firewall-cmd that will allow SSH access to your server *only* from network 192.168.56.0/24 and interface enp0s8 (if your network and/on interface name differs - change it accordingly).
```
[root@localhost superadmin]# firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.0.0/22" service name="ssh" accept'
success
[root@localhost superadmin]# firewall-cmd --permanent --remove-service ssh --zone=public
success
[root@localhost superadmin]# firewall-cmd --permanent --zone=public --set-target=DROP
success

[root@localhost superadmin]# firewall-cmd --list-all
public (active)
  target: DROP
  icmp-block-inversion: no
  interfaces: eth0
  sources: 
  services: dhcpv6-client
  ports: 
  protocols: 
  masquerade: no
  forward-ports: 
  source-ports: 
  icmp-blocks: 
  rich rules: 
	rule family="ipv4" source address="192.168.0.0/22" service name="ssh" accept
```
2. Shutdown firewalld and add the same rules via iptables.
```
[root@localhost superadmin]# systemctl stop firewalld
[root@localhost superadmin]# iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
[root@localhost superadmin]# iptables -A INPUT -s 192.168.0.0/22 -i eth0 -p tcp --dport 22 -j ACCEPT[root@localhost superadmin]# iptables -L INPUT -v -n
[root@localhost superadmin]# iptables -P INPUT DROP 
Chain INPUT (policy DROP 148 packets, 22646 bytes)
 pkts bytes target     prot opt in     out     source               destination         
  264 25000 ACCEPT     tcp  --  eth0   *       192.168.0.0/22       0.0.0.0/0            tcp dpt:22
  115 34918 ACCEPT     all  --  *      *       0.0.0.0/0            0.0.0.0/0            state RELATED,ESTABLISHED

#/sbin/service iptables save
```
