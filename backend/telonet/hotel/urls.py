from django.urls import path
from .views import (
    index, QueryView, ProcedureView, AdministradorView, ClienteView, EventoView, ServicioView, LoginView
)

urlpatterns = [
    path("", index, name="index"),
    path("query/", QueryView.as_view(), name="query"),
    path("procedure/", ProcedureView.as_view(), name="procedure"),
    path("administradores/", AdministradorView.as_view(), name="administradores"),
    path("clientes/", ClienteView.as_view(), name="clientes"),
    path("eventos/", EventoView.as_view(), name="eventos"),
    path("servicios/", ServicioView.as_view(), name="servicios"),
    path("login/", LoginView.as_view(), name="login"),
]