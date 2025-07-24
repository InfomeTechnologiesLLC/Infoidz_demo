from rest_framework import serializers
from portal.models import ContactEntries 

class ContactEntriesSerializer(serializers.ModelSerializer):
    class Meta:
        model = ContactEntries
        fields = ['id', 'name', 'email', 'personal_number', 'whatsapp_number', 'profile_pic', 'url_slug','created_at']