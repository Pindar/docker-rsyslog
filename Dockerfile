FROM ubuntu:14.04
MAINTAINER Simon Dittlmann

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qq && \
  apt-get install --no-install-recommends -y -qq software-properties-common python-software-properties && \
  add-apt-repository ppa:adiscon/v8-stable && \
  apt-get update -qq && \
  apt-get remove -y -qq software-properties-common python-software-properties && \
  apt-get -y -qq autoremove && \
  apt-get -y -qq clean

RUN apt-get install -y -qq rsyslog-elasticsearch rsyslog-mmjsonparse rsyslog-mmnormalize && \
  apt-get -y -qq clean


ENV RSYSLOG_CENTRAL_CONF 30-central.conf
COPY conf/rsyslog.conf /etc/rsyslog.conf
COPY conf/$RSYSLOG_CENTRAL_CONF /etc/rsyslog.d/$RSYSLOG_CENTRAL_CONF
RUN rm -f /etc/rsyslog.d/50-default.conf

EXPOSE 514/tcp 514/udp

VOLUME /var/log
WORKDIR /var/log

COPY scripts/start.sh /start.sh
RUN chmod +x /start.sh
CMD ["/start.sh"]
