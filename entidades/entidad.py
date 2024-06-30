def entidad(cursor,nombre,cod_comuna)-> int | None:
  cursor.execute(f"INSERT INTO entidad (nombre,cod_comuna) VALUES (%s,%s) RETURNING id_entidad",(nombre,cod_comuna))
  result = cursor.fetchone()
  return result[0] if result else None