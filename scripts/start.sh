#!/bin/bash

if ! [[ "$ELASTICSEARCH_HOST" == "" ]]; then
  echo "INFO: set elasticsearch endpoint to $ELASTICSEARCH_HOST"
  sed -i "s/server=\"localhost\"/server=\"$ELASTICSEARCH_HOST\"/" /etc/rsyslog.d/$RSYSLOG_CENTRAL_CONF
else
  echo "ERROR: please set the ELASTICSEARCH_HOST environment variable";
  exit 1;
fi

exec /usr/sbin/rsyslogd -n