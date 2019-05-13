#!/bin/sh -x
set -euo pipefail

id

SERVER_VOL=/Server
mkdir -p "$SERVER_VOL"



if [ "$(id -u)" = '0' ]; then
  # Update the User and Group ID based on the PUID/PGID variables
  usermod -o -u "$PUID" mcServer
  groupmod -o -g "$PGID" mcServer
  # Take ownership of factorio data if running as root
  chown -R mcServer:mcServer $SERVER_VOL
  # Drop to the factorio user
  SU_EXEC="su-exec mcServer"
else
  SU_EXEC=""
fi


# Start Server
exec $SU_EXEC /opt/Server/ServerStart.sh