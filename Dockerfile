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
RUN apt-get update && apt-get install -y curl
RUN systemctl set-default multi-user.target

RUN echo "root:admin" | chpasswd

RUN curl https://raw.githubusercontent.com/ajenti/ajenti/master/scripts/install.sh > install.sh && bash install.sh

COPY setup /sbin/

CMD ["/sbin/init"]
