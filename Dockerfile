FROM amd64/openjdk:8-jre

LABEL maintainer="https://github.com/Kendalor/mmcContainer"

ARG USER=mcServer
ARG GROUP=mcServer
ARG PUID=845
ARG PGID=845

ENV PORT=25565 \
    VANNILA_VERSION=1.12.2 \
    PACK_VERSION=0.14.2 \
    PACK_URL=https://media.forgecdn.net/files/2705/204/FTBInteractionsServer_1.4.2.zip 

RUN mkdir -p /opt /Server && \
    echo "BUILD INFO: Created DIR" \
    curl -sSL $PACK_URL \
        -o /tmp/Files.zip && \
    echo "BUILD INFO: DOWNLOADED SERVER FILES" \
    unzip  /tmp/Files.zip -d /opt/Server && \
    echo "BUILD INFO: Extracted Server Files" \
    chmod ugo=rwx /opt/Server && \
    echo "BUILD INFO: Change Owner of Server Files" \
    rm /tmp/Files.zip && \
    echo "BUILD INFO: Removed DOwnloaded Archive" \
    addgroup -g $PGID -S $GROUP && \
    echo "BUILD INFO: Added User Group" \
    adduser -u $PUID -G $GROUP -s /bin/sh -SDH $USER && \
    echo "BUILD INFO: ADDED USER" \
    chown -R $USER:$GROUP /opt/Server /Server \
    echo "BUILD INFO: Changed Ownership of Server Dir"

VOLUME /Server

EXPOSE $PORT/tcp

COPY files/ /

ENTRYPOINT ["/docker-entrypoint.sh"]