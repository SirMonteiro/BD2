# api/views/estatisticas_top_conflitos_mortos_view.py
from rest_framework.response import Response
from rest_framework.viewsets import ViewSet
from api.utils import RawSQLHelper
# from ..permissions import IsAdmin

class EstatisticasTopConflitosMortosView(ViewSet):
    """
    Lista os 5 maiores conflitos em número de mortos.
    """
    # permission_classes = [IsAdmin]

    # GET /api/estatisticas/top-conflitos-mortos/
    def list(self, request):
        """
        Retorna o top 5 de conflitos com mais mortos.
        """
        query = "SELECT nome, nr_mortos FROM conflito ORDER BY nr_mortos DESC LIMIT 5;"
        data = RawSQLHelper.execute_query(query)
        return Response(data)
