# Empty docker-loopback project

This repository is an empty loopback API project with some supporting software set up and installed, all backed by Docker. 

## Installation

Run the init.sh file with the following positional parameters:
- $1 - MYSQL_USER - The username for the default mysql user for this database. 
- $2 - MYSQL_PASSWORD - The password for the default mysql user for this database.
- $3- MYSQL_ROOT_PASSWORD - The password for the root mysql user for this database.

### Bad Example
```
./init.sh loopback_user password password
```
