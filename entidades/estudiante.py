from entidades.persona_natural import persona_natural


def estudiante(
    cursor,
    cod_comuna,
    rut,
    nombre_elemento,
    nombre,
    sexo,
    fecha_nacimiento,
    direccion,
    nombre_pueblo_ori,
    discapacidad,
):
    id_entidad, rut = persona_natural(
        cursor,
        cod_comuna,
        rut,
        nombre_elemento,
        nombre,
        sexo,
        fecha_nacimiento,
        direccion,
        nombre_pueblo_ori,
        discapacidad,
    )

    cursor.execute(
        "INSERT INTO estudiante (id_entidad,rut) VALUES (%s,%s)", (id_entidad, rut)
    )

    return (id_entidad, rut)
