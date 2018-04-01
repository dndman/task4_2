#!/bin/bash
apt update
apt-get -y install ntp

#задаем переменную
ntpconfig="/etc/ntp.conf"

#бекапим конфиг
cp /etc/ntp.conf /etc/ntp.bak

#убираем из конфига ntp настройки по умолчанию
sed -i '/^pool /d' ${ntpconfig}
sed -i '/^server /d' ${ntpconfig}

#пишем актуальные настройки. это кривой и топорный метод, но я пока не вникся, как заставить sed.
#записывать нужные мне данные под той строкой, что мне нужна
#sed -i 19i\ 'pool ua.pool.ntp.org ' /etc/ntp.conf
echo "pool ua.pool.ntp.org" >>/etc/ntp.conf
#сохраняем правленый конфиг
cp /etc/ntp.conf /etc/ntp.conf.bak
#рестартим сервер
service ntp restart
echo "* * * * * root `pwd`/ntp_verify.sh" >> /etc/crontab
#далее нам нужно заставить крон крутить скрипт , который будет проверять, запущен ли ntp, и если нет, то запускать его.
#проверять конфиг ntp.conf на предмет изменений, и если они были, возвращать к правильному состоянию.
#пока не знаю, как это сделать.
