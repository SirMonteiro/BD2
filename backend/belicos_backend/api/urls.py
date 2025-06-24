from django.urls import path, include
from rest_framework import routers
from .views import *

router = routers.DefaultRouter()

# Example route
router.register(r'example', ExampleView, basename='example')

# Login routes
router.register(r'login', LoginView, basename='login')

# Cadastro de entidades
router.register(r'conflitos', ConflitoView, basename='conflito')
router.register(r'grupos', GrupoView, basename='grupo')
router.register(r'divisoes', DivisaoView, basename='divisao')
router.register(r'chefe-militar', ChefeMilitarView, basename='chefe-militar')
router.register(r'lider-politico', LiderPoliticoView, basename='lider-politico')

# Relatórios
router.register(r'estatisticas/tipo-conflito', EstatisticasTipoConflitoView, basename='estatisticas-tipo-conflito')
router.register(r'estatisticas/arma-traficante', EstatisticasArmaTraficanteView, basename='estatisticas-arma-traficante')
router.register(r'estatisticas/top-conflitos-mortos', EstatisticasTopConflitosMortosView, basename='estatisticas-top-conflitos-mortos')
router.register(r'estatisticas/top-organizacoes', EstatisticasTopOrganizacoesView, basename='estatisticas-top-organizacoes')
router.register(r'estatisticas/top-grupos-armas', EstatisticasTopGruposArmasView, basename='estatisticas-top-grupos-armas')
router.register(r'estatisticas/pais-religiosos', EstatisticasPaisReligiososView, basename='estatisticas-pais-religiosos')

urlpatterns = [
    path('', include(router.urls)),
]
