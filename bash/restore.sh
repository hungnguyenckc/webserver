#!/bin/bash
echo "Restoring database..."

dbname=$1
path=$2

docker exec mysql mysql -uroot -proot -e "DROP DATABASE ${dbname}"
docker exec mysql mysql -uroot -proot -e "CREATE DATABASE ${dbname}"

docker exec -i mysql mysql -uroot -proot -e "CREATE USER '${dbname}'@'%' IDENTIFIED BY '${dbname}'"
docker exec -i mysql mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON ${dbname}.* TO '${dbname}'@'%'"

docker exec -i mysql mysql -uroot -proot --default-character-set=utf8 ${dbname} < ${path}_structure.sql
docker exec -i mysql mysql -uroot -proot --default-character-set=utf8 ${dbname} < ${path}_data.sql

echo "Done."
