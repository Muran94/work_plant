#!/bin/bash

printf '\033[36m%s\033[m\n' 'Building App.'
docker build --target app-for-production --tag oshigoto_logger_production .

printf '\033[36m%s\033[m\n' 'Pushing Image To Heroku.'
docker tag oshigoto_logger_production registry.heroku.com/oshigoto-logger/web
docker push registry.heroku.com/oshigoto-logger/web

printf '\033[36m%s\033[m\n' 'Releasing App.'
heroku container:release web -a oshigoto-logger