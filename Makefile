TXT_COLOR_RED=\033[0;31m
TXT_COLOR_GREEN=\033[0;32m
TXT_COLOR_RESET=\033[0m
TXT_NEWLINE=\n
TXT_DELIMETER="==="

# Remove any not running containers
remove_containers_not_running:
	docker rm `docker ps -aq`

# Remove any running/not running containers
remove_containers_even_if_running:
	docker rm -f `docker ps -aq`

# Remove any incomplete images
remove_dangling_images :
	docker rmi -f `docker images -q --filter "dangling=true"`

.PHONY: remove_containers_not_running remove_containers_even_if_running remove_images_incomplete
