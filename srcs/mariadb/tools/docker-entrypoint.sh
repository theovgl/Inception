if [ -d "/var/lib/mysql/mysql" ]
then
	echo "Skipping configuration: /var/lib/mysql already exists"
else
	chown -R mysql:mysql /var/lib/mysql
	mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql > /dev/null
	echo "System tables created"
fi

echo "Starting Mariadb-server..."

cd /usr ; /usr/bin/mysqld_safe --skip-grant-tables --datadir=/var/lib/mysql --user=mysql<<EOS
ALTER USER 'root'@'%' IDENTIFIED BY $MYSQL_ROOT_PASSWORD;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';
CREATE DATABASE $DB_NAME;
CREATE USER $MYSQL_ADMIN_NAME@'%' IDENTIFIED BY $MYSQL_ADMIN_PASSWORD;
GRANT ALL PRIVILEGES ON $DB_NAME.* TO $MYSQL_ADMIN_NAME@'%';
SHOW DATABASES;
FLUSH PRIVILEGES;
EOS

