# api/views/grupo_view.py
from rest_framework.response import Response
from rest_framework.viewsets import ViewSet
from api.utils import RawSQLHelper
# from ..permissions import IsAdmin

class GrupoView(ViewSet):
    """
    ViewSet para visualizar e criar Grupos Armados.
    """
    # permission_classes = [IsAdmin]

    # GET /api/grupos/
    def list(self, request):
        """
        Lista todos os grupos armados.
        """
        query = "SELECT * FROM grupo_armado"
        data = RawSQLHelper.execute_query(query)
        return Response(data)

    # GET /api/grupos/<pk>/
    def retrieve(self, request, pk=None):
        """
        Retorna um grupo armado específico pelo seu código.
        """
        query = "SELECT * FROM grupo_armado WHERE codigo = %s"
        data = RawSQLHelper.execute_query(query, [pk])
        return Response(data)

    # POST /api/grupos/
    def create(self, request):
        """
        Cria um novo grupo armado.
        """
        nome = request.data.get('nome')
        soma_baixas = request.data.get('soma_baixas')

        query = """
            INSERT INTO grupo_armado (nome, soma_baixas)
            VALUES (%s, %s)
            RETURNING *;
        """
        params = [nome, soma_baixas]

        new_data = RawSQLHelper.execute_query(query, params)
        return Response(new_data)
