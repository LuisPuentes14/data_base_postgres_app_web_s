@echo off
set PGPASSWORD=12345

REM TABLAS
psql -U postgres -d test -f ./PostgreSQL/tables/tables.sql

SET PGCLIENTENCODING=utf8
REM DATA
psql -U postgres -d test -f ./PostgreSQL/data/profiles.sql
psql -U postgres -d test -f ./PostgreSQL/data/user_states.sql

REM CONSTRAIN
REM TRIGGERS
psql -U postgres -d test -f ./PostgreSQL/triggers/trg_after_insert_profiles.sql
psql -U postgres -d test -f ./PostgreSQL/triggers/trg_after_insert_web_modules.sql




