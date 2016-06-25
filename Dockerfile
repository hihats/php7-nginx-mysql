FROM centos:centos6
MAINTAINER hihats <hishats@gmail.com>

RUN yum clean all && rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm
RUN yum update -y && yum install -y git nginx gcc gcc-c++ epel-release
RUN yum update -y && yum -y --enablerepo=epel install supervisor
RUN yum update -y && yum install -y php70w php70w-devel php70w-fpm php70w-mysql php70w-mbstring php70w-pdo php70w-xml

RUN yum install -y wget \
    zlib \
    zlib-devel \
    openssl \
    openssl-devel \
    pcre-devel \
    libxml2 \
    libxml2-devel \
    libcurl \
    libcurl-devel \
    libpng-devel \
    libjpeg-devel \
    freetype-devel \
    libmcrypt-devel \
    openssh-server \
    python-setuptools && \
    yum clean all


RUN cp /usr/share/zoneinfo/Japan /etc/localtime
ADD containers/web/nginx.conf /etc/nginx/nginx.conf
COPY containers/web/php.ini /usr/local/etc/php/
ADD containers/web/supervisord.conf /etc/supervisord.conf
RUN sed -i 's/apache/root/g' /etc/php-fpm.d/www.conf
EXPOSE 8080
EXPOSE 443
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin
RUN mv /usr/local/bin/composer.phar /usr/local/bin/composer
COPY . /var/www/html/.
WORKDIR /var/www/html
RUN mkdir /var/www/html/vendor
RUN composer install
VOLUME ["/var/www/html/vendor"]
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
