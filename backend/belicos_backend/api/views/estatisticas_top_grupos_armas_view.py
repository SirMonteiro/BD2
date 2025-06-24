# api/views/estatisticas_top_grupos_armas_view.py
from rest_framework.response import Response
from rest_framework.viewsets import ViewSet
from api.utils import RawSQLHelper
# from ..permissions import IsAdmin

class EstatisticasTopGruposArmasView(ViewSet):
    """
    Lista os 5 maiores grupos armados com maior número de armas fornecidas.
    """
    # permission_classes = [IsAdmin]

    # GET /api/estatisticas/top-grupos-armas/
    def list(self, request):
        """
        Retorna o top 5 de grupos armados que mais receberam armas.
        """
        query = """
            SELECT ga.nome, SUM(h.qtd_vendida) as total_armas
            FROM grupo_armado ga
            JOIN historico_venda_armas h ON ga.codigo = h.codigo_grupo_armado
            GROUP BY ga.codigo, ga.nome
            ORDER BY total_armas DESC
            LIMIT 5;
        """
        data = RawSQLHelper.execute_query(query)
        return Response(data)
