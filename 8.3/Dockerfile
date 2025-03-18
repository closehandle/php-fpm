FROM ubuntu:noble

RUN apt update && \
    apt full-upgrade -y && \
    apt autoremove --purge -y && \
    apt install software-properties-common -y
RUN add-apt-repository ppa:ondrej/php && \
    apt update && \
    apt install php8.3 php8.3-bcmath php8.3-cli php8.3-common php8.3-curl php8.3-fpm php8.3-gd php8.3-gmp php8.3-imagick php8.3-imap php8.3-intl php8.3-mbstring php8.3-mysql php8.3-soap php8.3-xml php8.3-xmlrpc php8.3-zip -y

ADD https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz /ioncube_loaders_lin_x86-64.tar.gz
RUN tar xf ioncube_loaders_lin_x86-64.tar.gz && rm -f ioncube_loaders_lin_x86-64.tar.gz && mv -f ioncube/ioncube_loader_lin_8.3.so /usr/lib/php/20230831/ioncube_loader.so && rm -fr ioncube && \
    echo 'zend_extension = ioncube_loader.so' > /etc/php/8.3/mods-available/ioncube.ini && \
    ln -fs /etc/php/8.3/mods-available/ioncube.ini /etc/php/8.3/cli/conf.d/00-ioncube.ini && \
    ln -fs /etc/php/8.3/mods-available/ioncube.ini /etc/php/8.3/fpm/conf.d/00-ioncube.ini

ADD docker-entrypoint.sh /usr/bin/docker-entrypoint.sh
ADD docker.conf /etc/php/8.3/fpm/pool.d/docker.conf
RUN sed -E -i 's|^;?date.timezone ?= ?.*|date.timezone = Asia/Shanghai|g' /etc/php/8.3/*/php.ini && \
    sed -E -i 's|^;?post_max_size ?= ?.*|post_max_size = 100M|g' /etc/php/8.3/*/php.ini && \
    sed -E -i 's|^;?upload_max_filesize ?= ?.*|upload_max_filesize = 100M|g' /etc/php/8.3/*/php.ini && \
    sed -E -i 's|^;?max_execution_time ?= ?.*|max_execution_time = 120|g' /etc/php/8.3/*/php.ini && \
    sed -E -i 's|^;?max_input_time ?= ?.*|max_input_time = 30|g' /etc/php/8.3/*/php.ini && \
    sed -E -i 's|^;?memory_limit ?= ?.*|memory_limit = 512M|g' /etc/php/8.3/*/php.ini && \
    sed -E -i 's|^;?mysqli.max_persistent ?= ?.*|mysqli.max_persistent = 8|g' /etc/php/8.3/*/php.ini && \
    sed -E -i 's|^;?mysqli.reconnect ?= ?.*|mysqli.reconnect = On|g' /etc/php/8.3/*/php.ini && \
    sed -E -i 's|^;?short_open_tag ?= ?.*|short_open_tag = Off|g' /etc/php/8.3/*/php.ini && \
    sed -E -i 's|^;?expose_php ?= ?.*|expose_php = Off|g' /etc/php/8.3/*/php.ini && \
    sed -E -i 's|^;?opcache.enable ?= ?.*|opcache.enable = 1|g' /etc/php/8.3/*/php.ini && \
    sed -E -i 's|^;?opcache.memory_consumption ?= ?.*|opcache.memory_consumption = 512|g' /etc/php/8.3/*/php.ini && \
    sed -E -i 's|^;?opcache.interned_strings_buffer ?= ?.*|opcache.interned_strings_buffer = 128|g' /etc/php/8.3/*/php.ini && \
    sed -E -i 's|^;?opcache.max_accelerated_files ?= ?.*|opcache.max_accelerated_files = 1000000|g' /etc/php/8.3/*/php.ini && \
    sed -E -i 's|^;?opcache.validate_timestamps ?= ?.*|opcache.validate_timestamps = 0|g' /etc/php/8.3/*/php.ini && \
    sed -E -i 's|^;?session.save_path ?= ?.*|session.save_path = /tmp|g' /etc/php/8.3/*/php.ini && \
    sed -E -i 's|^;?session.cookie_lifetime ?= ?.*|session.cookie_lifetime = 1800|g' /etc/php/8.3/*/php.ini && \
    sed -E -i 's|^;?session.gc_probability ?= ?.*|session.gc_probability = 1|g' /etc/php/8.3/*/php.ini && \
    sed -E -i 's|^;?session.gc_divisor ?= ?.*|session.gc_divisor = 1000|g' /etc/php/8.3/*/php.ini && \
    sed -E -i 's|^;?session.gc_maxlifetime ?= ?.*|session.gc_maxlifetime = 1800|g' /etc/php/8.3/*/php.ini

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
