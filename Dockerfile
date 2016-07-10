FROM itherz/webapp-full:d7

ENV DEBIAN_FRONTEND noninteractive
 
RUN apt-get update && apt-get install -y openssl
 
ENV [ "DAYS 730", "CLIENT_DAYS 730", "START_SERIAL 646464", "START_CRL 1000", "CRL_DAYS 30", "KEY_LENGTH 2048", \
      "COUNTRY Russian Federation", "STATE Russia", "LOCALITY St. Petersburg", "ORGANIZATION Default Organization", \
      "OU IT Department", "PASSWORD changeme", "EMAIL support@org.ru", "CAHOST ca.example.ru" ]

VOLUME [ "/usr/lib/ssl/CA", "/storage", "/var/www" ]

ADD 03-initialize /etc/container-run.d/
ADD openssl.cnf /
ADD ca.req /
ADD sign /
ADD revoke /

EXPOSE 80
