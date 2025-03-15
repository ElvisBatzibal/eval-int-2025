USE eval_int_2025;

--1. Ingresar los roles. Administrador Empleado. 

INSERT INTO roles (nombre, descripcion) VALUES ('Administrador','Administrador del sistema');
INSERT INTO roles (nombre, descripcion) VALUES ('Empleado','Empleado de la empresa');

--2. Agregar los puestos.
INSERT INTO puestos (puesto) VALUES ('Jefe de Informatica');
INSERT INTO puestos (puesto) VALUES ('Secretaria');
INSERT INTO puestos (puesto) VALUES ('Contador');

--3. Agregar un empleado para cada puesto. 
INSERT INTO empleados (nombre,apellido,telefono,fecha_nacimiento,puesto_id) VALUES ('Juan','Perez','1234567890','1990-01-01',1);
INSERT INTO empleados (nombre,apellido,telefono,fecha_nacimiento,puesto_id) VALUES ('Maria','Lopez','1234567890','2000-01-01',2);
INSERT INTO empleados (nombre,apellido,telefono,fecha_nacimiento,puesto_id) VALUES ('Pedro','Ramirez','1234567890','2002-01-01',3);

-- 4. Ingrese 3 usuarios, los empleados con puesto secretaria y contador deberán tener el permiso de tipo empleado y el empleado con el puesto jefe de informática el permiso de administrador.

INSERT INTO usuarios (usuario, email, password, estado, rol_id, empleado_id) VALUES
('carlos.lopez', 'carlos.lopez@gmail.com', 'password123', 'A', 1, 1), -- Administrador (Jefe de Informática)
('ana.perez', 'ana.perez@gmail.com', 'password123', 'A', 2, 2), -- Empleado (Secretaria)
('luis.gomez', 'luis.gomez@gmail.com', 'password123', 'A', 2, 3) -- Empleado (Contador)
;

-- 5. Obtener los datos de todos los usuarios, los datos a mostrar son: Nombre Compledo del empleado, puesto, email, nombre del rol, Activo

SELECT e.nombre + ' ' + e.apellido AS 'Nombre Completo'
, p.puesto AS Puesto
, u.email AS Email
, r.nombre AS Rol
, CASE u.estado WHEN 'A' THEN 'Si' ELSE 'No' END AS Activo

FROM usuarios u
INNER JOIN empleados e ON u.empleado_id = e.empleado_id
INNER JOIN puestos p ON e.puesto_id = p.puesto_id
INNER JOIN roles r ON u.rol_id = r.rol_id
;

-- 6. Crear una vista con el nombre vw_usuarios, utilizar la consulta anterior.

CREATE VIEW vw_usuarios AS
SELECT e.nombre + ' ' + e.apellido AS 'Nombre Completo'
, p.puesto AS Puesto
, u.email AS Email
, r.nombre AS Rol
, CASE u.estado WHEN 'A' THEN 'Si' ELSE 'No' END AS Activo  
FROM usuarios u
INNER JOIN empleados e ON u.empleado_id = e.empleado_id
INNER JOIN puestos p ON e.puesto_id = p.puesto_id
INNER JOIN roles r ON u.rol_id = r.rol_id
;

SELECT * FROM vw_usuarios;

-- 7. Modificar teléfono y fecha de nacimiento del empleado con id 3, los datos son los siguientes: Teléfono: 22334455, Fecha de nacimiento: 01/01/2000

UPDATE empleados SET telefono = '22334455', fecha_nacimiento = '2000-01-01' WHERE empleado_id = 3;

SELECT * FROM empleados;

-- 8. Eliminar los datos del empleado con id 3 y fecha de nacimiento 01/01/2000
DELETE FROM empleados WHERE empleado_id = 3 AND fecha_nacimiento = '2000-01-01';

SELECT * FROM empleados;