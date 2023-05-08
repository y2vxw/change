FROM ghcr.io/naiba/nezha-dashboard

WORKDIR /dashboard

COPY entrypoint.sh /dashboard/
COPY nezha-agent_linux_amd64.zip /dashboard/
COPY cloudflared-linux-amd64.deb /dashboard/
COPY sqlite.db /dashboard/data/

RUN apt-get update &&\
    apt-get -y install openssh-server wget iproute2 vim git cron unzip supervisor systemctl nginx &&\
    ls
    pwd
    unzip /dashboard/nezha-agent.zip &&\
    dpkg -i /dashboard/cloudflared.deb &&\
    rm -f /dashboard/nezha-agent.zip /dashboard/cloudflared.deb &&\
    touch /dbfile &&\
    chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
