from django.urls import path, include
from rest_framework import routers
from .views import *

router = routers.DefaultRouter()

# Example route
router.register(r'example', ExampleView, basename='example')

# Login routes
router.register(r'login', LoginView, basename='login')

# Cadastro de entidades
# router.register(r'military-groups', MilitaryGroupView, basename='military-groups')
# router.register(r'military-divisions', MilitaryDivisionView, basename='military-divisions')
# router.register(r'military-leaders', MilitaryLeaderView, basename='military-leaders')
# router.register(r'political-leaders', PoliticalLeaderView, basename='political-leaders')
# router.register(r'conflicts', ConflictView, basename='conflicts')

# Relatórios
router.register(r'reports/conflict-types-histogram', ConflictTypeHistogramView, basename='report-conflict-types')
# router.register(r'reports/arms-dealers-barrett-m200', ArmsDealersSpecificWeaponsView, basename='report-arms-dealers')
# router.register(r'reports/top-deadly-conflicts', TopDeadlyConflictsView, basename='report-deadliest')
# router.register(r'reports/top-mediating-orgs', TopMediatingOrgsView, basename='report-mediators')
# router.register(r'reports/top-armed-groups', TopArmedGroupsView, basename='report-armed-groups')
# router.register(r'reports/top-religious-country', TopReligiousConflictCountryView, basename='report-religious')

urlpatterns = [
    path('', include(router.urls)),
]
