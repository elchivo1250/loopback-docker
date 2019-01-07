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

This will create all the configs then install and run the database and web containers. After it's finished running, you
should be able to go to http://localhost/explorer to see the API. Now change the remote repository's url to a new project, 
and you're all set. Huzzah!
