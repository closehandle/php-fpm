FROM ubuntu:noble

RUN apt update && \
    apt full-upgrade -y && \
    apt autoremove --purge -y && \
    apt install software-properties-common -y
RUN add-apt-repository ppa:ondrej/php && \
    apt update && \
    apt install php8.0 php8.0-bcmath php8.0-cli php8.0-common php8.0-curl php8.0-fpm php8.0-gd php8.0-gmp php8.0-imagick php8.0-imap php8.0-intl php8.0-mbstring php8.0-mysql php8.0-soap php8.0-xml php8.0-xmlrpc php8.0-zip -y

ADD docker-entrypoint.sh /usr/bin/docker-entrypoint.sh
ADD docker.conf /etc/php/8.0/fpm/pool.d/docker.conf
RUN sed -E -i 's|^;?date.timezone ?= ?.*|date.timezone = Asia/Shanghai|g' /etc/php/8.0/*/php.ini && \
    sed -E -i 's|^;?post_max_size ?= ?.*|post_max_size = 100M|g' /etc/php/8.0/*/php.ini && \
    sed -E -i 's|^;?upload_max_filesize ?= ?.*|upload_max_filesize = 100M|g' /etc/php/8.0/*/php.ini && \
    sed -E -i 's|^;?max_execution_time ?= ?.*|max_execution_time = 120|g' /etc/php/8.0/*/php.ini && \
    sed -E -i 's|^;?max_input_time ?= ?.*|max_input_time = 30|g' /etc/php/8.0/*/php.ini && \
    sed -E -i 's|^;?memory_limit ?= ?.*|memory_limit = 512M|g' /etc/php/8.0/*/php.ini && \
    sed -E -i 's|^;?mysqli.max_persistent ?= ?.*|mysqli.max_persistent = 8|g' /etc/php/8.0/*/php.ini && \
    sed -E -i 's|^;?mysqli.reconnect ?= ?.*|mysqli.reconnect = On|g' /etc/php/8.0/*/php.ini && \
    sed -E -i 's|^;?short_open_tag ?= ?.*|short_open_tag = Off|g' /etc/php/8.0/*/php.ini && \
    sed -E -i 's|^;?expose_php ?= ?.*|expose_php = Off|g' /etc/php/8.0/*/php.ini && \
    sed -E -i 's|^;?opcache.enable ?= ?.*|opcache.enable = 1|g' /etc/php/8.0/*/php.ini && \
    sed -E -i 's|^;?opcache.memory_consumption ?= ?.*|opcache.memory_consumption = 512|g' /etc/php/8.0/*/php.ini && \
    sed -E -i 's|^;?opcache.interned_strings_buffer ?= ?.*|opcache.interned_strings_buffer = 128|g' /etc/php/8.0/*/php.ini && \
    sed -E -i 's|^;?opcache.max_accelerated_files ?= ?.*|opcache.max_accelerated_files = 1000000|g' /etc/php/8.0/*/php.ini && \
    sed -E -i 's|^;?opcache.validate_timestamps ?= ?.*|opcache.validate_timestamps = 0|g' /etc/php/8.0/*/php.ini && \
    sed -E -i 's|^;?session.save_path ?= ?.*|session.save_path = /tmp|g' /etc/php/8.0/*/php.ini && \
    sed -E -i 's|^;?session.cookie_lifetime ?= ?.*|session.cookie_lifetime = 1800|g' /etc/php/8.0/*/php.ini && \
    sed -E -i 's|^;?session.gc_probability ?= ?.*|session.gc_probability = 1|g' /etc/php/8.0/*/php.ini && \
    sed -E -i 's|^;?session.gc_divisor ?= ?.*|session.gc_divisor = 1000|g' /etc/php/8.0/*/php.ini && \
    sed -E -i 's|^;?session.gc_maxlifetime ?= ?.*|session.gc_maxlifetime = 1800|g' /etc/php/8.0/*/php.ini

FROM scratch
COPY --from=0 / /

ENV FPM_BIND=0.0.0.0
ENV FPM_PORT=9000

ENV FPM_START_SERVERS=8
ENV FPM_MIN_SPARE_SERVERS=8
ENV FPM_MAX_SPARE_SERVERS=128
ENV FPM_CHILDREN=128

ENTRYPOINT ["docker-entrypoint.sh"]
CMD []
