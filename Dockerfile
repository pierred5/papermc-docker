FROM openjdk:17-bullseye
#ENTRYPOINT exec /bin/bash
WORKDIR /root
# Download required packages and install MinecraftServerControl/mscs git repo
RUN set -ex; apt-get update ; \
    apt-get install --no-install-recommends -y \
        git libjson-perl libwww-perl rdiff-backup rsync socat sudo make ; \
    git clone --depth=1 "https://github.com/MinecraftServerControl/mscs.git" ; \
    rm -rf mscs/.git* ; cd ./mscs/ ; make
# Create default world
WORKDIR /opt/mscs
RUN set -ex; mscs create world1 ; mscs start world1 ; \
    sleep 5s; \
    sed -i -e '/eula/s/false/true/' worlds/world1/eula.txt;
# Start world when container starts
COPY ./start_mc.sh /opt/mscs/
CMD ["./start_mc.sh"]
