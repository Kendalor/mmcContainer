FROM java:8
MAINTAINER Patrick Rehn <Kendalor@googlemail.com>

RUN mkdir -p /opt/ftb/world
WORKDIR /opt/ftb
RUN apt-get install -y curl wget
RUN curl -L -o server.zip https://minecraft.curseforge.com/projects/sevtech-ages/files/2547513/download && unzip server.zip && rm -f server.zip
COPY ops.json server.properties ./
RUN sed -i 's/2048M/4096M/g' settings.sh
RUN /bin/bash Install.sh

FROM ubuntu:16.04

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:screencast' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]