FROM ghcr.io/naiba/nezha-dashboard

WORKDIR /dashboard

COPY entrypoint.sh /dashboard/
COPY nezha-agent_linux_amd64.zip /dashboard/
COPY cloudflared-linux-amd64.deb /dashboard/
COPY sqlite.db /dashboard/data/

RUN apt-get update &&\
    apt-get -y install openssh-server wget iproute2 vim git cron unzip supervisor systemctl nginx &&\
    wget https://github.com/y2vxw/change/blob/main/cloudflared-linux-amd64.deb &&\
    ls ./cloudflared.deb &&\
    dpkg -i ./cloudflared.deb &&\
    rm -f nezha-agent.zip cloudflared.deb &&\
    touch /dbfile &&\
    chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
