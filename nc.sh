apt update -y && apt upgrade -y

sudo wget https://download.nextcloud.com/server/releases/nextcloud-20.0.1.zip

unzip nextcloud-20.0.1.zip
mv nextcloud /var/www
rm nextcloud-20.0.1.zip

mv nextcloud.conf /etc/apache2/sites-available
sudo a2ensite nextcloud.conf
sudo a2enmod rewrite headers env dir mime setenvif ssl

sudo chmod 775 -R /var/www/nextcloud/
sudo chown www-data:www-data /var/www/nextcloud/ -R

sudo systemctl restart apache2