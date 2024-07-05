from  psycopg2._psycopg import cursor as CURSOR

def estudia(
    cursor : CURSOR,
    codigo_est: int,
    id_estudiante: int,
    rut_estudiante: int,
    nivel_alumno_ano: str,
    ano: int,   
):
    cursor.execute(
        "INSERT INTO estudia (codigo_est, id_estudiante, rut_estudiante, nivel_alumno_ano, ano) VALUES (%s, %s, %s, %s, %s)",
        (codigo_est, id_estudiante, rut_estudiante, nivel_alumno_ano, ano),
    )
    cursor.execute("SELECT id_biblioteca FROM biblioteca_escolar_cra WHERE codigo_est = %s", (codigo_est,))
    ids_bibliotecas = cursor.fetchall()
    
    for row in ids_bibliotecas: 
        id_biblioteca = row[0]
        if nivel_alumno_ano == 'basica':
            cursor.execute("UPDATE atiende_ano SET nivel_basico = nivel_basico + 1 WHERE id_biblioteca = %s and ano = %s", (id_biblioteca,ano))
        
        elif nivel_alumno_ano == 'media':
            cursor.execute("UPDATE atiende_ano SET nivel_medio = nivel_medio + 1 WHERE id_biblioteca = %s and ano = %s", (id_biblioteca,ano))
