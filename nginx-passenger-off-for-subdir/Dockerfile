FROM ruby:2.7-slim

COPY --from=composer /usr/bin/composer /usr/bin/composer
COPY entrypoint.sh /entrypoint.sh

ENV ROR_HOME /home/app/ror
ENV LARA_HOME /home/app/lara

RUN chmod +x /entrypoint.sh \
  && apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    build-essential \
    shared-mime-info \
    libsqlite3-dev \
    php \
    unzip \
    php-mbstring \
    php-dom \
    php-fpm \
    curl \
    libcurl4-openssl-dev \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log \
  #
  # Install passenger
  && gem install passenger --no-document \
  && passenger-install-nginx-module --auto \
  #
  # Install rails
  && mkdir -p $ROR_HOME && cd $ROR_HOME \
  && gem install rails --version 6.1.2 \
  && rails _6.1.2_ new . --minimal --api \
  && bundle install \
  && chown -R www-data:www-data $ROR_HOME \
  #
  # Install laravel
  && mkdir -p $LARA_HOME /var/run/php && cd $LARA_HOME \
  && composer create-project --prefer-dist laravel/laravel="8.5.11" . \
  && chown -R www-data:www-data $LARA_HOME /var/run/php \
  #
  && true

ENTRYPOINT ["/entrypoint.sh"]

CMD ["tail", "-F", "/opt/nginx/logs/access.log"]
