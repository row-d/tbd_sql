from os import getenv
from dotenv import load_dotenv
import psycopg2
from faker import Faker
from valores import *
from entidades.persona_natural import persona_natural


def random_run(fake: Faker) -> int:
    return fake.unique.random_int(*rango_rut_valido)


def random_cod_comuna(fake: Faker) -> int:
    return fake.random_int(*rango_cod_comuna)


def random_nombre_elemento(fake: Faker) -> str:
    return fake.random_element(valores_nombre_elemento_patrimonio_inmaterial)


def random_sexo(fake: Faker) -> str:
    return fake.random_element(tipo_sexo)


def random_pueblo_originario(fake: Faker) -> str | None:
    return fake.random_element(tipo_pueblo_originario)


if __name__ == "__main__":
    load_dotenv()
    database = getenv("DATABASE_NAME") or "postgres"
    user = getenv("DATABASE_USER") or "postgres"
    host = getenv("DATABASE_HOST") or "localhost"
    port = getenv("DATABASE_PORT") or "5432"

    fake = Faker()
    conn = psycopg2.connect(database=database, user=user, host=host, port=port)
    cursor = conn.cursor()

    # util data
    filas_por_entidad = 10
    # queries
    # - persona_natural
    for _ in range(filas_por_entidad):
        persona_natural(
            cursor,
            random_cod_comuna(fake),
            random_run(fake),
            random_nombre_elemento(fake),
            fake.name(),
            random_sexo(fake),
            fake.date_of_birth(),
            fake.address(),
            random_pueblo_originario(fake),
            fake.boolean(25),
        )

    # end queries
    conn.commit()
    cursor.close()
    conn.close()
