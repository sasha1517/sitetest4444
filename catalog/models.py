# catalog/models.py
from django.db import models

class Category(models.Model):
    title = models.CharField("Назва категорії", max_length=100)
    description = models.TextField("Опис", blank=True, default="")
    image_url = models.URLField("Посилання на зображення", blank=True, null=True)
    link = models.CharField("Посилання сторінки", max_length=50, default="/page/1/")
    
    class Meta:
        verbose_name = "Категорія"
        verbose_name_plural = "Категорії"
        ordering = ['-id']  # Новые сверху

    def __str__(self):
        return self.title
