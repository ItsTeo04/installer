#!/bin/bash

# source  <(curl -s https://raw.githubusercontent.com/VertisanPRO/wemx-installer/web/src/nginx.sh)
apt -y install software-properties-common curl apt-transport-https ca-certificates gnupg
LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php
curl -sS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | sudo bash
apt update
echo | apt-add-repository universe
apt -y install php8.1 php8.1-{common,cli,gd,mysql,mbstring,bcmath,xml,fpm,curl,zip} mariadb-server nginx tar unzip git
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
export COMPOSER_ALLOW_SUPERUSER=1
cd /var/www
composer create-project laravel/laravel wemx -n
cd /var/www/wemx
composer require wesex/installer dev-web -n
php artisan wemx:setup nginx --type=dev
php artisan module:enable >> /dev/null 2>&1
php artisan module:update >> /dev/null 2>&1
php artisan migrate --force >> /dev/null 2>&1
php artisan wemx:chown >> /dev/null 2>&1

