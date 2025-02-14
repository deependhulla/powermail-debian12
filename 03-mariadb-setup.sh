#!/bin/bash


systemctl stop  mariadb

## get latest stable Version from direct mariadb
curl -LsS https://r.mariadb.com/downloads/mariadb_repo_setup | sudo bash -s -- --mariadb-server-version="mariadb-10.11"
apt-get -y install mariadb-server mariadb-client mariadb-backup

systemctl start mariadb

sed -i "s/LimitNOFILE=32768/LimitNOFILE=62768/"   /usr/lib/systemd/system/mariadb.service
systemctl daemon-reload

MYSQLPASSVPOP=`pwgen -c -1 8`
echo $MYSQLPASSVPOP > /usr/local/src/mariadb-mydbadmin-pass
echo "mydbadmin password in /usr/local/src/mariadb-mydbadmin-pass"

echo "GRANT ALL PRIVILEGES ON *.* TO mydbadmin@localhost IDENTIFIED BY '$MYSQLPASSVPOP'" with grant option | mysql -uroot
mysqladmin -uroot reload
mysqladmin -uroot refresh

systemctl restart  mariadb

#mysqladmin -u root -ptmppassword status
#mysqladmin -u root -p extended-status
#mysqladmin -u root -p processlist

echo "Database Password Setup done."
