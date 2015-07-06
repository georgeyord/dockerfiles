# On public host, aka middleman

```
[middleman]$ docker-compose up
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
[destination]$ ssh -R 2200:localhost:22 middleman-user@middleman-public-ip
```
leave this process running!

# Connect from client to destination
```
[client]$ ssh middleman-user@middleman-public-ip

[middleman]$ ssh destination-user@localhost -p2200

```