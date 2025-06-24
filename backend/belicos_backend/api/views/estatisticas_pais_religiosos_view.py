# api/views/estatisticas_pais_religiosos_view.py
from rest_framework.response import Response
from rest_framework.viewsets import ViewSet
from api.utils import RawSQLHelper
# from ..permissions import IsAdmin

class EstatisticasPaisReligiososView(ViewSet):
    """
    Lista o país com maior número de conflitos religiosos.
    """
    # permission_classes = [IsAdmin]

    # GET /api/estatisticas/pais-religiosos/
    def list(self, request):
        """
        Retorna o país com mais conflitos do tipo 'Religioso'.
        """
        query = """
            SELECT p.nome, COUNT(c.codigo) as numero_conflitos_religiosos
            FROM pais p
            JOIN paises_afetados pa ON p.codigo = pa.codigo_pais
            JOIN conflito c ON pa.codigo_conflito = c.codigo
            WHERE c.tipo_conf = 'Religioso'
            GROUP BY p.codigo, p.nome
            ORDER BY numero_conflitos_religiosos DESC
            LIMIT 1;
        """
        data = RawSQLHelper.execute_query(query)
        return Response(data)
