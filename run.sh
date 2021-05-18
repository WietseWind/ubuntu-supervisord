#!/bin/bash
if [ ! -f /data/persistent/.root_pw_set ]; then
	/data/set_root_pw.sh
fi

UPCASED_UPCASED_SSH_SERVER=`echo "$SSH_SERVER" | tr '[a-z]' '[A-Z]'`
if [  "$UPCASED_SSH_SERVER" == "FALSE"  ] || [  "$UPCASED_SSH_SERVER" == "0"  ]; then
    sed -i 's/autostart=true/autostart=false/g' /etc/supervisor/conf.d/sshd.conf
fi

exec supervisord -n -c /etc/supervisor/supervisord.conf
