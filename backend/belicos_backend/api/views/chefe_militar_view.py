# api/views/chefe_militar_view.py
from rest_framework.response import Response
from rest_framework.viewsets import ViewSet
from api.utils import RawSQLHelper
# from ..permissions import IsAdmin

class ChefeMilitarView(ViewSet):
    """
    ViewSet para visualizar e criar Chefes Militares.
    """
    # permission_classes = [IsAdmin]

    # GET /api/chefe-militar/
    def list(self, request):
        """
        Lista todos os chefes militares.
        """
        query = "SELECT * FROM chefe_militar"
        data = RawSQLHelper.execute_query(query)
        return Response(data)

    # GET /api/chefe-militar/<pk>/
    def retrieve(self, request, pk=None):
        """
        Retorna um chefe militar específico pelo seu código.
        """
        query = "SELECT * FROM chefe_militar WHERE codigo_chefe = %s"
        data = RawSQLHelper.execute_query(query, [pk])
        return Response(data)

    # POST /api/chefe-militar/
    def create(self, request):
        """
        Cria um novo chefe militar.
        """
        faixa_hierarquica = request.data.get('faixa_hierarquica')
        nome_lider = request.data.get('nome_lider')
        codigo_lider = request.data.get('codigo_lider')
        numero_divisao = request.data.get('numero_divisao')
        grupo_divisao = request.data.get('grupo_divisao')

        query = """
            INSERT INTO chefe_militar (faixa_hierarquica, nome_lider, codigo_lider, numero_divisao, grupo_divisao)
            VALUES (%s, %s, %s, %s, %s)
            RETURNING *;
        """
        params = [faixa_hierarquica, nome_lider, codigo_lider, numero_divisao, grupo_divisao]

        new_data = RawSQLHelper.execute_query(query, params)
        return Response(new_data)
