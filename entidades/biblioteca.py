def biblioteca(cursor, nombre_bib):
    cursor.execute(
        "INSERT INTO biblioteca (nombre_bib) VALUES (%s) RETURNING id_biblioteca",
        (nombre_bib,),
    )
    id_biblioteca = cursor.fetchone()[0]
    return int(id_biblioteca)
