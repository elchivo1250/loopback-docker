#!/bin/bash

if [[ $1 == ""]]; then
    echo "You must enter a mysql user name"
    exit 1
fi

if [[ $2 == ""]]; then
    echo "You must enter a mysql password"
    exit 1
fi

if [[ $3 == ""]]; then
    echo "You must enter a mysql root user password"
    exit 1
fi

echo config/secrets.env config/secrets.test.env | xargs -n 1 cp config/secrets.dist.env

 find ./config -iname secrets*.env -not -iname secrets.dist.env | xargs sed -i 's/MYSQL_USER=/MYSQL_USER=$1/'
 find ./config -iname secrets*.env -not -iname secrets.dist.env | xargs sed -i 's/MYSQL_PASSWORD=/MYSQL_PASSWORD=$2/'
 find ./config -iname secrets*.env -not -iname secrets.dist.env | xargs sed -i 's/MYSQL_ROOT_PASSWORD=/MYSQL_ROOT_PASSWORD=$3/'

docker-compose up -d db
docker-compose -f services.yml run --rm npm install

 docker exec -i loopback-docker_db_1 sh -c "mysql -u root -p -e \"ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '$3'\""
 docker exec -i loopback-docker_db_1 sh -c "mysql -u root -p -e \"ALTER USER '$1'@'%' IDENTIFIED WITH mysql_native_password BY '$2'\""

docker-compose -f services.yml run --rm updateSchema
docker-compose up -d web
