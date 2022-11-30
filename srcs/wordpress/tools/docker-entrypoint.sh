cd /var/www/html

if [ -f "/var/www/html/wp-config.php" ];
then
	echo "Config already exists"
else
	wp core download --path=/var/www/html
	wp config create --dbname=$DB_NAME --dbuser=$WP_ADMIN_NAME --dbhost="mariadb:3306" --dbpass=$WP_ADMIN_PASSWORD
	wp db create
	wp core install --title=wordpress --admin_user=$WP_ADMIN_NAME --admin_password=$WP_ADMIN_PASSWORD --skip-email --admin_email=tvogel@student.42.fr --url=https://tvogel.42.fr --path=/var/www/html

	wp user update $WP_ADMIN_NAME --user_pass=$WP_ADMIN_PASSWORD
	wp user create $WP_USER $WP_USER@42.fr --user_pass=$WP_USER_PASSWORD --role=author --porcelain
fi
chmod -R 755 /var/www/html
chown -R www-data:www-data /var/www/html

exec "$@"
