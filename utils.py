from faker import Faker
from valores import *

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

def random_disciplina(fake: Faker) -> str:
    return fake.random_element(tipo_disciplina_artesano)