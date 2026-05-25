# contacts/urls.py
from django.urls import path
from . import views

app_name = 'contacts'  # Это поможет избегать конфликтов имён

urlpatterns = [
    path('', views.contacts_page, name='contacts_page'),
]
