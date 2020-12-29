#!/bin/bash
#===============================================================================
# IDENTIFICATION DIVISION
#          FILE:  pg_tablesync.sh
#         USAGE:  ./pg_tablesync.sh
#   DESCRIPTION:  Sync tables between two PostgreSQL DB
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  TAKE CARE USING THIS IN PRODUCTION ENVIRONMENTS!
#          TODO:  ---
#        AUTHOR:  Ricardo Barbosa (RickkBarbosa), ricardo.barbosa@nubeliu.com
#       COMPANY:  NubeliU
#       VERSION:  1.0
#       CREATED:  14/06/2018 15:23:23 PM BRT
#      REVISION:  29/12/2020 16:47:30 PM BRT
#===============================================================================

DATE=$(date +%Y%m%d;)
BACKUPDIR="/home/user/.pg_tablesync"
TMPDIR=$(mktemp -d --suffix=pg_tablesync)

DATA_ORIGIN='<db-origin>:dbname:user:password'
DATA_DESTINY='<db-origin>:dbname:user:password'

TABLES="table1
table2
table3"

dump_origin(){
    IFS=': ' read -r -a DB_CREDENTIALS <<< "${DATA_ORIGIN}"

    #Getting credentials
    DB_HOST="${DB_CREDENTIALS[0]}"
    DB_NAME="${DB_CREDENTIALS[1]}"
    DB_USER="${DB_CREDENTIALS[2]}"
    DB_PASS="${DB_CREDENTIALS[3]}"


    #Dump tables from ORIGIN
    export PGPASSWORD="${DB_PASS}"

    #Extracting selected tables
    for TABLE in $TABLES; do
        echo "Downloading data on table ${TABLE} ..."
        pg_dump -x --column-inserts --inserts --disable-triggers --no-owner -c -C -h ${DB_HOST} -U ${DB_USER} --dbname=${DB_NAME} -t "${TABLE}" -Fp -f "${TMPDIR}/${TABLE}.sql"
        
        #Threatment on SQL dump file
        sed -i "s/${USER_ORIGIN}/${USER_DESTINY}/g" "${TMPDIR}/${TABLE}.sql"
        sed -i '/^CREATE\ INDEX/d' "${TMPDIR}/${TABLE}.sql"
        ex -sc '1i|SET session_replication_role = replica;' -cx "${TMPDIR}/${TABLE}.sql"
    done
}

backup(){
    #Now working on Destiny
    IFS=': ' read -r -a DB_CREDENTIALS <<< "${DATA_DESTINY}"

    #Getting credentials
    DB_HOST="${DB_CREDENTIALS[0]}"
    DB_NAME="${DB_CREDENTIALS[1]}"
    DB_USER="${DB_CREDENTIALS[2]}"
    DB_PASS="${DB_CREDENTIALS[3]}"

    #Restoring them on destiny
    export PGPASSWORD="${PWD_DESTINY}"

    #Perform a full backup
    pg_dump -h ${DB_HOST} -U ${DB_USER} -C ${DB_NAME} > "${BACKUPDIR}/${DB_NAME}_FULL_${DATE}.sql"
}

send_to_destiny(){
    #Now working on Destiny
    IFS=': ' read -r -a DB_CREDENTIALS <<< "${DATA_DESTINY}"

    #Getting credentials
    DB_HOST="${DB_CREDENTIALS[0]}"
    DB_NAME="${DB_CREDENTIALS[1]}"
    DB_USER="${DB_CREDENTIALS[2]}"
    DB_PASS="${DB_CREDENTIALS[3]}"

    #Restoring them on destiny
    export PGPASSWORD="${PWD_DESTINY}"

    psql -h ${DB_HOST} -U ${DB_USER} --dbname="${DB_NAME}" --command="SET session_replication_role = replica;"

    for TABLE in $TABLES; do
        psql -h ${DB_HOST} -U ${DB_USER} --dbname="${DB_NAME}" -c --command="DROP TABLE ${TABLE} CASCADE;"
        psql -v ON_ERROR_STOP=1 -h ${DB_HOST} -U ${DB_USER} --dbname="${DB_NAME}" --table="${TABLE}" < "${TMPDIR}/${TABLE}.sql"
    done

    #Re-Enabling right replication role
    psql -h ${DB_HOST} -U ${DB_USER} --dbname="${DB_NAME}" --command="SET session_replication_role = DEFAULT;"
}

main(){
    dump_origin
    backup
    send_to_destiny
}