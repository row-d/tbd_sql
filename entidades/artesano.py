from entidades.persona_natural import persona_natural


def artesano(
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
    disciplina,
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
        "INSERT INTO artesano (id_entidad,rut,disciplina) VALUES (%s,%s,%s)",
        (id_entidad, rut, disciplina),
    )

    return (id_entidad, rut)
