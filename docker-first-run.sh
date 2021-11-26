#!/bin/sh

docker-compose run db psql -h db --username=postgres -c "create user nrdb with password 'nrdb' CREATEDB;"
docker-compose run web rake db:create db:migrate 

