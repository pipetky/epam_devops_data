### Используя ansible ad-hoc:

1. Cоздать такого же пользователя на остальных машинах:  
```
superadmin@PipetkyBook:~/epam_devops_data/ansible$ ansible -i inventory.yml epam -m ansible.builtin.user -a "name=superadmin group=wheel" -u localadmin --ask-pass --become --ask-become-pass
SSH password: 
BECOME password[defaults to SSH password]: 
192.168.3.100 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": true,
    "comment": "",
    "create_home": true,
    "group": 10,
    "home": "/home/superadmin",
    "name": "superadmin",
    "shell": "/bin/bash",
    "state": "present",
    "system": false,
    "uid": 1001
}
192.168.3.101 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": true,
    "comment": "",
    "create_home": true,
    "group": 10,
    "home": "/home/superadmin",
    "name": "superadmin",
    "shell": "/bin/bash",
    "state": "present",
    "system": false,
    "uid": 1001
}
```


2. Подложить ему ssh-ключи  
```
superadmin@PipetkyBook:~/epam_devops_data/ansible$ ansible -i inventory.yml epam -m ansible.posix.authorized_key -a "user=superadmin state=present key='{{ lookup('file', '/home/superadmin/.ssh/id_rsa.pub') }}'" -u localadmin --ask-pass --become --ask-become-pass
SSH password: 
BECOME password[defaults to SSH password]: 
192.168.3.100 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": true,
    "comment": null,
    "exclusive": false,
    "follow": false,
    "key": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCxGnavuuRHekoZoXYpjvE45C8Z0hk1HXVBpAS8VOrg0XuBk21VMN4BJBF2XR/eIRXkUACyErWSV3WWssAZQtyoc+fyTiqC690hGNxBjTC9ukKtGAQv4Vi8SCitKhW/vkWFlMIxYAuL0ITwa5E5py3ZeL4RzRw6TukfgZLQEw8BgHiO0O6+9MTxO6vvqgSwQFu/wZ3tMxNL+5zTw3lxgi7w3MlbP8cAKDgF2ZnCmnd23izQEKRXd37E9aI4d2AuZKI0n4oyxlvYo4nPuNcKr1Vsss9O0lYOGk6ht+KRM3is+cQsrehVkCP4DCOR4VJMcoIItcUR5zyvx/kCKO827Tjf",
    "key_options": null,
    "keyfile": "/home/superadmin/.ssh/authorized_keys",
    "manage_dir": true,
    "path": null,
    "state": "present",
    "user": "superadmin",
    "validate_certs": true
}
192.168.3.101 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": true,
    "comment": null,
    "exclusive": false,
    "follow": false,
    "key": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCxGnavuuRHekoZoXYpjvE45C8Z0hk1HXVBpAS8VOrg0XuBk21VMN4BJBF2XR/eIRXkUACyErWSV3WWssAZQtyoc+fyTiqC690hGNxBjTC9ukKtGAQv4Vi8SCitKhW/vkWFlMIxYAuL0ITwa5E5py3ZeL4RzRw6TukfgZLQEw8BgHiO0O6+9MTxO6vvqgSwQFu/wZ3tMxNL+5zTw3lxgi7w3MlbP8cAKDgF2ZnCmnd23izQEKRXd37E9aI4d2AuZKI0n4oyxlvYo4nPuNcKr1Vsss9O0lYOGk6ht+KRM3is+cQsrehVkCP4DCOR4VJMcoIItcUR5zyvx/kCKO827Tjf",
    "key_options": null,
    "keyfile": "/home/superadmin/.ssh/authorized_keys",
    "manage_dir": true,
    "path": null,
    "state": "present",
    "user": "superadmin",
    "validate_certs": true
}
```


3. Дать возможность использовать sudo (помните о том, что редактирование /etc/sudoers не через visudo - плохая идея)  
```
superadmin@PipetkyBook:~/epam_devops_data/ansible$ ansible -i inventory.yml epam -m ansible.builtin.lineinfile -a "path=/etc/sudoers state=present regexp='^%wheel ALL=' line='%wheel  ALL=(ALL) NOPASSWD: ALL' validate='/usr/sbin/visudo -cf %s'" -u localadmin --ask-pass --become --ask-become-pass
SSH password: 
BECOME password[defaults to SSH password]: 
192.168.3.101 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "backup": "",
    "changed": true,
    "msg": "line added"
}
192.168.3.100 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "backup": "",
    "changed": true,
    "msg": "line added"
}
```