#!/bin/bash
set -e  # Exit on error

initdb -D /var/lib/postgresql/data
pg_ctl -D /var/lib/postgresql/data start
pg_isready

psql -h localhost -p 5432 -U postgres << EOF
CREATE DATABASE olddb;
EOF

psql -h localhost -p 5432 -U postgres olddb << EOF
CREATE TABLE test ( val INT PRIMARY KEY , name varchar(50));
INSERT INTO test VALUES(0 , 'Floppa');
INSERT INTO test VALUES(1, 'Halompa');

CREATE USER leafy WITH PASSWORD 'AsiiItBoss';

\q
EOF

#pg_dump only dumps the db contents , while pg_dumpall dumps the roles , permissions etc. ALL
pg_dumpall -U postgres -d olddb > /tmp/olddb.sql

exec "$@"

