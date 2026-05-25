cat > build.sh << 'EOF'
#!/bin/bash
set -e
python manage.py migrate --noinput
python manage.py collectstatic --noinpu
python manage.py createsuperuser --noinput || truet
gunicorn --bind 0.0.0.0:$PORT mysite.wsgi:application
EOF
