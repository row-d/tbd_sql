-- DOMINIOS
CREATE DOMAIN modalidad_actividad AS VARCHAR CHECK(VALUE in ('presencial', 'virtual', 'ambas'));
CREATE DOMAIN sexo as VARCHAR CHECK(VALUE IN ('mujer', 'hombre'));
create DOMAIN disciplina_artesano as varchar check(
  value in (
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
CREATE DOMAIN tipo_vinculo AS VARCHAR NOT NULL CHECK(VALUE IN ('contrato', 'externo'));
CREATE DOMAIN tipo_mon_nac AS VARCHAR CHECK(
  VALUE IN (
    'monumento historico mueble',
    'monumento historico inmueble',
    'santuario de la naturaleza',
    'zona tipica'
  )
);
CREATE DOMAIN tipo_pat_natural AS VARCHAR NOT NULL CHECK(
  VALUE IN (
    'Monumento natural',
    'parque nacional',
    'reserva nacional'
  )
);

CREATE DOMAIN nivel_educacional AS VARCHAR NOT NULL CHECK(VALUE IN ('basica','media'));

CREATE DOMAIN pueblo_originario AS VARCHAR CHECK(
  VALUE IN (
    'Mapuche', 
    'Aymara', 
    'Rapa Nui', 
    'Atacamenos', 
    'Quechua', 
    'Colla', 
    'Chango', 
    'Diaguita', 
    'Kawesqar', 
    'Yagan'
  )
);

create table region(
  cod_region SERIAL PRIMARY KEY,
  nom_region VARCHAR UNIQUE NOT NULL
);

create table provincia(
  cod_provincia SERIAL PRIMARY KEY,
  nom_provincia VARCHAR UNIQUE NOT NULL,
  cod_region INTEGER NOT NULL REFERENCES region(cod_region) 
);

create table comuna(
  cod_comuna SERIAL PRIMARY KEY,
  nom_comuna VARCHAR UNIQUE NOT NULL,
  cod_provincia INTEGER NOT NULL REFERENCES provincia(cod_provincia) 
);

create table entidad(
  id_entidad SERIAL PRIMARY KEY,
  nombre VARCHAR NOT NULL,
  cod_comuna INTEGER NOT NULL REFERENCES comuna(cod_comuna)  -- localiza
);
create table persona_juridica(
  id_entidad INTEGER PRIMARY KEY REFERENCES entidad(id_entidad)
);

create table organizacion(
  id_entidad INTEGER PRIMARY KEY REFERENCES entidad(id_entidad)
);

create table dia_patrimonio(
  numero_version SERIAL PRIMARY KEY,
  fecha_inicio DATE NOT NULL, 
  fecha_termino DATE NOT NULL 
);

create table actividad(
  id_actividad SERIAL PRIMARY KEY,
  version_dia_patrimonio INTEGER NOT NULL REFERENCES dia_patrimonio(numero_version),
  id_entidad INTEGER REFERENCES entidad(id_entidad),
  nombre_actividad DATE NOT NULL, 
  modalidad modalidad_actividad NOT NULL
);

CREATE TABLE patrimonio_natural(
  id_patrimonio_nat SERIAL PRIMARY KEY,
  id_entidad INTEGER NOT NULL REFERENCES organizacion(id_entidad),
  -- dirige 
  nombre_patrimonio_nat VARCHAR NOT NULL,
  tipo tipo_pat_natural NOT NULL 
);
CREATE TABLE patrimonio_inmaterial(nombre_elemento VARCHAR PRIMARY KEY);
create table persona_natural(
  id_entidad INTEGER PRIMARY KEY REFERENCES entidad(id_entidad),
  rut INTEGER UNIQUE NOT NULL,
  nombre_elemento VARCHAR REFERENCES patrimonio_inmaterial(nombre_elemento),
  nombre VARCHAR NOT NULL,
  sexo sexo NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  direccion VARCHAR NOT NULL, 
  nombre_pueblo_ori pueblo_originario,
  discapacidad BOOLEAN NOT NULL
);

create table artesano(
  rut INTEGER PRIMARY KEY REFERENCES persona_natural(rut),
  disciplina disciplina_artesano NOT NULL
); 

create table artesania(
  id_artesania SERIAL PRIMARY KEY,
  nombre_producto VARCHAR NOT NULL, 
  ano_sello DATE,
  rut_artesano INTEGER REFERENCES artesano(rut)
);

create table estudiante(
  rut INTEGER PRIMARY KEY REFERENCES persona_natural(rut)
);

CREATE TABLE biblioteca( 
  id_biblioteca SERIAL PRIMARY KEY, 
  nombre_bib VARCHAR NOT NULL
);

CREATE TABLE biblioteca_publica( 
  id_biblioteca INTEGER PRIMARY KEY REFERENCES biblioteca(id_biblioteca),
  id_entidad INTEGER NOT NULL REFERENCES persona_juridica(id_entidad)
); 

CREATE TABLE presta_material(
  id_biblioteca INTEGER NOT NULL REFERENCES biblioteca_publica(id_biblioteca),
  rut_persona INTEGER NOT NULL REFERENCES persona_natural(rut), 
  fecha DATE NOT NULL, 
  CONSTRAINT presta_material_pk PRIMARY KEY (id_biblioteca, rut_persona)
);
CREATE TABLE establecimiento_educacional(
  codigo_est SERIAL PRIMARY KEY,
  nombre VARCHAR NOT NULL,
  cod_comuna INTEGER NOT NULL REFERENCES comuna(cod_comuna)
);

CREATE TABLE biblioteca_escolar_cra( 
  id_biblioteca INTEGER PRIMARY KEY REFERENCES biblioteca(id_biblioteca),
  codigo_est INTEGER REFERENCES establecimiento_educacional(codigo_est)
); 
CREATE TABLE ano(ano INTEGER PRIMARY KEY);
CREATE TABLE atiende_ano(
  id_biblioteca INTEGER NOT NULL REFERENCES biblioteca_escolar_cra(id_biblioteca),
  ano INTEGER NOT NULL REFERENCES ano(ano),
  nivel_medio INTEGER,
  nivel_basico INTEGER,
  CONSTRAINT atiende_ano_pk PRIMARY KEY (id_biblioteca, ano)
);

CREATE TABLE estudia(
  rut_estudiante INTEGER NOT NULL REFERENCES estudiante(rut),
  codigo_est INTEGER REFERENCES establecimiento_educacional(codigo_est), 
  nivel_alumno_ano nivel_educacional NOT NULL,
  ano INTEGER NOT NULL REFERENCES ano(ano),
  CONSTRAINT estudia_pk PRIMARY KEY (rut_estudiante, codigo_est)
);


CREATE TABLE monumento_nacional(
  id_monumento SERIAL PRIMARY KEY,
  id_entidad INTEGER NOT NULL REFERENCES organizacion(id_entidad),
  -- administra
  nombre_monumento VARCHAR NOT NULL,
  tipo tipo_mon_nac NOT NULL
);

CREATE TABLE visita(
  id_patrimonio_nat INTEGER NOT NULL REFERENCES patrimonio_natural(id_patrimonio_nat),
  rut INTEGER NOT NULL REFERENCES persona_natural(rut),
  fecha DATE NOT NULL,
  CONSTRAINT visita_pk PRIMARY KEY (id_patrimonio_nat, rut)
);

CREATE TABLE se_encuentra(
  id_patrimonio_nat INTEGER NOT NULL REFERENCES patrimonio_natural(id_patrimonio_nat),
  cod_comuna INTEGER NOT NULL REFERENCES comuna(cod_comuna),
  CONSTRAINT se_encuentra_pk PRIMARY KEY (id_patrimonio_nat, cod_comuna)
);

CREATE TABLE museo (
  id_museo SERIAL PRIMARY KEY,
  id_entidad INTEGER NOT NULL REFERENCES entidad(id_entidad),
  nombre_museo VARCHAR NOT NULL
);

CREATE TABLE visita_ano(
  id_museo INTEGER NOT NULL REFERENCES museo(id_museo),
  ano INTEGER NOT NULL REFERENCES ano(ano),
  cantidad_discapacidad INTEGER NOT NULL,
  cantidad_pueblo_originario INTEGER NOT NULL,
  CONSTRAINT visita_ano_pk PRIMARY KEY (id_museo, ano)
);

-- FIXME: Falta dominio en el pdf


CREATE TABLE trabaja(
  id_museo INTEGER NOT NULL REFERENCES museo(id_museo),
  rut INTEGER NOT NULL REFERENCES persona_natural(rut),
  vinculo tipo_vinculo NOT NULL,
  CONSTRAINT trabaja_pk PRIMARY KEY (id_museo, rut)
);

CREATE TABLE acude(
  id_museo INTEGER NOT NULL REFERENCES museo(id_museo),
  rut INTEGER NOT NULL REFERENCES persona_natural(rut),
  fecha DATE NOT NULL,
  CONSTRAINT acude_pk PRIMARY KEY (id_museo, rut)
);

CREATE TABLE ambito_patrimonio(ambito VARCHAR PRIMARY KEY);

CREATE TABLE corresponde(
  nombre_elemento VARCHAR NOT NULL REFERENCES patrimonio_inmaterial(nombre_elemento),
  ambito VARCHAR NOT NULL REFERENCES ambito_patrimonio(ambito),
  CONSTRAINT corresponde_pk PRIMARY KEY (nombre_elemento, ambito)
);