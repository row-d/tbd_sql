def atiende_ano(cursor, id_biblioteca, ano):
    cursor.execute(
        "INSERT INTO atiende_ano (id_biblioteca, ano) VALUES (%s, %s)",
        (id_biblioteca, ano),
    )
    
