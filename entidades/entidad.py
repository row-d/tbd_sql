def entidad(cursor, nombre, cod_comuna):
    cod_comuna = int(cod_comuna)
    cursor.execute(
        "INSERT INTO entidad (nombre,cod_comuna) VALUES (%s,%s) RETURNING id_entidad",
        (nombre, cod_comuna),
    )
    result = cursor.fetchone()
    return int(result[0])
