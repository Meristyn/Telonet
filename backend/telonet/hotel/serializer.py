from rest_framework.serializers import Serializer
from rest_framework.fields import CharField

class QuerySerializer(Serializer):
    query = CharField(max_length=300)

class ProcedureSerializer(Serializer):
    procedure_name = CharField(max_length=100)
    params = CharField(max_length=300)