cat > build.sh << 'EOF'
#!/bin/bash
set -e
python manage.py migrate --noinput
python manage.py collectstatic --noinpu
python manage.py createsuperuser --noinput || true
gunicorn --bind 0.0.0.0:$PORT mysite.wsgi:application
python manage.py shell << EOF
from django.contrib.auth import get_user_model
User = get_user_model()
if not User.objects.filter(username='admin').exists():
    User.objects.create_superuser('admin', 'admin@test.com', 'Qwerty12345!')
EOF
