if [ -d "/var/lib/mysql" ]
then
	echo "skipping configuration: /var/lib/mysql already exists"
else
	mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql > /dev/null
	echo "System tables created"
fi

echo "Starting Mariadb-server..."

/usr/bin/mysqld --user=root <<EOS
ALTER USER 'root'@'localhost' IDENTIFIED BY $MYSQL_ROOT_PASSWORD;
DELETE FROM mysql.user WHERE User='';

DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';

FLUSH PRIVILEGES;
EOS
