FROM ubuntu:12.10
MAINTAINER Corentin Kerisit <corentin.kerisit@gmail.com>

RUN echo "deb http://fr.archive.ubuntu.com/ubuntu quantal main universe" > /etc/apt/sources.list && apt-get update
RUN locale-gen en_US en_US.UTF-8

RUN apt-get install -y curl lsb-release supervisor build-essential wget
RUN apt-get install -qqy python-software-properties

RUN mkdir -p /var/log/supervisor

RUN apt-get install -qqy openjdk-7-jre-headless
RUN wget --progress=bar:force http://archive.apache.org/dist/lucene/solr/1.4.1/apache-solr-1.4.1.tgz
RUN tar --extract --file apache-solr-1.4.1.tgz -C /opt
RUN mv /opt/apache-solr-1.4.1 /opt/solr

ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8983

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
