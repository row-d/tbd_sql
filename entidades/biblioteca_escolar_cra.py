from entidades.biblioteca import biblioteca


def biblioteca_escolar_cra(cursor, nom_bib, codigo_est) -> None:
    id_biblioteca = biblioteca(cursor, nom_bib)
    codigo_est = int(codigo_est)
    cursor.execute(
        "INSERT INTO biblioteca_escolar_cra (id_biblioteca,codigo_est) VALUES (%s,%s)",
        (id_biblioteca, codigo_est),
    )
