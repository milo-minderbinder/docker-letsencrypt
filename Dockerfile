# mminderbinder/letsencrypt
FROM mminderbinder/baseimage:0.9.18
MAINTAINER Milo Minderbinder <minderbinder.enterprises@gmail.com>

RUN apt-get update && apt-get -y install \
		python2.7 \
		python-dev \
		git

WORKDIR /root

ADD https://bootstrap.pypa.io/get-pip.py get-pip.py
RUN python get-pip.py

RUN git clone https://github.com/letsencrypt/letsencrypt /root/letsencrypt

WORKDIR /root

RUN sh /root/letsencrypt/letsencrypt-auto --help

RUN pip install letsencrypt-s3front

COPY run-letsencrypt.sh /root/run-letsencrypt.sh
RUN chmod +x /root/run-letsencrypt.sh

# Clean up APT when done
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

