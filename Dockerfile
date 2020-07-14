FROM debian:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get install -y --force-yes --no-install-recommends dpkg-dev apt-utils nginx gpg gpg-agent \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

ADD nginx.conf /etc/nginx/sites-enabled/default
ADD startup.sh /

EXPOSE 80
VOLUME /data
ENTRYPOINT ["/startup.sh"]
