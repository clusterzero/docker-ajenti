FROM ubuntu:xenial-20160818

ENV container docker

# Don't start any optional services except for the few we need.
RUN find /etc/systemd/system \
         /lib/systemd/system \
         -path '*.wants/*' \
         -not -name '*journald*' \
         -not -name '*systemd-tmpfiles*' \
         -not -name '*systemd-user-sessions*' \
         -exec rm \{} \;
RUN apt-get update && apt-get install -y curl wget
RUN echo "root:admin" | chpasswd

#Ajenti
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yq  wget
RUN rm /etc/apt/apt.conf.d/docker-gzip-indexes
RUN wget -O- https://raw.github.com/ajenti/ajenti/1.x/scripts/install-ubuntu.sh | sh

RUN DEBIAN_FRONTEND=noninteractive apt-get install -yq ajenti-v 


COPY setup /sbin/

CMD ["/sbin/init"]
