#!/bin/sh

# 1. Получаем/обновляем/используем старые сертификаты от certbot
# Если сертификатов еще не было (папки с сертификатами не существует)
if [[ ! -d /etc/letsencrypt/live/${DOMAIN}/privkey.pem ]]; then
    # то получаем их впервые
    certbot certonly --standalone --webroot --webroot-path=/certbot --register-unsafely-without-email --agree-tos -d ${DOMAIN}
fi



# 2. Запускаем cron для ежедневной проверки сертификатов
crond -b -l 8 -L /app/cron.log

# 3. Задаем конфиг nginx для использования ssl
envsubst < ./nginx.conf > /etc/nginx/conf.d/default.conf

# 4. Запуск nginx в интерактивном режиме
# Теперь nginx главные процесс, если с ним что-то случится, то контейнер перезапустится
nginx -g 'daemon off;'
