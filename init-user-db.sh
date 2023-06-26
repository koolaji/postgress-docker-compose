#!/bin/bash
set -e
set -x
#echo "host replication all 0.0.0.0/0 md5" >> "$PGDATA/pg_hba.conf"
cat /var/lib/postgresql/pg_hba.conf > "/var/lib/postgresql/data/pg_hba.conf"
cat /var/lib/postgresql/postgresql.conf > "/var/lib/postgresql/data/postgresql.conf"
#su - postgres /usr/bin/pg_ctl reload
#psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
psql -v ON_ERROR_STOP=1   <<-EOSQL
CREATE USER repl_user REPLICATION LOGIN CONNECTION LIMIT 100 ENCRYPTED PASSWORD '123456';
EOSQL
