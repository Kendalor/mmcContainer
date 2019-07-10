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


RUN mkdir -p -v /opt/Server && \
    echo "BUILD INFO: Created DIR" && \
    apt-get install curl && \
    echo "BUILD INFO: Extracted Server Files" && \
    chmod ugo=rwx /opt/Server && \
    echo "BUILD INFO: Change Owner of Server Files" && \
    addgroup --system --gid $PGID  $GROUP && \
    echo "BUILD INFO: Added User Group" && \
    adduser --system --uid $PUID --ingroup $GROUP --shell /bin/sh $USER && \
    echo "BUILD INFO: ADDED USER" && \
    chown -R $USER:$GROUP /opt/Server  && \
    su $USER && \
    echo "BUILD INFO: Changed Ownership of Server Dir" && \
    echo "$(ls /opt/Server), $(pwd), $(ls), $(whoami)"
    
USER $USER
COPY --chown=845:845 files/docker-entrypoint.sh /
VOLUME /server
EXPOSE $PORT/tcp
ENTRYPOINT ["/docker-entrypoint.sh"]