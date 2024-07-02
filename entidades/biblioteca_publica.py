from entidades.biblioteca import biblioteca


def biblioteca_publica(cursor, nom_bib, id_persona_juridica) -> None:
    id_biblioteca = biblioteca(cursor, nom_bib)

    cursor.execute(
        "INSERT INTO biblioteca_publica (id_biblioteca,id_persona_jur) VALUES (%s,%s)",
        (id_biblioteca,id_persona_juridica),
    )
