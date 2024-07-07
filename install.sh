#!/bin/ash
# NextCloud Installation Script

apk update
apk add wget unzip

cd /mnt/server
wget -O nextcloud.zip https://download.nextcloud.com/server/releases/latest.zip --no-check-certificate
unzip nextcloud.zip
mkdir web
mv nextcloud/* web/
mv nextcloud/.htaccess web/
mv nextcloud/.user.ini web/
rm -rf nextcloud/
rm -rf nextcloud.zip

sed -i '/use OC\\Encryption\\HookManager/i\session_save_path("/home/container/tmp");' web/lib/base.php
mkdir tmp
