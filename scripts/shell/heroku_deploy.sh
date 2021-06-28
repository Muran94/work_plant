#!/bin/bash

printf '\033[36m%s\033[m\n' 'Building App.'
docker build --target app-for-production --tag jizobiyori_production .

printf '\033[36m%s\033[m\n' 'Pushing Image To Heroku.'
docker tag jizobiyori_production registry.heroku.com/jizobiyori/web
docker push registry.heroku.com/jizobiyori/web

printf '\033[36m%s\033[m\n' 'Releasing App.'
heroku container:release web -a jizobiyori