def ano(cursor, year):
    year = int(year)
    cursor.execute("INSERT INTO ano (ano) VALUES (%s)", (year,))
