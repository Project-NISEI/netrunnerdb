#!/bin/bash

docker-compose exec db psql -h db --user=postgres db/development
