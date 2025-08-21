#!/bin/bash

status=`systemctl status httpd | grep -c running`

if [ "$status" = 1 ]; then
   echo "Apache Rodando"
elif [ "$status" = 0 ]; then
   echo "Apache Parado"
fi
