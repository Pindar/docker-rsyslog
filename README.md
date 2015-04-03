docker-rsyslog
==============

You can use this docker image to setup a central rsyslog server which ships all logs to an elasticsearch cluster and creates a log file per %programmname% to `/var/log/remote`.

```
docker run \
--name central-rsyslog \
-p 514:514 \
-p 514:514/udp \
-e ELASTICSEARCH_HOST=[ELASTICSEARCH_ENDPOINT, e.g. logs.example.com] \
-v /vol/logs:/var/log/remote \
pindar/docker-rsyslog
```