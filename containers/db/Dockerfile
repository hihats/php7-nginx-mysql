FROM mysql:5.7
RUN cp /usr/share/zoneinfo/Japan /etc/localtime
COPY ./my.cnf /etc/mysql/conf.d/
RUN mkdir /var/tmp/mysql
