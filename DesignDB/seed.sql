USE olimpiadas;

-- Insertar Directores de Federaciones
INSERT INTO directores (nombre, telefono, direccion, nivel_academico, email) 
VALUES 
('Juan Pérez', '12345678', 'Avenida Principal #123', 'Licenciatura en Deportes', 'juan.perez@email.com'),
('Ana Gómez', '87654321', 'Calle Secundaria #456', 'Maestría en Administración Deportiva', 'ana.gomez@email.com');



-- Insertar Federaciones (usando los directores creados)
INSERT INTO federaciones (direccion, telefono, director_id, presupuesto)
VALUES 
('Zona 1, Ciudad', '22113344', 1, 500000.00),
('Zona 2, Ciudad', '33224455', 2, 750000.00);



-- Insertar Instalaciones
INSERT INTO instalaciones (nombre, direccion, tamano_m2, capacidad, descripcion, estado, federacion_id, ultimo_mantenimiento_id)
VALUES 
('Estadio Nacional', 'Zona 1, Ciudad', 15000.00, 50000, 'Estadio principal para competiciones', 'Operativo', 1, 1),
('Gimnasio Olímpico', 'Zona 2, Ciudad', 5000.00, 1000, 'Gimnasio de alto rendimiento', 'Mantenimiento', 2, 2);

-- Insertar Mantenimiento Instalaciones
INSERT INTO instalaciones_mantenimiento (fecha, descripcion, costo, instalacion_id)
VALUES 
('2025-02-01', 'Cambio de luminarias', 10000.00, 1),
('2025-02-15', 'Reparación de gradas', 5000.00, 2);

-- Insertar Deportes
INSERT INTO deportes (nombre)
VALUES 
('Atletismo'),
('Natación');

-- Insertar Categorías Deportivas
INSERT INTO categorias (nombre, descripcion, observaciones)
VALUES 
('Carrera de velocidades', 'Carrera de velocidades', 'Categoría principal'),
('Natación Estilos libres y combinados', 'Estilos libres y combinados', 'Requiere piscina olímpica'),
('Carrera de con vallas', 'Carrera de con vallas', 'Categoría principal'),
('Saltos horizontales', 'Carrera de con vallas', 'Categoría principal');

-- Insertar Subcategorías
INSERT INTO subcategorias (nombre, descripcion, categoria_id)
VALUES 
('100 metros planos', 'Carrera de velocidad', 1),
('Maratón', 'Carrera de larga distancia', 1),
('50 metros libres', 'Natación en piscina olímpica', 2);

-- Insertar Relación Deporte-Categoría
INSERT INTO deporte_categoria (deporte_id, categoria_id)
VALUES 
(1, 1),
(2, 2);

-- Insertar Entrenadores
INSERT INTO entrenadores (nombre_completo, direccion_residencia, telefono_casa, telefono_movil, email, deporte_id)
VALUES 
('Carlos Ramírez', 'Calle 3, Zona 10', '22112233', '55112233', 'carlos.ramirez@email.com', 1),
('Laura Mendoza', 'Avenida Reforma, Zona 9', '99887766', '44113322', 'laura.mendoza@email.com', 2);

-- Insertar Atletas
INSERT INTO atletas (nombre_completo, direccion_residencia, telefono_casa, telefono_movil, numero_federado, deporte_id, entrenador_id, mejor_tiempo, fecha_mejor_tiempo, federacion_id)
VALUES 
('Pedro Castillo', 'Colonia Los Pinos, Zona 5', '12345678', '98765432', 'FED001', 1, 1, '00:09:58', '2024-06-15', 1),
('María López', 'Residencial Olímpica, Zona 8', '56781234', '54327891', 'FED002', 2, 2, '00:25:00', '2024-07-10', 2);

-- Insertar Medallas
INSERT INTO medallas (tipo, campeonato, fecha, atleta_id)
VALUES 
('Oro', 'Campeonato Nacional de Atletismo', '2024-07-20', 1),
('Plata', 'Campeonato Nacional de Natación', '2024-08-15', 2);

-- Insertar Relación Atleta-Categoría
INSERT INTO atleta_categoria (atleta_id, categoria_id, subcategoria_id, mejor_tiempo)
VALUES 
(1, 1, 1, '00:09:58'),
(2, 2, 3, '00:25:00');

