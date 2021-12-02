1. Открыть инструкцию по пользованию приложением awk. Найти секцию про использование переменных окружения. Сохранить эту секцию в отдельный файл.
**Ответ:**
```
[superadmin@localhost ~]$ man awk | grep  "ENVIRONMENT VARIABLES" -A 7 > man_awk_env.txt
[superadmin@localhost ~]$ cat man_awk_env.txt 
ENVIRONMENT VARIABLES
       The AWKPATH environment variable can be used to provide a list of directories that gawk searches when looking for files named via the -f and --file options.

       For socket communication, two special environment variables can be used to control the number of retries (GAWK_SOCK_RETRIES), and the interval between retries (GAWK_MSEC_SLEEP).  The interval is  in
       milliseconds. On systems that do not support usleep(3), the value is rounded up to an integral number of seconds.

       If  POSIXLY_CORRECT  exists  in  the environment, then gawk behaves exactly as if --posix had been specified on the command line.  If --lint has been specified, gawk issues a warning message to this
       effect.
```
2. Написать скрипт, который создаёт файл "task2.txt" директорией выше своего местоположения. В случае ошибки текст ошибки записывается в err.log а пользователю выдаётся сообщение "Error."
\*. Если файл уже существует, выдаётся одна ошибка, а если нет прав для его создания - другая.
**Ответ:**
script_1.sh
3. Создать 2 файла: 1-й - текстовый с указанием абслютного пути до директории. 2-й - скрипт, который при выполнении выводит содержимое директории по указанному в первом файле.
\*. Скрипт выводит отдельно количество файлов и количество директорий.
\**. Скрипт принимает любое количество записей в первом файле и обрабатывает их последовательно.
**Ответ:**:
script_2.sh