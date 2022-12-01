-- TABLA DE CONFIGURACIÓN
CREATE TABLE IF NOT EXISTS `rinku`.`CONFIG` (
  `CFG_CONFIG_VALOR` VARCHAR(250) NULL,
  `CFG_CONFIG_GRUPO` VARCHAR(250) NULL,
  `CFG_CONFIG_VAR` VARCHAR(250) NULL);

-- TABLA DE TIPOS DE ROLES
CREATE TABLE IF NOT EXISTS `rinku`.`ROLES` (
  `ID` INT NOT NULL,
  `R_NAME` VARCHAR(300) NULL,
  `R_ADDITIONAL` VARCHAR(300) NULL,
  PRIMARY KEY (`ID`));

-- TABLA DE EMPLEADOS
CREATE TABLE IF NOT EXISTS `rinku`.`EMPLOYEED` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `E_NAME` VARCHAR(300) NULL,
  `E_NUMBER_ID` INT,  
  `ROLE_ID` INT,
  PRIMARY KEY (`ID`),
  INDEX role_id (`ROLE_ID`),
    FOREIGN KEY (`ROLE_ID`)
    REFERENCES `rinku`.`ROLES` (`ID`));

-- Tabla de reporte de pagos
CREATE TABLE IF NOT EXISTS `rinku`.`report_payments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `month` VARCHAR(45) NULL,
  `year` VARCHAR(45) NULL,
  `payment` VARCHAR(45) NULL,
  `employeed_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX employeed_id (`employeed_id`),
    FOREIGN KEY (`employeed_id`)
    REFERENCES `rinku`.`EMPLOYEED` (`ID`));

-- INFORMACION DE LA TABLA DE CONFIGURACIÓN
INSERT INTO `rinku`.`CONFIG` (`CFG_CONFIG_VALOR`, `CFG_CONFIG_GRUPO`, `CFG_CONFIG_VAR`) VALUES ("5", "ENTREGAS", "PAGO_ENTREGA");
INSERT INTO `rinku`.`CONFIG` (`CFG_CONFIG_VALOR`, `CFG_CONFIG_GRUPO`, `CFG_CONFIG_VAR`) VALUES ("9", "PAGOS", "ISR");
INSERT INTO `rinku`.`CONFIG` (`CFG_CONFIG_VALOR`, `CFG_CONFIG_GRUPO`, `CFG_CONFIG_VAR`) VALUES ("10000", "PAGOS", "SALDO_TOPE");
INSERT INTO `rinku`.`CONFIG` (`CFG_CONFIG_VALOR`, `CFG_CONFIG_GRUPO`, `CFG_CONFIG_VAR`) VALUES ("3", "PAGOS", "ISR_TOPE");
INSERT INTO `rinku`.`CONFIG` (`CFG_CONFIG_VALOR`, `CFG_CONFIG_GRUPO`, `CFG_CONFIG_VAR`) VALUES ("4", "PAGOS", "VALES");
INSERT INTO `rinku`.`CONFIG` (`CFG_CONFIG_VALOR`, `CFG_CONFIG_GRUPO`, `CFG_CONFIG_VAR`) VALUES ("30", "PAGOS", "PAGO_HORA");
INSERT INTO `rinku`.`CONFIG` (`CFG_CONFIG_VALOR`, `CFG_CONFIG_GRUPO`, `CFG_CONFIG_VAR`) VALUES ("8", "PAGOS", "HORAS");
INSERT INTO `rinku`.`CONFIG` (`CFG_CONFIG_VALOR`, `CFG_CONFIG_GRUPO`, `CFG_CONFIG_VAR`) VALUES ("6", "PAGOS", "DIAS");
INSERT INTO `rinku`.`CONFIG` (`CFG_CONFIG_VALOR`, `CFG_CONFIG_GRUPO`, `CFG_CONFIG_VAR`) VALUES ("4", "PAGOS", "SEMANAS");

-- INSERTAR LOS ROLES 
INSERT INTO `rinku`.`ROLES` (`ID`, `R_NAME`, `R_ADDITIONAL`) VALUES (1,"CHOFER", "10");
INSERT INTO `rinku`.`ROLES` (`ID`, `R_NAME`, `R_ADDITIONAL`) VALUES (2,"CARGADOR", "5");
INSERT INTO `rinku`.`ROLES` (`ID`, `R_NAME`, `R_ADDITIONAL`) VALUES (3,"AUXILIAR", "0");

-- INSERTAR UN EMPLEADO
INSERT INTO `rinku`.`EMPLOYEED` (`E_NAME`, `ROLE_ID`, `E_NUMBER_ID`) VALUES ("ALFONSO MANUEL AGUILAR LEYVA", 1, 1);
INSERT INTO `rinku`.`EMPLOYEED` (`E_NAME`, `ROLE_ID`, `E_NUMBER_ID`) VALUES ("MANUEL AGUILAR CRUZ", 1, 2);
INSERT INTO `rinku`.`EMPLOYEED` (`E_NAME`, `ROLE_ID`, `E_NUMBER_ID`) VALUES ("JESUS VAZQUEZ", 3, 3);

-- Crear SP de Lista de Empleados
DELIMITER $$
CREATE PROCEDURE rinku.listEmployeeds()
BEGIN
    SELECT A.ID, A.E_NAME, A.ROLE_ID, B.R_NAME, B.R_ADDITIONAL, A.E_NUMBER_ID FROM RINKU.EMPLOYEED A INNER JOIN ROLES B ON A.ROLE_ID = B.ID;
END$$

-- Crear el SP para agregar un nuevo empleado
DELIMITER //
CREATE PROCEDURE rinku.addEmployeed (IN E_NAME VARCHAR(300), IN E_ROLE VARCHAR(300), IN E_NUMBER_ID INT)
BEGIN
    INSERT INTO `rinku`.`EMPLOYEED` (`E_NAME`, `ROLE_ID`, `E_NUMBER_ID`) VALUES (E_NAME, E_ROLE, E_NUMBER_ID);
END //

-- Crear el SP para obtener los roles
DELIMITER $$
CREATE PROCEDURE rinku.getRoles()
BEGIN
    SELECT * FROM RINKU.ROLES;
END$$

-- Crear el SP para obtener el siguiente numero de empleado
DELIMITER $$
CREATE PROCEDURE rinku.getNumberId()
BEGIN
    SELECT MAX(E_NUMBER_ID) FROM RINKU.EMPLOYEED;
END$$