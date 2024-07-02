def artesania(cursor, nombre_producto, ano_sello, id_artesano, rut_artesano):
    ano_sello = int(ano_sello)
    id_artesano = int(id_artesano)
    rut_artesano = int(rut_artesano)
    cursor.execute(
        "INSERT INTO artesania (nombre_producto,ano_sello,id_artesano,rut_artesano) VALUES (%s,%s,%s,%s) RETURNING id_artesania",
        (nombre_producto, ano_sello, id_artesano, rut_artesano),
    )
