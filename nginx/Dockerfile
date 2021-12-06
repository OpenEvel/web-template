# syntax=docker/dockerfile:1
# Используем образ сервера nginx
FROM nginx
# Копируем свои настройки в контейнер
# Используем шаблон настроект nginx, чтобы в docker-compose.yml удобней передавать переменные окружения
COPY default.conf.template /etc/nginx/templates/

# Подключаем ssl сертификат внутри контейнера
# Сам сертификат
COPY ./certs/my_ssl.crt /etc/ssl/my_ssl.crt
# Приватный ключ
COPY ./certs/private_my_ssl.key /etc/ssl/private_my_ssl.key
