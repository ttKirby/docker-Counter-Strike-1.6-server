#!/bin/bash
set -e

bash /scripts/cstrike.sh
bash /scripts/rehlds.sh
bash /scripts/metamod.sh
bash /scripts/amxmodx.sh
bash /scripts/fast_dl.sh
bash /scripts/hostname.sh
bash /scripts/password.sh
bash /scripts/rcon.sh
bash /scripts/steam_id.sh
bash /scripts/bot.sh

if [[ "$FAST_DL" == "true" ]]; then
  service nginx start
fi

cd /hlds
exec ./hlds_run \
  -game cstrike \
  -strictportbind \
  -ip 0.0.0.0 \
  -port 27015 \
  +sv_lan "${SV_LAN:-0}" \
  +map "${MAP:-de_dust2}" \
  +maxplayers "${PLAYERS:-16}" \
  +sys_ticrate "${SERVER_TICK:-100}"
