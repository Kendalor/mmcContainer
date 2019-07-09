#!/bin/sh -x

SERVER_VOL=/Server
mkdir -p "$SERVER_VOL"



# Start Server
echo "Dockerfile Params: $PORT, $PACK_VERSION, $PACK_URL, $MCVER, $JARFILE, $LAUNCHWRAPPERVERSION, $LAUNCHWRAPPER, $FORGEJAR, $JAVACMD, $MAX_RAM, $JAVA_PARAMETERS"
echo "eula=true" > $SERVER_VOL/eula.txt
echo "Entry Point Working"

# does settings-locale.sh exist ? If not create one
if [ -f settings-local.sh ]; then
    echo "export JAVACMD=$JAVACMD; export MAX_RAM=$MAX_RAM ; export JAVA_PARAMETERS=$JAVA_PARAMETERS; " > /Server/settings-locale.sh
    chmod +x /Server/settings-local.sh
fi


chmod +x $SERVER_VOL/ServerStart.sh
exec $SERVER_VOL/ServerStart.sh