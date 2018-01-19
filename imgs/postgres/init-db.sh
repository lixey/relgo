#!/bin/sh
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE USER $PROJECT_USER WITH password '$POSTGRES_PASSWORD';
    CREATE DATABASE $PROJECT_DB;
    GRANT ALL PRIVILEGES ON DATABASE $PROJECT_DB TO $PROJECT_USER;
EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" $PROJECT_DB <<-EOSQL
    CREATE EXTENSION adminpack
      SCHEMA pg_catalog
        VERSION "1.0";

    CREATE EXTENSION pgcrypto
      SCHEMA public
        VERSION "1.3";
EOSQL
