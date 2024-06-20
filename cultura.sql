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

create table persona_natural(
  rut INTEGER PRIMARY KEY FOREIGN KEY REFERENCES entidad(id_entidad),
  sexo sexo_persona NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  direccion VARCHAR NOT NULL,
  nombre_pueblo_ori pueblo_originario,
  discapacidad VARCHAR NOT NULL -- Preguntar profe
);

create table artesano

create table persona_juridica(
  id_entidad INTEGER PRIMARY KEY FOREIGN KEY REFERENCES entidad(id_entidad),
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

>-- Mi parte
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
  id_biblioteca SERIAL PRIMARY KEY,
  nombre_bib VARCHAR NOT NULL,
);

CREATE TABLE biblioteca_publica(
  id_biblioteca SERIAL PRIMARY KEY FOREIGN KEY REFERENCES biblioteca(id_biblioteca),
);

CREATE TABLE biblioteca_escolar_cra(
  id_biblioteca SERIAL PRIMARY KEY FOREIGN KEY REFERENCES biblioteca(id_biblioteca),
);

CREATE TABLE establecimiento_educacional(
  codigo_est SERIAL PRIMARY KEY,
  nombre VARCHAR NOT NULL,
);

CREATE TABLE ano(ano INTEGER PRIMARY KEY,);

CREATE DOMAIN tipo_mon_nac AS VARCHAR NOT NULL CHECK(
  VALUE IN (
    'monumento hisorico mueble',
    'monumento histórico inmueble',
    'santuario de la naturaleza',
    'zona tipica'
  )
);

CREATE TABLE monumento_nacional(
  id_monumento SERIAL PRIMARY KEY,
  nombre_monumento VARCHAR NOT NULL,
  tipo tipo_mon_nac NOT NULL
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

CREATE TABLE museo (
  id_museo SERIAL PRIMARY KEY,
  nombre_museo VARCHAR NOT NULL
);

CREATE TABLE ambito_patrimonio(
  ambito VARCHAR PRIMARY KEY
);

CREATE TABLE patrimonio_inmaterial(nombre VARCHAR NOT NULL); -- QUE CHUCHA ??