docker-compose kill; docker-compose rm -f ; docker-compose up -d; docker-compose logs

docker-compose run registrator bash -c "go get && go build -ldflags \"-X main.Version dev\" -o /bin/registrator && /bin/registrator consul://consul_server:8500"

