#!/bin/sh -x

SERVER_VOL=/Server
mkdir -p "$SERVER_VOL"



# Start Server
echo "Dockerfile Params: $PORT, $PACK_VERSION, $PACK_URL, $MCVER, $JARFILE, $LAUNCHWRAPPERVERSION, $LAUNCHWRAPPER, $FORGEJAR, $JAVACMD, $MAX_RAM, $JAVA_PARAMETERS"
echo "eula=true" > $SERVER_VOL/eula.txt
echo "Entry Point Working"
chmod +x $SERVER_VOL/ServerStart.sh
#exec $SERVER_VOL/ServerStart.sh