#!/bin/sh -x

# Variables and TestStuff
SERVER_VOL=/opt/Server
mkdir -p "$SERVER_VOL"
whoami

eula_false() {
    grep -q 'eula=false' $SERVER_VOL/eula.txt
    return $?
}


#Downlaod Server Files and Extract
echo "Downlaoding STuff"
curl -sSL $PACK_URL -o /tmp/Files.zip
echo "BUILD INFO: DOWNLOADED SERVER FILES"
unzip  /tmp/Files.zip -d /tmp/Server
echo "comapring JSONS"

echo "already running Server found"
if ! cmp --silent /opt/Server/version.json /tmp/Server/version.json ; then
    echo "Json files differ, Update"
    # Update Logic
    # Overwrite every File/Dir in the Server directory if the corresponding file/dir in the archive exists
    for i in $(ls /tmp/Server); do
        if [ -e /opt/Server/${i} ]; then
            echo "File ${i} in opt/Server found"
            rm -r $SERVER_VOL/${i}
            echo "Deleted File/Dir ${i}"
        fi
        cp -r /tmp/Server/${i} $SERVER_VOL/${i}
        echo "Copied ${i} to Server Dir"
    done
fi

rm -r /tmp/Files.zip
rm -r /tmp/Server


# EULA Exists ? 
if [ -f $SERVER_VOL/eula.txt ] && eula_false ; then
    echo "eula=$EULA" > $SERVER_VOL/eula.txt
fi

if [ ! -f $SERVER_VOL/eula.txt ]; then
    echo "eula=$EULA" > $SERVER_VOL/eula.txt
fi
# does settings-locale.sh exist ? If not create one
echo "Checking for Settings Locale"
sleep 1
if [ ! -f $SERVER_VOL/settings-local.sh ]; then
        echo "export JAVACMD='${JAVACMD}' 
export MAX_RAM='${MAX_RAM}'
export JAVA_PARAMETERS='${JAVA_PARAMETERS}'" > $SERVER_VOL/settings-local.sh
    chmod +x $SERVER_VOL/settings-local.sh
fi

# Start FTB Script
pwd
cd $SERVER_VOL
pwd
chmod +x $SERVER_VOL/install.sh
exec $SERVER_VOL/install.sh
chmod +x $SERVER_VOL/settings.sh
chmod +x $SERVER_VOL/settings-local.sh
chmod +x $SERVER_VOL/ServerStart.sh
exec $SERVER_VOL/ServerStart.sh