import re
from django.shortcuts import get_object_or_404, render , HttpResponse , redirect
from django.contrib.auth.models import User
from django.http import JsonResponse
from .models import *
from django.contrib.auth import authenticate,login , logout
from django.contrib.auth.decorators import login_required
from django.template.loader import render_to_string 
from django.utils.text import slugify
import uuid
from PIL import Image
from django.db.models.functions import TruncDate
from datetime import datetime ,timedelta
from django.db.models import Count
import json
from .utilities import generate_contact_url_slug, commonChecker
import base64
from django.core.files.base import ContentFile
from PIL import Image
from io import BytesIO
from smartcard.System import readers
import smartcard
import segno


####PAGES
#login page 
def login_page(request):
    return render(request,'login.html')

@login_required
@commonChecker()
def dashboard(request):
    # user_organization = request.user.profile.organization
    all_contacts=ContactEntries.objects.filter(active=True,created_by__profile__organization=request.user.profile.organization)
    
    total_contact_count=all_contacts.count()
    this_month_count=all_contacts.filter(created_at__month=datetime.today().month,created_at__year=datetime.today().year).count()
    this_week_count=all_contacts.filter(created_at__range=[datetime.today().date() - timedelta(days=7),datetime.today()]).count()
    today_count=all_contacts.filter(created_at__month=datetime.today().month,created_at__year=datetime.today().year,created_at__day=datetime.today().day).count()
    
    last_15_days_counts=list(all_contacts.filter(created_at__range=[datetime.today() - timedelta(days=15), datetime.today() ]).annotate(day=TruncDate('created_at')).values('day').annotate(n=Count('day')).values('day','n'))
    
    for d in last_15_days_counts:
        d["day"]=d["day"].strftime('%d-%b')
    
    data={'last_15_days':last_15_days_counts,'total_count':total_contact_count,'this_month_count':this_month_count,'this_week_count':this_week_count,'today_count':today_count}
    return render(request,'pages/dashboard/index.html',data)

@login_required
def contacts_page(request):

    entries=ContactEntries.objects.filter(active=True,created_by__profile__organization=request.user.profile.organization).order_by('-id')
    data={'entries':entries}
    return render(request,'pages/contacts/index.html',data) 

@login_required
def contacts_add_page(request):
    
    _social_medias=socialMedias.objects.filter(active=True)
    
    res={'social_medias':_social_medias,'cards':cards.objects.filter(active=True)}
    
    return render(request,'pages/contacts/add/index.html',res)
@login_required
def contacts_edit_page(request):
    edit_id=request.GET.get('edit-id')
    
    entry=ContactEntries.objects.get(id=edit_id)
    _social_medias=socialMedias.objects.filter(active=True)
    
    _social_medias_links=[]
    
    for s in entry.social_medias.filter(active=True):
        _social_medias_links.append({
            
            'social_media_id':s.social_media.id,
            'social_media_name':s.social_media.name,
            'social_media_link':s.link,
            'social_media_icon':s.social_media.icon
        })
        

    
    return render(request,'pages/contacts/edit/index.html',{'entry':entry,'social_medias':_social_medias,'social_medias_link_dump':json.dumps(_social_medias_links),'cards':cards.objects.filter(active=True)})
###

def validate_login(request):
    username=request.POST.get('username')
    password=request.POST.get('password')

    user=authenticate(username=username,password=password)
    if user is not None:
        login(request,user)
        try:
        
            if request.user.profile.organization.expiry_date <= datetime.now().date():
                
                return JsonResponse({'ErrorCode':'expiry_date','reason':'Activation is expired','success':True})
           
            return JsonResponse({'success':True})
        except:
            return JsonResponse({'success':False,'ErrorCode':'user_not_found','reason':'Something went wrong'})
    else:
        return JsonResponse({'ErrorCode':'user_not_found','reason':'Invalid username or password. Please try again.','success':False})
    
def forgot_password(request):
    return render(request,'forgot-password.html')

@login_required
def plan_expired_page(request):
    
    if request.user.profile.organization.expiry_date <= datetime.now().date():
        return render(request,'error/organization_expiry_date_error.html') 
    else:
        return redirect('dashboard')
@login_required
def user_logout(request):
    logout(request)
    return redirect('portal:login_page')

def submit_new_contact(request):
    try:
        # Get all fields from POST data
        id = request.POST.get('id')
        name = request.POST.get('name')
        personal_number = request.POST.get('personal-number')
        office_number = request.POST.get('office-number')
        designation = request.POST.get('designation-name')
        company_name = request.POST.get('company-name')
        whatsapp = request.POST.get('whatsapp-number')
        e_mail = request.POST.get('email-id')
        email2 = request.POST.get('email-id-2')
        web_site = request.POST.get('website')
        location = request.POST.get('location')
        address = request.POST.get('address')
        card_id = request.POST.get('card-id')
        
        # Handle file uploads
        profile_pic = request.POST.get('cropped-profile-pic')
        business_card = request.FILES.get('business-card')
        profile_pic_file = None

        # Process profile picture if provided
        if profile_pic:
            try:
                format, imgstr = profile_pic.split(';base64,')
                ext = format.split('/')[-1]
                img_data = base64.b64decode(imgstr)
                profile_pic_file = ContentFile(img_data, name=f'profile_pic.{ext}')
            except Exception as e:
                return JsonResponse({'success': False, 'reason': 'Invalid profile image: ' + str(e)})
        elif 'profile-pic' in request.FILES:
            profile_pic_file = request.FILES['profile-pic']

        # Normalize fields
        personal_number = personal_number or None
        office_number = office_number or None
        whatsapp = whatsapp or None
        designation = designation or None
        company_name = company_name or None
        e_mail = e_mail or None
        email2 = email2 or None
        location = location or None
        address = address or None
        web_site = web_site or None
        
        # Format WhatsApp number and website URL
        if whatsapp:
            whatsapp = whatsapp.replace('+', '')
        
        if web_site and not web_site.startswith(('http://', 'https://')):
            web_site = f'https://{web_site}'

        # Check contact limit
        if ContactEntries.objects.filter(active=True).count() >= request.user.profile.organization.contact_limit:
            return JsonResponse({
                'success': False,
                'reason': "You've reached the contact limit. Unable to add more",
                'errorCode': 'contact_limit'
            })

        # Generate URL slug and get card
        url_slug = generate_contact_url_slug()
        _card = cards.objects.get(id=card_id)

        # Create new contact entry
        obj = ContactEntries.objects.create(
            name=name,
            personal_number=personal_number,
            company_name=company_name,
            designation=designation,
            office_number=office_number,
            whatsapp_number=whatsapp,
            email=e_mail,
            email2=email2,
            website=web_site,
            location=location,
            address=address,
            profile_pic=profile_pic_file,
            cover_image=request.FILES.get('cover-image'),
            url_slug=url_slug,
            created_by=request.user,
            profile_pic_thumbnail=profile_pic_file,
            card=_card,
            business_card=business_card
        )

        # Process profile picture thumbnails if provided
        if profile_pic_file:
            profile_img = Image.open(obj.profile_pic.path)
            profile_img.thumbnail((1000, 1000))
            profile_img.save(obj.profile_pic.path)

            profile_img_thumb = Image.open(obj.profile_pic_thumbnail.path)
            profile_img_thumb.thumbnail((80, 80))
            profile_img_thumb.save(obj.profile_pic_thumbnail.path)

        # Generate vCard
        vcard = f"""BEGIN:VCARD
VERSION:3.0
N:{name};
FN:{name}
ORG:{company_name or ''}
TEL;TYPE=HOME,VOICE:{personal_number or ''}
EMAIL;TYPE=INTERNET,PREF:{e_mail or ''}
END:VCARD"""

        # Generate QR code
        qr = segno.make(vcard)
        buffer = io.BytesIO()
        qr.save(buffer, kind='png', scale=10, border=4)
        qr_filename = f"qr_{obj.id}.png"
        obj.qr_code.save(qr_filename, ContentFile(buffer.getvalue()))
        obj.save()

        return JsonResponse({
            'success': True,
            'entry_id': obj.id,
            'qr_code_url': obj.qr_code.url if obj.qr_code else None
        })

    except Exception as e:
        return JsonResponse({'success': False, 'errorCode': 'exception', 'reason': str(e)})

def edit_submit_contact(request):
    id = request.POST.get('id')
    name = request.POST.get('name')
    personal_number = request.POST.get('personal-number')
    office_number = request.POST.get('office-number')
    designation = request.POST.get('designation-name')
    company_name = request.POST.get('company-name')
    whatsapp = request.POST.get('whatsapp-number')
    e_mail = request.POST.get('email-id')
    email2 = request.POST.get('email-id-2')
    web_site = request.POST.get('website')
    location = request.POST.get('location')
    address = request.POST.get('address')
    card_id = request.POST.get('card-id')

    profile_pic = request.POST.get('cropped-profile-pic')
    business_card = request.FILES.get('business-card')
    profile_pic_file = None

    if profile_pic:
        try:
            format, imgstr = profile_pic.split(';base64,')
            ext = format.split('/')[1]
            img_data = base64.b64decode(imgstr)
            profile_pic_file = ContentFile(img_data, name=f'profile_pic.{ext}')
        except Exception as e:
            return JsonResponse({'success': False, 'reason': str(e)})
    elif 'profile-pic' in request.FILES:
        profile_pic_file = request.FILES['profile-pic']

    # Normalize
    personal_number = personal_number or None
    office_number = office_number or None
    whatsapp = whatsapp or None
    designation = designation or None
    company_name = company_name or None
    e_mail = e_mail or None
    email2 = email2 or None
    location = location or None
    address = address or None
    web_site = web_site or None
    if web_site and not web_site.startswith(('http://', 'https://')):
        web_site = f'https://{web_site}'

    try:
        contact_obj = ContactEntries.objects.get(id=id)

        if card_id:
            _card = cards.objects.get(id=card_id)
            contact_obj.card = _card

        contact_obj.name = name
        contact_obj.personal_number = personal_number
        contact_obj.company_name = company_name
        contact_obj.designation = designation
        contact_obj.office_number = office_number
        contact_obj.whatsapp_number = whatsapp
        contact_obj.email = e_mail
        contact_obj.email2 = email2
        contact_obj.website = web_site
        contact_obj.location = location
        contact_obj.address = address

        if profile_pic_file:
            contact_obj.profile_pic = profile_pic_file
            contact_obj.profile_pic_thumbnail = profile_pic_file

        if business_card:
            contact_obj.business_card = business_card

        vcard = f"""BEGIN:VCARD
VERSION:3.0
N:{name};
FN:{name}
ORG:{company_name or ''}
TEL;TYPE=HOME,VOICE:{personal_number or ''}
EMAIL;TYPE=INTERNET,PREF:{e_mail or ''}
END:VCARD"""

        qr = segno.make(vcard)
        buffer = io.BytesIO()
        qr.save(buffer, kind='png', scale=10, border=4)
        qr_filename = f"qr_{contact_obj.id}.png"

        if contact_obj.qr_code:
            contact_obj.qr_code.delete()

        contact_obj.qr_code.save(qr_filename, ContentFile(buffer.getvalue()))

        if profile_pic_file:
            contact_obj.save()

            profile_img = Image.open(contact_obj.profile_pic.path)
            profile_img.thumbnail((1000, 1000))
            profile_img.save(contact_obj.profile_pic.path)

            profile_img_thumb = Image.open(contact_obj.profile_pic_thumbnail.path)
            profile_img_thumb.thumbnail((80, 80))
            profile_img_thumb.save(contact_obj.profile_pic_thumbnail.path)

        contact_obj.save()

        return JsonResponse({
            "success": True,
            'entry_id': contact_obj.id,
            'qr_code_url': contact_obj.qr_code.url if contact_obj.qr_code else None
        })

    except ContactEntries.DoesNotExist:
        return JsonResponse({'success': False, 'reason': 'Contact not found.'})
    except Exception as e:
        return JsonResponse({'success': False, 'reason': str(e)})
    

def delete_file(request):
    if request.method == "POST":
        entry_id = request.POST.get('entry_id')
        file_type = request.POST.get('file_type')

        try:
            contact_entry = get_object_or_404(ContactEntries, id=entry_id)

            if file_type == 'profile-pic':
                contact_entry.profile_pic.delete()
                contact_entry.profile_pic_thumbnail.delete()
                contact_entry.profile_pic = None
            elif file_type == 'company-logo':
                contact_entry.company_logo.delete()
                contact_entry.company_logo = None
            elif file_type == 'cover-image':
                contact_entry.cover_image.delete()
                contact_entry.cover_image = None
            elif file_type == 'background-image':
                contact_entry.background_image.delete()
                contact_entry.background_image = None
            
            contact_entry.save()
            return JsonResponse({'success': True, 'message': 'File deleted successfully'})
        
        except ContactEntries.DoesNotExist:
            return JsonResponse({'success': False, 'message': 'Entry not found'}, status=404)
    return JsonResponse({'success': False, 'message': 'Invalid request'}, status=400)

def get_contact_detail(request):
    id=request.GET.get('id')
    
    obj=ContactEntries.objects.filter(id=id).values("id","name","personal_number","office_number","whatsapp_number","email","website","location","address","profile_pic","cover_image","designation","company_name")
    
    return JsonResponse({"data":list(obj)[0]})

def delete_contact_entry(request):
    id=request.POST.get('id')
    
    status={"success":False}  
    try:
        status['success']=True
        ContactEntries.objects.filter(id=id).update(active=False)
        
    except Exception as e:
        status['success']=False
    
    return JsonResponse({"status":status})   

# def apk_page(request):
#     return render(request,'apk_page.html')

##Essantails


def create_new_user(request):
    username=request.GET.get('username')
    password=request.GET.get('password')
    
    new_user=User.objects.create_user(username=username,password=password)
    new_user.save()
    
    
    # uid=str(uuid.uuid4()[:6])
    
    UserDetails.objects.create(user=new_user)
    
    
    return HttpResponse('Done')

from typing import List
from smartcard.CardConnection import CardConnection
from smartcard.util import toHexString
import ndef

def create_ndef_record(url: str) -> bytes:
    """Encodes a given URI into a complete NDEF message using ndeflib.

    Args:
        url (str): The URI to be encoded into an NDEF message.

    Returns:
        bytes: The complete NDEF message as bytes, ready to be written to an NFC tag.
    """
    uri_record = ndef.UriRecord(url)

    encoded_message = b''.join(ndef.message_encoder([uri_record]))

    message_length = len(encoded_message)

    initial_message = b'\x03' + message_length.to_bytes(1, 'big') + encoded_message + b'\xFE'

    padding_length = -len(initial_message) % 4
    complete_message = initial_message + (b'\x00' * padding_length)

    return complete_message


def write_ndef_message(connection: CardConnection, ndef_message: bytes) -> bool:
    """Writes the NDEF message to the NFC tag.

    Args:
        connection (CardConnection): The connection to the NFC tag.
        ndef_message (bytes): The NDEF message to be written.

    Returns:
        bool: True if the write operation is successful, False otherwise.
    """
    page = 4  # Starting page
    while ndef_message:
        block_data = ndef_message[:4]  # Write 4 bytes at a time
        ndef_message = ndef_message[4:]  # Update remaining data
        WRITE_COMMAND = [0xFF, 0xD6, 0x00, page, 0x04] + list(block_data)
        
        response, sw1, sw2 = connection.transmit(WRITE_COMMAND)

        if sw1 != 0x90 or sw2 != 0x00:
            print(f"Failed to write to page {page}, SW1: {sw1:02X}, SW2: {sw2:02X}")
            return False

        print(f"Successfully wrote to page {page}")
        page += 1

    return True


def write_to_nfc(request):
    if request.method == "POST":
        # Get the URL (link) to write to the NFC tag
        url_slug = request.POST.get("link")
        data_to_write = url_slug  

        try:
            # List available readers
            r = readers()
            if not r:
                return JsonResponse({"error": "No card reader found!"}, status=400)

            # Find the contactless reader
            reader = next((rdr for rdr in r if "CL" in str(rdr)), None)
            if not reader:
                return JsonResponse({"error": "No contactless card reader found!"}, status=400)

            print(f"Selected reader: {reader}")

            # Connect to the reader
            connection = reader.createConnection()
            connection.connect()

            # Prepare the NDEF message (the URL to be written to the card)
            ndef_message = create_ndef_record(data_to_write)

            # Write the NDEF message to the NFC card
            success = write_ndef_message(connection, ndef_message)

            if success:
                return JsonResponse({"success": "Link written to NFC card successfully!"})
            else:
                return JsonResponse({"error": "Failed to write to NFC card!"}, status=500)

        except Exception as e:
            print(f"Error: {str(e)}")
            return JsonResponse({"error": str(e)}, status=500)

    return JsonResponse({"error": "Invalid request method"}, status=405)

def profile(request,entrie_id):
    entrie=ContactEntries.objects.get(id=entrie_id)
    return render(request, 'pages/profile.html', {'profile':entrie})

def email_signature(request):
    return render(request, 'pages/email_signature.html' )

def contact_email_signature(request,entrie_id):
    contact_details = ContactEntries.objects.get(id=entrie_id)
    return render(request, 'pages/email_signature.html',{'data':contact_details})


def analytics(request):
    total_count = Organizations.objects.filter(active=1)
    contacts = ContactEntries.objects.filter(active=1)
    active_count = ContactEntries.objects.filter(active=1).count()
    customer_details = Customer_Details.objects.filter(active=1)
    page_view_count = customer_details.count()
    growth_count = Customer_Details.objects.filter(active=1,created_at=datetime.now().date()).count()
    data= {'total_count':total_count,'contacts' :contacts,'active_count':active_count,'customer_details':customer_details,'page_view_count':page_view_count,'growth_count':growth_count}
    return render(request, 'pages/analytics.html', data)

def delete_customer_entry(request):
    id=request.POST.get('id')
    print(id)
    
    status={"success":False}  
    try:
        status['success']=True
        Customer_Details.objects.filter(id=id).update(active=0)
        
    except Exception as e:
        status['success']=False
    
    return JsonResponse({"status":status})  

def bulk_upload(request):
    return render(request,'bulk_upload.html')

def build_excel_bulk_upload(request):
    final_data=json.loads(request.POST.get('final_data'))
    print(final_data)
    # error_row_ids=[]
    # for i in final_data:
    #     if validateData(i) == False:
    #         error_row_ids.append(i['row-id'])
    
    # if len(error_row_ids) != 0:
    #     return JsonResponse ({'success':False,'error_rows_ids':error_row_ids}) 
    
    for data in final_data:
        
    
        # buildcardType=BuildCardType.objects.get(name__icontains=data['card-type'])
        # location = Locations.objects.get(name__icontains=data['location'])
        obj=ContactEntries.objects.create(name=data['full-name'],personal_number=data['personal-number'],email=data['email'],address=data['address'],location=data['location'],office_number=data['office-number'],designation=data['designation'],
                                                whatsapp_number=data['whatsapp-number'],website=data['website'],card_id=1,url_slug=generate_contact_url_slug(),created_by_id=request.user.id,writed=0)
    
    
    return JsonResponse({'success':True})
    
 
def validateData(data):
    required_fields = ['full-name', 'personal-number', 'email', 'address', 'designation', 
                       'office-number', 'whatsapp-number', 'webiste', 'location']

    for field in required_fields:
        if field not in data or data[field] is None or data[field] == '':
            print(f"Validation failed: Missing or empty field {field} in row {data}")
            return False

    return True

def update_writed_status(request):
    if request.method == "POST":
        entry_id = request.POST.get("entry_id")
        try:
            entry = ContactEntries.objects.get(id=entry_id)
            entry.writed = 1 
            entry.save()
            return JsonResponse({"success": True})
        except ContactEntries.DoesNotExist:
            return JsonResponse({"success": False, "error": "Entry not found"})
    
    return JsonResponse({"success": False, "error": "Invalid request method"})