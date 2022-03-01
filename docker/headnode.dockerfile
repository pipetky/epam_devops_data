FROM ubuntu:20.04
SHELL ["/bin/bash", "-c"]
ENV HADOOP_HOME=/usr/local/hadoop/current
ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
ENV HADOOP_LOG_DIR=/var/log/hadoop
COPY headnode_start.sh /
RUN apt update -y && \
apt install -y openssh-client openssh-server wget sudo openjdk-8-jdk && \
echo "headnode" > /etc/hostname && \
chmod +x headnode_start.sh && \
groupadd hadoop && \
useradd -m -g hadoop hadoop && \
useradd -g hadoop yarn && \
useradd -g hadoop hdfs && \
mkdir -p /opt/mount{1,2}/namenode-dir && \
chown hdfs:hadoop /opt/mount{1,2}/namenode-dir && \
wget https://archive.apache.org/dist/hadoop/common/hadoop-3.1.2/hadoop-3.1.2.tar.gz && \
tar xvzf hadoop-3.1.2.tar.gz -C /opt/ && \
mkdir /usr/local/hadoop && \
ln -s /opt/hadoop-3.1.2 /usr/local/hadoop/current && \
wget -O /usr/local/hadoop/current/etc/hadoop/hadoop-env.sh https://gist.githubusercontent.com/rdaadr/2f42f248f02aeda18105805493bb0e9b/raw/6303e424373b3459bcf3720b253c01373666fe7c/hadoop-env.sh && \
wget -O /usr/local/hadoop/current/etc/hadoop/core-site.xml https://gist.githubusercontent.com/rdaadr/64b9abd1700e15f04147ea48bc72b3c7/raw/2d416bf137cba81b107508153621ee548e2c877d/core-site.xml && \
wget -O /usr/local/hadoop/current/etc/hadoop/hdfs-site.xml https://gist.githubusercontent.com/rdaadr/2bedf24fd2721bad276e416b57d63e38/raw/640ee95adafa31a70869b54767104b826964af48/hdfs-site.xml && \
wget -O /usr/local/hadoop/current/etc/hadoop/yarn-site.xml https://gist.githubusercontent.com/Stupnikov-NA/ba87c0072cd51aa85c9ee6334cc99158/raw/bda0f760878d97213196d634be9b53a089e796ea/yarn-site.xml && \
sed -i -e 's|^export JAVA_HOME=.*$|export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64|' -e 's|^export HADOOP_HOME=.*$|export HADOOP_HOME=/usr/local/hadoop/current|' -e 's|^export HADOOP_HEAPSIZE_MAX=.*$|export HADOOP_HEAPSIZE_MAX=512M|' /usr/local/hadoop/current/etc/hadoop/hadoop-env.sh && \
sed -i 's|%HDFS_NAMENODE_HOSTNAME%|headnode|' /usr/local/hadoop/current/etc/hadoop/core-site.xml && \
sed -i -e 's|%NAMENODE_DIRS%|/opt/mount1/namenode-dir,/opt/mount2/namenode-dir|' -e 's|%DATANODE_DIRS%|/opt/mount1/datanode-dir,/opt/mount2/datanode-dir|' /usr/local/hadoop/current/etc/hadoop/hdfs-site.xml && \
sed -i -e 's|%YARN_RESOURCE_MANAGER_HOSTNAME%|headnode|' -e 's|%NODE_MANAGER_LOCAL_DIR%|/opt/mount1/nodemanager-local-dir,/opt/mount2/nodemanager-local-dir|' -e 's|%NODE_MANAGER_LOG_DIR%|/opt/mount1/nodemanager-log-dir,/opt/mount2/nodemanager-log-dir|' /usr/local/hadoop/current/etc/hadoop/yarn-site.xml && \
echo "HADOOP_HOME=/usr/local/hadoop/current" | sudo tee -a /etc/profile.d/hadoop.sh && \
mkdir /var/log/hadoop && \
chown hadoop:hadoop /var/log/hadoop/ && \
chmod 775 /var/log/hadoop/ && \
sed -i 's|^# export HADOOP_LOG_DIR.*$|export HADOOP_LOG_DIR=/var/log/hadoop|' /usr/local/hadoop/current/etc/hadoop/hadoop-env.sh && \
sudo -u hdfs $HADOOP_HOME/bin/hdfs namenode -format cluster1 && \
mkdir /run/sshd
COPY ["ssh_keys/headnode_id_rsa.pub","ssh_keys/headnode_id_rsa", "ssh_keys/worker_id_rsa.pub", "/home/hadoop/.ssh/"]
RUN mv /home/hadoop/.ssh/headnode_id_rsa.pub /home/hadoop/.ssh/id_rsa.pub && \
mv /home/hadoop/.ssh/headnode_id_rsa /home/hadoop/.ssh/id_rsa && \
cat /home/hadoop/.ssh/worker_id_rsa.pub >> /home/hadoop/.ssh/authorized_keys && \
chown hadoop:hadoop /home/hadoop/.ssh/* 
ENTRYPOINT ./headnode_start.sh
