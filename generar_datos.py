import psycopg2
import sys
from os import getenv
from dotenv import load_dotenv
from faker import Faker
from valores import *
from utils import *
from entidades.persona_natural import persona_natural
from entidades.artesano import artesano
from entidades.estudiante import estudiante
from entidades.persona_juridica import persona_juridica
from entidades.biblioteca_publica import biblioteca_publica
from entidades.biblioteca_escolar_cra import biblioteca_escolar_cra
from entidades.artesania import artesania
from entidades.ano import ano
from entidades.establecimiento_educacional import establecimiento_educacional


if __name__ == "__main__":
    load_dotenv()
    database = getenv("DATABASE_NAME") or "postgres"
    user = getenv("DATABASE_USER") or "postgres"
    host = getenv("DATABASE_HOST") or "localhost"
    port = getenv("DATABASE_PORT") or "5432"

    fake = Faker("es_CL")
    conn = psycopg2.connect(database=database, user=user, host=host, port=port)
    cursor = conn.cursor()

    # util data
    filas_por_entidad = 10
    personas_juridicas = []
    personas_naturales = []
    estudiantes = []
    artesanos = []
    codigos_est = []
    # queries

    # READ ARGS
    if len(sys.argv) > 1 and sys.argv[1] in ("--first", "-f"):
        cursor.execute(open("cultura.sql", "r").read())
        cursor.execute(open("seed.sql", "r").read())

    # - persona_juridica
    for _ in range(filas_por_entidad):
        per_jur = persona_juridica(cursor, fake.name(), random_cod_comuna(fake))
        personas_juridicas.append(per_jur)

    # - persona_natural
    for _ in range(filas_por_entidad):
        per_nat = persona_natural(
            cursor,
            random_cod_comuna(fake),
            random_run(fake),
            random_nombre_elemento(fake),
            fake.name(),
            random_sexo(fake),
            fake.date_of_birth(),
            fake.address(),
            random_pueblo_originario(fake),
            fake.boolean(35),
        )

        personas_naturales.append(per_nat)
    # - artesano
    for _ in range(filas_por_entidad):
        art = artesano(
            cursor,
            random_cod_comuna(fake),
            random_run(fake),
            random_nombre_elemento(fake),
            fake.name(),
            random_sexo(fake),
            fake.date_of_birth(),
            fake.address(),
            random_pueblo_originario(fake),
            fake.boolean(35),
            random_disciplina(fake),
        )
        personas_naturales.append(art)
        artesanos.append(art)
    # - estudiante
    for _ in range(filas_por_entidad):
        est = estudiante(
            cursor,
            random_cod_comuna(fake),
            random_run(fake),
            random_nombre_elemento(fake),
            fake.name(),
            random_sexo(fake),
            fake.date_of_birth(),
            fake.address(),
            random_pueblo_originario(fake),
            fake.boolean(35),
        )
        personas_naturales.append(est)
        estudiantes.append(est)

    # - biblioteca_publica
    for _ in range(filas_por_entidad):
        biblioteca_publica(cursor, fake.word(), fake.random_element(personas_juridicas))

    # - establecimiento_educacional
    for _ in range(filas_por_entidad):
        cod_est = establecimiento_educacional(
            cursor, fake.word(), random_cod_comuna(fake)
        )
        codigos_est.append(cod_est)

    # - biblioteca_escolar_cra
    for _ in range(filas_por_entidad):
        biblioteca_escolar_cra(cursor, fake.company(), fake.random_element(codigos_est))
    # - artesania
    for _ in range(filas_por_entidad):
        random_artesano = fake.random_element(artesanos)
        artesania(
            cursor,
            fake.word(),
            fake.year(),
            random_artesano[0],
            random_artesano[1],
        )
    # - ano
    for y in range(1900, 2025):
        ano(cursor, y)

    # end queries
    conn.commit()
    cursor.close()
    conn.close()
