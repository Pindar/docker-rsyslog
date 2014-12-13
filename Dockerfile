FROM ubuntu:14.04
MAINTAINER Simon Dittlmann <simon.dittlmann@tado.com>

RUN apt-get update -qq && \
  apt-get install --no-install-recommends -y -qq software-properties-common python-software-properties && \
  add-apt-repository ppa:adiscon/v8-stable && \
  echo "deb-src http://ppa.launchpad.net/adiscon/v8-stable/ubuntu trusty main" >> /etc/apt/sources.list.d/adiscon-v8-stable-trusty.list && \
  apt-get update -qq && \
  apt-get remove -y -qq software-properties-common python-software-properties && \
  apt-get -y -qq autoremove && \
  apt-get -y -qq clean

RUN apt-get install -y -qq \
	build-essential \
	fakeroot \
	dpkg-dev \
	libcurl4-openssl-dev \
	libcurl4-gnutls-dev

RUN apt-get source -y -qq rsyslog

RUN sudo apt-get -y -qq build-dep rsyslog && \
	dpkg-source -x rsyslog_8.6.0.r1-0adiscon2trusty1.dsc && \
	cd rsyslog-8.6.0.r1/ && \
	export confflags=--enable-elasticsearch && \
	DEB_BUILD_OPTIONS="" fakeroot debian/rules binary