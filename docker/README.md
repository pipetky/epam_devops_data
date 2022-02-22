# Docker: Hadoop

Run Hadoop service in two Docker containers.  <br/>

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

* Docker
You can use the installation instructions guide [Installation Guide](https://docs.docker.com/engine/install/)
* Docker-compose 
You can use the installation instructions guide [Installation Guide](https://docs.docker.com/compose/install/)

### Building

Clone the repo and generate ssh keys::

```
git clone --branch docker https://github.com/pipetky/epam_devops_data.git
cd epam_devops_data/docker
mkdir ssh_keys
ssh-keygen -f ssh_keys/worker_id_rsa -N "" -C ""
ssh-keygen -f ssh_keys/headnode_id_rsa -N "" -C ""
```
Create volumes and network:
```
docker network create docker_hadoop && \
docker volume create docker_worker_1 && \
docker volume create docker_worker_2 && \
docker volume create docker_headnode_1 && \
docker volume create docker_headnode_2
```
Build images:
```
docker build -t pipetky/hadoop:worker -f worker.dockerfile . 
docker build -t pipetky/hadoop:headnode -f headnode.dockerfile .
``` 
### Run:
```
docker run -v docker_worker_1:/opt/mount1 -v docker_worker_2:/opt/mount2 --network docker_hadoop -p 9864:9864 -h worker -d --name worker pipetky/hadoop:worker
docker run -v docker_headnode_1:/opt/mount1 -v docker_headnode_2:/opt/mount2 --network docker_hadoop -p 8088:8088 -p 9870:9870 -h headnode -d --name headnode pipetky/hadoop:headnode
```

### Docker-compose:

You can also start service by runnig the docker-compose command:
```
docker-compose up
```

### Using:
Try to open in your browser:  
[http://127.0.0.1:8088](http://127.0.0.1:8088)  
[http://127.0.0.1:9870](http://127.0.0.1:9870)

### Contacts
Aleksandr Karabchevskiy - pipetky@gmail.com

Project Link: https://github.com/pipetky/epam_devops_data
DockerHub Link: https://hub.docker.com/r/pipetky/hadoop