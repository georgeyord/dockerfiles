#! /bin/sh

echo "Vagrant agent credetnials: ${VAGENT_USERNAME}/${VAGENT_SEVRET}"
echo ${VAGENT_USERNAME}:${VAGENT_SEVRET} > /etc/varnish/agent_secret

echo "Reading the source files"
source /etc/varnish/varnish.params

echo Binding to $VARNISH_LISTEN_ADDRESS:$VARNISH_LISTEN_PORT

/usr/sbin/varnishd \
    -P /var/run/varnish.pid \
    -f $VARNISH_VCL_CONF \
    -a $VARNISH_LISTEN_ADDRESS:$VARNISH_LISTEN_PORT \
    -T $VARNISH_ADMIN_LISTEN_ADDRESS:$VARNISH_ADMIN_LISTEN_PORT \
    -t $VARNISH_TTL \
    -u $VARNISH_USER \
    -g $VARNISH_GROUP \
    -S $VARNISH_SECRET_FILE \
    -s $VARNISH_STORAGE \
    $DAEMON_OPTS &

varnish-agent -K /etc/varnish/agent_secret start -d
