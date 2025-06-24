from rest_framework.response import Response
from rest_framework.viewsets import ViewSet
from api.utils import RawSQLHelper
# from api.permissions import IsStaffOrAdmin, IsAdmin

# from django.contrib.auth.hashers import make_password

class ExampleView(ViewSet):
    # permission_classes = [IsAdmin]
    # or
    # permission_classes = [AllowAny]  # Allow access to unauthenticated users

    # GET /example
    def list(self, request):
        query = "SELECT 'Esta é uma view de exemplo' as message;"
        client_data = RawSQLHelper.execute_query(query)
        # print(make_password("12345678"))
        return Response(client_data)

    # GET /example/<id>
    def retrieve(self, request, pk=None):
        query = "SELECT 'Você pediu pelo exemplo com id %s' as message;"
        client_data = RawSQLHelper.execute_query(query, [pk])
        return Response(client_data)
