#!/bin/bash
echo "Restoring database..."

dbname=$1
sitename=$2
path=$3

docker exec mysql mysql -uroot -proot -e "DROP DATABASE ${dbname}"
docker exec mysql mysql -uroot -proot -e "CREATE DATABASE ${dbname}"

docker exec -i mysql mysql -uroot -proot --default-character-set=utf8 ${dbname} < ${path}/${sitename}_structure.sql
docker exec -i mysql mysql -uroot -proot --default-character-set=utf8 ${dbname} < ${path}/${sitename}_data.sql

echo "Done."
