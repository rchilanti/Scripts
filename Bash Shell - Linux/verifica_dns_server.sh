#!/bin/bash

fil="$(cat /root/Renan/dns/servidores.txt)"

for i in ${fil};do
  echo "-------------------------------------------------------------------"
  echo "Loja ${i}"
  ping -c 2 -n -q ${i} >> /dev/null && {

echo "-----------------------------etc/resolv.conf---------------------------------"
sshpass -p root123 ssh -o StrictHostKeyChecking=no root@${i} 'cat /etc/resolv.conf'

echo "-----------------------------squid/resolv.conf---------------------------------"
sshpass -p root123 ssh -o StrictHostKeyChecking=no root@${i} "cat /var/squid/etc/resolv.conf"

echo "-----------------------------squid.conf---------------------------------"
sshpass -p root123 ssh -o StrictHostKeyChecking=no root@${i} "cat /var/squid/etc/squid.conf | grep dns_nameservers"

}
done
