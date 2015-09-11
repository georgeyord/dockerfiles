# Reverse SSH tunnel

**Reverse SSH is a technique that can be used to access systems (that are behind a firewall) from the outside world.**

> Extension of tifayuki/reverse-ssh-tunnel container, all thanks go to him.

The connections  we want to achieve is described here:
![SSH diagram](https://lh4.googleusercontent.com/aptJZFGs_mHtO7lrPWe4_WYwx8GQTx3Q8c4G8uoP223UGNq7PSyg4wntbRTykWs_1yOhlQo7sc260E0=w1892-h816-rw)
[SSH diagram](https://lh4.googleusercontent.com/aptJZFGs_mHtO7lrPWe4_WYwx8GQTx3Q8c4G8uoP223UGNq7PSyg4wntbRTykWs_1yOhlQo7sc260E0=w1892-h816-rw)

## Usage (using `docker run`)

> Go to `Usage using docker compose` to run the necessary containers easier

At the final state you should have this container running 3 times, one on each machine (public,destination,client).

### On public host, run:
```
[public]$ docker run -d \
    -e ROOT_PASS=<your_password> \
    -p <your_sshd_port>:22 \
    -p <forwarding_port>:1080 \
    tifayuki/reverse-ssh-tunnel
```
Parameters:
```
  <your_password> is the password used for NATed host to connect the public host
  <your_sshd port> is the port for NATed host to connect to
  <forwarding port> is the port allows others to access
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
[destination]$ docker run -d \
    -e PUBLIC_HOST_ADDR=<public_host_address> \
    -e PUBLIC_HOST_PORT=<public_host_port> \
    -e ROOT_PASS=<your_password> \
    -e PROXY_PORT=<NATed_service_port> \
    --net=host \
    tifayuki/reverse-ssh-tunnel
```
Parameters:
```
  <public_host_address> is the ip address or domain of your public host
  <public_host_port> is the same as <your sshd port> set on the public host
  <your_passorwd> is the same as <your passorwd> set on the public host
  <NATed_service_port> is the port that your service in NATed host listens to
```

### On client, connect to destination
```
[client]$ ssh -t -p <public_host_port> root@<public_host_address> "ssh <destination_user>@localhost -p 1080"
```

Example
-------

Suppose you have a service running in the NATed host, listens to port `22`, and there is also another public host with the ip address of `111.112.113.114`. You want users to access `111.112.113.114:1080` to communicate with your NATed service, you could the do the following:

On public host(`111.112.113.114`):
```
  docker run -d -e ROOT_PASS=mypass -p 2222:22 -p 1080:1080 tifayuki/reverse-ssh-tunnel
```
On NATed host:
```
  docker run -d -e PUBLIC_HOST_ADDR=111.112.113.114 -e PUBLIC_HOST_PORT=2222 -e ROOT_PASS=mypass -e PROXY_PORT=22 --net=host tifayuki/reverse-ssh-tunnel
```
On client:
```
  ssh -p 1080 user@111.112.113.114
```
Or using public host as intermediate:
```
  ssh -t -p 2222 root@111.112.113.114 "ssh user@localhost -p 1080"
```


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
