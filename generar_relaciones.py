from faker import Faker
from psycopg2._psycopg import cursor
from flow_template import flow_template
from relaciones.atiende_ano import atiende_ano
from valores import rango_ano


def main(cursor: cursor, fake: Faker):
    cursor.execute("SELECT id_biblioteca FROM biblioteca_escolar_cra")
    ids_biblioteca = cursor.fetchall()
    for id_biblioteca in ids_biblioteca:
        for y in range(*rango_ano):
            if fake.boolean(50):
                atiende_ano(cursor, id_biblioteca[0], y)


if __name__ == "__main__":
    flow_template(main)
