from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from django.contrib.auth import authenticate, login
from django.utils import timezone
from datetime import datetime,timedelta
from django.http import JsonResponse
from rest_framework.permissions import IsAuthenticated
from portal.models import ContactEntries 
from .serializers import ContactEntriesSerializer
from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator
from django.db.models import Count
from django.db.models.functions import TruncDate

@method_decorator(csrf_exempt, name='dispatch')
class ValidateLoginAPI(APIView):

    def post(self, request, *args, **kwargs):
        username = request.data.get('username')
        password = request.data.get('password')

        if not username or not password:
            return Response({"ErrorCode": "invalid_data", "reason": "Username and password are required.", "success": False},status=status.HTTP_400_BAD_REQUEST)
        user = authenticate(username=username, password=password)
        if user is not None:
            login(request, user)
            try:
                if user.profile.organization.expiry_date <= timezone.now().date():
                    return Response({"ErrorCode": "expiry_date", "reason": "Activation is expired", "success": True},status=status.HTTP_200_OK)
                return Response({"success": True}, status=status.HTTP_200_OK)
            except Exception as e:
                return Response({"ErrorCode": "user_not_found", "reason": "Something went wrong", "success": False},status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        else:
            return Response({"ErrorCode": "user_not_found", "reason": "Invalid username or password. Please try again.", "success": False},status=status.HTTP_401_UNAUTHORIZED)


class DashboardAPI(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, *args, **kwargs):
        all_contacts = ContactEntries.objects.filter(active=True)

        total_contact_count = all_contacts.count()
        this_month_count = all_contacts.filter(created_at__month=datetime.today().month,created_at__year=datetime.today().year).count()

        this_week_count = all_contacts.filter(created_at__range=[datetime.today().date() - timedelta(days=7), datetime.today()]).count()

        today_count = all_contacts.filter(created_at__month=datetime.today().month,created_at__year=datetime.today().year,created_at__day=datetime.today().day).count()

        last_15_days_counts = list(all_contacts.filter(created_at__range=[datetime.today() - timedelta(days=15), datetime.today()]).annotate(day=TruncDate('created_at')).values('day').annotate(n=Count('day')).values('day', 'n'))

        for d in last_15_days_counts:
            d["day"] = d["day"].strftime('%d-%b')

        data = {'last_15_days': last_15_days_counts,'total_count': total_contact_count,'this_month_count': this_month_count,'this_week_count': this_week_count,'today_count': today_count}

        return Response(data)    

class ContactsAPI(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, *args, **kwargs):
        entries = ContactEntries.objects.filter(active=True,created_by__profile__organization=request.user.profile.organization).order_by('-id')
        
        serializer = ContactEntriesSerializer(entries, many=True)
        return Response({"entries": serializer.data}, status=200)
    

