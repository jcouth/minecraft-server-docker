# Base com OpenJDK 21
FROM openjdk:21-jdk-slim

# Pasta de trabalho dentro do container
WORKDIR /minecraft

COPY fabric-server-launch.jar .

COPY fabric-server-launcher.properties .

COPY server.jar .

COPY libraries ./libraries

COPY mods ./mods

# Aceita o EULA automaticamente
RUN echo "eula=true" > eula.txt

# Instalar rcon-cli
RUN apt-get update && apt-get install -y wget unzip \
  && wget https://github.com/itzg/rcon-cli/releases/download/1.6.2/rcon-cli_1.6.2_linux_amd64.tar.gz \
  && tar -xvf rcon-cli_1.6.2_linux_amd64.tar.gz -C /usr/local/bin \
  && rm rcon-cli_1.6.2_linux_amd64.tar.gz

# Copia script de inicialização
COPY start.sh .
RUN chmod +x start.sh

# Expõe portas do Minecraft e RCON
EXPOSE 25565
EXPOSE 25575

# Comando para iniciar o servidor
CMD ["./start.sh"]
