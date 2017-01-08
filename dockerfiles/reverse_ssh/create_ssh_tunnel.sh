#!/bin/bash 
command="sshpass -p '${SERVER_PASSWORD}' \
  ssh -o StrictHostKeyChecking=no \
  -N -R *:2222:localhost:22 \
  ${SERVER_USER}@${SERVER_HOST}"

createTunnel() { 
  /etc/init.d/ssh start
  eval ${command}

  if [[ $? -eq 0 ]]; then 
    echo Tunnel to jumpbox created successfully 
  else 
    echo An error occurred creating a tunnel to jumpbox. RC was $? 
  fi 
} 

for (( ; ; ))
do
  /bin/pidof ssh 
  if [[ $? -ne 0 ]]; then 
    echo Creating new tunnel connection
    createTunnel
  fi

  sleep 60
one
