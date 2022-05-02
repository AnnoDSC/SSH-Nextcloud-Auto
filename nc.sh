apt update -y && apt upgrade -y

sudo wget https://download.nextcloud.com/server/releases/nextcloud-20.0.1.zip

unzip nextcloud-20.0.1.zip
mv nextcloud /var/www
rm nextcloud-20.0.1.zip

echo -e '
Alias /nextcloud "/var/www/nextcloud/"

<Directory /var/www/nextcloud/>
  Options +FollowSymlinks
  AllowOverride All

 <IfModule mod_dav.c>
  Dav off
 </IfModule>

 SetEnv HOME /var/www/nextcloud
 SetEnv HTTP_HOME /var/www/nextcloud

</Directory>
' >> /etc/apache2/sites-available/nextcloud.conf

sudo a2ensite nextcloud.conf
sudo a2enmod rewrite headers env dir mime setenvif ssl

sudo chmod 775 -R /var/www/nextcloud/
sudo chown www-data:www-data /var/www/nextcloud/ -R

sudo systemctl restart apache2