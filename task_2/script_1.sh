#!/bin/bash
# Написать скрипт, который создаёт файл "task2.txt" директорией выше своего местоположения. 
# В случае ошибки текст ошибки записывается в err.log а пользователю выдаётся сообщение "Error."
# *. Если файл уже существует, выдаётся одна ошибка, а если нет прав для его создания - другая.


if [[ -f ../task2.txt ]]
    then 
        echo "Error! File already exist!"
    else
        touch ../task2.txt 2> err.log || echo "Error! See more in err.log"
fi