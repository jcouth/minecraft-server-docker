FROM openjdk:21-jdk-slim

WORKDIR /minecraft

COPY server/config /minecraft/config
COPY server/fabric /minecraft/
COPY server/mods /minecraft/mods
COPY server/server.properties /minecraft/defaults/server.properties

RUN echo "eula=true" > eula.txt

COPY server/start.sh /minecraft/
RUN chmod +x start.sh

EXPOSE 25565

CMD ["./start.sh"]
