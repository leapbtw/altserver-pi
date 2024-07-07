FROM debian:stable

WORKDIR /opt

RUN apt update
RUN apt install curl libavahi-compat-libdnssd-dev avahi-daemon python3 -y

RUN curl -L --output altserver $(curl -s https://api.github.com/repos/NyaMisty/AltServer-Linux/releases/latest | grep browser_download_url | grep aarch64 | cut -d '"' -f 4 | head -n 1)
RUN chmod +x altserver

RUN curl -L --output netmuxd $(curl -s https://api.github.com/repos/jkcoxson/netmuxd/releases/latest | grep browser_download_url | grep aarch64 | cut -d '"' -f 4 | head -n 1)
RUN chmod +x netmuxd

RUN mkdir -p /run/dbus
RUN mkdir -p /var/lib/lockdown
COPY *.plist /var/lib/lockdown/

COPY startup_script.sh /opt/startup_script.sh
RUN chmod +x /opt/startup_script.sh

ENV ALTSERVER_ANISETTE_SERVER=http://127.0.0.1:6969/

ENTRYPOINT ["/bin/sh", "-c", "/opt/startup_script.sh"]
