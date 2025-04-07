#!/bin/sh

pkill -f /opt/vdi-client/bin/desktop-client
exec /usr/bin/xrdp-run &
exec /opt/vdi-client/bin/desktop-client
