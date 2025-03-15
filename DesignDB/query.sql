use olimpiadas;

-- Ver los directores de federaciones y sus federaciones
SELECT 
    f.federacion_id, 
    f.direccion, 
    f.telefono, 
    f.presupuesto, 
    d.nombre AS director_nombre, 
    d.telefono AS director_telefono, 
    d.email AS director_email
FROM federaciones f
LEFT JOIN directores d ON f.director_id = d.director_id;


-- Ver las instalaciones y su ultimo mantenimiento

SELECT 
    i.instalacion_id, 
    i.nombre, 
    i.direccion, 
    i.tamano_m2, 
    i.capacidad, 
    i.estado, 
    f.direccion AS federacion_direccion, 
    m.fecha AS ultima_fecha_mantenimiento, 
    m.descripcion AS mantenimiento_descripcion, 
    m.costo AS mantenimiento_costo
FROM instalaciones i
LEFT JOIN federaciones f ON i.federacion_id = f.federacion_id
LEFT JOIN instalaciones_mantenimiento m ON i.ultimo_mantenimiento_id = m.mantenimiento_id;

-- Reporte de atletas con su entrenador, deporte y federación

SELECT 
    a.atleta_id, 
    a.nombre_completo AS atleta, 
    a.numero_federado, 
    e.nombre_completo AS entrenador, 
    d.nombre AS deporte, 
    f.direccion AS federacion
FROM atletas a
LEFT JOIN entrenadores e ON a.entrenador_id = e.entrenador_id
LEFT JOIN deportes d ON a.deporte_id = d.deporte_id
LEFT JOIN federaciones f ON a.federacion_id = f.federacion_id;

-- Medallas obtenidas por atletas

SELECT 
    m.medalla_id, 
    a.nombre_completo AS atleta, 
    d.nombre AS deporte, 
    m.tipo, 
    m.campeonato, 
    m.fecha
FROM medallas m
LEFT JOIN atletas a ON m.atleta_id = a.atleta_id
LEFT JOIN deportes d ON a.deporte_id = d.deporte_id
ORDER BY m.fecha DESC;

-- Atletas y su mejor tiempo en sus categorías

SELECT 
    a.nombre_completo AS atleta, 
    c.nombre AS categoria, 
    s.nombre AS subcategoria, 
    ac.mejor_tiempo
FROM atleta_categoria ac
LEFT JOIN atletas a ON ac.atleta_id = a.atleta_id
LEFT JOIN categorias c ON ac.categoria_id = c.categoria_id
LEFT JOIN subcategorias s ON ac.subcategoria_id = s.subcategoria_id
ORDER BY ac.mejor_tiempo ASC;


--  Instalaciones con mayor capacidad
SELECT 
    nombre, 
    capacidad, 
    estado, 
    direccion
FROM instalaciones
ORDER BY capacidad DESC;

-- Deportistas y sus categorías deportivas
SELECT 
    a.nombre_completo AS atleta, 
    d.nombre AS deporte, 
    c.nombre AS categoria
FROM deporte_categoria dc
LEFT JOIN deportes d ON dc.deporte_id = d.deporte_id
LEFT JOIN categorias c ON dc.categoria_id = c.categoria_id
LEFT JOIN atletas a ON a.deporte_id = d.deporte_id
ORDER BY a.nombre_completo;

-- Total de medallas por tipo

SELECT 
    tipo, 
    COUNT(*) AS total_medallas
FROM medallas
GROUP BY tipo
ORDER BY total_medallas DESC;

-- Query Costo total de mantenimiento de instalaciones
SELECT 
    SUM(costo) AS total_gasto_mantenimiento
FROM instalaciones_mantenimiento;

-- Entrenadores y cuántos atletas tienen a su cargo

SELECT 
    e.nombre_completo AS entrenador, 
    COUNT(a.atleta_id) AS total_atletas
FROM entrenadores e
LEFT JOIN atletas a ON e.entrenador_id = a.entrenador_id
GROUP BY e.nombre_completo
ORDER BY total_atletas DESC;

-- Atletas con sus tiempos en competencias
SELECT 
    a.nombre_completo, 
    a.mejor_tiempo, 
    a.fecha_mejor_tiempo, 
    d.nombre AS deporte
FROM atletas a
LEFT JOIN deportes d ON a.deporte_id = d.deporte_id
ORDER BY a.mejor_tiempo ASC;

-- Presupuesto total asignado a todas las federaciones
SELECT 
    SUM(presupuesto) AS total_presupuesto
FROM federaciones;

-- Atletas que han ganado más medallas
SELECT 
    a.nombre_completo AS atleta, 
    COUNT(m.medalla_id) AS total_medallas
FROM medallas m
LEFT JOIN atletas a ON m.atleta_id = a.atleta_id
GROUP BY a.nombre_completo
ORDER BY total_medallas DESC;

-- Cantidad de atletas por deporte
SELECT 
    d.nombre AS deporte, 
    COUNT(a.atleta_id) AS total_atletas
FROM deportes d
LEFT JOIN atletas a ON d.deporte_id = a.deporte_id
GROUP BY d.nombre
ORDER BY total_atletas DESC;

-- Cantidad de atletas por federación
SELECT 
    f.direccion AS federacion, 
    COUNT(a.atleta_id) AS total_atletas
FROM federaciones f
LEFT JOIN atletas a ON f.federacion_id = a.federacion_id
GROUP BY f.direccion
ORDER BY total_atletas DESC;