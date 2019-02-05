#!/usr/bin/env sh
set -e

# assign default id if user not set
echo "USER_GID: "${USER_GID:-9001}
echo "USER_UID: "${USER_UID:-9001}

## Change UID and GID for USER?
if [ -n "${USER_UID}" ]; then
    if [ -n "${USER_GID}" ]; then
        echo "-> change USER_UID and USER_GID"
        sed -i -e "s/^${HUGO_USER}:\([^:]*\):[0-9]*/${HUGO_USER}:\1:${USER_GID}/" /etc/group
        sed -i -e "s/^${HUGO_USER}:\([^:]*\):\([0-9]*\):[0-9]*/${HUGO_USER}:\1:\2:${USER_GID}/" /etc/passwd    
        sed -i -e "s/^${HUGO_USER}:\([^:]*\):[0-9]*:\([0-9]*\)/${HUGO_USER}:\1:${USER_UID}:\2/" /etc/passwd
        #chown -R --dereference -L ${HUGO_USER}:${HUGO_GROUP} ${HUGO_HOME}
    fi
fi

HUGO=/usr/local/sbin/hugo
echo "Hugo path: $HUGO"
echo "ARGS:      $@"

su-exec ${HUGO_USER} $@