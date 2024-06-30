from entidades.entidad import entidad

def persona_natural(
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
    id_entidad = entidad(cursor, nombre, cod_comuna)
    if id_entidad is not None:
        cursor.execute(
            f"INSERT INTO persona_natural (id_entidad,rut,nombre_elemento,nombre,sexo,fecha_nacimiento,direccion,nombre_pueblo_ori,discapacidad) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)",
            (
                id_entidad,
                rut,
                nombre_elemento,
                nombre,
                sexo,
                fecha_nacimiento,
                direccion,
                nombre_pueblo_ori,
                discapacidad,
            ),
        )
