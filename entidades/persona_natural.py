from entidades.entidad import entidad
from valores import (
    tipo_pueblo_originario,
    tipo_sexo,
    valores_nombre_elemento_patrimonio_inmaterial,
)


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
    rut = int(rut)
    id_entidad = entidad(cursor, nombre, cod_comuna)
    cursor.execute(
        "INSERT INTO persona_natural (id_entidad,rut,nombre_elemento,sexo,fecha_nacimiento,direccion,nombre_pueblo_ori,discapacidad) VALUES (%s,%s,%s,%s,%s,%s,%s,%s)",
        (
            id_entidad,
            rut,
            nombre_elemento,
            sexo,
            fecha_nacimiento,
            direccion,
            nombre_pueblo_ori,
            discapacidad,
        ),
    )
    return (id_entidad, rut)
