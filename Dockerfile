FROM php:7.4.6-fpm

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      software-properties-common \
      gnupg2 \
      wget \
      && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget -O - https://download.newrelic.com/548C16BF.gpg | apt-key add - && \
    add-apt-repository "deb http://apt.newrelic.com/debian/ newrelic non-free"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      newrelic-php5 \
      && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ARG NEWRELIC_LICENSE_KEY
COPY docker/newrelic.ini /usr/local/etc/php/conf.d/newrelic.ini
RUN sed -ie "s/<your-key-goes-here>/${NEWRELIC_LICENSE_KEY}/" /usr/local/etc/php/conf.d/newrelic.ini

RUN NR_INSTALL_KEY=${NEWRELIC_LICENSE_KEY} \
      newrelic-install install
