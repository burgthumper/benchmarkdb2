apt-get update &&\
echo "deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list &&\
apt-get install wget -y &&\
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - &&\
apt-get update &&\

sh -c "echo 'deb https://packagecloud.io/timescale/timescaledb/debian/ buster main' > /etc/apt/sources.list.d/timescaledb.list" &&\
wget --quiet -O - https://packagecloud.io/timescale/timescaledb/gpgkey | apt-key add - &&\
apt-get update &&\
apt-get install timescaledb-2-postgresql-12 -y
