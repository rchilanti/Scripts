#!/bin/bash

status=`/opt/glassfish5/glassfish/bin/asadmin list-domains | grep -c "domain1 running"`

if [ "$status" = 1 ]; then
   echo "Glassfish Rodando"
elif [ "$status" = 0 ]; then
   echo "Glassfish Parado"
fi
