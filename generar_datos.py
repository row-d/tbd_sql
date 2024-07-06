import sys
from valores import *
from utils import *
from flow_template import flow_template
from entidades.persona_juridica import persona_juridica
from entidades.persona_natural import persona_natural
from entidades.artesano import artesano
from entidades.estudiante import estudiante
from entidades.biblioteca_publica import biblioteca_publica
from entidades.establecimiento_educacional import establecimiento_educacional
from entidades.biblioteca_escolar_cra import biblioteca_escolar_cra
from entidades.artesania import artesania
from entidades.ano import ano


def main(cursor, fake):
    filas_por_entidad = 15
    

    if len(sys.argv) > 1 and sys.argv[1] in ("--first", "-f"):
        cursor.execute(open("cultura.sql", "r").read())
        cursor.execute(open("seed.sql", "r").read())
        # - ano
        for y in range(*rango_ano):
            ano(cursor, y)

    # por cada comuna generar datos
    for cod_comuna in range(*rango_cod_comuna):
        if fake.boolean(50):
            continue
        personas_juridicas = []
        personas_naturales = []
        estudiantes = []
        artesanos = []
        codigos_est = []
        # - persona_juridica
        for _ in range(filas_por_entidad):
            per_jur = persona_juridica(cursor, fake.name(), cod_comuna)
            personas_juridicas.append(per_jur)

        # - persona_natural
        for _ in range(filas_por_entidad):
            per_nat = persona_natural(
                cursor,
                cod_comuna,
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
                cod_comuna,
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
                cod_comuna,
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

        # - establecimiento_educacional
        for _ in range(filas_por_entidad):
            cod_est = establecimiento_educacional(
                cursor, fake.word(), cod_comuna
            )
            codigos_est.append(cod_est)

        # - biblioteca_publica
        for _ in range(filas_por_entidad):
            biblioteca_publica(cursor, fake.word(), fake.random_element(personas_juridicas))
        # - biblioteca_escolar_cra
        for codigo_est in codigos_est:
            for _ in range(fake.random_int(1, 3)):
                if fake.boolean(50):
                    biblioteca_escolar_cra(cursor, fake.company(), codigo_est)
        # - artesania
        for _ in range(filas_por_entidad):
            random_artesano = fake.random_element(artesanos)
            artesania(
                cursor,
                fake.word(),
                int(fake.year()) if fake.boolean(50) else None,
                random_artesano[0],
                random_artesano[1],
            )
    


if __name__ == "__main__":
    flow_template(main)
