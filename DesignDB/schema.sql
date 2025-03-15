
USE olimpiadas;

-- Tabla de Directores de Federaciones
CREATE TABLE directores (
    director_id INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    nivel_academico VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
);

-- Tabla de Federaciones
CREATE TABLE federaciones (
    [federacion_id] INT PRIMARY KEY IDENTITY (1, 1) NOT NULL,
    [direccion]     VARCHAR (255)   NOT NULL,
    [telefono]      VARCHAR (15)    NOT NULL,
    [director_id]   INT             NULL,
    [presupuesto]   DECIMAL (18, 2) NOT NULL,
    CONSTRAINT [FK_federaciones_directores] FOREIGN KEY ([director_id]) REFERENCES [dbo].[directores] ([director_id])
);

-- Tabla de Instalaciones
CREATE TABLE instalaciones (
    instalacion_id INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    tamano_m2 DECIMAL(10,2) NOT NULL,
    capacidad INT NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    federacion_id INT NOT NULL,
    ultimo_mantenimiento_id INT NOT NULL,
    CONSTRAINT FK_Instalaciones_Federaciones FOREIGN KEY (federacion_id) REFERENCES federaciones(federacion_id)
);

-- Tabla de Mantenimiento instalaciones
CREATE TABLE instalaciones_mantenimiento (
    mantenimiento_id INT PRIMARY KEY IDENTITY(1,1),
    fecha DATE NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    costo DECIMAL(18,2) NOT NULL,
    instalacion_id INT NOT NULL,
    CONSTRAINT FK_InstalacionesMantenimiento_Instalaciones FOREIGN KEY (instalacion_id) REFERENCES instalaciones(instalacion_id)
);

-- Tabla de Categorías Deportivas
CREATE TABLE categorias (
    categoria_id INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    observaciones VARCHAR(255)
);

CREATE TABLE subcategorias (
    subcategoria_id INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    categoria_id INT NOT NULL,
    CONSTRAINT FK_Subcategorias_Categorias FOREIGN KEY (categoria_id) REFERENCES categorias(categoria_id)
);

-- Tabla de Deportes
CREATE TABLE deportes (
    deporte_id INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL
);

-- Tabla de entrenadores
CREATE TABLE entrenadores (
    entrenador_id INT PRIMARY KEY IDENTITY(1,1),
    nombre_completo VARCHAR(100) NOT NULL,
    direccion_residencia VARCHAR(255) NOT NULL,
    telefono_casa VARCHAR(15),
    telefono_movil VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL,
    deporte_id INT NOT NULL,
    CONSTRAINT FK_Entrenadores_Deportes FOREIGN KEY (deporte_id) REFERENCES deportes(deporte_id)
);


-- Tabla de Atletas
CREATE TABLE atletas (
    atleta_id INT PRIMARY KEY IDENTITY(1,1),
    nombre_completo VARCHAR(100) NOT NULL,
    direccion_residencia VARCHAR(255) NOT NULL,
    telefono_casa VARCHAR(15),
    telefono_movil VARCHAR(15) NOT NULL,
    numero_federado VARCHAR(50) NOT NULL,
    deporte_id INT NOT NULL,
    entrenador_id INT NOT NULL,
    mejor_tiempo TIME NOT NULL,
    fecha_mejor_tiempo DATE NOT NULL,
    federacion_id INT NOT NULL,
    CONSTRAINT FK_Atletas_Deportes FOREIGN KEY (deporte_id) REFERENCES deportes(deporte_id),
    CONSTRAINT FK_Atletas_Federaciones FOREIGN KEY (federacion_id) REFERENCES federaciones(federacion_id),
    CONSTRAINT FK_Atletas_Entrenadores FOREIGN KEY (entrenador_id) REFERENCES entrenadores(entrenador_id)
);

-- Tabla de Medallas
CREATE TABLE medallas (
    medalla_id INT PRIMARY KEY IDENTITY(1,1),
    tipo VARCHAR(50) NOT NULL,
    campeonato VARCHAR(100) NOT NULL,
    fecha DATE NOT NULL,
    atleta_id INT NOT NULL,
    CONSTRAINT FK_Medallas_Atletas FOREIGN KEY (atleta_id) REFERENCES atletas(atleta_id)
);

-- Tabla de Relación entre Atletas y Categorías
CREATE TABLE atleta_categoria (
    atleta_id INT NOT NULL,
    categoria_id INT NOT NULL,
    subcategoria_id INT NOT NULL,
    mejor_tiempo TIME NOT NULL,
    PRIMARY KEY (atleta_id, categoria_id),
    CONSTRAINT FK_AtletaCategoria_Atletas FOREIGN KEY (atleta_id) REFERENCES atletas(atleta_id),
    CONSTRAINT FK_AtletaCategoria_Categorias FOREIGN KEY (categoria_id) REFERENCES categorias(categoria_id),
    CONSTRAINT FK_AtletaCategoria_Subcategorias FOREIGN KEY (subcategoria_id) REFERENCES subcategorias(subcategoria_id)
);

-- Tabla de Relación entre Deportes y Categorías
CREATE TABLE deporte_categoria (
    deporte_id INT NOT NULL,
    categoria_id INT NOT NULL,
    PRIMARY KEY (deporte_id, categoria_id),
    CONSTRAINT FK_DeporteCategoria_Deportes FOREIGN KEY (deporte_id) REFERENCES deportes(deporte_id),
    CONSTRAINT FK_DeporteCategoria_Categorias FOREIGN KEY (categoria_id) REFERENCES categorias(categoria_id)
);