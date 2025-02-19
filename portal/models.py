from django.db import models
from django.contrib.auth.models import  User
import os
from app.models import cards
# Create your models here.
class Profile(models.Model):
    name=models.CharField(null=True,max_length=100)
    user=models.OneToOneField(User, on_delete=models.CASCADE)
    organization=models.ForeignKey('Organizations',null=True,on_delete=models.CASCADE)
    
    active=models.BooleanField(default=True)
    created_at=models.DateField(auto_now_add=True)
    
    def __str__(self):
        return self.name
    
    class Meta:
        db_table="UserDetails"
class socialMedias(models.Model):
    name=models.CharField(max_length=50)    
    icon=models.CharField(max_length=50)
    active=models.BooleanField(default=True)
    
    class Meta:
        db_table="social_medias"

class contactEntrySocialMedias(models.Model):
    link=models.TextField()
    social_media=models.ForeignKey(socialMedias, on_delete=models.CASCADE)
    active=models.BooleanField(default=True)
    
    class Meta:
        db_table='contact_entry_social_medias'
class ContactEntries(models.Model):
    name=models.TextField(null=True)
    personal_number=models.CharField(null=True,max_length=20)
    company_name=models.TextField(null=True)
    designation=models.TextField(null=True)
    office_number=models.CharField(null=True,max_length=20)
    whatsapp_number=models.CharField(null=True,max_length=20)
    email=models.TextField(null=True)
    email2=models.TextField(null=True)
    website=models.TextField(null=True)
    location=models.TextField(null=True)
    address=models.TextField(null=True)
    profile_pic=models.FileField(upload_to='profile',null=True)
    profile_pic_thumbnail=models.FileField(upload_to='profile/thubnail',null=True)
    cover_image=models.FileField(upload_to='coverimage',null=True)
    background_image = models.FileField(upload_to='background_images',null=True)
    company_logo = models.FileField(upload_to='company_logo',null=True) 
    social_medias=models.ManyToManyField(contactEntrySocialMedias,null=True)
    card=models.ForeignKey(cards,on_delete=models.CASCADE)
    created_by=models.ForeignKey(User,on_delete=models.CASCADE)
    url_slug=models.CharField(max_length=1000)
    about_me = models.TextField(null=True)
    business_card = models.FileField(upload_to='businessCard',null=True)    
    
    created_at=models.DateField(auto_now_add=True)
    updated_at=models.DateField(auto_now=True)
    
    active=models.BooleanField(default=True)
    writed = models.IntegerField(default=True)

    def __str__(self):
        return self.name
    class Meta:
        db_table="ContactEntries"

class Organizations(models.Model):
    name=models.CharField(null=True,max_length=100)
    active=models.BooleanField(default=True)
    
    
    expiry_date=models.DateField(null=True)
    contact_limit=models.IntegerField(default=10)
    
    def __str__(self):
        return self.name
    class Meta:
        db_table="Organizations"

class CutomizedCard(models.Model):
    contact_id = models.IntegerField(null=True)
    active=models.BooleanField(default=True)
    styles = models.TextField(blank=True, null=True)
    created_at=models.DateField(auto_now_add=True)
    updated_at=models.DateField(auto_now=True)

    class Meta:
        db_table = "customized_card_contact"

class Customer_Details(models.Model):
    name = models.TextField(null=True)
    email = models.TextField(null=True)
    phone = models.CharField(max_length=20)
    active = models.IntegerField(null=True)
    created_at=models.DateField(auto_now_add=True)
    updated_at=models.DateField(auto_now=True)

    class Meta:
        db_table = 'customer_details'   
