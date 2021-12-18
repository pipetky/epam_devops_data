#!/bin/bash
# 3. Создать 2 файла: 1-й - текстовый с указанием абслютного пути до директории. 2-й - скрипт, который при выполнении выводит содержимое директории 
# по указанному в первом файле.
# *. Скрипт выводит отдельно количество файлов и количество директорий.
# **. Скрипт принимает любое количество записей в первом файле и обрабатывает из последовательно.

green=`tput setaf 2`
reset=`tput sgr0`
yellow=`tput setaf 3`

echo "${red}red text ${green}green text${reset}"
for path in $(cat paths.txt) 
    do
        echo "${green} $path: ${yellow} contains $(ls -p $path |grep -v / | wc -l) files and $(ls -p $path |grep / | wc -l) directories ${reset} " 
        ls $path
    done