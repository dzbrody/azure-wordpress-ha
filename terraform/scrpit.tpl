#!/bin/bash
export HOME="/root"
export WP_INSTALL_PATH="/var/www/html"
export WP_INSTALL_LOCK_FILE="/tmp/wp_install.lock"
#Mount nfs share
mkdir -p /var/www/html

#NFS
apt-get -y update
sleep 30
apt-get install nfs-common -y

bash -c 'echo "samylab.blob.core.windows.net:/samylab/wordpress-content /var/www/html nfs sec=sys,vers=3,nolock,proto=tcp" >> /etc/fstab'
mount -a

# Install wordpress if not already installed
if [ -z "$(ls -A $WP_INSTALL_PATH)" ]; then
  echo "Wordpress installation directory is empty. Installing it now"
  if [ -f "$WP_INSTALL_LOCK_FILE" ]; then
    echo "Lock file already exists"
  else
    echo "Lock file does not exist. Proceeding with installation"
    touch "$WP_INSTALL_LOCK_FILE"
    wget http://wordpress.org/latest.tar.gz
    tar xvf latest.tar.gz -C $WP_INSTALL_PATH --strip-components=1
    rm "$WP_INSTALL_LOCK_FILE"
  fi
else
   echo "Wordpress installation directory is not empty. skipping..."
fi

#install php and composer

apt install php8.1-fpm php8.1-cli php8.1-common php8.1-mbstring php8.1-xmlrpc php8.1-soap php8.1-gd php8.1-xml php8.1-intl php8.1-mysql php8.1-cli php8.1-ldap php8.1-zip php8.1-curl php8.1-opcache php8.1-readline php8.1-xml php8.1-gd php8.1-imagick -y

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar /usr/local/bin/composer

#Install and configure apache
apt install -y apache2 libapache2-mod-php

a2enmod rewrite
cat <<EOF >> /etc/apache2/apache2.conf
<Directory /var/www/html/>
        AllowOverride All
</Directory>
EOF
chown -R www-data:www-data /var/www/html
systemctl enable apache2
systemctl restart apache2

# Restart agent to remotely execute commands
systemctl restart walinuxagent
