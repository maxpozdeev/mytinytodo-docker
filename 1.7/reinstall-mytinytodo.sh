#!/bin/bash
set -Eeo pipefail

cd /var/www/html

# remove all files and folders excepting db/ and config.php
find . -maxdepth 1 ! -name db ! -name config.php ! -name . -exec rm -rf "{}" \;

# db/todolist.db and config.php are not present in archive, should not be overwritten even without -k flag.
tar -xzf -k /usr/src/mytinytodo.tar.gz --strip-components 1 

if [[ "$MTT_DB_TYPE" != '' && ! -e db/docker-config.php ]]; then
    rnd="$(head -c1m /dev/urandom | sha1sum | head -c40)"
    cat /usr/src/docker-config.php | sed "s/Put Random Text Here/$rnd/g" > db/docker-config.php 
fi

if [[ -e db/docker-config.php && ! -e config.php ]]; then
    ln -s db/docker-config.php config.php
fi

chown -R www-data:www-data * || true