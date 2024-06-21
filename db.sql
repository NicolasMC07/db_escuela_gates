-- Deshabilitar comprobaciones de claves únicas y foreign keys durante la ejecución del script
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- Crear la base de datos si no existe
CREATE SCHEMA IF NOT EXISTS `b0t2xst1vj9gp3pcr3lf` ;
USE `b0t2xst1vj9gp3pcr3lf` ;

-- Crear la tabla roles
CREATE TABLE IF NOT EXISTS `b0t2xst1vj9gp3pcr3lf`.`roles` (
  `id` INT NOT NULL AUTO_INCREMENT, 
  `nombre` VARCHAR(50) NULL,  
  PRIMARY KEY (`id`) 
) ENGINE = InnoDB;

-- Crear la tabla tipo_documentos
CREATE TABLE IF NOT EXISTS `b0t2xst1vj9gp3pcr3lf`.`tipo_documentos` (
  `id` INT NOT NULL AUTO_INCREMENT,  
  `nombre` VARCHAR(45) NULL,  
  `abreviatura` VARCHAR(45) NULL,  
  PRIMARY KEY (`id`)  
) ENGINE = InnoDB;

-- Crear la tabla empleados
CREATE TABLE IF NOT EXISTS `b0t2xst1vj9gp3pcr3lf`.`empleados` (
  `id` INT NOT NULL AUTO_INCREMENT,  
  `nombre` VARCHAR(45) NULL,  
  `numero_documento` VARCHAR(45) NULL,  
  `telefono` VARCHAR(45) NULL,  
  `direccion` VARCHAR(45) NULL,  
  `email` VARCHAR(45) NULL,  
  `fecha_contratacion` DATE NULL, 
  `roles_id` INT NOT NULL, 
  `tipo_documentos_id` INT NOT NULL,  
  PRIMARY KEY (`id`, `roles_id`, `tipo_documentos_id`),  
  INDEX `fk_empleados_roles_idx` (`roles_id` ASC) VISIBLE,  
  INDEX `fk_empleados_tipo_documentos1_idx` (`tipo_documentos_id` ASC) VISIBLE,  
  CONSTRAINT `fk_empleados_roles`
    FOREIGN KEY (`roles_id`)
    REFERENCES `b0t2xst1vj9gp3pcr3lf`.`roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,  
  CONSTRAINT `fk_empleados_tipo_documentos1`
    FOREIGN KEY (`tipo_documentos_id`)
    REFERENCES `b0t2xst1vj9gp3pcr3lf`.`tipo_documentos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION  
) ENGINE = InnoDB;

-- Crear la tabla cursos
CREATE TABLE IF NOT EXISTS `b0t2xst1vj9gp3pcr3lf`.`cursos` (
  `id` INT NOT NULL AUTO_INCREMENT, 
  `nombre` VARCHAR(45) NULL,  
  `empleado_encargado_id` INT NOT NULL,  
  PRIMARY KEY (`id`, `empleado_encargado_id`),  
  INDEX `fk_cursos_empleados1_idx` (`empleado_encargado_id` ASC) VISIBLE, 
  CONSTRAINT `fk_cursos_empleados1`
    FOREIGN KEY (`empleado_encargado_id`)
    REFERENCES `b0t2xst1vj9gp3pcr3lf`.`empleados` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION  
) ENGINE = InnoDB;

-- Crear la tabla estudiantes
CREATE TABLE IF NOT EXISTS `b0t2xst1vj9gp3pcr3lf`.`estudiantes` (
  `id` INT NOT NULL AUTO_INCREMENT, 
  `nombre` VARCHAR(45) NULL,  
  `numero_documento` VARCHAR(45) NULL, 
  `telefono_acudiente` VARCHAR(45) NULL,  
  `direccion` VARCHAR(45) NULL, 
  `fecha_nacimiento` VARCHAR(45) NULL, 
  `tipo_documentos_id` INT NOT NULL,  
  `cursos_id` INT NOT NULL, 
  PRIMARY KEY (`id`, `tipo_documentos_id`, `cursos_id`), 
  INDEX `fk_estudiantes_tipo_documentos1_idx` (`tipo_documentos_id` ASC) VISIBLE,  
  INDEX `fk_estudiantes_cursos1_idx` (`cursos_id` ASC) VISIBLE,  
  CONSTRAINT `fk_estudiantes_tipo_documentos1`
    FOREIGN KEY (`tipo_documentos_id`)
    REFERENCES `b0t2xst1vj9gp3pcr3lf`.`tipo_documentos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,  
  CONSTRAINT `fk_estudiantes_cursos1`
    FOREIGN KEY (`cursos_id`)
    REFERENCES `b0t2xst1vj9gp3pcr3lf`.`cursos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION  
) ENGINE = InnoDB;

-- Crear la tabla asignaturas
CREATE TABLE IF NOT EXISTS `b0t2xst1vj9gp3pcr3lf`.`asignaturas` (
  `id` INT NOT NULL AUTO_INCREMENT, 
  `nombre` VARCHAR(45) NULL,  
  `empleados_id` INT NOT NULL,  
  PRIMARY KEY (`id`, `empleados_id`), 
  INDEX `fk_asignaturas_empleados1_idx` (`empleados_id` ASC) VISIBLE,  
  CONSTRAINT `fk_asignaturas_empleados1`
    FOREIGN KEY (`empleados_id`)
    REFERENCES `b0t2xst1vj9gp3pcr3lf`.`empleados` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION  
) ENGINE = InnoDB;

-- Crear la tabla cursos_asignaturas
CREATE TABLE IF NOT EXISTS `b0t2xst1vj9gp3pcr3lf`.`cursos_asignaturas` (
  `id` INT NOT NULL AUTO_INCREMENT, 
  `asignaturas_id` INT NOT NULL,  
  `cursos_id` INT NOT NULL, 
  PRIMARY KEY (`id`, `asignaturas_id`, `cursos_id`), 
  INDEX `fk_cursos_asignaturas_asignaturas1_idx` (`asignaturas_id` ASC) VISIBLE, 
  INDEX `fk_cursos_asignaturas_cursos1_idx` (`cursos_id` ASC) VISIBLE, 
  CONSTRAINT `fk_cursos_asignaturas_asignaturas1`
    FOREIGN KEY (`asignaturas_id`)
    REFERENCES `b0t2xst1vj9gp3pcr3lf`.`asignaturas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,  
  CONSTRAINT `fk_cursos_asignaturas_cursos1`
    FOREIGN KEY (`cursos_id`)
    REFERENCES `b0t2xst1vj9gp3pcr3lf`.`cursos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION 
) ENGINE = InnoDB;

-- Crear la tabla notas
CREATE TABLE IF NOT EXISTS `b0t2xst1vj9gp3pcr3lf`.`notas` (
  `id` INT NOT NULL AUTO_INCREMENT,  
  `estudiantes_id` INT NOT NULL,  
  `asignaturas_id` INT NOT NULL,  
  `nota` DECIMAL(3,2) NULL,  
  PRIMARY KEY (`id`, `estudiantes_id`, `asignaturas_id`),  
  INDEX `fk_notas_estudiantes1_idx` (`estudiantes_id` ASC) VISIBLE,  
  INDEX `fk_notas_asignaturas1_idx` (`asignaturas_id` ASC) VISIBLE, 
  CONSTRAINT `fk_notas_estudiantes1`
    FOREIGN KEY (`estudiantes_id`)
    REFERENCES `b0t2xst1vj9gp3pcr3lf`.`estudiantes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,  
  CONSTRAINT `fk_notas_asignaturas1`
    FOREIGN KEY (`asignaturas_id`)
    REFERENCES `b0t2xst1vj9gp3pcr3lf`.`asignaturas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION 
) ENGINE = InnoDB;

-- Restaurar comprobaciones de claves únicas y foreign keys
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
-- Insertar registros en la tabla roles
INSERT INTO b0t2xst1vj9gp3pcr3lf.roles (nombre) VALUES
('rector'),
('profesor'),
('estudiante'),
('coordinador'),
('aseo');
-- Insertar registros en la tabla tipo_documentos
INSERT INTO b0t2xst1vj9gp3pcr3lf.tipo_documentos (nombre, abreviatura) VALUES
('cédula de ciudadanía', 'cc'),
('tarjeta de identidad', 'ti'),
('cédula de extranjería', 'ce'),
('pasaporte', 'pa'),
('registro civil', 'rc');
-- Insertar registros en la tabla empleados
INSERT INTO b0t2xst1vj9gp3pcr3lf.empleados (nombre, numero_documento, telefono, direccion, email, fecha_contratacion, roles_id, tipo_documentos_id) VALUES
('juan pérez', '123456789', '3001234567', 'calle 123', 'juan.perez@example.com', '2020-01-15', 2, 1),
('ana gómez', '987654321', '3009876543', 'carrera 45', 'ana.gomez@example.com', '2019-06-01', 2, 1),
('carlos martínez', '112233445', '3001122334', 'avenida 10', 'carlos.martinez@example.com', '2021-03-20', 4, 1),
('marta rodríguez', '556677889', '3005566778', 'diagonal 22', 'marta.rodriguez@example.com', '2018-09-10', 5, 1),
('luis fernández', '998877665', '3009988776', 'transversal 8', 'luis.fernandez@example.com', '2022-12-01', 2, 1);
-- Insertar registros en la tabla cursos
INSERT INTO b0t2xst1vj9gp3pcr3lf.cursos (nombre, empleado_encargado_id) VALUES
('6-1', 1),
('7-1', 2),
('8-1', 3),
('9-1', 4),
('10-1', 5);
-- Insertar registros en la tabla estudiantes
INSERT INTO b0t2xst1vj9gp3pcr3lf.estudiantes (nombre, numero_documento, telefono_acudiente, direccion, fecha_nacimiento, cursos_id, tipo_documentos_id) VALUES
('pedro ramírez', '111222333', '3101234567', 'calle 45', '2005-05-15', 1, 1),
('lucía ortiz', '444555666', '3109876543', 'carrera 12', '2006-11-20', 2, 1),
('sofía hernández', '777888999', '3101122334', 'avenida 7', '2007-03-10',3, 1),
('mateo lópez', '123321123', '3105566778', 'diagonal 19', '2008-08-30', 4, 1),
('valeria sánchez', '456654456', '3109988776', 'transversal 21', '2009-01-25', 5, 1);
-- Insertar registros en la tabla asignaturas
INSERT INTO b0t2xst1vj9gp3pcr3lf.asignaturas (nombre, empleados_id) VALUES
('álgebra', 1),
('química', 2),
('historia', 3),
('matematicas', 4),
('fisica', 5);
-- Insertar registros en la tabla cursos_asignaturas
INSERT INTO b0t2xst1vj9gp3pcr3lf.cursos_asignaturas (asignaturas_id, cursos_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- llamando tablas
select * from cursos;
select * from empleados;
select * from estudiantes;
select * from asignaturas;

-- ver listado de estudiantes de un grupo x

SELECT e.nombre FROM estudiantes e 
INNER JOIN cursos c ON e.cursos_id = c.id
WHERE c.nombre = '6-1';

-- ver la lista de estudiantes que vean una asignatura x

SELECT e.nombre, a.nombre FROM estudiantes e
INNER JOIN cursos_asignaturas ca ON e.cursos_id = ca.cursos_id
INNER JOIN asignaturas a ON ca.asignaturas_id = a.id
WHERE a.id = 5;

-- ver lista de profesores que le dictan clase a un estudiante x

SELECT e.nombre AS nombre_profesor, est.nombre AS nombre_estudiante
FROM empleados AS e
JOIN cursos AS c ON e.id = c.empleado_encargado_id
JOIN estudiantes AS est ON est.cursos_id = c.id
WHERE c.id = 5;

-- ver los grupos ordenados de forma descendente 

SELECT COUNT(*) AS Estudiantes , c.nombre FROM estudiantes e
INNER JOIN cursos c ON e.cursos_id = c.id
GROUP BY c.nombre ORDER BY Estudiantes desc


-- datos de acceso a la base de datos implementada en la nube
-- host : b0t2xst1vj9gp3pcr3lf-mysql.services.clever-cloud.com
-- Database Name : b0t2xst1vj9gp3pcr3lf
-- user : uaeqwtl9lrcpa5nq
-- password : mu6kFWiGYeyiI5wz0abO
-- port 3306