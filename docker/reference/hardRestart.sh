echo "Stopping containers" &&\

docker stop $(docker ps -a -q) &&\

echo "Removing containers" &&\

docker rm $(docker ps -a -q) &&\

echo "Removing volumes" &&\

docker volume rm $(docker volume ls -q) &&\

echo "Rebuilding Image" &&\

docker build ../ --tag benchmark_main &&\

cd ../ &&\
docker-compose up
