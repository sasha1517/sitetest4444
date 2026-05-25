cat > build.sh << 'EOF'
#!/bin/bash
set -e
python manage.py migrate --noinput
python manage.py collectstatic --noinput
gunicorn --bind 0.0.0.0:$PORT mysite.wsgi:application
EOF
