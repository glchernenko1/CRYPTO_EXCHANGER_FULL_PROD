# Команды для работы с Git субмодулями

# 1. Добавление нового субмодуля
# git submodule add <URL_репозитория> <путь_в_проекте>

# Примеры для криптовалютного обменника:
# git submodule add https://github.com/ccxt/ccxt.git libs/ccxt
# git submodule add https://github.com/sammchardy/python-binance.git libs/binance
# git submodule add https://github.com/your-username/crypto-utils.git utils

# 2. Инициализация субмодулей после клонирования репозитория
# git submodule init
# git submodule update




# Или одной командой:
# git submodule update --init --recursive

# 3. Обновление всех субмодулей до последних коммитов
# git submodule update --remote

# 4. Обновление конкретного субмодуля
# git submodule update --remote <имя_субмодуля>

# 5. Клонирование репозитория с субмодулями
# git clone --recursive <URL_репозитория>

# 6. Удаление субмодуля
# git submodule deinit <путь_к_субмодулю>
# git rm <путь_к_субмодулю>
# rm -rf .git/modules/<путь_к_субмодулю>

# 7. Просмотр статуса субмодулей
# git submodule status

# 8. Foreach - выполнение команды во всех субмодулях
# git submodule foreach 'git pull origin main'
