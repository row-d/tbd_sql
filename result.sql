--VISTA
/*
 V.3.
 Cree una vista que contenga para cada región, la cantidad de bibliotecas escolares que tiene y la
 cantidad de bibliotecas públicas que tiene.
 */
CREATE
OR REPLACE VIEW bibliotecas_por_region AS (
     SELECT
          re.cod_region,
          re.nom_region,
          (
               SELECT
                    count(*)
               FROM
                    biblioteca_publica pb
                    JOIN persona_juridica pj ON pb.id_persona_jur = pj.id_entidad
                    JOIN entidad ent USING(id_entidad)
                    JOIN comuna USING(cod_comuna)
                    JOIN provincia USING(cod_provincia)
               WHERE
                    provincia.cod_region = re.cod_region
          ) AS bibliotecas_publicas,
          (
               SELECT
                    count(*) AS bibliotecas_escolares_cra
               FROM
                    biblioteca_escolar_cra be
                    JOIN establecimiento_educacional est_ed USING(codigo_est)
                    JOIN comuna co USING(cod_comuna)
                    JOIN provincia USING(cod_provincia)
               WHERE
                    provincia.cod_region = re.cod_region
          ) AS bibliotecas_escolares_cra
     FROM
          region re
);

-- TRIGGER
/*
 T.6.
 Cree un trigger para que cada vez que un estudiante cambia de establecimiento en un año se modifique
 estadística de atendidos en ese año y nivel en las bibliotecas escolares que corresponden tanto al
 establecimiento antiguo como al nuevo.
 */

CREATE
OR REPLACE FUNCTION estudiante_cambia_establecimiento_fn() RETURNS TRIGGER AS $$
    DECLARE
        OLD_BIB_ID biblioteca_escolar_cra.id_biblioteca%TYPE;
        NEW_BIB_ID biblioteca_escolar_cra.id_biblioteca%TYPE;
    BEGIN
        IF NEW.codigo_est <> OLD.codigo_est THEN
            SELECT be.id_biblioteca INTO OLD_BIB_ID
            FROM biblioteca_escolar_cra be
            WHERE be.codigo_est = OLD.codigo_est;

            SELECT be.id_biblioteca INTO NEW_BIB_ID
            FROM biblioteca_escolar_cra be
            WHERE be.codigo_est = NEW.codigo_est;
            
            IF OLD_BIB_ID IS NOT NULL THEN
                IF OLD.nivel_alumno_ano = 'basica' THEN
                    UPDATE atiende_ano
                    SET nivel_basico = nivel_basico - 1
                    WHERE id_biblioteca = OLD_BIB_ID AND ano = OLD.ano;
                ELSIF OLD.nivel_alumno_ano = 'media' THEN
                    UPDATE atiende_ano
                    SET nivel_medio = nivel_medio - 1
                    WHERE id_biblioteca = OLD_BIB_ID AND ano = OLD.ano;
                END IF;
            END IF;
            
            IF NEW_BIB_ID IS NOT NULL THEN
                IF NEW.nivel_alumno_ano = 'basica' THEN
                    UPDATE atiende_ano
                    SET nivel_basico = nivel_basico + 1
                    WHERE id_biblioteca = NEW_BIB_ID AND ano = NEW.ano;
                ELSIF NEW.nivel_alumno_ano = 'media' THEN
                    UPDATE atiende_ano
                    SET nivel_medio = nivel_medio + 1
                    WHERE id_biblioteca = NEW_BIB_ID AND ano = NEW.ano;
                END IF;
            END IF;
        END IF;

        RETURN NEW;
    END
$$ LANGUAGE plpgsql;

CREATE TRIGGER estudiante_cambia_establecimiento
AFTER
UPDATE
ON estudia FOR EACH ROW EXECUTE FUNCTION estudiante_cambia_establecimiento_fn();
     

-- FUNCIÓN
/*
 F.7.
 Escriba una función que liste la nómina de productos artesanales con sello de excelencia, por año,
 disciplina y región. (referencia tabla 9.5).
 
 Debe considerar que un producto artesanal ha obtenido el sello de
 excelencia si tiene un valor en año_sello. La disciplina y región corresponden a datos del artesano que lo
 produce.
 */
 
CREATE OR REPLACE FUNCTION listar_productos_artesanales_con_sello()
RETURNS SETOF RECORD LANGUAGE PLPGSQL AS $$
    DECLARE
        _cur cursor for SELECT artesania.ano_sello,
                               artesania.nombre_producto,
                               artesano.disciplina,
                               region.nom_region
                        FROM artesania
                        JOIN artesano ON artesano.id_entidad = artesania.id_artesano
                        JOIN entidad ON entidad.id_entidad = artesano.id_entidad
                        JOIN comuna ON entidad.cod_comuna = comuna.cod_comuna
                        JOIN provincia ON provincia.cod_provincia = comuna.cod_provincia
                        JOIN region ON region.cod_region = provincia.cod_region
                        WHERE artesania.ano_sello IS NOT NULL
                        ORDER BY artesania.ano_sello DESC;
        _rec RECORD;
        
    BEGIN
        OPEN _cur;
        LOOP
            FETCH _cur INTO _rec;
            EXIT WHEN NOT FOUND;
            RETURN NEXT _rec;
        END LOOP;
        CLOSE _cur;        
    END;
$$;


