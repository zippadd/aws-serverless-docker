./build.sh
container=`docker create aws-serverless-node-docker:latest`
docker start $container > /dev/null
docker ps --all --filter id=$container --filter status=running --no-trunc --format "{{.ID}} {{.Status}}"
docker exec -it $container bash