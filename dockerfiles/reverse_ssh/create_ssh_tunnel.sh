#!/bin/bash 
command="sshpass -p '${SERVER_PASSWORD}' \
  ssh -o StrictHostKeyChecking=no \
  -N -R 2222:localhost:22 \
  ${SERVER_USER}@${SERVER_HOST}" 

ssh_command="/usr/sbin/sshd -D"

# Run a command in the background.
runBackground() {
  echo "Running ${ssh_command} in background"
  eval "$@" &>/dev/null &disown;
}

createTunnel() { 
  eval "${command}"

  if [[ $? -eq 0 ]]; then 
    echo Tunnel to jumpbox created successfully 
  else 
    echo An error occurred creating a tunnel to jumpbox. RC was $? 
  fi 
} 

runBackground "${ssh_command}"

for (( ; ; ))
do
  /bin/pidof ssh 
  if [[ $? -ne 0 ]]; then 
    echo Creating new tunnel connection
    createTunnel
  fi

  sleep 60
done
