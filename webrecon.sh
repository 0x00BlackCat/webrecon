#/bin/bash

# banner
if [ "$2" == "" ]; then
    echo -e "\033[31;5m-------------------------------------------\033[0m"
    echo -e "\e[32m|-         Pentest Profissional         --|\e[0m"
    echo -e "\e[32m|-            Timeless Recon            --|\e[0m"
    echo -e "\033[31;5m-------------------------------------------\033[0m"
    echo -e "\e[32m|- ./webrecon.sh http://site.com.br php --|\e[0m"
    echo -e "\033[31;5m-------------------------------------------\033[0m"
else

    echo -e "\033[31;5m---------------------------------------------\033[0m"

    server=$(curl -s --head -H "User-Agent: PentestProfissional" $1 | grep "Server" | cut -d " " -f2)
    if [[ $server != "" ]]; then echo "WebServer Encontrado -> $server"; fi

    tech=$(curl -s --head -H "User-Agent: PentestProfissional" $1 | grep "X-Powered-By" | cut -d " " -f2)
    if [[ $tech != "" ]]; then echo "Tecnologias -> $tech"; fi

    echo -e "\033[31;5m---------------------------------------------\033[0m"
    echo -e "\e[32mBuscando Diretorios e Arquivos\e[0m"
    echo -e "\033[31;5m---------------------------------------------\033[0m"

    for dir in $(cat lista.txt); do
        status=$(curl -s -H "User-Agent: PentestProfissional" -o /dev/null -w "%{http_code}" $1/$dir/)
        if [ $status == "200" ]; then
            echo "Diretorio encontrado ---> $1/$dir/"
        fi
    done
    echo -e "\033[31;5m---------------------------------------------\033[0m"

    for files in $(cat lista.txt); do
        status=$(curl -s -H "User-Agent: PentestProfissional" -o /dev/null -w "%{http_code}" $1/$files)
        status2=$(curl -s -H "User-Agent: PentestProfissional" -o /dev/null -w "%{http_code}" $1/$files.$2)
        if [ $status == "200" ]; then
            echo "Arquivo encontrado         $1/$files"
        fi
        if [ $status2 == "200" ]; then
            echo "Arquivo $2 encontrado      $1/$files.$2"
        fi
    done
fi
