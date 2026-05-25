from django.db import models

# Create your models here.
class Category(models.Model):
    title = models.CharField(max_length=200, verbose_name="Назва категорії")
    description = models.TextField(verbose_name="Опис")
    image_url = models.URLField(verbose_name="Посилання на картинку", blank=True)

    def __str__(self):
        return self.title

    class Meta:
        verbose_name = "Категорія"
        verbose_name_plural = "Категорії"
