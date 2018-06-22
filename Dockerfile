FROM ubuntu:16.04
MAINTAINER Patrick Rehn <Kendalor@googlemail.com>


ENV DEBIAN_FRONTEND noninteractive
ENV JAVA_HOME       /usr/lib/jvm/java-8-oracle
ENV LANG            en_US.UTF-8
ENV LC_ALL          en_US.UTF-8


RUN \
 apt-get update && apt-get install -y openssh-server && \
 mkdir /var/run/sshd && \
 echo 'root:ftb' | chpasswd  && \
 sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
 sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
 apt-get install -y wget && \
 apt-get update && \
 apt-get install -y --no-install-recommends locales && \
 locale-gen en_US.UTF-8 && \
 apt-get dist-upgrade -y && \
 apt-get --purge remove openjdk* && \
 echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections && \
 echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" > /etc/apt/sources.list.d/webupd8team-java-trusty.list && \
 apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886 && \
 apt-get update && \
 apt-get install -y --no-install-recommends oracle-java8-installer oracle-java8-set-default && \
 apt-get clean all && \
 echo "export VISIBLE=now" >> /etc/profile


ENV NOTVISIBLE "in users profile"


EXPOSE 22
EXPOSE 25565
CMD ["/usr/sbin/sshd", "-D"]