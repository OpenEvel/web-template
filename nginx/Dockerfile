# syntax=docker/dockerfile:1
# Используем образ сервера nginx
FROM nginx
# Копируем свои настройки в контейнер
# Используем шаблон настроект nginx, чтобы в docker-compose.yml удобней передавать переменные окружения
COPY default.conf.template /etc/nginx/templates/

# Подключаем ssl сертификат внутри контейнера
# Сам сертификат
COPY ./certs /etc/ssl