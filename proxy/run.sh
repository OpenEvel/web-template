#!/bin/sh
# 1. Задаём настройки nginx для получения первого сертификата
cp /app/first.conf /etc/nginx/conf.d/default.conf

# 2. Запускаем nginx в фоновом режиме, чтобы можно было запустить certbot
nginx -g 'daemon on;'

# 3. Получаем/обновляем/используем старые сертификаты от certbot
# Если сертификатов еще не было (папки с сертификатами не существует)
if [ ! -f /etc/letsencrypt/live/${DOMAIN}/fullchain.pem ] || [ ! -f /etc/letsencrypt/live/${DOMAIN}/privkey.pem ]; then
    # то получаем их впервые
    certbot certonly --webroot --webroot-path=/certbot --register-unsafely-without-email --agree-tos -d ${DOMAIN}
fi

# 4. на всякий случай пытаемся обновить существующий сертификат
# Если еще рано его обновлять, то ничего делать не будет
certbot renew

# 5. Останавливаем nginx, чтобы потом запустить его НЕ в фоновом режиме
nginx -s stop

# 6. Задаем конфиг nginx для использования ssl
envsubst < ./prod.conf > /etc/nginx/conf.d/default.conf

# 7. Запускаем cron для ежедневной проверки сертификатов
crond -b -l 8 -L /app/cron.log

# 8. Запуск nginx в интерактивном режиме
# Теперь nginx главные процесс, если с ним что-то случится, то контейнер перезапустится
nginx -g 'daemon off;'
