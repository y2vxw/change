FROM ghcr.io/naiba/nezha-dashboard

WORKDIR /dashboard

COPY entrypoint.sh /dashboard/

COPY sqlite.db /dashboard/data/

RUN apt-get update &&\
    apt-get -y install openssh-server wget iproute2 vim git cron unzip supervisor systemctl nginx &&\
    wget -O nezha-agent.zip https://github.com/naiba/nezha/releases/download/v0.14.11/nezha-agent_linux_amd64.zip &&\
    unzip nezha-agent.zip &&\
    wget -O cloudflared.deb https://github.com/cloudflare/cloudflared/releases/download/2023.5.0/cloudflared-linux-amd64.deb &&\
    dpkg -i cloudflared.deb &&\
    rm -f nezha-agent.zip cloudflared.deb &&\
    touch /dbfile &&\
    chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
