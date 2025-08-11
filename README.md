
- **microservices** - Микросервисы (Google Sheets API)
- **core** - Backend API на FastAPI с базой данных PostgreSQL
- **frontend** - React frontend приложение

## Быстрый старт

### Предварительные требования

- Docker и Docker Compose
- Git
- Make (опционально, для удобства)

### Запуск системы

1. **Клонирование с субмодулями:**
   ```bash
   git clone --recursive git@github.com:glchernenko1/CRYPTO_EXCHANGER_FULL_PROD.git
   cd CRYPTO_EXCHANGER_FULL_PROD
   ```

   Или если уже клонировали без субмодулей:
   ```bash
   git submodule update --init --recursive
   ```

2. **Настройка Google Sheets API:**
   - Поместите файл `google.json` с учетными данными в корневую папку проекта

3. **Запуск системы:**
   ```bash
   # Используя Make (рекомендуется)
   make up
   
   # Или напрямую через Docker Compose
   docker-compose up -d
   ```

### Порядок запуска

Система автоматически запускается в правильной последовательности:

1. **База данных** (PostgreSQL) и **Redis** - запускаются первыми
2. **Микросервисы** (порт 8888) - запускаются и проходят health check
3. **Core API** (порт 8000) - инициализация БД, затем запуск API
4. **Frontend** (порт 3000) - запускается последним

## Доступные сервисы

- **Frontend:** http://localhost:3000
- **Core API:** http://localhost:8000
- **Микросервисы:** http://localhost:8888
- **PostgreSQL:** localhost:5432
- **Redis:** localhost:6379

## Управление системой

### Через Makefile

```bash
make help          # Показать все доступные команды
make build         # Собрать все Docker образы
make up            # Запустить систему
make down          # Остановить систему
make restart       # Перезапустить систему
make logs          # Показать логи всех сервисов
make status        # Статус контейнеров
make health        # Проверить здоровье сервисов
make clean         # Очистить неиспользуемые ресурсы
```

### Через Docker Compose

```bash
docker-compose up -d           # Запуск в фоновом режиме
docker-compose down            # Остановка
docker-compose logs -f         # Просмотр логов
docker-compose ps              # Статус контейнеров
docker-compose build --no-cache  # Пересборка образов
```

## Работа с субмодулями

### Обновление субмодулей

```bash
# Обновить все субмодули до последних версий
git submodule update --remote

# Обновить конкретный субмодуль
git submodule update --remote frontend
```

### Работа внутри субмодулей

```bash
# Перейти в субмодуль и внести изменения
cd frontend
git checkout main
# внести изменения
git add .
git commit -m "Update frontend"
git push

# Вернуться в главный проект и зафиксировать новую версию субмодуля
cd ..
git add frontend
git commit -m "Update frontend submodule"
git push
```

## Структура проекта

```
CRYPTO_EXCHANGER_FULL_PROD/
├── docker-compose.yml      # Главный файл Docker Compose
├── .env                    # Переменные окружения
├── Makefile               # Команды для управления
├── google.json            # Учетные данные Google API
├── frontend/              # React frontend (субмодуль)
├── core/                  # FastAPI backend (субмодуль)
└── microservices/         # Go микросервисы (субмодуль)
```

## Переменные окружения

Основные переменные настраиваются в файле `.env`:

```env
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
POSTGRES_DB=postgres
REACT_APP_API_URL=http://localhost:8000
REACT_APP_MICROSERVICES_URL=http://localhost:8888
```

## Разработка

### Режим разработки

```bash
# Запуск с пересборкой и выводом логов
make dev

# Или
docker-compose up --build
```

### Отладка

```bash
# Логи конкретного сервиса
make logs-core
make logs-frontend
make logs-microservices

# Подключение к контейнеру
docker exec -it crypto-core bash
docker exec -it crypto-frontend sh
```

## Troubleshooting

### Частые проблемы

1. **Ошибка подключения к БД:**
   - Убедитесь, что PostgreSQL контейнер запущен
   - Проверьте переменные окружения в `.env`

2. **Frontend не может подключиться к API:**
   - Проверьте `REACT_APP_API_URL` в `.env`
   - Убедитесь, что Core API запущен

3. **Субмодули пустые:**
   ```bash
   git submodule update --init --recursive
   ```

4. **Проблемы с Docker:**
   ```bash
   make clean  # Очистить неиспользуемые ресурсы
   docker system prune -a  # Полная очистка
   ```

### Полная перезагрузка

```bash
make down
make clean
make build
make up
```
