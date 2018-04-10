FROM ubuntu:16.04

LABEL name=testevm

CMD ["/sbin/my_init"]

EXPOSE 22

WORKDIR /home/vagrant

RUN sed -i 's/^deb-src/# deb-src/;s/^# deb http/deb http/' /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y openssh-server sudo

RUN adduser vagrant
RUN printf 'vagrant:vagrant' | chpasswd

RUN if [ ! -f /home/vagrant/.bashrc ]; then find /etc/skel -mindepth 1 -maxdepth 1 -exec cp -r {} /home/vagrant \;; fi

RUN mkdir -p /home/vagrant/.ssh
RUN printf 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key' > /home/vagrant/.ssh/authorized_keys

RUN mkdir -p /vagrant /var/run/sshd
RUN chmod 0755 /var/run/sshd

RUN chown -R vagrant. /home/vagrant /vagrant

RUN mkdir -p /etc/sudoers.d
RUN install -bm 0440 /dev/null /etc/sudoers.d/vagrant
RUN printf 'vagrant ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/vagrant

RUN apt-get clean
RUN find /var/lib/apt/lists /tmp /var/tmp -maxdepth 1 -mindepth 1 -exec rm -rf {} +

RUN printf '#!/bin/sh\n\nwhile :; do\n\t/usr/sbin/sshd -dD\ndone' > /sbin/my_init
RUN chmod +x /sbin/my_init
