#!/bin/bash

if [ $1 = "" ]; then
    echo "You must enter a mysql user name"
    exit 1
fi

if [ $2 = "" ]; then
    echo "You must enter a mysql password"
    exit 1
fi

if [ $3 = "" ]; then
    echo "You must enter a mysql root user password"
    exit 1
fi

# Create secrets environment files
echo config/secrets.env config/secrets.test.env | xargs -n 1 cp config/secrets.dist.env

# Update keys in secrets environment to reflect expected values
 find ./config -iname secrets*.env -not -iname secrets.dist.env | xargs sed -i "s/MYSQL_USER=/MYSQL_USER=${1}/"
 find ./config -iname secrets*.env -not -iname secrets.dist.env | xargs sed -i "s/MYSQL_PASSWORD=/MYSQL_PASSWORD=${2}/"
 find ./config -iname secrets*.env -not -iname secrets.dist.env | xargs sed -i "s/MYSQL_ROOT_PASSWORD=/MYSQL_ROOT_PASSWORD=${3}/"

# Start db container 
docker-compose up -d db

# Run npm install and give database container time to start
docker-compose -f services.yml run --rm npm install


# Update password security type in mysql to make it work with the loopback-connector-mysql
 docker exec -i loopback-docker_db_1 sh -c "mysql -u root -p -e \"ALTER USER '${1}'@'%' IDENTIFIED WITH mysql_native_password BY '${2}'\""

# Update database schema
docker-compose -f services.yml run --rm updateSchema

# Start web container
docker-compose up -d web
