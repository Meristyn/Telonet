from django.db import connection

def querySQL(query: str):
    try:
        with connection.cursor() as cursor:
            cursor.execute(query)
            result = cursor.fetchall()
            columns = [col[0] for col in cursor.description]
            return {"columns": columns, "data": result}
    except Exception as e:
        return {"error": str(e)}