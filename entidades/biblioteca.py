def biblioteca(cursor, nombre_bib):
    cursor.execute(
        "INSERT INTO biblioteca (nombre_bib) VALUES (%s) RETURNING id_biblioteca",
        (nombre_bib,),
    )
    result = cursor.fetchone()
    return result[0]
