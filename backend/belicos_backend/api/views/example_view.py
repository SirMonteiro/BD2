from rest_framework.response import Response
from rest_framework.viewsets import ViewSet
from api.utils import RawSQLHelper
from api.permissions import IsStaffOrAdmin, IsAdmin

from django.contrib.auth.hashers import make_password

class ExampleView(ViewSet):
    permission_classes = [IsAdmin]

    # GET /conflitos
    def list(self, request):
        query = "SELECT * FROM conflitos"
        client_data = RawSQLHelper.execute_query(query)
        print(make_password("12345678"))
        return Response(client_data)

    # GET /conflitos/<id>
    def retrieve(self, request, pk=None):
        query = "SELECT * FROM conflitos WHERE id = %s"
        client_data = RawSQLHelper.execute_query(query, [pk])
        return Response(client_data)
