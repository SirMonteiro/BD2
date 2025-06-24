# api/views/divisao_view.py
from rest_framework.response import Response
from rest_framework.viewsets import ViewSet
from api.utils import RawSQLHelper
# from ..permissions import IsAdmin

class DivisaoView(ViewSet):
    """
    ViewSet para visualizar e criar Divisões de um Grupo Armado.
    """
    # permission_classes = [IsAdmin]

    # GET /api/divisoes/
    def list(self, request):
        """
        Lista todas as divisões.
        """
        query = "SELECT * FROM divisao"
        data = RawSQLHelper.execute_query(query)
        return Response(data)

    # GET /api/divisoes/<pk>/
    def retrieve(self, request, pk=None):
        """
        Retorna uma divisão específica pelo seu número.
        Nota: Esta tabela possui chave primária composta. Esta busca
        simplificada considera apenas o número da divisão.
        """
        query = "SELECT * FROM divisao WHERE numero_divisao = %s"
        data = RawSQLHelper.execute_query(query, [pk])
        return Response(data)

    # POST /api/divisoes/
    def create(self, request):
        """
        Cria uma nova divisão.
        """
        codigo_grupo = request.data.get('codigo_grupo')
        nr_avioes = request.data.get('nr_avioes')
        nr_tanques = request.data.get('nr_tanques')
        nr_barcos = request.data.get('nr_barcos')
        nr_membros = request.data.get('nr_membros')
        nr_baixas = request.data.get('nr_baixas')

        query = """
            INSERT INTO divisao (codigo_grupo, nr_avioes, nr_tanques, nr_barcos, nr_membros, nr_baixas)
            VALUES (%s, %s, %s, %s, %s, %s)
            RETURNING *;
        """
        params = [codigo_grupo, nr_avioes, nr_tanques, nr_barcos, nr_membros, nr_baixas]

        new_data = RawSQLHelper.execute_query(query, params)
        return Response(new_data)
