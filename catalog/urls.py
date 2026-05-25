# catalog/urls.py
from django.urls import path
from . import views

app_name = 'catalog'

urlpatterns = [
    path('', views.home, name='home'),  # ← имя функции должно совпадать с catalog/views.py!
]
