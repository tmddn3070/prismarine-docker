FROM amazoncorretto:17-alpine3.15-jdk

ARG Prismarine_url=https://github.com/PrismarineTeam/Prismarine/releases/download/latest/Prismarine-paperclip-1.18.2-R0.1-SNAPSHOT-reobf.jar
ENV Prismarine_get_url=$Prismarine_url

WORKDIR /data

ADD ${Prismarine_url} Prismarine-paperclip-1.18.2-R0.1-SNAPSHOT-reobf.jar

RUN wget 

WORKDIR /data

VOLUME "/data"

EXPOSE 25565/tcp
EXPOSE 25565/udp

ARG memory_size=1G
ENV MEMORYSIZE=$memory_size

ARG java_flags="-Dterminal.jline=false -Dterminal.ansi=true -Djline.terminal=jline.UnsupportedTerminal -Dlog4j2.formatMsgNoLookups=true -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -Dcom.mojang.eula.agree=true --add-modules=jdk.incubator.vector"
ENV JAVAFLAGS=$java_flags

WORKDIR /data

ENTRYPOINT java -Xms$MEMORYSIZE -Xmx$MEMORYSIZE $JAVAFLAGS -jar /data/Prismarine-paperclip-1.18.2-R0.1-SNAPSHOT-reobf.jar --nojline nogui
