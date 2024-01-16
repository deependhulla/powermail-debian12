#!/bin/sh

## for Development of checking Database in details.

wget -c "https://files.phpmyadmin.net/phpMyAdmin/5.2.1/phpMyAdmin-5.2.1-english.tar.gz" -O /tmp/phpMyAdmin-5.2.1-english.tar.gz
cd /tmp
tar -xzf phpMyAdmin-5.2.1-english.tar.gz 
cd -
mv  /tmp/phpMyAdmin-5.2.1-english /var/www/html/dbadminonweb 2>/dev/null 1>/dev/null

cp /var/www/html/dbadminonweb/config.sample.inc.php /var/www/html/dbadminonweb/config.inc.php

chown -R www-data:www-data /var/www/html/dbadminonweb

sed -i "s/\$cfg\['blowfish_secret'\] = '';/\$cfg\['blowfish_secret'\] = '`pwgen -c 32 1`';/" /var/www/html/dbadminonweb/config.inc.php
echo "PHPMyAdmin installed as : https://`hostname -f`/dbadminonweb/"
