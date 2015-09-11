# Reverse SSH tunnel

> Reverse SSH is a technique that can be used to access systems (that are behind a firewall) from the outside world.

The connections  we want to achieve is described here:
![SSH diagram](https://lh4.googleusercontent.com/aptJZFGs_mHtO7lrPWe4_WYwx8GQTx3Q8c4G8uoP223UGNq7PSyg4wntbRTykWs_1yOhlQo7sc260E0=w1892-h816-rw)

## Usage (using `docker-compose`)

### On public host, aka middleman

```
[public]$ docker-compose up reversesshpublic
```

### On NATed host, aka destination
Configure ssh server, add the GatewayPorts option:
```
GatewayPorts yes
```
to `/etc/ssh/sshd_config` and restart ssh service

```
[destination]$ sudo servie ssh restart
```

Connect to middleman:
```
[destination]$ docker-compose up reversesshdestination
```
leave this process running!

### On client, connect to destination
```
[client]$ docker-compose run reversesshclient
```
