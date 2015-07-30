# Docker image to run scripts repetitively 

## What is Heartbeat

Heartbeat is a very small bash script to run scripts every X seconds

## Usage
 
To run the container:

```
docker run -it --rm -v [PATH_TO_SCRIPTS_DIRECTORY]:/scripts -e HEARTBEAT_CYCLE=[HEARTBEAT_CYCLE] georgeyord/curl-heartbeat
```

Where:

* `API PATH_TO_SCRIPTS_DIRECTORY` is the directory containing scripts files
* `HEARTBEAT_CYCLE` is the time to wait until the next run in seconds

Example 1 - Run `date +"%T"` every 10 seconds:
```
docker run -it --rm -v `pwd`/scripts:/scripts -e HEARTBEAT_CYCLE=10 georgeyord/curl-heartbeat
```
having that a file exists in ./scripts/foo with the following content:
```
date +"%T"
```

Example 2 - Run `date +"%T"` and`curl -X GET 'http://target'` every 15 seconds to `foo_api` container:
```
docker run -it --rm -v `pwd`/scripts:/scripts -e HEARTBEAT_CYCLE=15 -link foo_api:target georgeyord/curl-heartbeat
```
having that 2 file exists.

First ./scripts/foo with the following content:
```
date +"%T"
```
Secondly ./scripts/bar with the following content:
```
curl -X GET 'http://target'
```