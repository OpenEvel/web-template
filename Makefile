up:
	# Запускаем в фоновом режиме и билдим контейнер nginx
	# с нашими настройками и сертификатами
	docker compose up -d --build
down:
	# Завершаем работу веб приложения 
	docker compose down