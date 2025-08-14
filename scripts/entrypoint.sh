#!/bin/bash
set -e

bash /scripts/cstrike.sh

MODULES=("rehlds" "metamod" "amxmodx" "fastdl")

for module in "${MODULES[@]}"; do
  varname=$(echo "$module" | tr '[:lower:]' '[:upper:]')
  value="${!varname}"
  if [[ "$value" == "true" ]]; then
    bash "/scripts/${module}.sh"
  fi
done

bash /scripts/bots.sh
bash /scripts/administration.sh

if [[ "$FASTDL" == "true" ]]; then
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
  +maxplayers "${PLAYERS:-16}"
