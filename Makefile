# Makefile для управления CRYPTO_EXCHANGER_FULL_PROD

.PHONY: help build up down restart logs clean status health

# Показать справку
help:
	@echo "Доступные команды:"
	@echo "  build    - Собрать все Docker образы"
	@echo "  up       - Запустить всю систему"
	@echo "  down     - Остановить всю систему"
	@echo "  restart  - Перезапустить всю систему"
	@echo "  logs     - Показать логи всех сервисов"
	@echo "  status   - Показать статус всех контейнеров"
	@echo "  health   - Проверить здоровье сервисов"
	@echo "  clean    - Очистить неиспользуемые ресурсы Docker"

# Собрать все образы
build:
	@echo "Сборка Docker образов..."
	docker compose build  #--no-cache

# Запустить всю систему
up:
	@echo "Запуск системы криптовалютного обменника..."
	@echo "Последовательность: microservices → core → frontend"
	docker compose up -d

# Остановить всю систему
down:
	@echo "Остановка системы..."
	docker compose down

# Перезапустить систему
restart: down up

# Показать логи
logs:
	docker compose logs -f

# Показать логи конкретного сервиса
logs-microservices:
	docker compose logs -f microservices

logs-core:
	docker compose logs -f core

logs-frontend:
	docker compose logs -f frontend

# Статус контейнеров
status:
	@echo "Статус контейнеров:"
	docker compose ps

# Проверка здоровья сервисов
health:
	@echo "Проверка здоровья сервисов..."
	@echo "Microservices (port 8888):"
	@curl -s http://localhost:8888/health || echo "Микросервисы недоступны"
	@echo "\nCore API (port 8000):"
	@curl -s http://localhost:8000/health || echo "Core API недоступен"
	@echo "\nFrontend (port 3000):"
	@curl -s http://localhost:3000 > /dev/null && echo "Frontend доступен" || echo "Frontend недоступен"

# Очистка неиспользуемых ресурсов
clean:
	@echo "Очистка неиспользуемых Docker ресурсов..."
	docker system prune -f
	docker volume prune -f

# Обновление субмодулей
update-submodules:
	@echo "Обновление субмодулей до последних версий..."
	git submodule update --remote --merge

# Полная пересборка с обновлением субмодулей
rebuild: update submodules down clean build up

# Режим разработки (с выводом логов)
dev:
	@echo "Запуск в режиме разработки..."
	docker compose up --build
