import sys
from faker import Faker
from psycopg2._psycopg import cursor
from flow_template import flow_template
from relaciones.atiende_ano import atiende_ano
from valores import rango_ano, rango_cod_comuna
from relaciones.estudia import estudia
from entidades.estudiante import estudiante

comandos = {"atiende_ano": "asigna valores a la relacion atiende_ano"}


def main(cursor: cursor, fake: Faker):

    # para todas las bibliotecas existentes le asigna un año de atención con una probabilidad del 50%
    if len(sys.argv) > 1:
        match sys.argv[1]:
            case "atiende_ano":
                cursor.execute("SELECT id_biblioteca FROM biblioteca_escolar_cra")
                ids_biblioteca = cursor.fetchall()
                
                rel_bib_ano = {}
                
                for id_biblioteca in ids_biblioteca:
                    for _ in range(5):
                        _ano = fake.random_int(2000, 2024)
                        if id_biblioteca[0] not in rel_bib_ano:
                            rel_bib_ano[id_biblioteca[0]] = []
                        if _ano not in rel_bib_ano[id_biblioteca[0]]:
                            rel_bib_ano[id_biblioteca[0]].append(_ano)
                            atiende_ano(cursor, id_biblioteca[0],_ano)
            case "estudia":
                for cod_comuna in range(*rango_cod_comuna):
                    cursor.execute(
                        "SELECT codigo_est FROM establecimiento_educacional WHERE cod_comuna = %s",
                        (cod_comuna,),
                    )
                    codigos_est = cursor.fetchall()
                    cursor.execute(
                        "SELECT id_entidad,rut FROM estudiante JOIN entidad USING (id_entidad) WHERE cod_comuna = %s AND id_entidad NOT IN (SELECT id_estudiante FROM estudia)",
                        (cod_comuna,),
                    )
                    ids_estudiante = cursor.fetchall()
                    i_est_ed = 0
                    while True:
                        if len(ids_estudiante) == 0:
                            break
                        for _ in range(5):
                            id_estudiante,rut = ids_estudiante.pop()
                            estudia(
                                cursor,
                                codigos_est[i_est_ed][0],
                                id_estudiante,
                                rut,
                                fake.random_element(("basica", "media")),
                                fake.random_int(2000,2024),
                            )
                        if i_est_ed < len(codigos_est):
                            i_est_ed += 1
                        else:
                            i_est_ed = 0

            case _:
                print("comando no encontrado")
                print("comandos disponibles:")
                for comando, descripcion in comandos.items():
                    print(f"{comando}:\n\t{descripcion}\n")


if __name__ == "__main__":
    flow_template(main)
