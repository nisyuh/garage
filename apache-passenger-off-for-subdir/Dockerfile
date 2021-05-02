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
    #php-fpm \
    apache2 \
    apache2-dev \
    libcurl4-openssl-dev \
    libapr1-dev \
    libaprutil1-dev \
    libapache2-mod-php \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log \
  #
  # Install passenger
  && gem install passenger --no-document \
  && passenger-install-apache2-module --auto \
  && passenger-install-apache2-module --snippet > /etc/apache2/mods-available/passenger.load \
  && echo "PassengerDefaultUser www-data\n" > /etc/apache2/mods-available/passenger.conf \
  && a2enmod passenger \
  && touch /etc/apache2/sites-available/webapp.conf \
  && a2ensite webapp \
  && a2dissite 000-default \
  #
  # Install rails
  && mkdir -p $ROR_HOME && cd $ROR_HOME \
  && gem install rails --version 6.1.2 \
  && rails _6.1.2_ new . --minimal --api \
  && bundle install \
  && chown -R www-data:www-data $ROR_HOME \
  #
  # Install laravel
  && mkdir -p $LARA_HOME && cd $LARA_HOME \
  && composer create-project --prefer-dist laravel/laravel="8.5.11" . \
  && chown -R www-data:www-data $LARA_HOME \
  #
  && true

ENTRYPOINT ["/entrypoint.sh"]

CMD ["tail", "-F", "/var/log/apache2/access.log"]
