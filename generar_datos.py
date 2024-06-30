from os import getenv
from dotenv import load_dotenv
import psycopg2
from faker import Faker
from dominios import *

def random_run(fake: Faker)-> int:
  return fake.unique.random_int(10000000,99999999)

def patrimonio_inmaterial(cursor,nombre_elemento):
  cursor.execute(f"INSERT INTO patrimonio_inmaterial (nombre_elemento) VALUES ('{nombre_elemento}')")

def entidad(cursor,nombre,cod_comuna)-> int | None:
  cursor.execute(f"INSERT INTO entidad (nombre,cod_comuna) VALUES ('{nombre}',{cod_comuna}) RETURNING id_entidad")
  result = cursor.fetchone()
  return result[0] if result else None

def persona_natural(cursor,cod_comuna,rut,nombre_elemento,nombre,sexo,fecha_nacimiento,direccion,nombre_pueblo_ori,discapacidad):
  id_entidad = entidad(cursor,nombre,cod_comuna)
  if id_entidad is not None:
    cursor.execute(f"INSERT INTO persona_natural (id_entidad,rut,nombre_elemento,nombre,sexo,fecha_nacimiento,direccion,nombre_pueblo_ori,discapacidad) VALUES ({id_entidad},'{rut}','{nombre_elemento}','{nombre}','{sexo}','{fecha_nacimiento}','{direccion}','{nombre_pueblo_ori}','{discapacidad}')")


if __name__ == "__main__":  
  load_dotenv()
  database = getenv("DATABASE_NAME") or "postgres"
  user = getenv("DATABASE_USER") or "postgres"
  host = getenv("DATABASE_HOST") or "localhost"
  port = getenv("DATABASE_PORT") or "5432"
  
  fake = Faker()
  conn = psycopg2.connect(database=database, user=user, host=host, port=port)
  cursor = conn.cursor()
  # queries
  rango_cod_comunas = (347,692)
  # crear persona_natural
  
  
  
  # end queries 
  conn.commit()
  cursor.close()
  conn.close()