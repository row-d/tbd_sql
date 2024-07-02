def establecimiento_educacional(cursor, nombre, cod_comuna):
    cod_comuna = int(cod_comuna)
    cursor.execute(
        "INSERT INTO establecimiento_educacional (nombre,cod_comuna) VALUES (%s,%s) RETURNING codigo_est",
        (nombre, cod_comuna),
    )
    return int(cursor.fetchone()[0])
