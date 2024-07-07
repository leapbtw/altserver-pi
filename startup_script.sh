dbus-daemon --system --fork
avahi-daemon -D

sleep 1
echo "\nALTSERVER_ANISETTE_SERVER=$ALTSERVER_ANISETTE_SERVER\n"
if [ -f /var/run/avahi-daemon/pid ]; then
    echo "Avahi daemon is running"
else
    echo "Avahi daemon is not running"
fi

/opt/netmuxd &
env ALTSERVER_ANISETTE_SERVER=$ALTSERVER_ANISETTE_SERVER /opt/altserver
