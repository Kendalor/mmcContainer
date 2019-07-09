FROM amd64/openjdk:8-jre

LABEL maintainer="https://github.com/Kendalor/mmcContainer"

ARG USER=mcserver
ARG GROUP=mcserver
ARG PUID=845
ARG PGID=845

ENV PORT=25565 \
    PACK_URL="https://media.forgecdn.net/files/2727/712/FTBPresentsStoneblock2Server_1.15.0.zip" \
    JAVACMD="java" \
    MAX_RAM="2048M" \
    JAVA_PARAMETERS='-XX:+UseParNewGC -XX:+CMSIncrementalPacing -XX:+CMSClassUnloadingEnabled -XX:ParallelGCThreads=5 -XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=10' \
    EULA="true"

VOLUME /Server
RUN mkdir -p /Server && \
    echo "BUILD INFO: Created DIR" && \
    apt-get install curl && \
    curl -sSL $PACK_URL \
        -o /tmp/Files.zip && \
    echo "BUILD INFO: DOWNLOADED SERVER FILES" && \
    unzip  /tmp/Files.zip -d /Server && \
    echo "BUILD INFO: Extracted Server Files" && \
    chmod ugo=rwx /Server && \
    echo "BUILD INFO: Change Owner of Server Files" && \
    rm /tmp/Files.zip && \
    echo "BUILD INFO: Removed DOwnloaded Archive" && \
    addgroup --gid $PGID  $GROUP && \
    echo "BUILD INFO: Added User Group" && \
    adduser --uid $PUID --ingroup $GROUP --shell /bin/sh $USER && \
    echo "BUILD INFO: ADDED USER" && \
    chown -R $USER:$GROUP /Server  && \
    echo "BUILD INFO: Changed Ownership of Server Dir" && \
    echo "$(ls /Server), $(pwd), $(ls)"

COPY --chown=845:845 files/docker-entrypoint.sh /
EXPOSE $PORT/tcp
ENTRYPOINT ["/docker-entrypoint.sh"]