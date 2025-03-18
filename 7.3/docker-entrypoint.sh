#!/usr/bin/env bash
cat << EOF > /etc/php/7.3/fpm/pool.d/www.conf
[www]
user = root
group = root
listen = $FPM_BIND:$FPM_PORT
listen.backlog = -1

pm = dynamic
pm.start_servers = $FPM_START_SERVERS
pm.min_spare_servers = $FPM_MIN_SPARE_SERVERS
pm.max_spare_servers = $FPM_MAX_SPARE_SERVERS
pm.max_children = $FPM_CHILDREN
pm.max_requests = 1024
request_terminate_timeout = 120
request_slowlog_timeout = 0
EOF

exec php-fpm7.3 -R
