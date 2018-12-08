FROM ubuntu:18.04
LABEL maintainer="Paul.Hivert@ynov.com"
LABEL Version="0.0.1"
ENV DEBIAN_FRONTEND  Noninteractive

# Install basics
RUN apt-get --fix-missing update
RUN apt-get install -y apt-utils locales
RUN apt-get install -y software-properties-common && \
add-apt-repository ppa:ondrej/php && apt-get update
RUN apt-get install -y --force-yes curl
RUN apt-get install -y vim

# Install PHP 7
RUN apt-get install -y --fix-missing php

# Enable apache mods.
RUN a2enmod rewrite


# Manually set up the apache environment variables
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

# Expose apache.
EXPOSE 80
EXPOSE 8080
EXPOSE 443
EXPOSE 3306

# Update the default apache site with the config we created.
ADD apache-config.conf ~/../etc/apache2/sites-enabled/000-default.conf

# By default start up apache in the foreground, override with /bin/bash for interative.
CMD /usr/sbin/apache2ctl -D FOREGROUND

#working directory
WORKDIR /var/www/website