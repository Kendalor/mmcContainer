#!/bin/sh -x

SERVER_VOL=/opt/Server
mkdir -p "$SERVER_VOL"
whoami


# Start Server
echo "Entry Point Working"
echo "eula=true" > $SERVER_VOL/eula.txt

#Downlaod Server Files and Extract
echo "Downlaoding STuff"
curl -sSL $PACK_URL -o /tmp/Files.zip
echo "BUILD INFO: DOWNLOADED SERVER FILES"
unzip  /tmp/Files.zip -d /opt/Server

# Update Logic !?

# does settings-locale.sh exist ? If not create one
echo "Checking for Settings Locale"
sleep 1
if [ -f $SERVER_VOL/settings-local.sh ]; then
    echo "export JAVACMD=$JAVACMD; export MAX_RAM=$MAX_RAM ; export JAVA_PARAMETERS=$JAVA_PARAMETERS; " > $SERVER_VOL/settings-locale.sh
    chmod +x $SERVER_VOL/settings-local.sh
fi


chmod +x $SERVER_VOL/ServerStart.sh
#exec $SERVER_VOL/ServerStart.sh