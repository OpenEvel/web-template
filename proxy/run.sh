#!/bin/sh

# 1. Получаем/обновляем/используем старые сертификаты от certbot
# Если сертификатов еще не было (папки с сертификатами не существует)
if [[ ! -d /etc/letsencrypt/live/${domain}/ ]]; then
    # то получаем их впервые
    certbot certonly --standalone --webroot --webroot-path=/certbot --register-unsafely-without-email --agree-tos -d $domain
fi
    
# 2. на всякий случай пытаемся обновить существующий сертификат
# Если еще рано его обновлять, то ничего делать не будет
certbot renew

# 3. Запускаем cron для ежедневной проверки сертификатов
crond -b -l 8 -L /app/cron.log

# 4. Запуск nginx в интерактивном режиме
# Теперь nginx главные процесс, если с ним что-то случится, то контейнер перезапустится
nginx -g 'daemon off;'
