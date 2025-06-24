# api/views/estatisticas_arma_traficante_view.py
from rest_framework.response import Response
from rest_framework.viewsets import ViewSet
from api.utils import RawSQLHelper
# from ..permissions import IsAdmin

class EstatisticasArmaTraficanteView(ViewSet):
    """
    Lista os traficantes e grupos armados para armas específicas.
    """
    # permission_classes = [IsAdmin]

    # GET /api/estatisticas/arma-traficante/
    def list(self, request):
        """
        Lista traficantes e grupos para os quais forneceram armas
        'Barret M82' ou 'M200 intervention'.
        """
        query = """
            SELECT t.nome as nome_traficante, t.sobrenome, ga.nome as nome_grupo_armado, h.modelo_arma
            FROM historico_venda_armas h
            JOIN traficante t ON h.codigo_traficante = t.codigo
            JOIN grupo_armado ga ON h.codigo_grupo_armado = ga.codigo
            WHERE h.modelo_arma IN ('Barret M82', 'M200 intervention');
        """
        data = RawSQLHelper.execute_query(query)
        return Response(data)
