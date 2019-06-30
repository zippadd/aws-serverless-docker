./localBuild.sh
container=`docker create ubuntu:16.04`
docker start $container
echo $container
docker ps --all --filter id=$container --filter status=running --no-trunc --format "{{.ID}} {{.Status}}"
docker exec $container sh -c "command -v bash"