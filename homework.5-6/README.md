### Awk /ɔːk/
1. What is the most frequent browser?<br/>
**Ответ:**
```
superadmin@PipetkyBook:~/epam_devops_data/homework.5-6$ awk -F\" '{seen[$6]++}END{for (i in seen) print seen[i], i}' access.log | sort -n | tail -n 1
340874 Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)

```

2. Show number of requests per month for ip 216.244.66.230 (for example: Sep 2016 - 100500 reqs, Oct 2016 - 0 reqs, Nov 2016 - 2 reqs...)<br/>
**Ответ:**
```
superadmin@PipetkyBook:~/epam_devops_data/homework.5-6$ awk '$1=="216.244.66.230" {gsub(/\//, " ", $4); reqs[substr($4, 5, 8)]++}END{for (i in reqs) print i, "-"reqs[i]" reqs"}' access.log
Feb 2021 -14 reqs
Dec 2020 -1 reqs
Nov 2021 -106 reqs
May 2021 -27 reqs
Jul 2021 -23 reqs
Oct 2021 -23 reqs
Apr 2021 -34 reqs
Jun 2021 -3 reqs
Sep 2021 -7 reqs
Jan 2021 -43 reqs
Dec 2021 -5 reqs
Mar 2021 -2 reqs
Aug 2021 -108 reqs
```
3. Show total amount of data which server has provided for each unique ip (i.e. 100500 bytes for 1.2.3.4; 9001 bytes for 5.4.3.2 and so on)<br/>
**Ответ:**
```
superadmin@PipetkyBook:~/epam_devops_data/homework.5-6$ awk  '{data[$1]+=$10}END{for (i in data) print data[i] " bytes", "for " i}' access.log |head -n 5
55659696 bytes for 96.55.233.248
133930511 bytes for 45.120.49.66
11871936 bytes for 138.186.137.168
226 bytes for 162.55.223.199
10439 bytes for 194.195.117.205 
```

### Sed
1. Change all browsers to "lynx"<br/>
**Ответ:**
```
superadmin@PipetkyBook:~/epam_devops_data/homework.5-6$ sed -E 's/"[^"]*/"lynx/5' access.log |head -n 5
13.66.139.0 - - [19/Dec/2020:13:57:26 +0100] "GET /index.php?option=com_phocagallery&view=category&id=1:almhuette-raith&Itemid=53 HTTP/1.1" 200 32653 "-" "lynx" "-"
157.48.153.185 - - [19/Dec/2020:14:08:06 +0100] "GET /apache-log/access.log HTTP/1.1" 200 233 "-" "lynx" "-"
157.48.153.185 - - [19/Dec/2020:14:08:08 +0100] "GET /favicon.ico HTTP/1.1" 404 217 "http://www.almhuette-raith.at/apache-log/access.log" "lynx" "-"
216.244.66.230 - - [19/Dec/2020:14:14:26 +0100] "GET /robots.txt HTTP/1.1" 200 304 "-" "lynx" "-"
54.36.148.92 - - [19/Dec/2020:14:16:44 +0100] "GET /index.php?option=com_phocagallery&view=category&id=2%3Awinterfotos&Itemid=53 HTTP/1.1" 200 30662 "-" "lynx" "-"
```
2. Masquerade all ip addresses. Rewrite file.<br/>
**Ответ:**
```
superadmin@PipetkyBook:~/epam_devops_data/homework.5-6$ sed -E -i 's/[[:digit:]][^ ]*/x.x.x.x/' access.log
superadmin@PipetkyBook:~/epam_devops_data/homework.5-6$ head -n 5 access.log 

x.x.x.x - - [19/Dec/2020:13:57:26 +0100] "GET /index.php?option=com_phocagallery&view=category&id=1:almhuette-raith&Itemid=53 HTTP/1.1" 200 32653 "-" "Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)" "-"
x.x.x.x - - [19/Dec/2020:14:08:06 +0100] "GET /apache-log/access.log HTTP/1.1" 200 233 "-" "Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36" "-"
x.x.x.x - - [19/Dec/2020:14:08:08 +0100] "GET /favicon.ico HTTP/1.1" 404 217 "http://www.almhuette-raith.at/apache-log/access.log" "Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36" "-"
x.x.x.x - - [19/Dec/2020:14:14:26 +0100] "GET /robots.txt HTTP/1.1" 200 304 "-" "Mozilla/5.0 (compatible; DotBot/1.1; http://www.opensiteexplorer.org/dotbot, help@moz.com)" "-"
```
### Extra (*)<br/>
Show list of unique ips, who made more then 50 requests to the same url within 10 minutes (for example too many requests to "/")<br/>
**Ответ:**<br/>
It works for 5-10 minutes, and loads cpu.<br/>
```
superadmin@PipetkyBook:~/epam_devops_data/homework.5-6$ sed -E "/\[/s/:/ /; /\[/s/\//-/; /\[/s/\//-/"  access.log | awk  '{ts="\""substr($4" "$5, 2, 17)"\""; ("date +%s -d "ts)| getline epochsec; print $1, (epochsec/60), $8}' | awk '{reqs[$1" "$3" "$2]++}END{for ( i in reqs)  if (reqs[i]>=50) print i, " "reqs[i]}' | awk '{result[$1" to \""$2"\""]+=$4}END{for (i in result) print "from "i" - "result[i] " requests" }' | head -n 10
from 62.138.6.15 to "/robots.txt" - 111 requests
from 62.39.220.35 to "/apache-log/access.log" - 130 requests
from 62.138.6.15 to "/index.php?option=com_phocagallery&view=category&id=2:winterfotos&Itemid=53" - 71 requests
from 88.136.178.175 to "/apache-log/access.log" - 354 requests
from 181.215.0.50 to "/administrator/index.php" - 80 requests
from 112.45.96.181 to "/apache-log/access.log" - 173 requests
from 213.80.185.129 to "/apache-log/access.log" - 79 requests
from 107.174.33.153 to "/apache-log/access.log" - 51 requests
from 45.57.153.61 to "/apache-log/access.log" - 58 requests
from 13.89.61.99 to "/vendor/phpunit/phpunit/src/Util/PHP/eval-stdin.php" - 96 requests
```