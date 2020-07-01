FROM php:8.0-rc-fpm

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
