# On public host, aka middleman

```
[public]$ docker-compose up reversesshpublic
```

# On NATed host, aka destination
## Configure ssh server
Add the GatewayPorts option:
```
GatewayPorts yes
```
to `/etc/ssh/sshd_config` and restart ssh service

```
[destination]$ sudo servie ssh restart
```

## Connect to middleman
```
[destination]$ docker-compose up reversesshdestination
```
leave this process running!

# Connect from client to destination
```
[client]$ docker-compose run reversesshclient
```
