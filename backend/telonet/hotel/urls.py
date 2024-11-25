from .views import *
from django.urls import path

urlpatterns = [
  path("", index),
  path("query", QueryView.as_view()),
  path("procedure", ProcedureView.as_view())
]