from django.urls import path
from .views import ValidateLoginAPI,ContactsAPI,DashboardAPI

urlpatterns = [
    path('validate-login/', ValidateLoginAPI.as_view(), name='validate-login'),
    path('api/dashboard/', DashboardAPI.as_view(), name='dashboard-api'),
    path('contacts/', ContactsAPI.as_view(), name='contacts-api'),
]