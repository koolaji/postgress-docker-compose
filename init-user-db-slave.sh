#!/bin/bash
set -e
set -x
#echo "host replication all 0.0.0.0/0 md5" >> "$PGDATA/pg_hba.conf"
#su - postgres /usr/bin/pg_ctl reload
#psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
rm -fr /var/lib/postgresql/data/*
pg_basebackup -h master -U repl_user --checkpoint=fast -D /var/lib/postgresql/data -R --slot=test -C --port=5432 
sed -i  's/host=localhost/host=master/g' /var/lib/postgresql/data/postgresql.auto.conf
psql -v ON_ERROR_STOP=1   <<-EOSQL
CREATE USER repl_user REPLICATION LOGIN CONNECTION LIMIT 100 ENCRYPTED PASSWORD '123456';
EOSQL
