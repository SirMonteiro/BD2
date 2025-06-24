# api/views/conflito_view.py
from rest_framework.response import Response
from rest_framework.viewsets import ViewSet
from api.utils import RawSQLHelper
# from ..permissions import IsAdmin

class ConflitoView(ViewSet):
    """
    ViewSet para visualizar e criar Conflitos.
    """
    # permission_classes = [IsAdmin]

    # GET /api/conflitos/
    def list(self, request):
        """
        Lista todos os conflitos.
        """
        query = "SELECT * FROM conflito"
        data = RawSQLHelper.execute_query(query)
        return Response(data)

    # GET /api/conflitos/<pk>/
    def retrieve(self, request, pk=None):
        """
        Retorna um conflito específico pelo seu código.
        """
        query = "SELECT * FROM conflito WHERE codigo = %s"
        data = RawSQLHelper.execute_query(query, [pk])
        return Response(data)

    # POST /api/conflitos/
    def create(self, request):
        """
        Cria um novo conflito.
        """
        nome = request.data.get('nome')
        tipo_conf = request.data.get('tipo_conf')
        nr_feridos = request.data.get('nr_feridos')
        nr_mortos = request.data.get('nr_mortos')

        query = """
            INSERT INTO conflito (nome, tipo_conf, nr_feridos, nr_mortos)
            VALUES (%s, %s, %s, %s)
            RETURNING *;
        """
        params = [nome, tipo_conf, nr_feridos, nr_mortos]

        new_data = RawSQLHelper.execute_query(query, params)
        return Response(new_data)
