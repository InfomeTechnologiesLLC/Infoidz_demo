from .models import ContactEntries
import uuid
from django.shortcuts import render

from datetime import datetime
from functools import wraps
def generate_contact_url_slug():
    
    url_slug=uuid.uuid4().hex[:10]
    
    if ContactEntries.objects.filter(url_slug=url_slug).exists():
        generate_contact_url_slug()
    return url_slug


##decorators

def commonChecker():
    def decorator(view):    
        @wraps(view)
        def _wrapped_view(request, *args, **kwargs):
            
            if request.user.profile.organization.expiry_date <= datetime.now().date():
                return render(request,'error/organization_expiry_date_error.html')   
            else:
                return view(request, *args, **kwargs)
                
        return _wrapped_view
    return decorator