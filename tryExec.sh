./localBuild.sh
container=`docker create aws-serverless-node-docker:latest`
docker start $container
echo $container
docker ps --all --filter id=$container --filter status=running --no-trunc --format "{{.ID}} {{.Status}}"
docker exec $container sh -c "command -v bash"