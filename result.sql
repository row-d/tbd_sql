-- TODO: generar datos para tablas: region, biblioteca_publica, biblioteca_escolar_cra, estudiante, establecimiento_educacional, artesania, artesano, año

--VISTA
/*
V.3. 
Cree una vista que contenga para cada región, la cantidad de bibliotecas escolares que tiene y la
cantidad de bibliotecas públicas que tiene.
*/
--CREATE VIEW bibliotecas_regiones as 
SELECT COUNT(id_biblioteca) FROM biblioteca_publica;

-- TRIGGER
/*
T.6. 
Cree un trigger para que cada vez que un estudiante cambia de establecimiento en un año se modifique
estadística de atendidos en ese año y nivel en las bibliotecas escolares que corresponden tanto al
establecimiento antiguo como al nuevo.
*/
-- FUNCIÓN
/*
F.7. 
Escriba una función que liste la nómina de productos artesanales con sello de excelencia, por año,
disciplina y región. (referencia tabla 9.5). 

Debe considerar que un producto artesanal ha obtenido el sello de
excelencia si tiene un valor en año_sello. La disciplina y región corresponden a datos del artesano que lo
produce.
*/