#!/bin/bash
set -e

# 0. УСТАНАВЛИВАЕМ БИБЛИОТЕКИ (самое важное!)
echo ">>> Installing requirements..."
pip install -r requirements.txt

# 1. Миграции
echo ">>> Applying migrations..."
python manage.py migrate --noinput

# 2. Статика (картинки, CSS)
echo ">>> Collecting static files..."
python manage.py collectstatic --noinput

# 3. Создание админа
echo ">>> Creating superuser..."
python manage.py shell << EOF
from django.contrib.auth import get_user_model
User = get_user_model()
if not User.objects.filter(username='admin').exists():
    User.objects.create_superuser('admin', 'admin@test.com', 'super_secret_password_123')
    print("SUCCESS: Admin created!")
else:
    print("INFO: Admin already exists.")
EOF

# 4. Запуск сервера
echo ">>> Starting Gunicorn..."
gunicorn --bind 0.0.0.0:$PORT mysite.wsgi:application
