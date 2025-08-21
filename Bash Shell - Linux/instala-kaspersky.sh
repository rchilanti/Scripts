#!/bin/bash

#ALTERAR PARA O MICRO QUE VAI INSTALAR
micro="srvprd001"


for i in ${micro};do

aplica_config_agent(){
        /usr/bin/expect << EOF
        set timeout -1
        spawn sshpass -p root123 ssh -o StrictHostKeyChecking=no root@${i}
        expect "#"
        send "/opt/kaspersky/klnagent64/lib/bin/setup/postinstall.pl\r"
        send "q\r"
	expect "]:"
	send "y\r"
        expect "IP-address"
        send "10.0.0.220\r"
        expect "]:"
	send "\r"
	expect "]:"
        send "\r"
        expect "]:"
        send "\r"
        expect "]:"
        send "\r"
        expect "#"
	send "exit\r"
	expect eof
EOF
}

aplica_config_agent32(){
        /usr/bin/expect << EOF
        set timeout -1
        spawn sshpass -p root123 ssh -o StrictHostKeyChecking=no root@${i}
        expect "#"
        send "/opt/kaspersky/klnagent/lib/bin/setup/postinstall.pl\r"
        send "q\r"
	expect "]:"
	send "y\r"
        expect "IP-address"
        send "10.0.0.220\r"
        expect "]:"
	send "\r"
	expect "]:"
        send "\r"
        expect "]:"
        send "\r"
        expect "]:"
        send "\r"
        expect "#"
	send "exit\r"
	expect eof
EOF
}



echo Micro "${i}"
  
ping -c 2 -n -q ${i} >> /dev/null && {

cat="$(ssh root@${i} 'getconf LONG_BIT')"

#ALTERAR PARA O SERVIDOR DA LOJA
server="srvprd001"

if [ "$cat" = 64 ]; then

echo "SO 64bits"


sshpass -p root123 ssh -o StrictHostKeyChecking=no root@${i} "rpm -ivh /mnt/AV/kesl-11.2.0-4528.x86_64.rpm"
scp -o StrictHostKeyChecking=no /root/Cesar/KSP/configs/autoinstall.ini ${i}:/opt/kaspersky/kesl/doc/
sshpass -p root123 ssh -o StrictHostKeyChecking=no root@${i} "/opt/kaspersky/kesl/bin/kesl-setup.pl --autoinstall=/opt/kaspersky/kesl/doc/autoinstall.ini"
sshpass -p root123 ssh -o StrictHostKeyChecking=no root@${i} "rpm -ivh /mnt/AV/klnagent64-12.0.0-60.x86_64.rpm"
aplica_config_agent ${i}

elif [ "$cat" = 32 ]; then

echo "SO 32bits"


sshpass -p root123 ssh -o StrictHostKeyChecking=no root@${i} "rpm -ivh /mnt/AV/kesl-11.2.0-4528.i386.rpm"
scp -o StrictHostKeyChecking=no /root/Cesar/KSP/configs/autoinstall.ini ${i}:/opt/kaspersky/kesl/doc/
sshpass -p root123 ssh -o StrictHostKeyChecking=no root@${i} "/opt/kaspersky/kesl/bin/kesl-setup.pl --autoinstall=/opt/kaspersky/kesl/doc/autoinstall.ini"
sshpass -p root123 ssh -o StrictHostKeyChecking=no root@${i} "rpm -e klnagent-12.0.1-60.i386"
sshpass -p root123 ssh -o StrictHostKeyChecking=no root@${i} "rpm -ivh /mnt/AV/klnagent-12.0.1-60.i386.rpm"
aplica_config_agent32 ${i}
fi
}

done
