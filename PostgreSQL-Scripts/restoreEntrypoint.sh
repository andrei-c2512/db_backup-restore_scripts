#!/bin/bash
set -e  # Exit on error

initdb -D /var/lib/postgresql/data
pg_ctl -D /var/lib/postgresql/data start
pg_isready

psql -h localhost -p 5432 -U postgres << EOF
CREATE DATABASE newdb;
EOF

psql -U postgres -d postgres -f /tmp/newdb.sql

exec "$@"

