#!/bin/bash
# Corriendo un Motor de postgresql
sudo rm -rf log
mkdir -p log
docker rm -f q202552-postgres
docker run --name q202552-postgres -v $PWD/log:/var/lib/postgresql/data -p 5432:5432  -v "$PWD/my-postgres.conf":/etc/postgresql/postgresql.conf -d postgres:9.3-alpine -c 'config_file=/etc/postgresql/postgresql.conf'
sleep 5
psql -h 127.0.0.1 -p 5432  -U postgres  -c "select 1"
sudo ls log/pg_log|nawk '{print "tail -n20 log/pg_log/"$0 }'|sudo bash
