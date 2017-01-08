# Reverse SSH Tunnel  
This container implements a reverse SSH proxy inside a container, on startup the SSH deamon is started and a ssh tunnel is created to a remote server.  The docker container creates a tunnel to your remote server mapping port 22 on the container to port 2222 on the remote server.

## Running
To run with docker execute the following command:  

```
docker run --rm -e "SERVER_USER=[remote server ssh username]" -e "SERVER_PASSWORD=[remote server ssh password]" -e "SERVER_HOST=[remote server]" nicholasjackson/reverse_ssh_tunnel
```

## Remote login
1. Login to your remote ssh server specified in the environment variables  
2. Start a tunnel session to your docker container `ssh -p 2222 sshuser@localhost` and use the password *sshpass* when prompted.
