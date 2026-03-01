.PHONY: up down restart build rm help build-go-base rm-image clean

DOCKER_COMPOSE = docker-compose
GO_BASE_IMAGE = homelab-go-base:1.26
GO_BASE_CONTEXT = ./docker/base-go

# Сборка базового Go-образа
build-go-base:
	docker build -t $(GO_BASE_IMAGE) $(GO_BASE_CONTEXT)

# Запуск контейнеров в фоновом режиме (предварительно собираем образ)
up: build-go-base
	$(DOCKER_COMPOSE) up -d

# Остановка и удаление контейнеров
down:
	$(DOCKER_COMPOSE) down

# Перезапуск контейнеров (остановка, затем запуск)
restart:
	$(MAKE) down && $(MAKE) up

# Сборка контейнеров (пересборка образов) перед запуском
build: build-go-base
	$(DOCKER_COMPOSE) build

# Удаление только остановленных контейнеров (не образов)
rm:
	$(DOCKER_COMPOSE) rm -f

# Удаление базового Go-образа
rm-go-image:
	docker rmi -f $(GO_BASE_IMAGE)

# Полная очистка: остановка контейнеров, удаление контейнеров и образа
clean: down rm rm-go-image
	@echo "Все контейнеры и образ $(GO_BASE_IMAGE) удалены."

# Справка
.DEFAULT_GOAL = help
help:
	@echo "Доступные цели:"
	@echo "  build-go-base  - собрать базовый Go-образ"
	@echo "  up             - запустить контейнеры"
	@echo "  down           - остановить контейнеры"
	@echo "  restart        - перезапустить контейнеры"
	@echo "  build          - пересобрать образы"
	@echo "  rm             - удалить остановленные контейнеры (не образы)"
	@echo "  rm-image       - удалить базовый Go-образ"
	@echo "  clean          - полная очистка: остановка и удаление контейнеров + образа"