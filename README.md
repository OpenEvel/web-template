# web-template

## Настройка и порядок работы

### Разработка при помощи Docker

Запустить и остановить сервис можнл следующими комманадми:

* Запуск

    ```
    docker compose up -d --build
    ```

* Остановка

    ```
    docker compose down
    ```

Также будут полезны следующие комманды:

* Удаление всех контейнеров

    ```
    docker rm -f $(docker ps -aq)
    ```

* Удаление всех скаченных или собранных образов

    ```
    docker rmi -f $(docker images -aq)
    ```

* Удаление всех томов (пригодится если изменять параметры базы данных)

    ```
    docker volume rm -f $(docker volume ls -q)
    ```

* Очистка кеша и удаление ненужных данных, образов и тд

    ```
    docker system prune -f --volumes
    ```

### Установка и настройка DJANGO

Cоздать и активировать виртуальное окружение:

```
python3 -m venv venv
```

* Если у вас Linux/macOS

    ```
    source venv/bin/activate
    ```

* Если у вас windows

    ```
    source venv/scripts/activate
    ```

Все последующие действия подразумевают, что вы находитесь в папке backend. Чтобы перейти в неё из корня проекта достаточно выполнить комманду:

```
cd backend/
```

Установить зависимости из файла requirements.txt:

```
python3 -m pip install --upgrade pip
```

```
pip install -r requirements.txt
```

Создать миграции:

```
python3 manage.py makemigrations
```

Применить миграции:

```
python3 manage.py migrate
```

Собрать статические файлы чтобы отображалась админка:

```
python3 manage.py collectstatic
```

Создать администратора django

```
python3 manage.py createsuperuser
```

Запустить проект:

```
python3 manage.py runserver
```

### Как запустить фронтенд

Установить yarn [тут](https://classic.yarnpkg.com/en/docs/install#windows-stable)

Перейти в директорию frontend

```
cd frontend
```

Установить зависимости

```
yarn
```

Собрать фронт

Предварительно в файле `frontend/plugins/apiAxios.ts` задать переменную `defaultURL`

```
yarn build
```

Запуск фронтенда

```
node .output/server/index.mjs
```
