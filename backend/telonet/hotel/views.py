from django.http import HttpResponse
from rest_framework.views import APIView
from rest_framework.response import Response

from .serializer import QuerySerializer
from .core import sql

# Create your views here.
def index(request):
  return HttpResponse("Hola mundo desde la api")

class QueryView(APIView):
  def get(self, request):
    serializer = QuerySerializer(data=request.GET)
    if serializer.is_valid():
      query = serializer.validated_data['query']

      results = sql.querySQL(query=query)

      return Response({"results": results})
    else:
      return Response(serializer.errors, status=400)
  
  def post(self, request):
    serializer = QuerySerializer(data=request.data)
    if serializer.is_valid():
      query = serializer.validated_data['query']
      results = sql.querySQL(query=query)

      return Response({"results": results})
    else:
      return Response(serializer.errors, status=400)