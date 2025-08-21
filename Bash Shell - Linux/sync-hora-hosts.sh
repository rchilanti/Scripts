#!/bin/bash

fil="$(cat /root/Renan/hosts.txt)"

for i in ${fil};do

  
  	echo "--------------------------------------Loja ${i}-----------------------------------------"
 	ping -c 2 -n -q ${i} >> /dev/null && {

	echo
	echo "-------------------------------------Altera SYNC_HWCLOCK--------------------------------"
	sshpass -p root123 ssh -o StrictHostKeyChecking=no root@${i} 'sed -i '/SYNC_HWCLOCK/s/no/yes/' /etc/sysconfig/ntpd'
	echo "-------------------------------------Insere step-stikers--------------------------------"
	sshpass -p root123 ssh -o StrictHostKeyChecking=no root@${i} 'echo "192.168.10.10" >> /etc/ntp/step-tickers'
	echo
	echo "----------------------------------------------------------------------------------------"

}
done
