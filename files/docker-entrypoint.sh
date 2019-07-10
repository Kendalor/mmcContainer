#!/bin/sh -x

SERVER_VOL=/opt/Server
mkdir -p "$SERVER_VOL"



# Start Server
echo "Entry Point Working"
echo "eula=true" > $SERVER_VOL/eula.txt

echo "Downlaoding STuff"
curl -sSL $PACK_URL -o /tmp/Files.zip
echo "BUILD INFO: DOWNLOADED SERVER FILES"
unzip  /tmp/Files.zip -d /opt/Server



# does settings-locale.sh exist ? If not create one
if [ -f $SERVER_VOL/settings-local.sh ]; then
    echo "export JAVACMD=$JAVACMD; export MAX_RAM=$MAX_RAM ; export JAVA_PARAMETERS=$JAVA_PARAMETERS; " > $SERVER_VOL/settings-locale.sh
    chmod +x $SERVER_VOL/settings-local.sh
fi


chmod +x $SERVER_VOL/ServerStart.sh
exec $SERVER_VOL/ServerStart.sh