#!/usr/bin/env bash
sudo docker run -d -p 2227:22/tcp -p 25585:25565 --name SevtechServer -e "USER=root" -e "PW=nudelsuppe"  mmc_container:latest
