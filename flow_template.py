from os import getenv
from dotenv import load_dotenv
from faker import Faker
from psycopg2 import connect
from psycopg2._psycopg import cursor
from typing import Callable


def flow_template(closure: Callable[[cursor, Faker], None]):
    load_dotenv()
    database = getenv("DATABASE_NAME") or "postgres"
    user = getenv("DATABASE_USER") or "postgres"
    host = getenv("DATABASE_HOST") or "localhost"
    port = getenv("DATABASE_PORT") or "5432"

    fake = Faker("es_CL")
    conn = connect(database=database, user=user, host=host, port=port)
    cursor = conn.cursor()
    closure(cursor, fake)
    conn.commit()
    cursor.close()
    conn.close()
