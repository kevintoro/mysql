-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3308
-- Tiempo de generación: 24-04-2020 a las 04:35:32
-- Versión del servidor: 8.0.18
-- Versión de PHP: 7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `campeonato`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dt`
--

DROP TABLE IF EXISTS `dt`;
CREATE TABLE IF NOT EXISTS `dt` (
  `documento` varchar(5) NOT NULL,
  `fechainicio` varchar(10) NOT NULL,
  PRIMARY KEY (`documento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dtequipo`
--

DROP TABLE IF EXISTS `dtequipo`;
CREATE TABLE IF NOT EXISTS `dtequipo` (
  `codequipo` varchar(5) NOT NULL,
  `docdt` varchar(5) NOT NULL,
  `fechainicio` varchar(10) NOT NULL,
  PRIMARY KEY (`codequipo`,`docdt`,`fechainicio`),
  KEY `fk_dtequipo_dt` (`docdt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `eqtorneo`
--

DROP TABLE IF EXISTS `eqtorneo`;
CREATE TABLE IF NOT EXISTS `eqtorneo` (
  `codtorneo` varchar(5) NOT NULL,
  `codequipo` varchar(5) NOT NULL,
  `codgrupo` varchar(5) NOT NULL,
  PRIMARY KEY (`codtorneo`,`codequipo`),
  KEY `fk_eqtorneo_torneopartidoeq_equipo` (`codequipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `equipo`
--

DROP TABLE IF EXISTS `equipo`;
CREATE TABLE IF NOT EXISTS `equipo` (
  `codequipo` varchar(5) NOT NULL,
  `nombre` varchar(10) NOT NULL,
  `origen` varchar(50) NOT NULL,
  `colorlocal` varchar(10) NOT NULL,
  `colorvisita` varchar(10) NOT NULL,
  PRIMARY KEY (`codequipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `equipo`
--

INSERT INTO `equipo` (`codequipo`, `nombre`, `origen`, `colorlocal`, `colorvisita`) VALUES
('1', 'Boyaca', 'Boyaca, Tunja', 'azul', 'verde'),
('10', 'Cucuta', 'Cucuta', 'rojo', 'negro'),
('11', 'Pasto', 'Pasto', 'rojo', 'azul'),
('12', 'Tolima', 'Tolima', 'vinotinto', 'blanco'),
('13', 'Junior', 'Barranquilla', 'rojoblanco', 'azul'),
('14', 'Millos', 'Bogota', 'azul', 'blanco'),
('15', 'OnceCaldas', 'Manizales', 'rojo', 'verde'),
('16', 'Pereira', 'Pereira', 'rojo', 'amarillo'),
('17', 'Aguilas', 'Rionegro', 'amarillo', 'rojo'),
('18', 'Alianza pe', 'Barrancabermeja', 'amarillo', 'negro'),
('19', 'Patriotas', 'Boyaca', 'rojo', 'blanco'),
('2', 'Medellin', 'Medellin', 'rojo', 'azul'),
('20', 'Jaguares', 'Monteria', 'azul', 'verde'),
('3', 'America', 'Cali', 'rojo', 'blanco'),
('4', 'Santa fe', 'Bogota', 'rojo', 'blanco'),
('5', 'Equidad', 'Bogota', 'verde', 'gris'),
('6', 'Envigado', 'Envigado', 'naranja', 'verde'),
('7', 'Cali', 'Cali', 'verde', 'blanco'),
('8', 'Nacional', 'Medellin', 'verde', 'blanco'),
('9', 'Bmanga', 'Bucaramanga', 'amarillo', 'verde');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estadio`
--

DROP TABLE IF EXISTS `estadio`;
CREATE TABLE IF NOT EXISTS `estadio` (
  `codestadio` varchar(5) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `ubicacion` varchar(15) NOT NULL,
  PRIMARY KEY (`codestadio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jugador`
--

DROP TABLE IF EXISTS `jugador`;
CREATE TABLE IF NOT EXISTS `jugador` (
  `documento` varchar(5) NOT NULL,
  `numero` varchar(2) NOT NULL,
  `codequipo` varchar(5) NOT NULL,
  `codjugador` varchar(5) NOT NULL,
  PRIMARY KEY (`codequipo`,`codjugador`),
  KEY `fk_jugador_persona` (`documento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `partido`
--

DROP TABLE IF EXISTS `partido`;
CREATE TABLE IF NOT EXISTS `partido` (
  `codpartido` varchar(5) NOT NULL,
  `codtorneo` varchar(5) NOT NULL,
  `codronda` varchar(5) NOT NULL,
  `fecha` varchar(10) NOT NULL,
  `codestadio` varchar(5) NOT NULL,
  PRIMARY KEY (`codpartido`,`codtorneo`,`codronda`),
  KEY `codtorneo` (`codtorneo`),
  KEY `codpartido` (`codpartido`,`codronda`),
  KEY `codronda` (`codronda`),
  KEY `fk_parptido_estadio` (`codestadio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

DROP TABLE IF EXISTS `persona`;
CREATE TABLE IF NOT EXISTS `persona` (
  `documento` varchar(5) NOT NULL,
  `nombre` varchar(10) NOT NULL,
  `fechanac` varchar(10) NOT NULL,
  `ciudad` varchar(15) NOT NULL,
  PRIMARY KEY (`documento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `torneo`
--

DROP TABLE IF EXISTS `torneo`;
CREATE TABLE IF NOT EXISTS `torneo` (
  `codtorneo` varchar(5) NOT NULL,
  `fechainicio` varchar(10) NOT NULL,
  `fechafin` varchar(10) NOT NULL,
  `nombre` varchar(10) NOT NULL,
  PRIMARY KEY (`codtorneo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `torneopartidoeq`
--

DROP TABLE IF EXISTS `torneopartidoeq`;
CREATE TABLE IF NOT EXISTS `torneopartidoeq` (
  `codtorneo` varchar(5) NOT NULL,
  `codequipo` varchar(5) NOT NULL,
  `codronda` varchar(5) NOT NULL,
  `codpartido` varchar(5) NOT NULL,
  PRIMARY KEY (`codtorneo`,`codequipo`,`codronda`,`codpartido`),
  KEY `fk_torneopartidoeq_equipo` (`codequipo`),
  KEY `codpartido` (`codpartido`),
  KEY `codronda` (`codronda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `dt`
--
ALTER TABLE `dt`
  ADD CONSTRAINT `fk_dt_persona` FOREIGN KEY (`documento`) REFERENCES `persona` (`documento`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Filtros para la tabla `dtequipo`
--
ALTER TABLE `dtequipo`
  ADD CONSTRAINT `fk_dtequipo_dt` FOREIGN KEY (`docdt`) REFERENCES `dt` (`documento`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_dtequipo_equipo` FOREIGN KEY (`codequipo`) REFERENCES `equipo` (`codequipo`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Filtros para la tabla `eqtorneo`
--
ALTER TABLE `eqtorneo`
  ADD CONSTRAINT `fk_eqtorneo_equipo` FOREIGN KEY (`codequipo`) REFERENCES `equipo` (`codequipo`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_eqtorneo_torneo` FOREIGN KEY (`codtorneo`) REFERENCES `torneo` (`codtorneo`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_eqtorneo_torneopartidoeq_equipo` FOREIGN KEY (`codequipo`) REFERENCES `torneopartidoeq` (`codequipo`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_eqtorneo_torneopartidoeq_torneo_` FOREIGN KEY (`codtorneo`) REFERENCES `torneopartidoeq` (`codtorneo`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Filtros para la tabla `jugador`
--
ALTER TABLE `jugador`
  ADD CONSTRAINT `fk_jugador_equipo` FOREIGN KEY (`codequipo`) REFERENCES `equipo` (`codequipo`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_jugador_persona` FOREIGN KEY (`documento`) REFERENCES `persona` (`documento`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Filtros para la tabla `partido`
--
ALTER TABLE `partido`
  ADD CONSTRAINT `fk_parptido_estadio` FOREIGN KEY (`codestadio`) REFERENCES `estadio` (`codestadio`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Filtros para la tabla `torneopartidoeq`
--
ALTER TABLE `torneopartidoeq`
  ADD CONSTRAINT `torneopartidoeq_ibfk_1` FOREIGN KEY (`codpartido`) REFERENCES `partido` (`codpartido`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `torneopartidoeq_ibfk_2` FOREIGN KEY (`codtorneo`) REFERENCES `partido` (`codtorneo`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `torneopartidoeq_ibfk_3` FOREIGN KEY (`codronda`) REFERENCES `partido` (`codronda`) ON DELETE RESTRICT ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
