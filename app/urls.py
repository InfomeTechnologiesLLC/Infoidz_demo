from django.urls import path
from . import views

urlpatterns = [
    path('',views.main_page,name='main-page'),
    path('card/<str:slug>',views.card_page,name="card-page"),
    path('getvcard/<str:slug>',views.getVcard,name='getvcard'),
    path('demo-page',views.demo_page,name='demo-page'),
    path('info-id',views.infoid_page,name='info-id'),   
    path('preview-card/<int:card_id>/', views.preview_card, name='preview_card'), 
    path('save-card-styles/', views.save_card_styles, name='save_card_styles'),
    path('registration',views.registration,name='registration'),
    path('registration_page',views.registration_page,name='registration_page'),
    path('submit_details',views.submit_details, name='submit_details')
]