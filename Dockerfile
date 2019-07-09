FROM amd64/openjdk:8-jre

LABEL maintainer="https://github.com/Kendalor/mmcContainer"

ARG USER=mcServer
ARG GROUP=mcServer
ARG PUID=845
ARG PGID=845

ENV PORT=25565 \
    VANNILA_VERSION=1.12.2 \
    PACK_VERSION=1.14.0 \
    PACK_URL=https://media.forgecdn.net/files/2720/980/FTBPresentsStoneblock2Server_1.14.0.zip

VOLUME /Server
RUN mkdir -p /opt /Server && \
    echo "BUILD INFO: Created DIR" && \
    apt-get install curl && \
    curl -sSL $PACK_URL \
        -o /tmp/Files.zip && \
    echo "BUILD INFO: DOWNLOADED SERVER FILES" && \
    unzip  /tmp/Files.zip -d /opt/Server && \
    echo "BUILD INFO: Extracted Server Files" && \
    chmod ugo=rwx /opt/Server && \
    echo "BUILD INFO: Change Owner of Server Files" && \
    rm /tmp/Files.zip && \
    echo "BUILD INFO: Removed DOwnloaded Archive" && \
    addgroup --gid $PGID  $GROUP && \
    echo "BUILD INFO: Added User Group" && \
    adduser --uid $PUID --gid $GROUP --shell /bin/sh $USER && \
    echo "BUILD INFO: ADDED USER" && \
    chown -R $USER:$GROUP /opt/Server /Server  && \
    echo "BUILD INFO: Changed Ownership of Server Dir" && \
    echo $(ls /Server)
COPY --chown=845:845 files/docker-entrypoint.sh /
EXPOSE $PORT/tcp
ENTRYPOINT ["/docker-entrypoint.sh"]