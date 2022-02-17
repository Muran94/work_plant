# BASE
FROM ruby:3.0.1-alpine as base
ARG app_name
ARG bundle_jobs
ARG bundle_without
ENV APP_NAME=$app_name \
    LANG=ja_JP.UTF-8 \
    TZ=Asia/Tokyo \
    BUNDLE_JOBS=$bundle_jobs \
    BUNDLE_WITHOUT=$bundle_without
WORKDIR /${APP_NAME}
RUN apk update && \
    apk add --no-cache build-base git imagemagick less postgresql-client postgresql-dev python2 tzdata vim yarn && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime



# GEMS
FROM base as gems
COPY Gemfile* ./
RUN bundle install && \
    rm -rf /usr/local/bundle/cache/*.gem && \
    find /usr/local/bundle/gems/ -name "*.c" -delete && \
    find /usr/local/bundle/gems/ -name "*.o" -delete && \
    find /usr/local/bundle/gems/ -path '/*/ext/*/Makefile' -exec dirname {} \; | xargs -n1 -P$(nproc) -I{} make -C {} clean



# YARN
FROM base as yarn
COPY package.json ./
COPY yarn.lock ./
RUN yarn install --check-files & yarn cache clean



# BASE APP
FROM base as base-app
COPY . .
COPY --from=gems /usr/local/bundle /usr/local/bundle
COPY --from=yarn /${APP_NAME}/yarn.lock yarn.lock



# APP FOR DEVELOPMENT AND TEST
FROM base-app as app-for-development-and-test



# APP FOR PRODUCTION
FROM base-app as app-for-production
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 80