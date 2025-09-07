#!/bin/bash
# Inicializa o servidor Fabric garantindo server.properties

# Caminho do server.properties
PROPS_FILE="/minecraft/server.properties"

# Se não existir, cria um básico
if [ ! -f "$PROPS_FILE" ]; then
  echo "server.properties não encontrado. Criando um padrão..."
  cat > "$PROPS_FILE" <<EOL
enable-rcon=true
rcon.port=25575
rcon.password=minha_senha_segura
server-port=25565
server-ip=
motd=Servidor Fabric no Docker
max-players=20
online-mode=true
level-name=world
difficulty=normal
gamemode=survival
spawn-protection=16
view-distance=10
simulation-distance=10
pvp=true
allow-flight=false
EOL
fi

Loop principal para reiniciar o servidor se cair
while true; do
    java -Xmx16G -Xms8G -jar fabric-server-launch.jar nogui

    # Backup automático da pasta world
    if [ -d world ]; then
        cp -r world backups/world_$(date +%Y%m%d_%H%M%S)
        echo "Backup realizado com sucesso!"
    fi

    sleep 10
done
