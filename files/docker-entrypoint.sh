#!/bin/sh -x

SERVER_VOL=/Server
mkdir -p "$SERVER_VOL"



# Start Server
echo "Dockerfile Params: $PORT, $VANILLA_VERSION, $PACK_VERSION, $PACK_URL"
echo "eula=true" > /opt/Server/eula.txt
echo "Entry Point Working"
chmod +x /opt/Server/ServerStart.sh
# exec /opt/Server/ServerStart.sh