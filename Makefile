# Makefile для управления CRYPTO_EXCHANGER_FULL_PROD

.PHONY: help build up down restart logs clean status update

# Показать справку
help:
	@echo "Доступные команды:"
	@echo "  build    - Собрать все Docker образы"
	@echo "  up       - Запустить всю систему в фоновом режиме"
	@echo "  down     - Остановить всю систему"
	@echo "  restart  - Перезапустить всю систему"
	@echo "  logs     - Показать логи всех сервисов"
	@echo "  status   - Показать статус всех контейнеров"
	@echo "  clean    - Очистить неиспользуемые ресурсы Docker"
	@echo "  update   - Обновить проект и пересобрать образы"

# Собрать все образы
build:
	@echo "Сборка Docker образов..."
	docker compose build

# Запустить всю систему
up:
	@echo "Запуск системы..."
	docker compose up -d

# Остановить всю систему
down:
	@echo "Остановка системы..."
	docker compose down

# Перезапустить всю систему
restart: down up

# Показать логи
logs:
	@echo "Просмотр логов..."
	docker compose logs -f

# Показать статус
status:
	@echo "Статус контейнеров:"
	docker compose ps

# Очистить систему
clean:
	@echo "Очистка Docker..."
	docker system prune -a -f

# Обновить проект
update:
	@echo "Остановка контейнеров..."
	docker compose down
	@echo "Получение последних изменений из Git..."
	git pull
	@echo "Обновление сабмодулей..."
	git submodule update --remote --merge
	@echo "Загрузка последней версии фронтенда..."
	docker pull ogrttt/front_cr_d_s:latest
	@echo "Сборка Docker образов..."
	docker compose build
