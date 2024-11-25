from django.http import HttpResponse
from rest_framework.views import APIView
from rest_framework.response import Response
from .core import sql
from .core.procedures import call_procedure
from .serializer import QuerySerializer, ProcedureSerializer

from django.contrib.auth import authenticate
from rest_framework.views import APIView
from rest_framework.response import Response

class LoginView(APIView):
    def post(self, request):
        correo = request.data.get('correo')
        contrasena = request.data.get('contrasena')

        user = authenticate(username=correo, password=contrasena)
        if user:
            return Response({
                "id_cliente": user.id,
                "nombre": user.first_name
            })
        return Response({"error": "Credenciales inválidas"}, status=400)


# Vista de prueba inicial
def index(request):
    return HttpResponse("Hola mundo desde la API")

# Ejecutar consultas SQL genéricas
class QueryView(APIView):
    def get(self, request):
        serializer = QuerySerializer(data=request.GET)
        if serializer.is_valid():
            query = serializer.validated_data['query']
            results = sql.querySQL(query=query)
            return Response({"results": results})
        return Response(serializer.errors, status=400)

# Ejecutar procedimientos almacenados
class ProcedureView(APIView):
    def post(self, request):
        serializer = ProcedureSerializer(data=request.data)
        if serializer.is_valid():
            procedure_name = serializer.validated_data['procedure_name']
            params = serializer.validated_data['params']
            results = call_procedure(procedure_name, params)
            return Response({"results": results})
        return Response(serializer.errors, status=400)

# Gestionar administradores
class AdministradorView(APIView):
    def get(self, request):
        query = "SELECT id, nombre, correo, creado_en FROM administrador;"
        administradores = sql.querySQL(query=query)
        return Response({"data": administradores})

# Gestionar clientes
class ClienteView(APIView):
    def get(self, request):
        query = "SELECT id_cliente, nombre, apellido, correo FROM cliente;"
        clientes = sql.querySQL(query=query)
        return Response({"data": clientes})

    def post(self, request):
        data = request.data
        query = f"""
            INSERT INTO cliente (nombre, apellido, correo, contrasena, nacionalidad, fecha_nacimiento, DNI)
            VALUES ('{data['nombre']}', '{data['apellido']}', '{data['correo']}', '{data['contrasena']}',
                    '{data['nacionalidad']}', '{data['fecha_nacimiento']}', '{data['dni']}')
        """
        sql.querySQL(query=query)
        return Response({"message": "Cliente agregado exitosamente"})

# Gestionar eventos
class EventoView(APIView):
    def get(self, request):
        query = "SELECT id_evento, nombre, fecha, descripcion, precio FROM evento;"
        eventos = sql.querySQL(query=query)
        return Response({"data": eventos})


# Gestionar servicios
class ServicioView(APIView):
    def get(self, request):
        # Consulta para obtener todos los servicios
        query = "SELECT id_servicio, nombre, descripcion, precio FROM servicio;"
        servicios = sql.querySQL(query=query)
        return Response({"data": servicios})
