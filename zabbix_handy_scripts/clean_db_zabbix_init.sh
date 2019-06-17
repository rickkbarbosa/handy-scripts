#!/bin/bash
DB_HOST=""
DB_NAME=""

mysql -h ${DB_HOST} $DB_NAME < clean_db_zabbix.sql
for TABLE in $(mysql -h ${DB_HOST} -Ne "SHOW TABLES" ${DB_NAME};); do
	mysql -h ${DB_HOST} ${DB_NAME} -Ne "OPTIMIZE TABLE ${TABLE}"
done
mysqldump -h ${DB_HOST} ${DB_NAME} > zabbix.sql



