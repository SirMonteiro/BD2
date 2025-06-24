# api/views/estatisticas_tipo_conflito_view.py
from rest_framework.response import Response
from rest_framework.viewsets import ViewSet
from api.utils import RawSQLHelper
# from ..permissions import IsAdmin

class EstatisticasTipoConflitoView(ViewSet):
    """
    Retorna um histograma por tipo de conflito.
    """
    # permission_classes = [IsAdmin]

    # GET /api/estatisticas/tipo-conflito/
    def list(self, request):
        """
        Gera um histograma (contagem) de conflitos por tipo.
        """
        query = "SELECT tipo_conf, COUNT(*) as total FROM conflito GROUP BY tipo_conf;"
        data = RawSQLHelper.execute_query(query)
        return Response(data)
