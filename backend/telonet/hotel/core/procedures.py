from django.db import connection

def call_procedure(proc_name:str, params:list):
    with connection.cursor() as cursor:
        placeholders = ', '.join(['%s'] * len(params))
        sql = f"CALL {proc_name}({placeholders})"
        
        cursor.execute(sql, params)
        
        result = cursor.fetchall()
        columns = [col[0] for col in cursor.description]
        return [dict(zip(columns, row)) for row in result]