## Repositories and Packages
  
- Use rpm for the following tasks:
1. Download sysstat package.
```
[root@localhost superadmin]# yum install --downloadonly --downloaddir=. sysstat 
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
 * base: centos-mirror.rbc.ru
 * extras: mirrors.powernet.com.ru
 * updates: mirror.awanti.com
Resolving Dependencies
--> Running transaction check
---> Package sysstat.x86_64 0:10.1.5-19.el7 will be installed
--> Processing Dependency: libsensors.so.4()(64bit) for package: sysstat-10.1.5-19.el7.x86_64
--> Running transaction check
---> Package lm_sensors-libs.x86_64 0:3.4.0-8.20160601gitf9185e5.el7 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

======================================================================================================================================================================================================
 Package                                          Arch                                    Version                                                         Repository                             Size
======================================================================================================================================================================================================
Installing:
 sysstat                                          x86_64                                  10.1.5-19.el7                                                   base                                  315 k
Installing for dependencies:
 lm_sensors-libs                                  x86_64                                  3.4.0-8.20160601gitf9185e5.el7                                  base                                   42 k

Transaction Summary
======================================================================================================================================================================================================
Install  1 Package (+1 Dependent package)

Total download size: 357 k
Installed size: 1.2 M
Background downloading packages, then exiting:
exiting because "Download Only" specified
```
2. Get information from downloaded sysstat package file.
```
[root@localhost superadmin]# rpm -qi -p sysstat-10.1.5-19.el7.x86_64.rpm 
Name        : sysstat
Version     : 10.1.5
Release     : 19.el7
Architecture: x86_64
Install Date: (not installed)
Group       : Applications/System
Size        : 1172488
License     : GPLv2+
Signature   : RSA/SHA256, Fri 03 Apr 2020 05:08:48 PM CDT, Key ID 24c6a8a7f4a80eb5
Source RPM  : sysstat-10.1.5-19.el7.src.rpm
Build Date  : Wed 01 Apr 2020 12:36:37 AM CDT
Build Host  : x86-01.bsys.centos.org
Relocations : (not relocatable)
Packager    : CentOS BuildSystem <http://bugs.centos.org>
Vendor      : CentOS
URL         : http://sebastien.godard.pagesperso-orange.fr/
Summary     : Collection of performance monitoring tools for Linux
Description :
The sysstat package contains sar, sadf, mpstat, iostat, pidstat, nfsiostat-sysstat,
tapestat, cifsiostat and sa tools for Linux.
The sar command collects and reports system activity information. This
information can be saved in a file in a binary format for future inspection. The
statistics reported by sar concern I/O transfer rates, paging activity,
process-related activities, interrupts, network activity, memory and swap space
utilization, CPU utilization, kernel activities and TTY statistics, among
others. Both UP and SMP machines are fully supported.
The sadf command may be used to display data collected by sar in various formats
(CSV, XML, etc.).
The iostat command reports CPU utilization and I/O statistics for disks.
The tapestat command reports statistics for tapes connected to the system.
The mpstat command reports global and per-processor statistics.
The pidstat command reports statistics for Linux tasks (processes).
The nfsiostat-sysstat command reports I/O statistics for network file systems.
The cifsiostat command reports I/O statistics for CIFS file systems.
```
3. Install sysstat package and get information about files installed by this package.
```
[root@localhost superadmin]# yum localinstall sysstat-10.1.5-19.el7.x86_64.rpm  -y
Loaded plugins: fastestmirror
Examining sysstat-10.1.5-19.el7.x86_64.rpm: sysstat-10.1.5-19.el7.x86_64
Marking sysstat-10.1.5-19.el7.x86_64.rpm to be installed
Resolving Dependencies
--> Running transaction check
---> Package sysstat.x86_64 0:10.1.5-19.el7 will be installed
--> Processing Dependency: libsensors.so.4()(64bit) for package: sysstat-10.1.5-19.el7.x86_64
Loading mirror speeds from cached hostfile
 * base: centos-mirror.rbc.ru
 * extras: mirrors.powernet.com.ru
 * updates: mirror.awanti.com
--> Running transaction check
---> Package lm_sensors-libs.x86_64 0:3.4.0-8.20160601gitf9185e5.el7 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

======================================================================================================================================================================================================
 Package                                   Arch                             Version                                                     Repository                                               Size
======================================================================================================================================================================================================
Installing:
 sysstat                                   x86_64                           10.1.5-19.el7                                               /sysstat-10.1.5-19.el7.x86_64                           1.1 M
Installing for dependencies:
 lm_sensors-libs                           x86_64                           3.4.0-8.20160601gitf9185e5.el7                              base                                                     42 k

Transaction Summary
======================================================================================================================================================================================================
Install  1 Package (+1 Dependent package)

Total size: 1.2 M
Installed size: 1.2 M
Downloading packages:
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : lm_sensors-libs-3.4.0-8.20160601gitf9185e5.el7.x86_64                                                                                                                              1/2 
  Installing : sysstat-10.1.5-19.el7.x86_64                                                                                                                                                       2/2 
  Verifying  : sysstat-10.1.5-19.el7.x86_64                                                                                                                                                       1/2 
  Verifying  : lm_sensors-libs-3.4.0-8.20160601gitf9185e5.el7.x86_64                                                                                                                              2/2 

Installed:
  sysstat.x86_64 0:10.1.5-19.el7                                                                                                                                                                      

Dependency Installed:
  lm_sensors-libs.x86_64 0:3.4.0-8.20160601gitf9185e5.el7                                                                                                                                             

Complete!

```
```
[root@localhost superadmin]# rpm -ql sysstat
/etc/cron.d/sysstat
/etc/sysconfig/sysstat
/etc/sysconfig/sysstat.ioconf
/usr/bin/cifsiostat
/usr/bin/iostat
/usr/bin/mpstat
/usr/bin/nfsiostat-sysstat
/usr/bin/pidstat
/usr/bin/sadf
/usr/bin/sar
/usr/bin/tapestat
/usr/lib/systemd/system/sysstat.service
/usr/lib64/sa
/usr/lib64/sa/sa1
/usr/lib64/sa/sa2
/usr/lib64/sa/sadc
/usr/share/doc/sysstat-10.1.5
/usr/share/doc/sysstat-10.1.5/CHANGES
/usr/share/doc/sysstat-10.1.5/COPYING
/usr/share/doc/sysstat-10.1.5/CREDITS
/usr/share/doc/sysstat-10.1.5/FAQ
/usr/share/doc/sysstat-10.1.5/README
/usr/share/doc/sysstat-10.1.5/sysstat-10.1.5.lsm
/usr/share/locale/af/LC_MESSAGES/sysstat.mo
/usr/share/locale/cs/LC_MESSAGES/sysstat.mo
/usr/share/locale/da/LC_MESSAGES/sysstat.mo
/usr/share/locale/de/LC_MESSAGES/sysstat.mo
/usr/share/locale/eo/LC_MESSAGES/sysstat.mo
/usr/share/locale/es/LC_MESSAGES/sysstat.mo
/usr/share/locale/eu/LC_MESSAGES/sysstat.mo
/usr/share/locale/fi/LC_MESSAGES/sysstat.mo
/usr/share/locale/fr/LC_MESSAGES/sysstat.mo
/usr/share/locale/hr/LC_MESSAGES/sysstat.mo
/usr/share/locale/id/LC_MESSAGES/sysstat.mo
/usr/share/locale/it/LC_MESSAGES/sysstat.mo
/usr/share/locale/ja/LC_MESSAGES/sysstat.mo
/usr/share/locale/ky/LC_MESSAGES/sysstat.mo
/usr/share/locale/lv/LC_MESSAGES/sysstat.mo
/usr/share/locale/mt/LC_MESSAGES/sysstat.mo
/usr/share/locale/nb/LC_MESSAGES/sysstat.mo
/usr/share/locale/nl/LC_MESSAGES/sysstat.mo
/usr/share/locale/nn/LC_MESSAGES/sysstat.mo
/usr/share/locale/pl/LC_MESSAGES/sysstat.mo
/usr/share/locale/pt/LC_MESSAGES/sysstat.mo
/usr/share/locale/pt_BR/LC_MESSAGES/sysstat.mo
/usr/share/locale/ro/LC_MESSAGES/sysstat.mo
/usr/share/locale/ru/LC_MESSAGES/sysstat.mo
/usr/share/locale/sk/LC_MESSAGES/sysstat.mo
/usr/share/locale/sr/LC_MESSAGES/sysstat.mo
/usr/share/locale/sv/LC_MESSAGES/sysstat.mo
/usr/share/locale/uk/LC_MESSAGES/sysstat.mo
/usr/share/locale/vi/LC_MESSAGES/sysstat.mo
/usr/share/locale/zh_CN/LC_MESSAGES/sysstat.mo
/usr/share/locale/zh_TW/LC_MESSAGES/sysstat.mo
/usr/share/man/man1/cifsiostat.1.gz
/usr/share/man/man1/iostat.1.gz
/usr/share/man/man1/mpstat.1.gz
/usr/share/man/man1/nfsiostat-sysstat.1.gz
/usr/share/man/man1/pidstat.1.gz
/usr/share/man/man1/sadf.1.gz
/usr/share/man/man1/sar.1.gz
/usr/share/man/man1/tapestat.1.gz
/usr/share/man/man5/sysstat.5.gz
/usr/share/man/man8/sa1.8.gz
/usr/share/man/man8/sa2.8.gz
/usr/share/man/man8/sadc.8.gz
/var/log/sa
```
  
- Add NGINX repository (need to find repository config on https://www.nginx.com/) and complete the following tasks using yum:
1. Check if NGINX repository enabled or not.
```
[root@localhost superadmin]# yum repolist enabled |grep nginx
nginx/7/x86_64                      nginx repo                               256
```
2. Install NGINX.
```
[root@localhost superadmin]# yum install nginx -y
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
 * base: centos-mirror.rbc.ru
 * extras: mirrors.powernet.com.ru
 * updates: mirror.awanti.com
Resolving Dependencies
--> Running transaction check
---> Package nginx.x86_64 1:1.20.2-1.el7.ngx will be installed
--> Finished Dependency Resolution

Dependencies Resolved

======================================================================================================================================================================================================
 Package                                     Arch                                         Version                                                   Repository                                   Size
======================================================================================================================================================================================================
Installing:
 nginx                                       x86_64                                       1:1.20.2-1.el7.ngx                                        nginx                                       790 k

Transaction Summary
======================================================================================================================================================================================================
Install  1 Package

Total download size: 790 k
Installed size: 2.8 M
Downloading packages:
nginx-1.20.2-1.el7.ngx.x86_64.rpm                                                                                                                                              | 790 kB  00:00:00     
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : 1:nginx-1.20.2-1.el7.ngx.x86_64                                                                                                                                                    1/1 
----------------------------------------------------------------------

Thanks for using nginx!

Please find the official documentation for nginx here:
* https://nginx.org/en/docs/

Please subscribe to nginx-announce mailing list to get
the most important news about nginx:
* https://nginx.org/en/support.html

Commercial subscriptions for nginx are available on:
* https://nginx.com/products/

----------------------------------------------------------------------
  Verifying  : 1:nginx-1.20.2-1.el7.ngx.x86_64                                                                                                                                                    1/1 

Installed:
  nginx.x86_64 1:1.20.2-1.el7.ngx                                                                                                                                                                     

Complete!
```
3. Check yum history and undo NGINX installation.
```
[root@localhost superadmin]# yum history list all
Loaded plugins: fastestmirror
ID     | Login user               | Date and time    | Action(s)      | Altered
-------------------------------------------------------------------------------
     7 | superadmin <superadmin>  | 2021-12-24 09:15 | Install        |    1 EE
     6 | superadmin <superadmin>  | 2021-12-23 10:11 | I, U           |  106   
     5 | superadmin <superadmin>  | 2021-12-23 10:10 | Erase          |    1   
     4 | superadmin <superadmin>  | 2021-12-23 10:06 | Install        |    1 EE
     3 | superadmin <superadmin>  | 2021-12-23 08:56 | Install        |    2   
     2 | superadmin <superadmin>  | 2021-12-18 06:08 | Install        |    1   
     1 | System <unset>           | 2021-11-25 11:05 | Install        |  302   
history list
[root@localhost superadmin]# yum history undo 7 -y
Loaded plugins: fastestmirror
Undoing transaction 7, from Fri Dec 24 09:15:01 2021
    Install nginx-1:1.20.2-1.el7.ngx.x86_64 @nginx
Resolving Dependencies
--> Running transaction check
---> Package nginx.x86_64 1:1.20.2-1.el7.ngx will be erased
--> Finished Dependency Resolution

Dependencies Resolved

======================================================================================================================================================================================================
 Package                                     Arch                                         Version                                                  Repository                                    Size
======================================================================================================================================================================================================
Removing:
 nginx                                       x86_64                                       1:1.20.2-1.el7.ngx                                       @nginx                                       2.8 M

Transaction Summary
======================================================================================================================================================================================================
Remove  1 Package

Installed size: 2.8 M
Downloading packages:
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Erasing    : 1:nginx-1.20.2-1.el7.ngx.x86_64                                                                                                                                                    1/1 
  Verifying  : 1:nginx-1.20.2-1.el7.ngx.x86_64                                                                                                                                                    1/1 

Removed:
  nginx.x86_64 1:1.20.2-1.el7.ngx                                                                                                                                                                     

Complete!
```
4. Disable NGINX repository.
```
[root@localhost superadmin]# sed -i 's/enabled=1/enabled=0/' /etc/yum.repos.d/nginx.repo
```
5. Remove sysstat package installed in the first task.
```
[root@localhost superadmin]# yum remove sysstat -y
Loaded plugins: fastestmirror
Resolving Dependencies
--> Running transaction check
---> Package sysstat.x86_64 0:10.1.5-19.el7 will be erased
--> Finished Dependency Resolution

Dependencies Resolved

======================================================================================================================================================================================================
 Package                                 Arch                                   Version                                          Repository                                                      Size
======================================================================================================================================================================================================
Removing:
 sysstat                                 x86_64                                 10.1.5-19.el7                                    @/sysstat-10.1.5-19.el7.x86_64                                 1.1 M

Transaction Summary
======================================================================================================================================================================================================
Remove  1 Package

Installed size: 1.1 M
Downloading packages:
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Erasing    : sysstat-10.1.5-19.el7.x86_64                                                                                                                                                       1/1 
  Verifying  : sysstat-10.1.5-19.el7.x86_64                                                                                                                                                       1/1 

Removed:
  sysstat.x86_64 0:10.1.5-19.el7                                                                                                                                                                      

Complete!
```
6. Install EPEL repository and get information about it.
[root@localhost superadmin]# yum install epel-release -y
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
 * base: centos-mirror.rbc.ru
 * extras: centos-mirror.rbc.ru
 * updates: centos-mirror.rbc.ru
Resolving Dependencies
--> Running transaction check
---> Package epel-release.noarch 0:7-11 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

======================================================================================================================================================================================================
 Package                                             Arch                                          Version                                        Repository                                     Size
======================================================================================================================================================================================================
Installing:
 epel-release                                        noarch                                        7-11                                           extras                                         15 k

Transaction Summary
======================================================================================================================================================================================================
Install  1 Package

Total download size: 15 k
Installed size: 24 k
Downloading packages:
epel-release-7-11.noarch.rpm                                                                                                                                                   |  15 kB  00:00:00     
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : epel-release-7-11.noarch                                                                                                                                                           1/1 
  Verifying  : epel-release-7-11.noarch                                                                                                                                                           1/1 

Installed:
  epel-release.noarch 0:7-11                                                                                                                                                                          

Complete!

[root@localhost superadmin]# yum info epel-release
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
epel/x86_64/metalink                                                                                                                                                           |  31 kB  00:00:00     
 * base: centos-mirror.rbc.ru
 * epel: mirror.nsc.liu.se
 * extras: centos-mirror.rbc.ru
 * updates: centos-mirror.rbc.ru
epel                                                                                                                                                                           | 4.7 kB  00:00:00     
(1/3): epel/x86_64/group_gz                                                                                                                                                    |  96 kB  00:00:00     
(2/3): epel/x86_64/updateinfo                                                                                                                                                  | 1.0 MB  00:00:00     
(3/3): epel/x86_64/primary_db                                                                                                                                                  | 7.0 MB  00:00:00     
Installed Packages
Name        : epel-release
Arch        : noarch
Version     : 7
Release     : 11
Size        : 24 k
Repo        : installed
From repo   : extras
Summary     : Extra Packages for Enterprise Linux repository configuration
URL         : http://download.fedoraproject.org/pub/epel
License     : GPLv2
Description : This package contains the Extra Packages for Enterprise Linux (EPEL) repository
            : GPG key as well as configuration for yum.

Available Packages
Name        : epel-release
Arch        : noarch
Version     : 7
Release     : 14
Size        : 15 k
Repo        : epel/x86_64
Summary     : Extra Packages for Enterprise Linux repository configuration
URL         : http://download.fedoraproject.org/pub/epel
License     : GPLv2
Description : This package contains the Extra Packages for Enterprise Linux (EPEL) repository
            : GPG key as well as configuration for yum.


7. Find how much packages provided exactly by EPEL repository.
```
[root@localhost superadmin]# yum --disablerepo="*" --enablerepo="epel" list available |wc -l
13920
```
8. Install ncdu package from EPEL repo.
```
[root@localhost superadmin]# yum --enablerepo="epel" install ncdu -y
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
 * base: centos-mirror.rbc.ru
 * epel: ftp.lysator.liu.se
 * extras: centos-mirror.rbc.ru
 * updates: centos-mirror.rbc.ru
Resolving Dependencies
--> Running transaction check
---> Package ncdu.x86_64 0:1.16-1.el7 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

======================================================================================================================================================================================================
 Package                                      Arch                                           Version                                               Repository                                    Size
======================================================================================================================================================================================================
Installing:
 ncdu                                         x86_64                                         1.16-1.el7                                            epel                                          53 k

Transaction Summary
======================================================================================================================================================================================================
Install  1 Package

Total download size: 53 k
Installed size: 89 k
Downloading packages:
warning: /var/cache/yum/x86_64/7/epel/packages/ncdu-1.16-1.el7.x86_64.rpm: Header V4 RSA/SHA256 Signature, key ID 352c64e5: NOKEY                                   ]  0.0 B/s |    0 B  --:--:-- ETA 
Public key for ncdu-1.16-1.el7.x86_64.rpm is not installed
ncdu-1.16-1.el7.x86_64.rpm                                                                                                                                                     |  53 kB  00:00:00     
Retrieving key from file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
Importing GPG key 0x352C64E5:
 Userid     : "Fedora EPEL (7) <epel@fedoraproject.org>"
 Fingerprint: 91e9 7d7c 4a5e 96f1 7f3e 888f 6a2f aea2 352c 64e5
 Package    : epel-release-7-11.noarch (@extras)
 From       : /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : ncdu-1.16-1.el7.x86_64                                                                                                                                                             1/1 
  Verifying  : ncdu-1.16-1.el7.x86_64                                                                                                                                                             1/1 

Installed:
  ncdu.x86_64 0:1.16-1.el7                                                                                                                                                                            

Complete!
```
  
*Extra task:
    Need to create an rpm package consists of a shell script and a text file. The script should output words count stored in file.
```
[root@localhost superadmin]# yum install rpm-build rpmdevtools -y > /dev/null
[root@localhost superadmin]# rpmdev-setuptree
[root@localhost rpmbuild]# ls /root/rpmbuild/
BUILD  RPMS  SOURCES  SPECS  SRPMS
[root@localhost rpmbuild]# cat .rpmmacros 
ckager superadmin

%_topdir %(echo $HOME)/rpmbuild

%_smp_mflags %( \
    [ -z "$RPM_BUILD_NCPUS" ] \\\
        && RPM_BUILD_NCPUS="`/usr/bin/nproc 2>/dev/null || \\\
                             /usr/bin/getconf _NPROCESSORS_ONLN`"; \\\
    if [ "$RPM_BUILD_NCPUS" -gt 16 ]; then \\\
        echo "-j16"; \\\
    elif [ "$RPM_BUILD_NCPUS" -gt 3 ]; then \\\
        echo "-j$RPM_BUILD_NCPUS"; \\\
    else \\\
        echo "-j3"; \\\
    fi )

%__arch_install_post \
    [ "%{buildarch}" = "noarch" ] || QA_CHECK_RPATHS=1 ; \
    case "${QA_CHECK_RPATHS:-}" in [1yY]*) /usr/lib/rpm/check-rpaths ;; esac \
    /usr/lib/rpm/check-buildroot

[root@localhost rpmbuild]# ls /root/rpmbuild/SOURCES/homework7/
homework7.sh  textfile.txt
[root@localhost rpmbuild]# cd /root/rpmbuild/SOURCES/
[root@localhost SOURCES]# tar czf homework7.tar.gz homework7-1

[root@localhost rpmbuild]# cat SPECS/homework7.spec 
Name:           homework7
Version:        1
Release:        0
Summary:        A Bash Script for homework #7

Group:          Admin
BuildArch:      noarch
License:        GPL
URL:            git@github.com:pipetky/epam_devops_data.git
Source0:        homework7.tar.gz

%description
The script outputs words count stored in file.

%prep
%setup -q
%build
%install
install -m 0755 -d $RPM_BUILD_ROOT/etc/homework7
install -m 0600 textfile.txt $RPM_BUILD_ROOT/etc/homework7/textfile.txt
install -m 0755 homework7.sh $RPM_BUILD_ROOT/etc/homework7/homework7.sh

%files
/etc/homework7
/etc/homework7/textfile.txt
/etc/homework7/homework7.sh

%changelog
* Tue Dec 24 2021 Alexandr Karabchevskiy  1.0.0
  - Initial rpm release



[root@localhost rpmbuild]# rpmbuild -ba SPECS/homework7.spec
warning: bogus date in %changelog: Tue Dec 24 2021 Alexandr Karabchevskiy  1.0.0
Executing(%prep): /bin/sh -e /var/tmp/rpm-tmp.PCch4R
+ umask 022
+ cd /root/rpmbuild/BUILD
+ cd /root/rpmbuild/BUILD
+ rm -rf homework7-1
+ /usr/bin/gzip -dc /root/rpmbuild/SOURCES/homework7.tar.gz
+ /usr/bin/tar -xf -
+ STATUS=0
+ '[' 0 -ne 0 ']'
+ cd homework7-1
+ /usr/bin/chmod -Rf a+rX,u+w,g-w,o-w .
+ exit 0
Executing(%build): /bin/sh -e /var/tmp/rpm-tmp.l4Lq1w
+ umask 022
+ cd /root/rpmbuild/BUILD
+ cd homework7-1
+ exit 0
Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.p5dh1b
+ umask 022
+ cd /root/rpmbuild/BUILD
+ '[' /root/rpmbuild/BUILDROOT/homework7-1-0.x86_64 '!=' / ']'
+ rm -rf /root/rpmbuild/BUILDROOT/homework7-1-0.x86_64
++ dirname /root/rpmbuild/BUILDROOT/homework7-1-0.x86_64
+ mkdir -p /root/rpmbuild/BUILDROOT
+ mkdir /root/rpmbuild/BUILDROOT/homework7-1-0.x86_64
+ cd homework7-1
+ install -m 0755 -d /root/rpmbuild/BUILDROOT/homework7-1-0.x86_64/etc/homework7
+ install -m 0600 textfile.txt /root/rpmbuild/BUILDROOT/homework7-1-0.x86_64/etc/homework7/textfile.txt
+ install -m 0755 homework7.sh /root/rpmbuild/BUILDROOT/homework7-1-0.x86_64/etc/homework7/homework7.sh
+ /usr/lib/rpm/find-debuginfo.sh --strict-build-id -m --run-dwz --dwz-low-mem-die-limit 10000000 --dwz-max-die-limit 110000000 /root/rpmbuild/BUILD/homework7-1
/usr/lib/rpm/sepdebugcrcfix: Updated 0 CRC32s, 0 CRC32s did match.
+ '[' noarch = noarch ']'
+ case "${QA_CHECK_RPATHS:-}" in
+ /usr/lib/rpm/check-buildroot
+ /usr/lib/rpm/redhat/brp-compress
+ /usr/lib/rpm/redhat/brp-strip-static-archive /usr/bin/strip
+ /usr/lib/rpm/brp-python-bytecompile /usr/bin/python 1
+ /usr/lib/rpm/redhat/brp-python-hardlink
+ /usr/lib/rpm/redhat/brp-java-repack-jars
Processing files: homework7-1-0.noarch
warning: File listed twice: /etc/homework7/homework7.sh
warning: File listed twice: /etc/homework7/textfile.txt
Provides: homework7 = 1-0
Requires(rpmlib): rpmlib(CompressedFileNames) <= 3.0.4-1 rpmlib(FileDigests) <= 4.6.0-1 rpmlib(PayloadFilesHavePrefix) <= 4.0-1
Checking for unpackaged file(s): /usr/lib/rpm/check-files /root/rpmbuild/BUILDROOT/homework7-1-0.x86_64
Wrote: /root/rpmbuild/SRPMS/homework7-1-0.src.rpm
Wrote: /root/rpmbuild/RPMS/noarch/homework7-1-0.noarch.rpm
Executing(%clean): /bin/sh -e /var/tmp/rpm-tmp.9rfWUc
+ umask 022
+ cd /root/rpmbuild/BUILD
+ cd homework7-1
+ /usr/bin/rm -rf /root/rpmbuild/BUILDROOT/homework7-1-0.x86_64
+ exit 0


[root@localhost rpmbuild]# rpm -qi -p RPMS/noarch/homework7-1-0.noarch.rpm 
Name        : homework7
Version     : 1
Release     : 0
Architecture: noarch
Install Date: (not installed)
Group       : Admin
Size        : 320
License     : GPL
Signature   : (none)
Source RPM  : homework7-1-0.src.rpm
Build Date  : Fri 24 Dec 2021 11:08:41 AM CST
Build Host  : localhost
Relocations : (not relocatable)
URL         : git@github.com:pipetky/epam_devops_data.git
Summary     : A Bash Script for homework #7
Description :
The script outputs words count stored in file.

[root@localhost rpmbuild]# rpm -ivh RPMS/noarch/homework7-1-0.noarch.rpm 
Preparing...                          ################################# [100%]
Updating / installing...
   1:homework7-1-0                    ################################# [100%]

[root@localhost rpmbuild]# ls /etc/homework7/
homework7.sh  textfile.txt

[root@localhost rpmbuild]# /etc/homework7/./homework7.sh 
45

```
  
## Work with files
  
1. Find all regular files below 100 bytes inside your home directory.
```
[superadmin@localhost ~]$ find . -type f -size -100c
./.bash_logout
./.lesshst
./rpmbuild/SOURCES/homework7-1/homework7.sh
./rpmbuild/BUILD/homework7/homework7.sh
./rpmbuild/BUILD/homework7-1/homework7.sh
./rpmbuild/BUILD/homework7-1/debugsources.list
./rpmbuild/BUILD/homework7-1/debugfiles.list
./rpmbuild/BUILD/homework7-1/debuglinks.list
```
2. Find an inode number and a hard links count for the root directory. The hard link count should be about 17. Why?    
There are 18 hardlinks to /, one for each ".." inside each folders (16) and "., .." in /.

```
[root@localhost /]# ls -lia
total 20
      64 dr-xr-xr-x.  18 root root  237 Dec 15 03:47 .
      64 dr-xr-xr-x.  18 root root  237 Dec 15 03:47 ..
     120 lrwxrwxrwx.   1 root root    7 Nov 25 11:05 bin -> usr/bin
      64 dr-xr-xr-x.   5 root root 4096 Dec 23 10:16 boot
    1025 drwxr-xr-x.  20 root root 3100 Dec 18 05:57 dev
16777281 drwxr-xr-x.  78 root root 8192 Dec 24 11:30 etc
33604927 drwxr-xr-x.  15 root root  186 Dec 15 03:49 home
     124 lrwxrwxrwx.   1 root root    7 Nov 25 11:05 lib -> usr/lib
      82 lrwxrwxrwx.   1 root root    9 Nov 25 11:05 lib64 -> usr/lib64
50332069 drwxr-xr-x.   2 root root    6 Apr 11  2018 media
      83 drwxr-xr-x.   2 root root    6 Apr 11  2018 mnt
16778332 drwxr-xr-x.   2 root root   19 Dec 18 05:58 opt
       1 dr-xr-xr-x. 132 root root    0 Dec 18 05:57 proc
33582977 dr-xr-x---.   4 root root  231 Dec 24 11:05 root
    1159 drwxr-xr-x.  24 root root  720 Dec 24 10:12 run
     125 lrwxrwxrwx.   1 root root    8 Nov 25 11:05 sbin -> usr/sbin
     355 drwxr-xr-x.   3 root root   19 Dec 15 03:47 share
33604928 drwxr-xr-x.   2 root root    6 Apr 11  2018 srv
       1 dr-xr-xr-x.  13 root root    0 Dec 18 05:57 sys
16777288 drwxrwxrwt.   7 root root 4096 Dec 24 11:35 tmp
33604889 drwxr-xr-x.  13 root root  155 Nov 25 11:05 usr
50331713 drwxr-xr-x.  19 root root  267 Nov 25 11:11 var
```
3. Check what inode numbers have "/" and "/boot" directory. Why?  
"/boot" and "/" have the same inode numbers, beacause both of them are root directory in their filesystems. And they have the same filesystems.
4. Check the root directory space usage by du command. Compare it with an information from df. If you find differences, try to find out why it happens.
```
[root@localhost /]# du -h 2>/dev/null | tail -n 1
1.8G    .
[root@localhost /]# df -h |grep " \/$"
/dev/mapper/centos-root   28G  1.8G   27G   7% /
```
There is no difference.  

5. Check disk space usage of /var/log directory using ncdu
```
ncdu 1.16 ~ Use the arrow keys to navigate, press ? for help                                                                                                                                          
--- /var/log -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    2.6 MiB [############################] /audit                                                                                                                                                     
    2.0 MiB [#####################       ] /anaconda
  380.0 KiB [####                        ]  messages-20211212
  380.0 KiB [####                        ]  messages-20211219
  224.0 KiB [##                          ]  messages-20211205
  124.0 KiB [#                           ]  messages
   88.0 KiB [                            ]  messages-20211128
   84.0 KiB [                            ]  secure-20211219
   52.0 KiB [                            ]  cron-20211219
   52.0 KiB [                            ]  cron
   48.0 KiB [                            ]  cron-20211205
   48.0 KiB [                            ]  cron-20211212
   40.0 KiB [                            ]  dmesg
   40.0 KiB [                            ]  dmesg.old
   36.0 KiB [                            ]  wtmp
   24.0 KiB [                            ]  boot.log-20211219
   24.0 KiB [                            ]  secure
   20.0 KiB [                            ]  lastlog
   20.0 KiB [                            ]  cron-20211128
   16.0 KiB [                            ]  boot.log-20211216
   12.0 KiB [                            ] /tuned
   12.0 KiB [                            ]  yum.log
   12.0 KiB [                            ]  boot.log-20211126
    8.0 KiB [                            ]  tallylog
    8.0 KiB [                            ]  btmp
    8.0 KiB [                            ]  secure-20211205
    8.0 KiB [                            ]  maillog-20211219
    4.0 KiB [                            ]  secure-20211128
    4.0 KiB [                            ]  maillog
    4.0 KiB [                            ]  grubby
    4.0 KiB [                            ]  firewalld
    4.0 KiB [                            ]  maillog-20211128
    4.0 KiB [                            ]  btmp-20211201
    4.0 KiB [                            ]  maillog-20211205
    4.0 KiB [                            ]  grubby_prune_debug
    4.0 KiB [                            ]  auth-errors
    0.0   B [                            ] /nginx
e   0.0   B [                            ] /rhsm
e   0.0   B [                            ] /qemu-ga
    0.0   B [                            ]  spooler-20211219
    0.0   B [                            ]  spooler-20211212
    0.0   B [                            ]  spooler-20211205
    0.0   B [                            ]  spooler-20211128
    0.0   B [                            ]  spooler
    0.0   B [                            ]  secure-20211212
    0.0   B [                            ]  maillog-20211212
    0.0   B [                            ]  boot.log

 Total disk usage:   6.3 MiB  Apparent size:   6.5 MiB  Items: 61                          

```