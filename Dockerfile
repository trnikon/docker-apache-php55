FROM ubuntu:14.04

VOLUME ["/var/www"]

RUN apt-get update && \
    apt-get install -y \
      apache2 \
      nano \
      sendmail \
      php5 \
      openssh-server \
      libcurl3 \
      php5-cli \
      libapache2-mod-php5 \
      php5-gd \
      php5-mcrypt \
      php5-curl \
      php-soap \
      php5-json \
      php5-ldap \
      php5-mysql \
      php5-pgsql \
      php5-xdebug

COPY ./etc/apache_default.conf /etc/apache2/sites-available/000-default.conf
COPY setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh
RUN a2enmod rewrite
RUN php5enmod mcrypt
RUN chown -R www-data:www-data /var/www

RUN echo -e "$(hostname -i)\t$(hostname).localdomain $(hostname)" >> /etc/hosts
RUN sendmailconfig -y

EXPOSE 80
CMD ["/usr/local/bin/setup.sh"]