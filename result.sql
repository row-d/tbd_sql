--VISTA
/*
V.3.
Cree una vista que contenga para cada región, la cantidad de bibliotecas escolares que tiene y la
cantidad de bibliotecas públicas que tiene.
*/
CREATE OR REPLACE VIEW bibliotecas_por_region AS
    (SELECT re.cod_region,

         (SELECT count(*)
          FROM biblioteca_publica pb
          JOIN persona_juridica pj ON pb.id_persona_jur = pj.id_entidad
          JOIN entidad ent USING(id_entidad)
          JOIN comuna USING(cod_comuna)
          JOIN provincia USING(cod_provincia)
          WHERE provincia.cod_region = re.cod_region ) AS bibliotecas_publicas,

         (SELECT count(*) AS bibliotecas_escolares_cra
          FROM biblioteca_escolar_cra be
          JOIN establecimiento_educacional est_ed USING(codigo_est)
          JOIN comuna co USING(cod_comuna)
          JOIN provincia USING(cod_provincia)
          WHERE provincia.cod_region = re.cod_region) AS bibliotecas_escolares_cra
     FROM region re);

-- TRIGGER
/*
T.6.
Cree un trigger para que cada vez que un estudiante cambia de establecimiento en un año se modifique
estadística de atendidos en ese año y nivel en las bibliotecas escolares que corresponden tanto al
establecimiento antiguo como al nuevo.
*/ -- FUNCIÓN
/*
F.7.
Escriba una función que liste la nómina de productos artesanales con sello de excelencia, por año,
disciplina y región. (referencia tabla 9.5).

Debe considerar que un producto artesanal ha obtenido el sello de
excelencia si tiene un valor en año_sello. La disciplina y región corresponden a datos del artesano que lo
produce.
*/