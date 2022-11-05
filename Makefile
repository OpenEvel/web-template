ssl:
	docker compose -f ssl.yml up -d
ssld:
	docker compose -f ssl.yml down
ps:
	docker ps -a
up:
	# Запускаем в фоновом режиме и билдим контейнер nginx
	# с нашими настройками и сертификатами
	docker compose -f app.yml up -d
down:
	# Завершаем работу веб приложения 
	docker compose -f app.yml down

clean: ssld down
	docker volume prune -f

l1:
	docker compose -f ssl.yml logs certbot

l2:
	docker compose -f app.yml logs certbot