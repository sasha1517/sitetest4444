from django.contrib import admin
from django.urls import path
from django.shortcuts import render, get_object_or_404
# Импортируем нашу модель категорий из созданного приложения catalog
from catalog.models import Category

# 1. Главная страница: вытаскиваем ВСЕ категории из базы
def home_page(request):
    categories = Category.objects.all()
    # Передаем их в шаблон под именем 'categories'
    return render(request, 'home.html', {'categories': categories})

# 2. Внутренняя страница: находим конкретную категорию по ID (номеру)
def test_page(request, num):
    # Если категории с таким ID нет, Django сам покажет красивую ошибку 404
    category = get_object_or_404(Category, id=num)
    # Передаем конкретную категорию в шаблон
    return render(request, 'page.html', {'category': category})

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', home_page),
    path('page/<int:num>/', test_page),
]
