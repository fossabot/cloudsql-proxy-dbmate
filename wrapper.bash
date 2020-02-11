#!/bin/bash
set -e

username=$(gcloud beta secrets versions access 1 --secret="mysql_username")
password=$(gcloud beta secrets versions access 1 --secret="mysql_password")
database=$(gcloud beta secrets versions access 1 --secret="mysql_database")
connection_name=$(gcloud beta secrets versions access 1 --secret="mysql_connection_name")

export DATABASE_URL="mysql://${username}:${password}@127.0.0.1:3306/${database}"

# Starting cloud procy in the background
cloud_sql_proxy -instances=${connection_name}=tcp:3306 &

sleep 1

echo "Running: dbmate $@"
dbmate wait && dbmate "$@"
