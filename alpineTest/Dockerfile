FROM openjdk:8-jre-alpine
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
    apk add --update --no-progress --no-cache bash curl unzip && \
    echo "BUILD INFO: Extracted Server Files" && \
    chmod ugo=rwx /opt/Server && \
    echo "BUILD INFO: Change Owner of Server Files" && \
    addgroup -g "$PGID" -S "$GROUP" && \
    adduser -u "$PUID" -G "$GROUP" -s /bin/sh -SDH "$USER" && \
    chown -R $USER:$GROUP /opt/Server  && \
    echo "BUILD INFO: Changed Ownership of Server Dir" && \
    echo "$(ls /opt/Server), $(pwd), $(ls), $(whoami)"

USER mcserver
COPY --chown=845:845 files/docker-entrypoint.sh /
VOLUME /server
EXPOSE $PORT/tcp
ENTRYPOINT ["/docker-entrypoint.sh"]