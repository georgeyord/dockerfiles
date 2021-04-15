# Web terminal with sane tooling

## Description

A terminal based on Debian OS that runs in your browser.

## Features

* Terminal (GoTTY with zsh and amenities)
* ssh client
* Multi-window (Byobu)
* Net tools:
  * nc
  * curl
  * wget
  * docker
  * docker-compose
* Optional access to host's docker service
* Run as `root` (default scenario) or custom user
* Custom user can have:
  * Custom User ID
  * Custom Group ID
  * Custom username
  * Custom home folder (default `/myhome`)
  * Sudo privileges without password

## Tools

* [gotty](https://github.com/yudai/gotty)
* [byobu](https://www.byobu.org/)
* [zsh](https://www.zsh.org/)
* [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)
* [spaceship](https://github.com/denysdovhan/spaceship-prompt)

## Try it

### Run as `root`:

Using `docker`:

```
docker run -d \
        -p 8080:8080 \
        -v "/var/run/docker.sock:/var/run/docker.sock" \
        -d terminal_terminal
```

Using `docker-compose`:

```
docker-compose up
```

### Run as the user running the docker command:

Using `docker`:

```
mkdir -p ./myhome
docker run -d \
        -e USER_NAME="myuser" \
        -e USER_ID="$(id -u)" \
        -e GROUP_ID="$(id -g)" \
        -v "${PWD}/myhome:/myhome" \
        -v "/var/run/docker.sock:/var/run/docker.sock" \
        -p 8080:8080 \
        -d terminal_terminal
```

## Additional tips

Byobu:

- Since everything run in byobu you should get familiar with its capabilities.
- You can disable byobu by overrding the `command` docker option.
- If you get the "Configure Byobu's ctrl-a behavior..." screen, pick the second option (2).

Running with custom user:

- When you get the "This is the Z Shell configuration function for new users,
zsh-newuser-install." screen, pick the Exit option (0). We will setup ZSH in the next step.
- The new user will not have `oh-my-zsh` setup yet, run `/setup-zsh.sh` to set it up. Then just run `zsh` to get the new fully featured shell.
