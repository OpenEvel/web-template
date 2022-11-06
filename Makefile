# Запуск первоначального сервера, чтобы получить первичные сертификаты
ssl:
	docker compose -f ssl.yml up -d

# Запуск работы всего приложения
# Зависимост cert - обновить сертификаты
# Зависимость web - перезагрузить вебсервер
up: cert web

# Завершаем работу web приложения
down:
	# Завершаем работу веб приложения, запускаем именно для двух файлов app.yml и ssl.yml
	# Так как в будущем количетсво сервисов и томом может быть разным
	# Также --volumes - удалит все тома, а значит и все наши сертификаты
	docker compose -f app.yml down --volumes
	docker compose -f ssl.yml down --volumes

# Обновляем сертификаты, со старыми первоначальными работать не будет
cert:
	docker compose -f app.yml up --force-recreate --no-deps certbot

# Перезагрузка webserver для обновления конфигурации
web:
	# Останавливаем вебсервер, чтобы изменить конфигурацию и добавить соединение по ssl
	docker compose -f app.yml stop webserver
	# Перезапускаем сервер с обновлённой конфигурацией
	docker compose -f app.yml up -d --force-recreate --no-deps webserver
# логи certbot
lcert:
	# Кстати здесь не важно какой файл идёт после -f
	docker compose -f ssl.yml logs certbot
# логи webserver
lweb:
	# здесь не важно какой файл идёт после -f
	docker compose -f ssl.yml logs webserver
# Проверить все контейнеры
ps:
	docker ps -a