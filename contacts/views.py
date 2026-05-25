#contacts/views.py
from django.shortcuts import render

def contacts_page(request):
    """Просто отдаём шаблон со страницей контактов"""
    return render(request, 'contacts/contacts.html', {'title': 'Контакти'})
