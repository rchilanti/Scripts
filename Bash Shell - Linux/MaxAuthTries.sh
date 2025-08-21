#!/bin/bash

fil="$(cat /root/Renan/micros.txt)"


for i in ${fil};do
  echo Micro "${i}"
  ping -c 2 -n -q ${i} >> /dev/null && {

sshpass -p root123 ssh -o StrictHostKeyChecking=no root@${i} '

cat=`cat /etc/issue |grep -c openSUSE`

if [ "$cat" = 1 ]; then
      echo "MaxAuthTries 3" >> /etc/ssh/sshd_config
      systemctl restart sshd.service
      echo "Adicionado MaxAuthTries"
elif [ "$cat" != 1 ]; then
	echo "OUTRO SO"
fi
'
}&

	while [ $(jobs -p |wc -l ) -ge 30 ];do
		sleep 5
	done
	
done
