FROM debian:8.5
MAINTAINER Raphaël Snts <r@snts.io>

EXPOSE 80 7331
VOLUME ["/var/www"]
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y upgrade

# Install Apache
RUN apt-get -y install apache2

# Install PHP
RUN apt-get -y install php5 php-pear php5-curl php5-gd php5-xmlrpc php5-intl php5-pgsql php5-mysql php5-cli libapache2-mod-php5 php5-ldap

# Install ssh
RUN apt-get -y install openssh-server

# Install other stuff
RUN apt-get -y install git pwgen vim

# Apache config
ADD ./apache.conf /etc/apache2/sites-avaliable/000-default.conf
RUN ln -sf /etc/apache2/sites-avaliable/000-default.conf /etc/apache2/sites-enabled/

# Foreground
ADD ./foreground.sh /etc/apache2/foreground.sh
RUN chmod +x /etc/apache2/foreground.sh

CMD ["/etc/apache2/foreground.sh"]