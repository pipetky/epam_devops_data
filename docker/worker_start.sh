#!/bin/bash
/usr/sbin/sshd -D -o ListenAddress=0.0.0.0 &

sudo -u hdfs /usr/local/hadoop/current/bin/hdfs datanode &
sudo -u yarn /usr/local/hadoop/current/bin/yarn nodemanager &

# Wait for any process to exit
wait -n
  
# Exit with status of process that exited first
exit $?