-- vamos a trabajar para esta ocasion con la tabla "oficina" pero antes debemos hacer una cosa:

-- Eliminamos la clave foranea y la relacion de la tabla empleados
ALTER TABLE jardineria.empleado DROP FOREIGN KEY empleado_ibfk_1;


-- Ahora si volvemos a la tabla "oficina"

-- Eliminamos la clave primaria de la tabla oficina
ALTER TABLE oficina
DROP PRIMARY KEY;

-- Añadir un nuevo campo llamado "id" que también lo convertiremos en clave primaria mas adelante
ALTER TABLE `oficina` ADD `id` INT NOT NULL AFTER `codigo_oficina`;

-- crear una clave primaria compuesta
ALTER TABLE oficina ADD PRIMARY KEY (codigo_oficina, id);

-- Llenar los campos existentes de la PK "id" con el total de numero de registros

SET @row_number = 0;

UPDATE oficina
SET id = (@row_number := @row_number + 1)
ORDER BY codigo_oficina;

-- Crear un trigger para que cuando se haga un insert se llene automaticamente el campo de la PK "id" con el numero siguiente del total de registros

DELIMITER //

CREATE TRIGGER before_insert_oficina
BEFORE INSERT ON oficina
FOR EACH ROW
BEGIN
  SET NEW.id = (SELECT COUNT(*) FROM oficina) + 1;
END;

//

DELIMITER ;
