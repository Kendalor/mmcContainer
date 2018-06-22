FROM java:8
MAINTAINER Patrick Rehn <Kendalor@googlemail.com>

RUN apt-get install -y wget

FROM ubuntu:16.04

RUN \
 apt-get update && apt-get install -y openssh-server && \
 mkdir /var/run/sshd && \
 echo 'root:screencast' | chpasswd  && \
 sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
 sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
EXPOSE 25565
CMD ["/usr/sbin/sshd", "-D"]