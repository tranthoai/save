#!/bin/bash
runningStatus="RUNNING"

gagaNodeToken() {
    echo "jjhtpymiucjudihl2d8a1d29437cd191"
}

mesonNetworkToken() {
    echo "nkpymvgwzighorbi5f92c440853b6000"
}

apphubStatus() {
    sudo ./apphub status
}

echo "----------START GAGANODE----------" && \
cd ~ && \
sudo rm -rf apphub-linux-amd64/ && \
curl -o apphub-linux-amd64.tar.gz https://assets.coreservice.io/public/package/60/app-market-gaga-pro/1.0.4/app-market-gaga-pro-1_0_4.tar.gz && \
tar -zxf apphub-linux-amd64.tar.gz && \
rm -rf apphub-linux-amd64.tar.gz &&\
cd ./apphub-linux-amd64 && \
sudo ./apphub service remove && \
sudo ./apphub service install && \
sudo ./apphub service start && \
sudo ./apphub status

while true

    do
        echo $(apphubStatus)
            
        if [[ $(apphubStatus) == *$runningStatus* ]]
            then
                echo "GAGANODE IS RUNNING, SET TOKEN NOW."
                break
        fi

        sleep 1
done

sudo ./apps/gaganode/gaganode config set --token=$(gagaNodeToken) && \
sudo ./apphub restart && \
sudo ./apphub status && \
sudo ./apps/gaganode/gaganode config get_json && \
echo "----------DONE GAGANODE----------"


sleep 1

echo "----------START MESON NETWORK----------" && \
cd ~ && \
sudo rm -rf meson_cdn-linux-amd64/ && \
curl -o meson_cdn-linux-amd64.tar.gz 'https://staticassets.meson.network/public/meson_cdn/v3.1.20/meson_cdn-linux-amd64.tar.gz' && \
tar -zxf meson_cdn-linux-amd64.tar.gz && \
rm -rf meson_cdn-linux-amd64.tar.gz && \
cd ./meson_cdn-linux-amd64

# Remove exists service
sudo ./service remove meson_cdn

sudo ./service install meson_cdn && \
sudo ./service start meson_cdn && \
sudo ./service status meson_cdn && \
sudo ./meson_cdn config set --token=$(mesonNetworkToken) --https_port=443 --cache.size=30 && \
sudo ./service restart meson_cdn && \
sudo ./service status meson_cdn && \
sudo ./meson_cdn config show && \
echo "----------DONE MESON NETWORK----------"
