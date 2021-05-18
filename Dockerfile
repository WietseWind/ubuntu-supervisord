FROM ubuntu:20.04
LABEL maintainer="w@xrpl-labs.com"

# Install packages
RUN apt-get update -y && apt-get -y upgrade && DEBIAN_FRONTEND=noninteractive apt-get -y install openssh-server ca-certificates pwgen supervisor git tar wget nano curl htop iputils-ping --no-install-recommends && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# #https://github.com/docker/docker/issues/6103
RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/.PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config && sed -ri 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config

# Define working directory.
WORKDIR /data

ADD set_root_pw.sh /data/set_root_pw.sh
ADD run.sh /data/run.sh

# As suggested here: http://docs.docker.com/articles/using_supervisord/
ADD supervisord_docker.conf /etc/supervisor/conf.d/supervisord_docker.conf

ADD sshd.conf /etc/supervisor/conf.d/sshd.conf

RUN chmod a+x /data/*.sh

# ## Strangely... docker.io don't want build this image since xterm env..
# # ENV TERM="xterm-color"

EXPOSE 22 8000 8001 8002 8003 8004 8005 8006 8007 8008 8009
CMD ["/data/run.sh"]
