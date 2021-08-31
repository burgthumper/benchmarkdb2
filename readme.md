# Timescale, MySQL, Postgres Docker Image Documentation
Miles Watson, 2-25-20

# Updated steps (As of March 7th)
Setup the following directory structure:
/mnt/wsl/docker-desktop/volumes
								/mysql
									/data
									/mysql-files
								/postgres
									/data

## Building
To build the image, run `docker build . --tag benchmark_main` in the docker root directory (new-docker-build)

MySQL will be installed from build, Postgres and Timescale need to be installed manually. The steps to do this are as follows:

* Open container's terminal
* Launch bash shell with `/bin/bash`
* Install Postgres and Timescale https://docs.timescale.com/latest/getting-started/installation/debian/installation-apt-debian

Use following script
```
apt-get update &&\
echo "deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list &&\
apt-get install wget -y &&\
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - &&\
apt-get update &&\

sh -c "echo 'deb https://packagecloud.io/timescale/timescaledb/debian/ buster main' > /etc/apt/sources.list.d/timescaledb.list" &&\
wget --quiet -O - https://packagecloud.io/timescale/timescaledb/gpgkey | apt-key add - &&\
apt-get update &&\
apt-get install timescaledb-2-postgresql-12 -y &&\
timescaledb-tune --quiet --yes &&\
apt-get install vim -y &&\

echo 'host      all		    all  		0.0.0.0/0 		trust
' >> /etc/postgresql/12/main/pg_hba.conf &&\
echo 'host  	all  		all    		::/0    		trust
' >> /etc/postgresql/12/main/pg_hba.conf &&\

service postgresql restart &&\
chsh -s /bin/bash
```
* `/etc/postgresql/12/main/pg_hba.conf`

In: , in the host and local section, change both auth values to `trust`
change `listen_address = 'localhost'` to `listen_address = *` in `/etc/postgresql/12/main/postgresql.conf`

https://bigbinary.com/blog/configure-postgresql-to-allow-remote-connection
Create superuser:
CREATE ROLE edward WITH LOGIN SUPERUSER PASSWORD 'edward'
## Running
Run with docker-compose:
`docker-compose up -d`

Always quit with ctrl+c, ctrl+z will leave hanging containers

## Managing Running Containers
List running containers:  `docker ps`
## wsl
launch from powershell: `ubuntu2004`
## Connecting to Containers SSH
`docker exec -it` (or open from the Docker GUI client)
To get BASH shell: `/bin/bash`

## Connecting with Windows
Use docker commands with the following argument:
`-H tcp://0.0.0.0:2375`

# Database Administration
Login to postgres console: `psql -U postgres`

# Volumes
Useful explanation: https://www.youtube.com/watch?v=VOK06Q4QqvE
Regarding Dockerfile volume command: "Every time you create a container from this image, docker will force that directory to be a volume. If you do not provide a volume in your run command, or compose file, the only option for docker is to create an anonymous volume. This is a local named volume with a long unique id for the name and no other indication for why it was created or what data it contains (anonymous volumes are were data goes to get lost). If you override the volume, pointing to a named or host volume, your data will go there instead."
https://nickjanetakis.com/blog/setting-up-docker-for-windows-and-wsl-to-work-flawlessly#ensure-volume-mounts-work
