apt update -y && apt upgrade -y

sudo wget https://download.nextcloud.com/server/releases/nextcloud-20.0.1.zip

unzip nextcloud-20.0.1.zip
mv nextcloud /var/www
rm nextcloud-20.0.1.zip

echo -e '
<VirtualHost *:80>
     ServerAdmin master@domain.com
     DocumentRoot /var/www/nextcloud/
     ServerName demo.domain.com
     ServerAlias www.demo.domain.com
  
     Alias /nextcloud "/var/www/nextcloud/"
     <Directory /var/www/nextcloud/>
        Options +FollowSymlinks
        AllowOverride All
        Require all granted
          <IfModule mod_dav.c>
            Dav off
          </IfModule>
        SetEnv HOME /var/www/nextcloud
        SetEnv HTTP_HOME /var/www/nextcloud
     </Directory>
     ErrorLog ${APACHE_LOG_DIR}/error.log
     CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
' >> /etc/apache2/sites-available/nextcloud.conf

a2ensite nextcloud.conf
a2enmod rewrite
a2enmod headers
a2enmod env
a2enmod dir
a2enmod mime

sudo chmod 775 -R /var/www/nextcloud/
sudo chown www-data:www-data /var/www/nextcloud/ -R

sudo systemctl restart apache2