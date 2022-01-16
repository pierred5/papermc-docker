FROM openjdk:17-bullseye
#ENTRYPOINT exec /bin/bash
WORKDIR /root
# Download required packages and install MinecraftServerControl/mscs git repo
RUN set -ex; apt-get update ; \
    apt-get install --no-install-recommends -y \
        git libjson-perl libwww-perl rdiff-backup rsync socat sudo make ; \
    git clone --depth=1 "https://github.com/MinecraftServerControl/mscs.git" ; \
    rm -rf mscs/.git* ; cd ./mscs/ ; make

# Create default world. Default called world
ARG WORLDNAME=world
WORKDIR /opt/mscs
RUN set -ex; mscs create $WORLDNAME;
COPY eula.txt worlds/$WORLDNAME/
RUN sed -i -e "1a#$(date)" worlds/$WORLDNAME/eula.txt

# Start world when container starts
COPY start_mc.sh /opt/mscs/
CMD ["./start_mc.sh"]
