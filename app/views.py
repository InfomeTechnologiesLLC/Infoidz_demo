import json
from django.http import JsonResponse
from django.shortcuts import render ,HttpResponse
from portal.models import ContactEntries,CutomizedCard,Customer_Details
import vobject
from app.models import cards
from portal.models import *
from django.template.loader import render_to_string
from portal.utilities import generate_contact_url_slug
# Create your views here.


def main_page(request):
    return render(request,'index1.html')

# def card_page(request,slug):

#     entry=ContactEntries.objects.filter(url_slug=slug).prefetch_related('social_medias')
    
#     if not entry.exists() :
#         return render(request,'card/not-found.html')
    
#     data={"entry":entry.first(),'social_medias':entry.first().social_medias.all()}
    
#     return render(request,f'card/{entry.first().card.name}.html',data)

def card_page(request, slug):
    entry = ContactEntries.objects.filter(url_slug=slug).prefetch_related('social_medias')

    if not entry.exists():
        return render(request, 'card/not-found.html')

    entry = entry.first()
    try:
        customized_card = CutomizedCard.objects.get(contact_id=entry.id)
        styles = json.loads(customized_card.styles)  
    except CutomizedCard.DoesNotExist:
        styles = {}

    data = {
        "entry": entry,
        'social_medias': entry.social_medias.all(),
        'styles': styles,  
    }

    return render(request, f'card/{entry.card.name}.html', data)



def preview_card(request, card_id):
    edit_id = request.GET.get('edit_id')
    
    entry = ContactEntries.objects.filter(card__id=card_id, id=edit_id).prefetch_related('social_medias').first()

    if not entry:
        return render(request, 'card/card_preview.html', {'error': 'No matching card found.'})
    
    try:
        card = CutomizedCard.objects.get(contact_id=entry.id)
        styles = json.loads(card.styles)
    except CutomizedCard.DoesNotExist:
        styles = {}

    card_html = render_to_string(f'card/{entry.card.name}.html', {'entry': entry, 'social_medias':entry.social_medias.all(), 'edit_id': edit_id,'styles':styles })

    return render(request, 'card/card_preview.html', {'card_html': card_html,'edit_id': edit_id,'styles': json.dumps(styles), 'card_id': card_id})



def save_card_styles(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        contact_id = data.get('contact_id')
        styles = data.get('styles')
        # print(styles)

        if not styles:
            styles = {}

        card = CutomizedCard.objects.filter(contact_id=contact_id).first()
        if card:
            card.styles = json.dumps(styles)
        else:
            card = CutomizedCard(contact_id=contact_id, styles=json.dumps(styles))
        
        card.save()

        return JsonResponse({'status': 'success'})



import base64
def getVcard(request,slug):
    
    
    entrie=ContactEntries.objects.filter(url_slug=slug).first()
    
    if entrie.profile_pic != '':
        with open(entrie.profile_pic.path, "rb") as image_file:
            
            profile_pic_base64 = base64.b64encode(image_file.read()).decode("utf-8")
    else:
        profile_pic_base64=''
        
        
    vcard_data =f"""BEGIN:VCARD
VERSION:3.0
FN:{entrie.name}
TEL;TYPE=cell:{entrie.personal_number}
EMAIL:{entrie.email}
TITLE:{entrie.designation}
URL:{entrie.website}
PHOTO;ENCODING=b;TYPE=JPEG:{profile_pic_base64}
END:VCARD"""

 
    # Create a response with the vCard data
    response = HttpResponse(vcard_data, content_type='text/vcard')
    response['Content-Disposition'] = f"""attachment; filename="{entrie.name} - contact.vcf"""

    return response

def demo_page(request):
    return render(request,'demo/index.html')

def infoid_page(request):
    return render(request,'info-id/index.html')

#counter event registration

def registration_page(request):
    social_medias = socialMedias.objects.filter(active=True)
    data = {
        'social_medias':social_medias
    }
    return render(request,'registration.html',data)

def registration(request):
    if request.method == "POST":
        fullname = request.POST.get('first_name') + " " + request.POST.get('last_name')
        personal_number = request.POST.get('personal_number')
        email = request.POST.get('email')
        address = request.POST.get('address')
        designation = request.POST.get('designation')
        office_number = request.POST.get('office_number')
        whatsapp_number = request.POST.get('whatsapp_number')
        website = request.POST.get('website')
        location = request.POST.get('location')
        company_name = request.POST.get('company_name')
        profile_pic = request.FILES.get('profile_pic')
        profile_thumbnail = request.FILES.get('profile_thumbnail')
        cover_image = request.FILES.get('cover_image')

        registration_obj = ContactEntries.objects.create(
            name=fullname,
            personal_number=personal_number,
            email=email,
            address=address,
            designation=designation,
            company_name=company_name,
            office_number=office_number,
            whatsapp_number=whatsapp_number,
            website=website,
            location=location,
            profile_pic=profile_pic,
            profile_pic_thumbnail=profile_thumbnail,
            cover_image=cover_image,
            card_id = 1,
            active = True,
            created_by_id = 1,
            url_slug = generate_contact_url_slug()
        )
        social_links = request.POST.get('social_links')
        if social_links:
            social_links = json.loads(social_links)
            _social_links = []
            for s in social_links:
                social_media = socialMedias.objects.get(id=s['social_media_type'])
                _social_links_obj = contactEntrySocialMedias.objects.create(link=s['social_media_link'], social_media=social_media)
                _social_links.append(_social_links_obj)

            registration_obj.social_medias.add(*_social_links)


        return JsonResponse({'message': 'Registration successful'})


def submit_details(request):
    if request.method == "POST":
        try:
            data = json.loads(request.body.decode("utf-8"))
            name = data.get('name')
            email = data.get('email')
            phone = data.get('phone')

            # print(f"Name: {name}, Email: {email}, Phone: {phone}")
            customer = Customer_Details.objects.create(
                name=name,
                email=email,
                phone=phone,
                active=1
            )
            return JsonResponse({'success': True, 'message': 'Details saved successfully!'})
        except Exception as e:
            return JsonResponse({'success': False, 'message': str(e)})
    return JsonResponse({'success': False, 'message': 'Invalid request method.'})