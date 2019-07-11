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
    JAVA_PARAMETERS='-XX:+UseParNewGC -XX:+CMSIncrementalPacing -XX:+CMSClassUnloadingEnabled -XX:ParallelGCThreads=5 -XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=10  -Dfml.queryResult=confirm' \
    EULA="true" 


RUN mkdir -p -v /opt/Server && \
    apt-get install curl && \
    chmod ugo=rwx /opt/Server && \
    addgroup --system --gid $PGID  $GROUP && \
    adduser --system --uid $PUID --ingroup $GROUP --shell /bin/sh $USER && \
    chown -R $USER:$GROUP /opt/Server

USER mcserver
COPY --chown=845:845 files/docker-entrypoint.sh /
VOLUME /server
EXPOSE $PORT/tcp
ENTRYPOINT ["/docker-entrypoint.sh"]