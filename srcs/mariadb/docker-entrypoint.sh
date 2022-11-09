if [ -d "/var/lib/mysql" ]
then
	echo "Skipping configuration: /var/lib/mysql already exists"
else
	mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql > /dev/null
	echo "System tables created"
fi

echo "Starting Mariadb-server..."

/usr/bin/mysqld_safe --user=root <<EOS
ALTER USER 'root'@'localhost' IDENTIFIED BY $MYSQL_ROOT_PASSWORD;
DELETE FROM mysql.user WHERE User='';

DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';

CREATE DATABASE IF NOT EXISTS $MYSQL_DB;
CREATE USER IF NOT EXISTS $MYSQL_USER @'localhost' IDENTIFIED BY $MYSQL_PASSWORD;
GRANT ALL PRIVILEGES ON $MYSQL_DB TO $MYSQL_USER IDENTIFIED BY $MYSQL_PASSWORD;

FLUSH PRIVILEGES;
EOS
