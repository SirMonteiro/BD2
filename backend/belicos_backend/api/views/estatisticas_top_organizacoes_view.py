# api/views/estatisticas_top_organizações_view.py
from rest_framework.response import Response
from rest_framework.viewsets import ViewSet
from api.utils import RawSQLHelper
# from ..permissions import IsAdmin

class EstatisticasTopOrganizacoesView(ViewSet):
    """
    Lista as 5 maiores organizações em número de mediações.
    """
    # permission_classes = [IsAdmin]

    # GET /api/estatisticas/top-organizacoes/
    def list(self, request):
        """
        Retorna o top 5 de organizações com mais mediações de entrada em conflitos.
        """
        query = """
            SELECT o.nome, COUNT(m.codigo_organizacao) as numero_mediacoes
            FROM organizacao o
            JOIN mediacao_entrada m ON o.codigo = m.codigo_organizacao
            GROUP BY o.codigo, o.nome
            ORDER BY numero_mediacoes DESC
            LIMIT 5;
        """
        data = RawSQLHelper.execute_query(query)
        return Response(data)
