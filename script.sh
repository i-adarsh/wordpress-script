#!/usr/bin/bash

sudo apt update -y

sudo apt clean metadata

sudo apt-get install -y php8.1 php8.1-cli php8.1-fpm php8.1-mysql php8.1-opcache php8.1-mbstring php8.1-xml php8.1-gd php8.1-curl
php -v

sudo apt install -y apache2 mariadb-server phpmyadmin

sudo systemctl enable apache2 --now

sudo systemctl enable mariadb --now

sudo mysql_secure_installation

create database wordpress;
create user 'admin'@'localhost' identified by 'pass@word';
grant all on wordpress.* to 'admin'@'localhost';
FLUSH PRIVILEGES;

wget https://wordpress.org/latest.tar.gz
sudo chown -R apache /var/www
sudo chgrp -R apache /var/www
sudo chmod 2775 /var/www
sudo mkdir -p /var/www/html/
sudo tar -xzvf latest.tar.gz -C /var/www/html/

cd /var/www/html/

sudo ln -s /usr/share/phpmyadmin .

sudo chown -R apache /var/www
sudo chgrp -R apache /var/www
find /var/www -type d -exec sudo chmod 2775 {} \;
find /var/www -type f -exec sudo chmod 0644 {} \;

cd /var/www/html/

sudo mv wordpress/* .
sudo chown -R apache:apache *
sudo chown -R 2775 *

sudo systemctl restart httpd
