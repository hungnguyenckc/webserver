#!/bin/bash
echo "Restoring database..."

name="beer_fridge"
path="./../www/beer-fridge/redgit/sql/"

docker exec mysql mysql -uroot -proot -e "DROP DATABASE ${name}"
docker exec mysql mysql -uroot -proot -e "CREATE DATABASE ${name}"

#Linux
#docker exec -i mysql mysql -uroot -proot --default-character-set=utf8  ${name} < ${path}/ ${name}_structure.sql
#docker exec mysql mysql -uroot -proot --default-character-set=utf8  ${name} < ${path}/ ${name}_data.sql

#Windows
cat ${path}/beer_fridge_structure.sql | docker exec -i mysql mysql -uroot -proot --default-character-set=utf8 $name
cat ${path}/beer_fridge_data.sql | docker exec -i mysql mysql -uroot -proot --default-character-set=utf8 $name

echo "Done."
