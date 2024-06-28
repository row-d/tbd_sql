create table dia_patrimonio(
  numero_version SERIAL PRIMARY KEY,
  fecha_inicio DATE NOT NULL,
  fecha_termino DATE NOT NULL
);

create table actividad(
  id_actividad SERIAL PRIMARY KEY,
  nombre_actividad DATE NOT NULL,
  version_dia_patrimonio FOREIGN KEY REFERENCES dia_patrimonio(numero_version),
  modalidad modalidad_actividad NOT NULL
);

create table entidad(
  id_entidad SERIAL PRIMARY KEY,
  nombre VARCHAR NOT NULL,
);

CREATE DOMAIN sexo as VARCHAR CHECK(
  VALUE IN (
    'mujer',
    'hombre'
  )
);
create table persona_natural(
  id_entidad INTEGER PRIMARY KEY FOREIGN KEY REFERENCES entidad(id_entidad),
  rut INTEGER UNIQUE NOT NULL,
  nombre VARCHAR NOT NULL,
  sexo sexo NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  direccion VARCHAR NOT NULL,
  nombre_pueblo_ori pueblo_originario,
  discapacidad VARCHAR NOT NULL -- Preguntar profe
);

create table artesano(
  rut INTEGER PRIMARY KEY FOREIGN KEY REFERENCES persona_natural(rut),
  disciplina disciplina_artesano NOT NULL
);

create DOMAIN disciplina_artesano as varchar check(
  values in (
    'alfareria y ceramica',
    'cesteria',
    'canteria y piedras',
    'huesos-cuernos-conchas',
    'instrumentos musicales y luthier',
    'madera',
    'marroquineria y talabarteria (cueros)',
    'metales y orfebreria',
    'papel',
    'textileria',
    'vidrio',
    'otros'
  )
);

create table artesania(
  id_artesania SERIAL PRIMARY KEY,
  nombre_producto VARCHAR NOT NULL,
  ano_sello DATE,
  rut_artesano INTEGER FOREIGN KEY REFERENCES artesano(rut)
);

create table estudiante(
  rut INTEGER NOT NULL PRIMARY KEY FOREIGN KEY REFERENCES persona_natural(rut)
);

create table persona_juridica(
  id_entidad INTEGER NOT NULL PRIMARY KEY FOREIGN KEY REFERENCES entidad(id_entidad),
  id_biblioteca INTEGER FOREIGN KEY REFERENCES biblioteca_publica(id_biblioteca) -- se_encarga
);

create table organizacion(
  id_entidad INTEGER PRIMARY KEY FOREIGN KEY REFERENCES entidad(id_entidad),
);

create table region(
  cod_region SERIAL PRIMARY KEY,
  nom_region VARCHAR NOT NULL,  
);

create table provincia(
  cod_provincia SERIAL PRIMARY KEY,
  nom_provincia VARCHAR NOT NULL,
  region FOREIGN KEY REFERENCES region(cod_region)
);

create table comuna(
  cod_comuna SERIAL PRIMARY KEY,
  nom_comuna VARCHAR NOT NULL,
  provincia FOREIGN KEY REFERENCES provincia(cod_provincia)
);

-- Mi parte
/* 
 Biblioteca
 Establecimiento_Educacional
 Monumento_Nacional
 Patromonio_Natural
 Museo
 Ambito_Patrimonio
 Patrimonio_Inmaterial 
 */
CREATE TABLE biblioteca(
  id_biblioteca SERIAL NOT NULL PRIMARY KEY,
  nombre_bib VARCHAR NOT NULL
  );

CREATE TABLE biblioteca_publica(
  id_biblioteca INTEGER NOT NULL PRIMARY KEY FOREIGN KEY REFERENCES biblioteca(id_biblioteca),
);

CREATE TABLE presta_material(
  fecha DATE NOT NULL, id_biblioteca INTEGER
);

CREATE TABLE biblioteca_escolar_cra(
  id_biblioteca INTEGER NOT NULL PRIMARY KEY FOREIGN KEY REFERENCES biblioteca(id_biblioteca),
  codigo_est INTEGER FOREIGN KEY establecimiento_educacional(codigo_est)
);
nono();
  id_biblioteca INTEGER FOREIGN NCEKEY REFERENCES biblioteca_escolar_cra(id_biblioteca),
  ano INTEGER FOREIGN KEY REFERE
  
  nivel_medio INTEGER NOT NULL,
  nivel_basico INTEGER NOT NULL

CREATE TABLE atiende_a

CREATE TABLE establecimiento_educacional(
  codigo_est SERIAL PRIMARY KEY,
  nombre VARCHAR NOT NULL,
  comuna INTEGER FOREIGN KEY REFERENCES comuna(cod_comuna)
);

CREATE TABLE ano(
  ano INTEGER PRIMARY KEY
);

CREATE TABLE estudia(
  rut_estudiante INTEGER FOREIGN KEY REFERENCES estudiante(rut)
  codigo_est INTEGER FOREIGN KEY REFERENCES establecimiento_educacional(codigo_est)
  nivel_alumno_ano nivel_educacional NOT NULL,
  ano INTEGER FOREIGN KEY REFERENCES ano(ano),
  CONSTRAINT estudia_pk PRIMARY KEY (rut_estudiante,codigo_establecimiento)
);

CREATE DOMAIN tipo_mon_nac AS VARCHAR CHECK(
  VALUE IN (
    'monumento historico mueble',
    'monumento historico inmueble',
    'santuario de la naturaleza',
    'zona tipica'
  )
);

CREATE TABLE monumento_nacional(
  id_monumento SERIAL NOT NULL PRIMARY KEY,
  nombre_monumento VARCHAR NOT NULL,
  tipo tipo_mon_nac NOT NULL
);

CREATE TABLE administra(
  id_entidad INTEGER NOT NULL FOREIGN KEY REFERENCES organizacion(id_entidad),
  id_monumento INTEGER NOT NULL FOREIGN KEY REFERENCES monumento_nacional(id_monumento)
);

CREATE DOMAIN tipo_pat_natural AS VARCHAR NOT NULL CHECK(
  VALUE IN (
    'Monumento natural',
    'parque nacional',
    'reserva nacional'
  )
);

CREATE TABLE patrimonio_natural(
  id_patrimonio_nat SERIAL PRIMARY KEY,
  nombre_patrimonio_nat VARCHAR NOT NULL,
  tipo tipo_pat_natural NOT NULL
);

CREATE TABLE dirige(id_entidad INTEGER NOT NULL FOREIGN KEY REFERENCES organizacion(id_entidad),id_patrimonio_nat INTEGER NOT NULL FOREIGN KEY REFERENCES patrimonio_natural(id_patrimonio_nat));

CREATE TABLE visita(fecha DATE NOT NULL, rut INTEGER FOREIGN KEY REFERENCES persona_natural(rut), id_patrimonio_nat INTEGER FOREIGN KEY REFERENCES patrimonio_natural(id_patrimonio_nat));

CREATE TABLE se_encuentra(id_patrimonio_nat INTEGER FOREIGN KEY REFERENCES patrimonio_natural(id_patrimonio_nat), cod_comuna INTEGER FOREIGN KEY REFERENCES comuna(cod_comuna) );

CREATE TABLE museo (
  id_museo SERIAL PRIMARY KEY,
  nombre_museo VARCHAR NOT NULL
);

CREATE TABLE gestiona(id_entidad INTEGER NOT NULL FOREIGN KEY REFERENCES organizacion(id_entidad),id_museo INTEGER NOT NULL FOREIGN KEY REFERENCES museo(id_museo));

CREATE TABLE visita_ano(id_museo INTEGER FOREIGN KEY, ano INTEGER FOREIGN KEY REFERENCES ano(ano), cantidad_discapacidad NOT NULL INTEGER DEFAULT 0, cantidad_pueblo_originario NOT NULL INTEGER DEFAULT 0);

-- FIXME: Falta dominio en el pdf
CREATE DOMAIN tipo_vinculo AS VARCHAR NOT NULL CHECK(
  VALUE IN (
    'contrato',
    'externo',
  )
);
CREATE TABLE trabaja(vinculo tipo_vinculo, id_museo INTEGER FOREIGN KEY REFERENCES museo(id_museo), rut INTEGER FOREIGN KEY REFERENCES persona_natural(rut));

CREATE TABLE acude(fecha DATE NOT NULL,id_museo INTEGER FOREIGN KEY REFERENCES museo(id_museo), rut INTEGER FOREIGN KEY REFERENCES persona_natural(rut));

CREATE TABLE ambito_patrimonio(
  ambito VARCHAR PRIMARY KEY
);

CREATE TABLE patrimonio_inmaterial(nombre_elemento VARCHAR NOT NULL PRIMARY KEY);

CREATE TABLE registra(rut integer FOREIGN KEY REFERENCES persona_natural(rut), nombre VARCHAR FOREIGN KEY REFERENCES patrimonio_natural(nombre_elemento));

CREATE TABLE corresponde(nombre_elemento VARCHAR FOREIGN KEY REFERENCES patrimonio_inmaterial(nombre_elemento), ambito VARCHAR FOREIGN KEY REFERENCES ambito_patrimonio(ambito));

