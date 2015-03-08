#!/usr/bin/env bash
chown -R postgres:postgres /var/lib/postgresql/9.3
chown -R postgres:postgres /etc/postgresql/9.3/main
chmod -R 700 /etc/postgresql/9.3/main

exec /sbin/setuser postgres  /usr/lib/postgresql/9.3/bin/postgres -D /var/lib/postgresql/9.3/main -c config_file=/etc/postgresql/9.3/main/postgresql.conf >> /var/log/postgresql/postgresql-9.3-main.log 2>&1

