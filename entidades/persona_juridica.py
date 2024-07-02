from entidades.entidad import entidad


def persona_juridica(cursor, nombre, cod_comuna):
    id_entidad = entidad(cursor, nombre, cod_comuna)

    cursor.execute(
        "INSERT INTO persona_juridica (id_entidad) VALUES (%s)", (id_entidad,)
    )

    return id_entidad
