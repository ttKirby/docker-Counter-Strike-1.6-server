Beta Version. 

README COMMING SOON!

https://hub.docker.com/r/ttkirby/cs16-server

docker run command:

docker run -d \
  --name cs16-server \
  -p 80:80 \
  -p 27015:27015/udp \
  -e LEGACY=true \
  -e REHLDS=true \
  -e METAMOD=true \
  -e AMXMODX=true \
  -e FAST_DL=true \
  -e HOSTNAME="ttKirby's Counter-Strike 1.6 Server" \
  -e PASSWORD=your_server_password \
  -e RCON=your_rcon_password \
  -e STEAM_ID="STEAM_0:1:12345678" \
  -e SV_LAN=0 \
  -e MAP=de_dust2 \
  -e PLAYERS=32 \
  -e SERVER_TICK=1000 \
  -e BOT=YaPB \
  -e KEY=yourkey \
  -e PW=yourpassword \
  -v /your/path/to/hlds:/hlds \
  --restart unless-stopped \
  ttkirby/cs16-server
