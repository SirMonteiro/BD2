# api/views/lider_politico_view.py
from rest_framework.response import Response
from rest_framework.viewsets import ViewSet
from api.utils import RawSQLHelper
# from ..permissions import IsAdmin

class LiderPoliticoView(ViewSet):
    """
    ViewSet para visualizar e criar Líderes Políticos.
    """
    # permission_classes = [IsAdmin]

    # GET /api/lider-politico/
    def list(self, request):
        """
        Lista todos os líderes.
        """
        query = "SELECT * FROM lider"
        data = RawSQLHelper.execute_query(query)
        return Response(data)

    # GET /api/lider-politico/<pk>/
    def retrieve(self, request, pk=None):
        """
        Retorna um líder específico pelo seu nome.
        Nota: Esta tabela possui chave primária composta. Esta busca
        simplificada considera apenas o nome do líder.
        """
        query = "SELECT * FROM lider WHERE nome_lider LIKE %s"
        data = RawSQLHelper.execute_query(query, [f"%{pk}%"])
        return Response(data)

    # POST /api/lider-politico/
    def create(self, request):
        """
        Cria um novo líder.
        """
        codigo_grupo = request.data.get('codigo_grupo')
        nome_lider = request.data.get('nome_lider')
        apoios = request.data.get('apoios')

        query = """
            INSERT INTO lider (codigo_grupo, nome_lider, apoios)
            VALUES (%s, %s, %s)
            RETURNING *;
        """
        params = [codigo_grupo, nome_lider, apoios]

        new_data = RawSQLHelper.execute_query(query, params)
        return Response(new_data)
