import json
import logging

import docker
from consolemenu import *
from consolemenu.items import *
from tabulate import tabulate


class Docker:
    def __init__(self):
        self.client = docker.from_env()

    def get_bad_containers(self):

        containers = self.client.containers.list(all=True)
        for container in containers:
            if container.status == 'exited' or container.status == 'dead':
                logging.error(f'{container.name} is in {container.status} status')

    def connect(self):
        url = input("enter url to connect: ")
        if url:
            self.client = docker.DockerClient(base_url=url)
        else:
            self.client = docker.from_env()

    def con_list(self):
        tab_list = []
        containers = self.client.containers.list(all=True)
        for container in containers:
            tab_list.append([container.id, container.image.tags[0], container.status, container.name])
        print(tabulate(tab_list, headers=['CONTAINER ID', 'IMAGE', 'STATUS', 'NAMES']))

    def inspect(self):
        con_id = input('enter container id: ')
        print(json.dumps(self.client.api.inspect_container(con_id), sort_keys=True, indent=4))


if __name__ == '__main__':
    doc = Docker()
    menu = ConsoleMenu("Title", "Subtitle")
    check_containers_status = FunctionItem("check containers status", doc.get_bad_containers)
    connect = FunctionItem("connect to docker", doc.connect)
    container_list = FunctionItem("print containers list", doc.con_list)
    container_inspect = FunctionItem("inspect container", doc.inspect)
    menu.append_item(check_containers_status)
    menu.append_item(connect)
    menu.append_item(container_list)
    menu.append_item(container_inspect)
    menu.show()
