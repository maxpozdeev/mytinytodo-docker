#!/bin/bash
set -Eeo pipefail
#set -u

if [[ "$1" == apache2* ]] || [ "$1" = 'php-fpm' ]; then
    uid="$(id -u)"
    gid="$(id -g)"
    #echo >&2 "Running as $uid:$gid with $@"

    if [ ! -e index.php ]; then
        echo >&2 "myTinyTodo not found, copying..."
        tar -xzf /usr/src/mytinytodo.tar.gz --strip-components 1 -C ./
        if [ "$uid" = '0' ]; then
            chown -R www-data:www-data * || true
        fi
    fi

    # By default config.php is created while setup.
    # In docker we can make it manually to use env vars for database connection, setup will only create database tables.
    # We place config file in db folder and symlink it to the root to keep it safe while further mtt version upgrade.
    if [[ "$MTT_DB_TYPE" != '' && ! -e db/docker-config.php ]]; then
        echo >&2 "Creating docker-config.php..."
        rnd="$(head -c1m /dev/urandom | sha1sum | head -c40)"
        cat /usr/src/docker-config.php | sed "s/Put Random Text Here/$rnd/g" > db/docker-config.php 
        if [ "$uid" = '0' ]; then
            chown -R www-data:www-data db/docker-config.php  || true
        fi
    fi 
    if [[ -e db/docker-config.php && ! -e config.php ]]; then
        echo >&2 "Linking config.php..."
        ln -s db/docker-config.php config.php
        if [ "$uid" = '0' ]; then
            chown -R www-data:www-data config.php  || true
        fi
    fi

fi

exec "$@"