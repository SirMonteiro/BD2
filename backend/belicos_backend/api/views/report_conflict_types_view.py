from rest_framework.response import Response
from rest_framework.viewsets import ViewSet
from api.utils import RawSQLHelper
from api.permissions import IsStaffOrAdmin, IsAdmin

class ConflictTypeHistogramView(ViewSet):
    permission_classes = [IsAdmin]

    def list(self, request):
        query = """
            SELECT tipo_conflito AS tipo, COUNT(*) AS quantidade
            FROM conflito
            GROUP BY tipo_conflito
            ORDER BY quantidade DESC
        """
        data = RawSQLHelper.execute_query(query)
        return Response(data)
