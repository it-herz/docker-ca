FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive
 
RUN apt-get update && apt-get install -y openssl nginx php7.0-fpm php7.0-ldap software-properties-common python-software-properties python-setuptools
 
ENV [ "DAYS 730", "CLIENT_DAYS 730", "START_SERIAL 646464", "START_CRL 1000", "CRL_DAYS 30", "KEY_LENGTH 2048", \
      "COUNTRY Russian Federation", "STATE Russia", "LOCALITY St. Petersburg", "ORGANIZATION Default Organization", \
      "OU IT Department", "PASSWORD changeme", "EMAIL support@org.ru", "CAHOST ca.example.ru" ]

# Supervisor Config
RUN mkdir /var/log/supervisor/
RUN /usr/bin/easy_install supervisor
RUN /usr/bin/easy_install supervisor-stdout
ADD supervisord.conf /etc/supervisord.conf

VOLUME [ "/usr/lib/ssl/CA", "/storage", "/var/www" ]

ADD run /
ADD prephp.sh /
ADD openssl.cnf /
ADD ca.req /
ADD sign /
ADD revoke /

EXPOSE 80

CMD [ "/run" ]
