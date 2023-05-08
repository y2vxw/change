FROM ghcr.io/naiba/nezha-dashboard

WORKDIR /dashboard
EXPOSE 80
COPY entrypoint.sh /dashboard/
COPY nezha-agent_linux_amd64.zip /dashboard/tem/
COPY nezha-agent /dashboard/
COPY cloudflared-linux-amd64.deb /dashboard/tem/
COPY sqlite.db /dashboard/data/
EXPOSE 5555
RUN apt-get update &&\
    apt-get -y install openssh-server wget iproute2 vim git cron unzip supervisor systemctl nginx &&\
    ls ./tem &&\
    dpkg -i ./tem/*.deb &&\
    ls &&\
    touch /dbfile &&\
    chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
