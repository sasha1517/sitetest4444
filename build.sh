#!/bin/bash
set -e

# 1. Миграции
python manage.py migrate --noinput

# 2. Статика
python manage.py collectstatic --noinput

# 3. Создание админа (принудительно)
python manage.py shell << EOF
from django.contrib.auth import get_user_model
User = get_user_model()
# Пытаемся найти админа 'admin'
if not User.objects.filter(username='admin').exists():
    User.objects.create_superuser('admin', 'admin@test.com', 'super_secret_password_123')
    print("Superuser created!")
else:
    print("Superuser already exists.")
EOF

# 4. Старт
gunicorn --bind 0.0.0.0:$PORT mysite.wsgi:application
