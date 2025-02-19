from django.urls import path
from . import views

app_name = 'portal'

urlpatterns = [
    
    #pages
    path('login',views.login_page,name='login_page'),
    path('dashboard',views.dashboard,name='dashboard'),
    path('contact-entries',views.contacts_page,name='contact-entries'),
    path('contact-entries/add',views.contacts_add_page,name='contact-entries-add'),
    path('contact-entries/edit',views.contacts_edit_page,name='contact-entries-edit'),
    path('plan-expired',views.plan_expired_page,name='plan-expired-page'),
    #
    path('create-new-user',views.create_new_user,name='create-new-user'),
    path('validate-user',views.validate_login,name='validate-user'),
    path('logout',views.user_logout,name='logout'),
    path('submit-new-contact',views.submit_new_contact,name='submit-new-contact'),
    path('get-contact-entire-detail',views.get_contact_detail,name='get-contact-entire-detail'),
    path('edit-submit-contact-entrie',views.edit_submit_contact,name="edit-submit-contact-entrie"),
    path('delete-contact-entrie',views.delete_contact_entry,name='delete-contact-entrie'),
    path('submit_new_contact',views.submit_new_contact,name='submit_new_contact'),
    path('forgot-password',views.forgot_password,name='forgot-password'),
    path('delete-file/', views.delete_file, name='delete_file'),
    path('write-to-nfc/', views.write_to_nfc, name='write_to_nfc'),
    path('profile/<int:entrie_id>', views.profile, name='profile'),
    path('email_signature',views.email_signature,name='email_signature'),
    path('contact_email_signature/<int:entrie_id>',views.contact_email_signature,name='contact_email_signature'),
    path('analytics',views.analytics,name='analytics'),
    path('delete-customer-details',views.delete_customer_entry, name='delete-customer-details'),
    path('bulk-upload',views.bulk_upload,name='bulk-upload'),
    path('build_excel_bulk_upload',views.build_excel_bulk_upload,name='build_excel_bulk_upload'),
    path("update-writed-status", views.update_writed_status, name="update-write-status"),
    # path('download_apk',views.apk_page,name='download_apk')
    
]

