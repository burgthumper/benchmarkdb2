<<<<<<< HEAD
After reboot of machine 
  the container needs restarted via Windows Terminal. Go to project docker folder. Then,
    PS C:\projects\benchmarkdb2\docker> docker-compose up -d
      alternative ~ PS C:\projects\benchmarkdb2\docker> docker-compose up
  get container id
    PS C:\projects\benchmarkdb2\docker> docker ps
  the service needs started, go into
    PS C:\projects\benchmarkdb2\docker> docker exec -it 5fa1ee0ab5bb bash
  then start service
    root@5fa1ee0ab5bb:/# service postgresql start
    root@5fa1ee0ab5bb:/# exit

NOTE: 
To get the services to work together the Dockerfile script must start a supervisor. Under that supervisor multiple services like mysql and postgresql and run. Then, when docker-compose up -d is run, the service postgresql start does not need to be executed.

To bring down the docker container from Windows Terminal
  PS C:\projects\benchmarkdb2\docker> docker-compose down
  PS C:\projects\benchmarkdb2\docker> docker system prune -a
  
To start the container and services from Windows Terminal
   PS C:\projects\benchmarkdb2\docker> docker build . --tag benchmark_main
   PS C:\projects\benchmarkdb2\docker> docker-compose up -d
   get container id
     PS C:\projects\benchmarkdb2\docker> docker ps
   the service needs started, go into
     PS C:\projects\benchmarkdb2\docker> docker exec -it 5fa1ee0ab5bb bash
   then start service
     root@5fa1ee0ab5bb:/# service postgresql start
     root@f0f33b66a2cb:/# su - postgres
     postgres@f0f33b66a2cb:~$ psql
     postgres=# CREATE ROLE edward WITH LOGIN SUPERUSER PASSWORD 'edward';
     postgres=# \q
     root@5fa1ee0ab5bb:/# exit
=======
After reboot of machine 
  the container needs restarted via Windows Terminal. Go to project docker folder. Then,
    PS C:\projects\benchmarkdb2\docker> docker-compose up -d
      alternative ~ PS C:\projects\benchmarkdb2\docker> docker-compose up
  get container id
    PS C:\projects\benchmarkdb2\docker> docker ps
  the service needs started, go into
    PS C:\projects\benchmarkdb2\docker> docker exec -it 5fa1ee0ab5bb bash
  then start service
    root@5fa1ee0ab5bb:/# service postgresql start
    root@5fa1ee0ab5bb:/# exit

NOTE: 
To get the services to work together the Dockerfile script must start a supervisor. Under that supervisor multiple services like mysql and postgresql and run. Then, when docker-compose up -d is run, the service postgresql start does not need to be executed.

To bring down the docker container from Windows Terminal
  PS C:\projects\benchmarkdb2\docker> docker-compose down
  PS C:\projects\benchmarkdb2\docker> docker volume rm $(docker volume ls -q)
  PS C:\projects\benchmarkdb2\docker> docker system prune -a
  
To start the container and services from Windows Terminal
   PS C:\projects\benchmarkdb2\docker> docker build . --tag benchmark_main
   PS C:\projects\benchmarkdb2\docker> docker-compose up -d
   get container id
     PS C:\projects\benchmarkdb2\docker> docker ps
   the service needs started, go into
     PS C:\projects\benchmarkdb2\docker> docker exec -it 5fa1ee0ab5bb bash
   then start service
     root@5fa1ee0ab5bb:/# service postgresql start
     root@f0f33b66a2cb:/# su - postgres
     postgres@f0f33b66a2cb:~$ psql
     postgres=# CREATE ROLE edward WITH LOGIN SUPERUSER PASSWORD 'edward';
     postgres=# \q
     root@5fa1ee0ab5bb:/# exit
>>>>>>> c774a59b53397ce4039f0d6130a0cd1a89852beb
