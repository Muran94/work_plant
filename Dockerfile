# BASE
FROM ruby:3.0.1-alpine3.13 as base
ARG bundle_jobs
ARG bundle_without
WORKDIR /app
ENV LANG=ja_JP.UTF-8 \
    TZ=Asia/Tokyo \
    BUNDLE_JOBS=$bundle_jobs \
    BUNDLE_WITHOUT=$bundle_without
RUN apk update && \
    apk add --no-cache build-base tzdata yarn postgresql-client && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime



# GEMS
FROM base as gems
COPY Gemfile* ./
RUN apk update && \
    apk add --no-cache git postgresql-dev && \
    bundle install && \
    rm -rf /usr/local/bundle/cache/*.gem && \
    find /usr/local/bundle/gems/ -name "*.c" -delete && \
    find /usr/local/bundle/gems/ -name "*.o" -delete && \
    find /usr/local/bundle/gems/ -path '/*/ext/*/Makefile' -exec dirname {} \; | xargs -n1 -P$(nproc) -I{} make -C {} clean



# YARN
FROM base as yarn
COPY package.json yarn.lock ./
RUN apk add --no-cache python2 && \
    yarn install --check-files && yarn cache clean



# BASE APP
FROM base as base-app
COPY . .
COPY --from=yarn /app/yarn.lock yarn.lock
COPY --from=gems /usr/local/bundle /usr/local/bundle



# APP FOR DEVELOPMENT AND TEST
FROM base-app as app-for-development-and-test
RUN apk add --no-cache less bash vim



# APP FOR PRODUCTION
FROM base-app as app-for-production
ENV RAILS_ENV=production \
    RACK_ENV=production \
    RAILS_LOG_TO_STDOUT=enabled \
    RAILS_SERVE_STATIC_FILES=enabled \
    SECRET_KEY_BASE=dummy
COPY --from=yarn /app/node_modules node_modules
RUN rails assets:precompile && \
    apk del --purge build-base
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]