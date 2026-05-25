#!/bin/bash
set -e

# 1. Миграции (создаем таблицы)
echo ">>> Applying migrations..."
python manage.py migrate --noinput

# 2. Статика (картинки CSS)
echo ">>> Collecting static files..."
python manage.py collectstatic --noinput

# 3. СОЗДАНИЕ АДМИНА (Железобетонный метод)
echo ">>> Creating superuser..."
python manage.py shell << EOF
from django.contrib.auth import get_user_model
User = get_user_model()
# Если пользователя 'admin' нет, создаем его с паролем 'admin123456'
if not User.objects.filter(username='admin').exists():
    User.objects.create_superuser('admin', 'admin@example.com', 'admin123456')
    print("SUCCESS: Admin user 'admin' created!")
else:
    print("INFO: Admin user already exists.")
EOF

# 4. Запуск сервера
echo ">>> Starting Gunicorn..."
gunicorn --bind 0.0.0.0:$PORT mysite.wsgi:application
