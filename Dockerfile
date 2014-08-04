FROM ubuntu:14.04
MAINTAINER Kazuya Yokogawa "yokogawa-k@klab.com"

RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -snvf /bin/true /sbin/initctl

RUN echo "deb http://jp.archive.ubuntu.com/ubuntu/ precise main universe" > /etc/apt/sources.list
RUN apt-get update
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y install libaio1 wget

ENV MYSQL_BASE /opt/mysql/server-5.6/
RUN (cd /tmp/ && wget http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.20-debian6.0-x86_64.deb)
RUN (dpkg -i /tmp/mysql-5.6.20-debian6.0-x86_64.deb && rm /tmp/mysql-5.6.20-debian6.0-x86_64.deb)
RUN (groupadd mysql && useradd -r -g mysql mysql)
RUN mkdir -p ${MYSQL_BASE}/data
RUN chown mysql:mysql ${MYSQL_BASE}/data
RUN ${MYSQL_BASE}/scripts/mysql_install_db --user=mysql
#RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf
ADD init.sql /tmp/
RUN (${MYSQL_BASE}/bin/mysqld_safe &); sleep 5; ${MYSQL_BASE}/bin/mysql -u root < /tmp/init.sql

CMD ["/opt/mysql/server-5.6/bin/mysqld_safe"]
