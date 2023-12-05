# Используем базовый образ Nginx
FROM nginx:alpine-slim

# Папка для взаимодействия с certbot
RUN mkdir -p /certbot
# Установка Certbot
RUN apk update && apk add --no-cache certbot

# Задаём рабочую директорию
WORKDIR /app

# Задаём параметры nginx
COPY . .

# Скрипт для правильного запуска контейнера
# Чтобы обновлял только те сертификаты, которые нужно
# Чтобы не попасть в бан из-за слишком частых запросов при деплое
RUN chmod +x ./run.sh

# Скрипт для обновления сертификатов через cron
COPY update_certs.sh /etc/periodic/daily/
RUN chmod +x /etc/periodic/daily/update_certs.sh