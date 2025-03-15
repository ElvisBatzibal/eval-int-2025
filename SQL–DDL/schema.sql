--DROP DATABASE IF EXISTS eval_int_2025;
--CREATE DATABASE eval_int_2025;
USE eval_int_2025;
CREATE TABLE marcas (
    marca_id INT PRIMARY KEY IDENTITY(1,1),
    marca VARCHAR(100) NOT NULL
);

CREATE TABLE tipo_equipo (
    tipo_id INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE puestos (
    puesto_id INT PRIMARY KEY IDENTITY(1,1),
    puesto VARCHAR(100) NOT NULL
);

CREATE TABLE empleados (
    empleado_id INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    telefono VARCHAR(12) NOT NULL,
    puesto_id INT NOT NULL,
    fecha_nacimiento DATE NOT NULL
);

CREATE TABLE roles (
    rol_id INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(100) NOT NULL
);

CREATE TABLE usuarios (
    usuario_id INT PRIMARY KEY IDENTITY(1,1),
    usuario VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL,
    estado CHAR(1) NOT NULL CHECK(estado IN ('A', 'I')),
    rol_id INT NOT NULL,
    empleado_id INT NOT NULL
);

CREATE TABLE equipos (
    equipo_id INT PRIMARY KEY IDENTITY(1,1),
    no_serie VARCHAR(100) NOT NULL,
    marca_id INT NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    fecha_compra DATE NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    tipo_equipo INT NOT NULL,
    empleado_id INT NOT NULL
);

--Llaves foráneas
ALTER TABLE empleados 
ADD CONSTRAINT fk_puesto_id 
FOREIGN KEY (puesto_id) 
REFERENCES puestos(puesto_id) 
;
--ON DELETE SET NULL;


ALTER TABLE usuarios 
ADD CONSTRAINT fk_rol_id 
FOREIGN KEY (rol_id) 
REFERENCES roles(rol_id)
;
--ON DELETE SET NULL;

ALTER TABLE equipos 
ADD CONSTRAINT fk_marca_id 
FOREIGN KEY (marca_id) 
REFERENCES marcas(marca_id)
;
--ON DELETE SET NULL;

ALTER TABLE equipos 
ADD CONSTRAINT fk_tipo_id 
FOREIGN KEY (tipo_equipo) 
REFERENCES tipo_equipo(tipo_id)
;
--ON DELETE SET NULL;

ALTER TABLE equipos 
ADD CONSTRAINT fk_empleado_id 
FOREIGN KEY (empleado_id) 
REFERENCES empleados(empleado_id)
;--ON DELETE SET NULL;

ALTER TABLE usuarios
ADD CONSTRAINT fk_usuarioempleado_id
FOREIGN KEY (empleado_id)
REFERENCES empleados(empleado_id)
--ON DELETE CASCADE
;


--ALTER TABLE usuarios
--DROP CONSTRAINT fk_usuarioempleado_id
--;