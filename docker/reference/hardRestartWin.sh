echo "Stopping containers" &&\

docker -H tcp://0.0.0.0:2375 stop $(docker -H tcp://0.0.0.0:2375 ps -a -q) &&\

echo "Removing containers" &&\

docker -H tcp://0.0.0.0:2375 rm $(docker -H tcp://0.0.0.0:2375 ps -a -q) &&\

echo "Removing volumes" &&\

docker -H tcp://0.0.0.0:2375 volume rm $(docker -H tcp://0.0.0.0:2375 volume ls -q) &&\

#echo "Rebuilding Image" &&\

# docker -H tcp://0.0.0.0:2375 build ../ --tag benchmark_main &&\

#cd ../ &&\
#docker -H tcp://0.0.0.0:2375-compose up
