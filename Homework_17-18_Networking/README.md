1. add secondary ip address to you second network interface enp0s8. Each point must be presented with commands and showing that new address was applied to the interface. To repeat adding address for points 2 and 3 address must be deleted (please add deleting address to you homework log) Methods:

```
[root@localhost superadmin]# ip -4 a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    inet 192.168.0.219/22 brd 192.168.3.255 scope global noprefixroute dynamic eth0
       valid_lft 2566954sec preferred_lft 2566954sec
```

1. using ip utility (stateless)
```
   [root@localhost superadmin]# ip a add 192.168.0.220/22 dev eth0
 [root@localhost superadmin]# ip -4 a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    inet 192.168.0.219/22 brd 192.168.3.255 scope global noprefixroute dynamic eth0
       valid_lft 2566883sec preferred_lft 2566883sec
    inet 192.168.0.220/22 scope global secondary eth0
       valid_lft forever preferred_lft forever
[root@localhost superadmin]# ip a del 192.168.0.220/22 dev eth0
[root@localhost superadmin]# ip -4 a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    inet 192.168.0.219/22 brd 192.168.3.255 scope global noprefixroute dynamic eth0
       valid_lft 2566323sec preferred_lft 2566323sec

```

2. using centos network configuration file (statefull)
```
[root@localhost superadmin]# cat /etc/sysconfig/network-scripts/ifcfg-eth0:0
DEVICE=eth0
ONBOOT=yes
IPADDR=192.168.0.220
NETMASK=255.255.252.0

[root@localhost superadmin]# ifup eth0:0
RTNETLINK answers: File exists
Determining if ip address 192.168.0.220 is already in use for device eth0...
RTNETLINK answers: File exists
[root@localhost superadmin]# ip -4 a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    inet 192.168.0.219/22 brd 192.168.3.255 scope global noprefixroute dynamic eth0
       valid_lft 2565242sec preferred_lft 2565242sec
    inet 192.168.0.220/22 brd 192.168.3.255 scope global secondary eth0
       valid_lft forever preferred_lft forever
[root@localhost superadmin]# ifdown eth0
[root@localhost superadmin]# rm /etc/sysconfig/network-scripts/ifcfg-eth0:0
[root@localhost superadmin]# ifup eth0
[root@localhost superadmin]# ip -4 a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    inet 192.168.0.219/22 brd 192.168.3.255 scope global noprefixroute dynamic eth0
       valid_lft 2564815sec preferred_lft 2564815sec
```
   
3. using nmcli utility (statefull)
```
[root@localhost superadmin]# nmcli con mod eth0 ipv4.addresses  192.168.0.220/24
[root@localhost superadmin]# nmcli con up eth0
[root@localhost superadmin]# ip -4 a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    inet 192.168.0.219/22 brd 192.168.3.255 scope global noprefixroute dynamic eth0
       valid_lft 2504984sec preferred_lft 2504984sec
    inet 192.168.0.220/24 brd 192.168.0.255 scope global noprefixroute eth0
       valid_lft forever preferred_lft forever


```
2. You should have a possibility to use ssh client to connect to your node using new address from previous step. Run tcpdump in separate tmux session or separate connection before starting ssh client and capture packets that are related to this ssh connection. Find packets that are related to TCP session establish.
```
[root@localhost superadmin]# tcpdump -i eth0 dst 192.168.0.220 and port 22 
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 262144 bytes
04:47:34.468385 IP 192.168.3.86.52146 > localhost.localdomain.ssh: Flags [S], seq 1929962074, win 64240, options [mss 1460,sackOK,TS val 2773442148 ecr 0,nop,wscale 7], length 0
04:47:34.469438 IP 192.168.3.86.52146 > localhost.localdomain.ssh: Flags [.], ack 296860049, win 502, options [nop,nop,TS val 2773442149 ecr 1787829], length 0
04:47:34.470275 IP 192.168.3.86.52146 > localhost.localdomain.ssh: Flags [P.], seq 0:41, ack 1, win 502, options [nop,nop,TS val 2773442150 ecr 1787829], length 41
04:47:34.488676 IP 192.168.3.86.52146 > localhost.localdomain.ssh: Flags [.], ack 22, win 502, options [nop,nop,TS val 2773442168 ecr 1787848], length 0
04:47:34.491432 IP 192.168.3.86.52146 > localhost.localdomain.ssh: Flags [P.], seq 41:1553, ack 22, win 502, options [nop,nop,TS val 2773442171 ecr 1787848], length 1512
04:47:34.492885 IP 192.168.3.86.52146 > localhost.localdomain.ssh: Flags [.], ack 1302, win 501, options [nop,nop,TS val 2773442173 ecr 1787852], length 0
04:47:34.502332 IP 192.168.3.86.52146 > localhost.localdomain.ssh: Flags [P.], seq 1553:1601, ack 1302, win 501, options [nop,nop,TS val 2773442182 ecr 1787852], length 48
04:47:34.514331 IP 192.168.3.86.52146 > localhost.localdomain.ssh: Flags [.], ack 1666, win 501, options [nop,nop,TS val 2773442194 ecr 1787874], length 0
04:47:34.524338 IP 192.168.3.86.52146 > localhost.localdomain.ssh: Flags [P.], seq 1601:1617, ack 1666, win 501, options [nop,nop,TS val 2773442204 ecr 1787874], length 16
04:47:34.563991 IP 192.168.3.86.52146 > localhost.localdomain.ssh: Flags [P.], seq 1617:1661, ack 1666, win 501, options [nop,nop,TS val 2773442244 ecr 1787924], length 44
04:47:34.564646 IP 192.168.3.86.52146 > localhost.localdomain.ssh: Flags [.], ack 1710, win 501, options [nop,nop,TS val 2773442244 ecr 1787924], length 0
04:47:34.564706 IP 192.168.3.86.52146 > localhost.localdomain.ssh: Flags [P.], seq 1661:1729, ack 1710, win 501, options [nop,nop,TS val 2773442244 ecr 1787924], length 68
04:47:34.568059 IP 192.168.3.86.52146 > localhost.localdomain.ssh: Flags [.], ack 1794, win 501, options [nop,nop,TS val 2773442248 ecr 1787928], length 0
04:47:34.572188 IP 192.168.3.86.52146 > localhost.localdomain.ssh: Flags [P.], seq 1729:2101, ack 1794, win 501, options [nop,nop,TS val 2773442252 ecr 1787928], length 372
04:47:34.575781 IP 192.168.3.86.52146 > localhost.localdomain.ssh: Flags [P.], seq 2101:2753, ack 2126, win 501, options [nop,nop,TS val 2773442255 ecr 1787934], length 652
04:47:34.588302 IP 192.168.3.86.52146 > localhost.localdomain.ssh: Flags [P.], seq 2753:2865, ack 2154, win 501, options [nop,nop,TS val 2773442268 ecr 1787948], length 112
04:47:34.838269 IP 192.168.3.86.52146 > localhost.localdomain.ssh: Flags [.], ack 2654, win 501, options [nop,nop,TS val 2773442518 ecr 1788154], length 0
04:47:34.838919 IP 192.168.3.86.52146 > localhost.localdomain.ssh: Flags [.], ack 2698, win 501, options [nop,nop,TS val 2773442519 ecr 1788198], length 0
04:47:34.839157 IP 192.168.3.86.52146 > localhost.localdomain.ssh: Flags [P.], seq 2865:3257, ack 2698, win 501, options [nop,nop,TS val 2773442519 ecr 1788198], length 392
04:47:34.846271 IP 192.168.3.86.52146 > localhost.localdomain.ssh: Flags [.], ack 2806, win 501, options [nop,nop,TS val 2773442526 ecr 1788206], length 0
04:47:34.848363 IP 192.168.3.86.52146 > localhost.localdomain.ssh: Flags [.], ack 2898, win 501, options [nop,nop,TS val 2773442528 ecr 1788208], length 0
04:47:34.892304 IP 192.168.3.86.52146 > localhost.localdomain.ssh: Flags [.], ack 2998, win 501, options [nop,nop,TS val 2773442572 ecr 1788252], length 0

```
**Established only:**
```
[root@localhost superadmin]#  tcpdump -i eth0 dst 192.168.0.220 and port 22 and 'tcp[13] & 8 == 8'
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 262144 bytes
05:06:29.036213 IP 192.168.3.86.52356 > localhost.localdomain.ssh: Flags [P.], seq 2726740141:2726740182, ack 199548490, win 502, options [nop,nop,TS val 2774576705 ecr 2922395], length 41
05:06:29.056891 IP 192.168.3.86.52356 > localhost.localdomain.ssh: Flags [P.], seq 41:1553, ack 22, win 502, options [nop,nop,TS val 2774576726 ecr 2922414], length 1512
05:06:29.069420 IP 192.168.3.86.52356 > localhost.localdomain.ssh: Flags [P.], seq 1553:1601, ack 1302, win 501, options [nop,nop,TS val 2774576738 ecr 2922419], length 48
05:06:29.088763 IP 192.168.3.86.52356 > localhost.localdomain.ssh: Flags [P.], seq 1601:1617, ack 1666, win 501, options [nop,nop,TS val 2774576758 ecr 2922441], length 16
05:06:29.128898 IP 192.168.3.86.52356 > localhost.localdomain.ssh: Flags [P.], seq 1617:1661, ack 1666, win 501, options [nop,nop,TS val 2774576798 ecr 2922489], length 44
05:06:29.129580 IP 192.168.3.86.52356 > localhost.localdomain.ssh: Flags [P.], seq 1661:1729, ack 1710, win 501, options [nop,nop,TS val 2774576799 ecr 2922489], length 68
05:06:29.138009 IP 192.168.3.86.52356 > localhost.localdomain.ssh: Flags [P.], seq 1729:2101, ack 1794, win 501, options [nop,nop,TS val 2774576807 ecr 2922493], length 372
05:06:29.141651 IP 192.168.3.86.52356 > localhost.localdomain.ssh: Flags [P.], seq 2101:2753, ack 2126, win 501, options [nop,nop,TS val 2774576811 ecr 2922500], length 652
05:06:29.154641 IP 192.168.3.86.52356 > localhost.localdomain.ssh: Flags [P.], seq 2753:2865, ack 2154, win 501, options [nop,nop,TS val 2774576824 ecr 2922514], length 112
05:06:29.489831 IP 192.168.3.86.52356 > localhost.localdomain.ssh: Flags [P.], seq 2865:3257, ack 2698, win 501, options [nop,nop,TS val 2774577159 ecr 2922849], length 392
```
3. Close session. Find in tcpdump output packets that are related to TCP session closure.
```
[root@localhost superadmin]#  tcpdump -i eth0 dst 192.168.0.220 and port 22 and 'tcp[13] & 1 == 1'
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 262144 bytes
05:17:25.145146 IP 192.168.3.86.52450 > localhost.localdomain.ssh: Flags [F.], seq 849559791, ack 435058857, win 501, options [nop,nop,TS val 2775232808 ecr 3578504], length 0
```
4. run tcpdump and request any http site in separate session. Find HTTP request and answer packets with ASCII data in it.  Tcpdump command must be as strict as possible to capture only needed packages for this http request.
```
[root@localhost superadmin]# tcpdump -A host 192.168.3.140 and  'tcp port 80 and (((ip[2:2] - ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0)'
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 262144 bytes
05:28:28.722391 IP localhost.localdomain.50148 > wikiadmin.p-c.ru.http: Flags [P.], seq 3873676030:3873676107, ack 1047239806, win 229, options [nop,nop,TS val 4242082 ecr 3118782795], length 77: HTTP: GET / HTTP/1.1
E... a@.@..^...........P....>k.~.....+.....
.@.....KGET / HTTP/1.1
User-Agent: curl/7.29.0
Host: 192.168.3.140
Accept: */*


05:28:28.722872 IP wikiadmin.p-c.ru.http > localhost.localdomain.50148: Flags [P.], seq 1:860, ack 77, win 227, options [nop,nop,TS val 3118782796 ecr 4242082], length 859: HTTP: HTTP/1.1 200 OK
E.....@.@..
.........P..>k.~...K.....9.....
...L.@..HTTP/1.1 200 OK
Server: nginx/1.14.0 (Ubuntu)
Date: Thu, 30 Dec 2021 10:28:28 GMT
Content-Type: text/html
Content-Length: 612
Last-Modified: Wed, 22 Apr 2020 13:25:51 GMT
Connection: keep-alive
ETag: "5ea045df-264"
Accept-Ranges: bytes

<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```