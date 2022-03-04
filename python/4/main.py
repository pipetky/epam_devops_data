import os
from string import Template

if __name__ == '__main__':
    str_t = Template(
        "This script has the following PID: $pid. It was ran by $user to work happily on $os_name-$release.")
    print(str_t.substitute(pid=os.getpid(), user=os.getlogin(), os_name=os.uname().sysname, release=os.uname().release))
    print("This script has the following PID: {}. It was ran by {} to work happily on {}-{}.".format(os.getpid(),
                                                                                                     os.getlogin(),
                                                                                                     os.uname().sysname,
                                                                                                     os.uname().release))
    print("This script has the following PID: %d. It was ran by %s to work happily on %s-%s." % (os.getpid(),
                                                                                                 os.getlogin(),
                                                                                                 os.uname().sysname,
                                                                                                 os.uname().release))
    print(
        f"This script has the following PID: {os.getpid()}. It was ran by {os.getlogin()} to work happily on {os.uname().sysname}-{os.uname().release}.")
