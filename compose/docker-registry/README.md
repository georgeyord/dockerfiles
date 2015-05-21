# Start the private Docker registry

1. Run `./compose.sh up -d`
1. Run `./compose.sh ps` to check that 2 containers are running
1. Check that the WebUi is accessible on port 5080.
1. Docker registry is accessible on port 5000.
 
# Publish new image to your private Docker registry

1. Find the desired image id (use: `docker images`)
1. Tag your image `docker tag [image-id] [registry-host]:5000/[image-name]`
1. Publish your image `docker push [registry-host]:5000/[image-name]`
 
# Search for image on your private Docker registry

```
docker search [registry-host]:5000/[search-term]
```

# Pull image from your private Docker registry

```
docker pull [registry-host]:5000/[image-name]
```