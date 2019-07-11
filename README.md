[![](https://images.microbadger.com/badges/version/kendalor/ftb_server.svg)](https://microbadger.com/images/kendalor/ftb_server "Get your own version badge on microbadger.com")    [![](https://images.microbadger.com/badges/image/kendalor/ftb_server.svg)](https://microbadger.com/images/kendalor/ftb_server "Get your own image badge on microbadger.com")
# ftb_server
Docker Container to start FTB Modpack Servers

## Quickstart
```bash
docker run  \
-d \
-p 22229:25565 \
-v /home/myName/ftbServer:/opt/Server \
-e "PACK_URL=https://media.forgecdn.net/files/2727/712/FTBPresentsStoneblock2Server_1.15.0.zip" \
-e "EULA=true" \
--name ftb_server \
kendalor/ftb_server:latest
```
# What Happens Here:

* `-d` : Detached Mode, so container starts as a daemon
* `-p` : The Port 22229 of the Host is forwarded to the 25565 Container Port
* `-v` : The dir /home/myName/ftbServer dir is linked to server dir in Container, **IMPORANT** to update the Server
* `-e PACK_URL` : This defines the ModPack which is run in the container, only works with FTB Packs Currently 
* `--name` : Name of the running Container, easier to use as a random assigned string
* `kendalor/ftb_server:latest` : Reference to the Image used to run the Container


## Environemnt Variables (Selecting the Modpack)


* `PORT` : Port used by Minecraft, defined in the server.properties file
* `PACK_URL` : Url of the Pack zip Archive, usually found in the "Additional Files" on the Twitch Modpack Site
* `JAVACMD` : The java command, usually "java". Used to create the settings-local.sh in the Server dir.
* `MAX_RAM` : Max Ram used by the Server, default is 2048M. Used to create the settings-local.sh in the Server dir.
* `JAVA_PARAMETERS` : java Args to append. Used to create the settings-local.sh in the Server dir.
* `EULA` : Accept the eula of mojang.




## Updating

Updating should be quite Easy

1. Stop the current Server:
```bash
docker stop ftb_server
```
2. Remove the current Server (world is stored in the volume):
```bash
docker rm ftb_server
```
3. Restart Server with new Server Files:
```bash
docker run  \
-d \
-p 22229:25565 \
-v /home/myName/ftbServer:/opt/Server \
-e "PACK_URL=https://media.forgecdn.net/files/2727/712/FTBPresentsStoneblock2Server_1.15.0.zip" \
-e "EULA=true" \
--name ftb_server \
kendalor/ftb_server:latest
```
    

