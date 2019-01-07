# Empty docker-loopback project

This repository is an empty loopback API project with some supporting software set up and installed, all backed by Docker. 

## Installation

Clone the repository: `git clone git@github.com:elchivo1250/loopback-docker.git`

Start the database: `docker-compose up -d db`

Install node packages: `docker-compose -f services.yml run --rm npm install`

Update the database: `docker-compose -f services.yml run --rm updateSchema`

Run the web container: `docker-compose up -d api`
