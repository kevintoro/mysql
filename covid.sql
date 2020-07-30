-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3308
-- Tiempo de generación: 17-04-2020 a las 19:54:13
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
-- Base de datos: `covid`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asign_familiar_paciente`
--

DROP TABLE IF EXISTS `asign_familiar_paciente`;
CREATE TABLE IF NOT EXISTS `asign_familiar_paciente` (
  `id_asignacion` int(11) NOT NULL AUTO_INCREMENT,
  `fecha_asignacion` date NOT NULL,
  PRIMARY KEY (`id_asignacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clinica`
--

DROP TABLE IF EXISTS `clinica`;
CREATE TABLE IF NOT EXISTS `clinica` (
  `id_clinica` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_clinica` varchar(80) NOT NULL,
  `direccion` varchar(100) NOT NULL,
  PRIMARY KEY (`id_clinica`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especialidad`
--

DROP TABLE IF EXISTS `especialidad`;
CREATE TABLE IF NOT EXISTS `especialidad` (
  `id_especialidad` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_especialidad` varchar(50) NOT NULL,
  PRIMARY KEY (`id_especialidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_paciente`
--

DROP TABLE IF EXISTS `estado_paciente`;
CREATE TABLE IF NOT EXISTS `estado_paciente` (
  `id_estado` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_estado` varchar(20) NOT NULL,
  PRIMARY KEY (`id_estado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `familiar_paciente`
--

DROP TABLE IF EXISTS `familiar_paciente`;
CREATE TABLE IF NOT EXISTS `familiar_paciente` (
  `id_asignacion` int(11) NOT NULL,
  `documento` varchar(15) NOT NULL,
  PRIMARY KEY (`documento`),
  KEY `fk_familiar_paciente` (`id_asignacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paciente`
--

DROP TABLE IF EXISTS `paciente`;
CREATE TABLE IF NOT EXISTS `paciente` (
  `id_paciente` int(11) NOT NULL AUTO_INCREMENT,
  `documento` varchar(15) NOT NULL,
  `lugar_procedencia` int(80) DEFAULT NULL,
  `id_estado` int(11) NOT NULL,
  `tipo_tratamiento` int(11) NOT NULL,
  `id_clinica` int(11) NOT NULL,
  `id_asignacion` int(11) NOT NULL,
  `id_riesgo` int(11) NOT NULL,
  PRIMARY KEY (`id_paciente`,`documento`),
  KEY `fk_paciente_persona` (`documento`),
  KEY `fk_asigna_persona_familiar` (`id_asignacion`),
  KEY `fk_paciente_estado` (`id_estado`),
  KEY `fk_paciente_tratamiento` (`tipo_tratamiento`),
  KEY `fk_paciente_clinica` (`id_clinica`),
  KEY `fk_paciente_riesgo` (`id_riesgo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

DROP TABLE IF EXISTS `persona`;
CREATE TABLE IF NOT EXISTS `persona` (
  `documento` varchar(15) NOT NULL,
  `nombre` varchar(80) NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `genero` char(1) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  PRIMARY KEY (`documento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_medico`
--

DROP TABLE IF EXISTS `personal_medico`;
CREATE TABLE IF NOT EXISTS `personal_medico` (
  `id_personal` int(11) NOT NULL AUTO_INCREMENT,
  `documento` varchar(15) NOT NULL,
  `id_clinica` int(11) NOT NULL,
  `id_especialidad` int(11) NOT NULL,
  `ultima_prueba` date NOT NULL,
  PRIMARY KEY (`id_personal`,`documento`),
  KEY `fk_medico_persona` (`documento`),
  KEY `fk_medico_especialidad` (`id_especialidad`),
  KEY `fk_medico_clinica` (`id_clinica`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_riesgo`
--

DROP TABLE IF EXISTS `tipo_riesgo`;
CREATE TABLE IF NOT EXISTS `tipo_riesgo` (
  `id_riesgo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_riesgo` varchar(80) NOT NULL,
  PRIMARY KEY (`id_riesgo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_tratamiento`
--

DROP TABLE IF EXISTS `tipo_tratamiento`;
CREATE TABLE IF NOT EXISTS `tipo_tratamiento` (
  `id_tipo_tratamiento` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_tratamiento` varchar(20) NOT NULL,
  PRIMARY KEY (`id_tipo_tratamiento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `familiar_paciente`
--
ALTER TABLE `familiar_paciente`
  ADD CONSTRAINT `fk_familiar_paciente` FOREIGN KEY (`id_asignacion`) REFERENCES `asign_familiar_paciente` (`id_asignacion`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_familiar_persona` FOREIGN KEY (`documento`) REFERENCES `persona` (`documento`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Filtros para la tabla `paciente`
--
ALTER TABLE `paciente`
  ADD CONSTRAINT `fk_asigna_persona_familiar` FOREIGN KEY (`id_asignacion`) REFERENCES `asign_familiar_paciente` (`id_asignacion`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_paciente_clinica` FOREIGN KEY (`id_clinica`) REFERENCES `clinica` (`id_clinica`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_paciente_estado` FOREIGN KEY (`id_estado`) REFERENCES `estado_paciente` (`id_estado`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_paciente_persona` FOREIGN KEY (`documento`) REFERENCES `persona` (`documento`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_paciente_riesgo` FOREIGN KEY (`id_riesgo`) REFERENCES `tipo_riesgo` (`id_riesgo`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_paciente_tratamiento` FOREIGN KEY (`tipo_tratamiento`) REFERENCES `tipo_tratamiento` (`id_tipo_tratamiento`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Filtros para la tabla `personal_medico`
--
ALTER TABLE `personal_medico`
  ADD CONSTRAINT `fk_medico_clinica` FOREIGN KEY (`id_clinica`) REFERENCES `clinica` (`id_clinica`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_medico_especialidad` FOREIGN KEY (`id_especialidad`) REFERENCES `especialidad` (`id_especialidad`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_medico_persona` FOREIGN KEY (`documento`) REFERENCES `persona` (`documento`) ON DELETE RESTRICT ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
