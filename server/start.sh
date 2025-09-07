#!/bin/bash

PROPS_FILE="/minecraft/server.properties"
DEFAULT_PROPS="/minecraft/defaults/server.properties"

if [ ! -f "$PROPS_FILE" ]; then
  echo "server.properties não encontrado. Criando um padrão..."
  cp "$DEFAULT_PROPS" "$PROPS_FILE"

  if [ -n "$MINECRAFT_PORT" ]; then
    sed -i "s/^server-port=.*/server-port=$MINECRAFT_PORT/" "$PROPS_FILE"
  fi
fi

while true; do
    java -Xmx16G -Xms8G -jar fabric-server-launch.jar nogui

    if [ -d world ]; then
        cp -r world backup/world_$(date +%Y%m%d_%H%M%S)
        echo "Backup realizado com sucesso!"
    fi

    sleep 10
done
