.PHONY: up down restart build rm

# Запуск контейнеров в фоновом режиме
up:
	docker-compose up -d

# Остановка и удаление контейнеров
down:
	docker-compose down

# Перезапуск контейнеров
restart:
	docker-compose down && docker-compose up -d

# Сборка контейнеров перед запуском
build:
	docker-compose build

# Удаление всех остановленных контейнеров
rm:
	docker-compose rm -f