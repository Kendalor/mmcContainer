#!/bin/sh -x

SERVER_VOL=/Server
mkdir -p "$SERVER_VOL"



# Start Server
echo "Entry Point Working"
chmod +x /opt/Server/ServerStart.sh
exec /opt/Server/ServerStart.sh