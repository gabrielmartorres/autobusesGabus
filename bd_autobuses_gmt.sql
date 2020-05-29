-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.4.6-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para bd_autobuses_gmt
DROP DATABASE IF EXISTS `bd_autobuses_gmt`;
CREATE DATABASE IF NOT EXISTS `bd_autobuses_gmt` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `bd_autobuses_gmt`;

-- Volcando estructura para tabla bd_autobuses_gmt.autobus
DROP TABLE IF EXISTS `autobus`;
CREATE TABLE IF NOT EXISTS `autobus` (
  `idAutobus` int(11) NOT NULL AUTO_INCREMENT,
  `numeroPlazas` int(11) NOT NULL DEFAULT 6,
  PRIMARY KEY (`idAutobus`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bd_autobuses_gmt.autobus: ~1 rows (aproximadamente)
DELETE FROM `autobus`;
/*!40000 ALTER TABLE `autobus` DISABLE KEYS */;
INSERT INTO `autobus` (`idAutobus`, `numeroPlazas`) VALUES
	(1, 6);
/*!40000 ALTER TABLE `autobus` ENABLE KEYS */;

-- Volcando estructura para tabla bd_autobuses_gmt.cliente
DROP TABLE IF EXISTS `cliente`;
CREATE TABLE IF NOT EXISTS `cliente` (
  `idCliente` int(11) NOT NULL AUTO_INCREMENT,
  `nifCliente` varchar(50) NOT NULL DEFAULT '',
  `password` varchar(200) NOT NULL DEFAULT '',
  `nombreCliente` varchar(100) NOT NULL DEFAULT '',
  `apellidosCliente` varchar(200) NOT NULL DEFAULT '',
  `correoCliente` varchar(100) NOT NULL DEFAULT '',
  `telefonoCliente` varchar(15) NOT NULL DEFAULT '',
  `domicilioCliente` varchar(200) NOT NULL DEFAULT '',
  PRIMARY KEY (`idCliente`),
  UNIQUE KEY `nifCliente` (`nifCliente`),
  UNIQUE KEY `correoCliente` (`correoCliente`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bd_autobuses_gmt.cliente: ~0 rows (aproximadamente)
DELETE FROM `cliente`;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;

-- Volcando estructura para tabla bd_autobuses_gmt.compra
DROP TABLE IF EXISTS `compra`;
CREATE TABLE IF NOT EXISTS `compra` (
  `idCompra` int(11) NOT NULL AUTO_INCREMENT,
  `idTarjetaCompra` int(11) NOT NULL,
  `idViajeCompra` int(11) NOT NULL,
  `localizadorCompra` varchar(50) NOT NULL,
  `fechaCompra` date NOT NULL,
  `importeCompra` double NOT NULL,
  PRIMARY KEY (`idCompra`),
  KEY `FK_compra_tarjeta` (`idTarjetaCompra`),
  KEY `FK_compra_viaje` (`idViajeCompra`),
  CONSTRAINT `FK_compra_tarjeta` FOREIGN KEY (`idTarjetaCompra`) REFERENCES `tarjeta` (`idTarjeta`),
  CONSTRAINT `FK_compra_viaje` FOREIGN KEY (`idViajeCompra`) REFERENCES `viaje` (`idViaje`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bd_autobuses_gmt.compra: ~0 rows (aproximadamente)
DELETE FROM `compra`;
/*!40000 ALTER TABLE `compra` DISABLE KEYS */;
/*!40000 ALTER TABLE `compra` ENABLE KEYS */;

-- Volcando estructura para tabla bd_autobuses_gmt.comprabackup
DROP TABLE IF EXISTS `comprabackup`;
CREATE TABLE IF NOT EXISTS `comprabackup` (
  `idCompraBackup` int(11) NOT NULL AUTO_INCREMENT,
  `idTarjetaCompraBackup` int(11) NOT NULL,
  `idViajeCompraBackup` int(11) NOT NULL,
  `localizadorCompraBackup` varchar(50) NOT NULL,
  `fechaCompraBackup` date NOT NULL,
  `importeCompraBackup` double NOT NULL,
  `fechaBajaCompraBackup` date NOT NULL,
  PRIMARY KEY (`idCompraBackup`),
  KEY `FK__tarjeta` (`idTarjetaCompraBackup`),
  KEY `FK__viajebackup` (`idViajeCompraBackup`),
  CONSTRAINT `FK__tarjeta` FOREIGN KEY (`idTarjetaCompraBackup`) REFERENCES `tarjeta` (`idTarjeta`),
  CONSTRAINT `FK__viajebackup` FOREIGN KEY (`idViajeCompraBackup`) REFERENCES `viajebackup` (`idViajeBackup`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bd_autobuses_gmt.comprabackup: ~0 rows (aproximadamente)
DELETE FROM `comprabackup`;
/*!40000 ALTER TABLE `comprabackup` DISABLE KEYS */;
/*!40000 ALTER TABLE `comprabackup` ENABLE KEYS */;

-- Volcando estructura para tabla bd_autobuses_gmt.configuracion
DROP TABLE IF EXISTS `configuracion`;
CREATE TABLE IF NOT EXISTS `configuracion` (
  `idConfiguracion` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `cif` varchar(50) NOT NULL,
  `telefono` int(11) NOT NULL,
  `usuario` varchar(50) NOT NULL,
  `password` varchar(200) NOT NULL,
  PRIMARY KEY (`idConfiguracion`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bd_autobuses_gmt.configuracion: ~1 rows (aproximadamente)
DELETE FROM `configuracion`;
/*!40000 ALTER TABLE `configuracion` DISABLE KEYS */;
INSERT INTO `configuracion` (`idConfiguracion`, `nombre`, `cif`, `telefono`, `usuario`, `password`) VALUES
	(1, 'GABUS', '12345678', 967230298, 'Administrador', '18a98c35f49808b45edadc75fb1b25ebfd4037d6');
/*!40000 ALTER TABLE `configuracion` ENABLE KEYS */;

-- Volcando estructura para tabla bd_autobuses_gmt.estacion
DROP TABLE IF EXISTS `estacion`;
CREATE TABLE IF NOT EXISTS `estacion` (
  `idEstacion` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `localidad` varchar(100) NOT NULL,
  PRIMARY KEY (`idEstacion`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bd_autobuses_gmt.estacion: ~3 rows (aproximadamente)
DELETE FROM `estacion`;
/*!40000 ALTER TABLE `estacion` DISABLE KEYS */;
INSERT INTO `estacion` (`idEstacion`, `nombre`, `direccion`, `localidad`) VALUES
	(1, 'Albacete', 'Calle Federico García Lorca, 12', 'Albacete'),
	(2, 'Hellín', 'Av. de la Constitución, 16-18', 'Hellín'),
	(3, 'La Roda', 'Av. Reina Sofía, 19', 'La Roda');
/*!40000 ALTER TABLE `estacion` ENABLE KEYS */;

-- Volcando estructura para tabla bd_autobuses_gmt.horario
DROP TABLE IF EXISTS `horario`;
CREATE TABLE IF NOT EXISTS `horario` (
  `idHorario` int(11) NOT NULL AUTO_INCREMENT,
  `idRuta` int(11) NOT NULL,
  `horaSalida` time NOT NULL,
  `tipoDia` enum('semana','sabado') NOT NULL,
  PRIMARY KEY (`idHorario`),
  KEY `FK_horario_ruta` (`idRuta`),
  CONSTRAINT `FK_horario_ruta` FOREIGN KEY (`idRuta`) REFERENCES `ruta` (`idRuta`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bd_autobuses_gmt.horario: ~11 rows (aproximadamente)
DELETE FROM `horario`;
/*!40000 ALTER TABLE `horario` DISABLE KEYS */;
INSERT INTO `horario` (`idHorario`, `idRuta`, `horaSalida`, `tipoDia`) VALUES
	(1, 1, '13:15:00', 'semana'),
	(2, 2, '07:40:00', 'semana'),
	(3, 5, '06:00:00', 'sabado'),
	(4, 6, '08:00:00', 'semana'),
	(5, 1, '15:00:00', 'sabado'),
	(6, 1, '08:30:00', 'semana'),
	(7, 2, '06:30:00', 'semana'),
	(8, 2, '13:00:00', 'sabado'),
	(9, 1, '20:40:00', 'sabado'),
	(12, 2, '22:10:00', 'semana'),
	(13, 2, '15:10:00', 'sabado');
/*!40000 ALTER TABLE `horario` ENABLE KEYS */;

-- Volcando estructura para tabla bd_autobuses_gmt.ocupacion
DROP TABLE IF EXISTS `ocupacion`;
CREATE TABLE IF NOT EXISTS `ocupacion` (
  `idOcupacion` int(11) NOT NULL AUTO_INCREMENT,
  `idCompraOcupacion` int(11) NOT NULL,
  `idViajeroOcupacion` int(11) NOT NULL,
  `asiento` int(11) NOT NULL,
  `importe` double NOT NULL,
  PRIMARY KEY (`idOcupacion`),
  UNIQUE KEY `idCompraOcupacion_idViajeroOcupacion_asiento` (`idCompraOcupacion`,`idViajeroOcupacion`,`asiento`),
  KEY `FK_ocupacion_viajero` (`idViajeroOcupacion`),
  CONSTRAINT `FK_ocupacion_compra` FOREIGN KEY (`idCompraOcupacion`) REFERENCES `compra` (`idCompra`),
  CONSTRAINT `FK_ocupacion_viajero` FOREIGN KEY (`idViajeroOcupacion`) REFERENCES `viajero` (`idViajero`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bd_autobuses_gmt.ocupacion: ~0 rows (aproximadamente)
DELETE FROM `ocupacion`;
/*!40000 ALTER TABLE `ocupacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `ocupacion` ENABLE KEYS */;

-- Volcando estructura para tabla bd_autobuses_gmt.ocupacionbackup
DROP TABLE IF EXISTS `ocupacionbackup`;
CREATE TABLE IF NOT EXISTS `ocupacionbackup` (
  `idOcupacionBackup` int(11) NOT NULL AUTO_INCREMENT,
  `idCompraOcupacionBackup` int(11) NOT NULL,
  `idViajeroOcupacionBackup` int(11) NOT NULL,
  `asientoBackup` int(11) NOT NULL,
  `importeBackup` double NOT NULL,
  `fechaBajaOcupacionBackup` date NOT NULL,
  PRIMARY KEY (`idOcupacionBackup`),
  UNIQUE KEY `idCompraOcupacionBackup_idViajeroOcupacionBackup_asientoBackup` (`idCompraOcupacionBackup`,`idViajeroOcupacionBackup`,`asientoBackup`),
  KEY `FK_ocupacionbackup_viajerobackup` (`idViajeroOcupacionBackup`),
  CONSTRAINT `FK_ocupacionbackup_comprabackup` FOREIGN KEY (`idCompraOcupacionBackup`) REFERENCES `comprabackup` (`idCompraBackup`),
  CONSTRAINT `FK_ocupacionbackup_viajerobackup` FOREIGN KEY (`idViajeroOcupacionBackup`) REFERENCES `viajerobackup` (`idViajeroBackup`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bd_autobuses_gmt.ocupacionbackup: ~0 rows (aproximadamente)
DELETE FROM `ocupacionbackup`;
/*!40000 ALTER TABLE `ocupacionbackup` DISABLE KEYS */;
/*!40000 ALTER TABLE `ocupacionbackup` ENABLE KEYS */;

-- Volcando estructura para tabla bd_autobuses_gmt.ruta
DROP TABLE IF EXISTS `ruta`;
CREATE TABLE IF NOT EXISTS `ruta` (
  `idRuta` int(11) NOT NULL AUTO_INCREMENT,
  `idOrigen` int(11) NOT NULL,
  `idDestino` int(11) NOT NULL,
  `duracion` time NOT NULL,
  `distancia` double NOT NULL DEFAULT 0,
  `precio` double NOT NULL DEFAULT 0,
  `comentario` varchar(50) NOT NULL,
  PRIMARY KEY (`idRuta`),
  UNIQUE KEY `idOrigen_idDestino` (`idOrigen`,`idDestino`),
  KEY `FK_ruta_estacion_2` (`idDestino`),
  CONSTRAINT `FK_ruta_estacion` FOREIGN KEY (`idOrigen`) REFERENCES `estacion` (`idEstacion`),
  CONSTRAINT `FK_ruta_estacion_2` FOREIGN KEY (`idDestino`) REFERENCES `estacion` (`idEstacion`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bd_autobuses_gmt.ruta: ~6 rows (aproximadamente)
DELETE FROM `ruta`;
/*!40000 ALTER TABLE `ruta` DISABLE KEYS */;
INSERT INTO `ruta` (`idRuta`, `idOrigen`, `idDestino`, `duracion`, `distancia`, `precio`, `comentario`) VALUES
	(1, 1, 2, '00:47:00', 49.3, 5.3, 'Albacete - Hellín'),
	(2, 2, 1, '00:45:00', 49.3, 3.5, 'Hellín - Albacete'),
	(5, 1, 3, '00:33:00', 37.3, 3.25, 'Albacete - La Roda'),
	(6, 3, 1, '00:33:00', 37.3, 3.25, 'La Roda - Albacete'),
	(7, 2, 3, '15:13:31', 104, 10.2, 'Hellín - La Roda'),
	(8, 3, 2, '15:13:55', 104, 10.2, 'La Roda - Hellín');
/*!40000 ALTER TABLE `ruta` ENABLE KEYS */;

-- Volcando estructura para tabla bd_autobuses_gmt.tarjeta
DROP TABLE IF EXISTS `tarjeta`;
CREATE TABLE IF NOT EXISTS `tarjeta` (
  `idTarjeta` int(11) NOT NULL AUTO_INCREMENT,
  `idCliente` int(11) NOT NULL,
  `numeroTarjeta` varbinary(200) NOT NULL,
  `tipoTarjeta` varchar(50) NOT NULL,
  `caducidadMes` int(2) NOT NULL,
  `caducidadAno` int(2) NOT NULL,
  PRIMARY KEY (`idTarjeta`),
  KEY `FK_tarjeta_cliente` (`idCliente`),
  CONSTRAINT `FK_tarjeta_cliente` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`idCliente`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bd_autobuses_gmt.tarjeta: ~0 rows (aproximadamente)
DELETE FROM `tarjeta`;
/*!40000 ALTER TABLE `tarjeta` DISABLE KEYS */;
/*!40000 ALTER TABLE `tarjeta` ENABLE KEYS */;

-- Volcando estructura para tabla bd_autobuses_gmt.viaje
DROP TABLE IF EXISTS `viaje`;
CREATE TABLE IF NOT EXISTS `viaje` (
  `idViaje` int(11) NOT NULL AUTO_INCREMENT,
  `idHorario` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `plazasLibres` int(11) NOT NULL DEFAULT 6,
  PRIMARY KEY (`idViaje`),
  KEY `FK_viaje_horario` (`idHorario`),
  CONSTRAINT `FK_viaje_horario` FOREIGN KEY (`idHorario`) REFERENCES `horario` (`idHorario`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bd_autobuses_gmt.viaje: ~10 rows (aproximadamente)
DELETE FROM `viaje`;
/*!40000 ALTER TABLE `viaje` DISABLE KEYS */;
INSERT INTO `viaje` (`idViaje`, `idHorario`, `fecha`, `plazasLibres`) VALUES
	(1, 1, '2020-03-20', 6),
	(3, 5, '2020-03-21', 6),
	(4, 6, '2020-03-20', 6),
	(5, 3, '2020-03-21', 6),
	(6, 4, '2020-03-21', 6),
	(7, 7, '2020-03-20', 6),
	(8, 8, '2020-03-21', 6),
	(11, 9, '2020-03-21', 6),
	(12, 12, '2020-03-20', 6),
	(13, 13, '2020-03-21', 6);
/*!40000 ALTER TABLE `viaje` ENABLE KEYS */;

-- Volcando estructura para tabla bd_autobuses_gmt.viajebackup
DROP TABLE IF EXISTS `viajebackup`;
CREATE TABLE IF NOT EXISTS `viajebackup` (
  `idViajeBackup` int(11) NOT NULL AUTO_INCREMENT,
  `idHorarioBackup` int(11) NOT NULL,
  `fechaBackup` date NOT NULL,
  `plazasLibresBackup` int(11) NOT NULL DEFAULT 6,
  `fechaBajaViajeBackup` date NOT NULL,
  PRIMARY KEY (`idViajeBackup`),
  KEY `FK_viajebackup_horario` (`idHorarioBackup`),
  CONSTRAINT `FK_viajebackup_horario` FOREIGN KEY (`idHorarioBackup`) REFERENCES `horario` (`idHorario`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bd_autobuses_gmt.viajebackup: ~0 rows (aproximadamente)
DELETE FROM `viajebackup`;
/*!40000 ALTER TABLE `viajebackup` DISABLE KEYS */;
/*!40000 ALTER TABLE `viajebackup` ENABLE KEYS */;

-- Volcando estructura para tabla bd_autobuses_gmt.viajero
DROP TABLE IF EXISTS `viajero`;
CREATE TABLE IF NOT EXISTS `viajero` (
  `idViajero` int(11) NOT NULL AUTO_INCREMENT,
  `nifViajero` varchar(50) NOT NULL,
  `nombreViajero` varchar(100) NOT NULL,
  `apellidosViajero` varchar(150) NOT NULL,
  PRIMARY KEY (`idViajero`),
  UNIQUE KEY `nifViajero` (`nifViajero`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bd_autobuses_gmt.viajero: ~0 rows (aproximadamente)
DELETE FROM `viajero`;
/*!40000 ALTER TABLE `viajero` DISABLE KEYS */;
/*!40000 ALTER TABLE `viajero` ENABLE KEYS */;

-- Volcando estructura para tabla bd_autobuses_gmt.viajerobackup
DROP TABLE IF EXISTS `viajerobackup`;
CREATE TABLE IF NOT EXISTS `viajerobackup` (
  `idViajeroBackup` int(11) NOT NULL AUTO_INCREMENT,
  `nifViajeroBackup` varchar(50) NOT NULL,
  `nombreViajeroBackup` varchar(100) NOT NULL,
  `apellidosViajeroBackup` varchar(150) NOT NULL,
  `fechaBajaViajeroBackup` date NOT NULL,
  PRIMARY KEY (`idViajeroBackup`),
  UNIQUE KEY `nifViajero` (`nifViajeroBackup`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bd_autobuses_gmt.viajerobackup: ~0 rows (aproximadamente)
DELETE FROM `viajerobackup`;
/*!40000 ALTER TABLE `viajerobackup` DISABLE KEYS */;
/*!40000 ALTER TABLE `viajerobackup` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
