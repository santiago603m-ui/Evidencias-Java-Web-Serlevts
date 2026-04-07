CREATE DATABASE  IF NOT EXISTS `biblioteca_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `biblioteca_db`;
-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: biblioteca_db
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `libros`
--

DROP TABLE IF EXISTS `libros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `libros` (
  `id_libro` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(200) NOT NULL,
  `autor` varchar(100) NOT NULL,
  `disponibles` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_libro`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `libros`
--

LOCK TABLES `libros` WRITE;
/*!40000 ALTER TABLE `libros` DISABLE KEYS */;
INSERT INTO `libros` VALUES (1,'Cien Años de Soledad','Gabriel Garcia Marquez',4),(2,'Don Quijote de la Mancha','Miguel de Cervantes',3),(3,'La Odisea','Homero',4),(4,'El Principito','Antoine de Saint-Exupery',6),(5,'1984','George Orwell',2),(6,'Fahrenheit 451','Ray Bradbury',3),(7,'Crimen y Castigo','Fiodor Dostoyevski',2),(8,'Orgullo y Prejuicio','Jane Austen',4),(9,'Moby Dick','Herman Melville',3),(10,'Hamlet','William Shakespeare',5),(11,'El Alquimista','Paulo Coelho',7),(12,'La Divina Comedia','Dante Alighieri',2),(13,'El Hobbit','J.R.R. Tolkien',6),(14,'Harry Potter 1','J.K. Rowling',8),(15,'Los Juegos del Hambre','Suzanne Collins',5),(16,'El Codigo Da Vinci','Dan Brown',4),(17,'La Sombra del Viento','Carlos Ruiz Zafon',3),(18,'Dracula','Bram Stoker',2),(19,'It','Stephen King',3),(20,'El Resplandor','Stephen King',4);
/*!40000 ALTER TABLE `libros` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prestamos`
--

DROP TABLE IF EXISTS `prestamos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prestamos` (
  `id_prestamo` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_libro` int NOT NULL,
  `fecha_prestamo` date NOT NULL,
  `fecha_devolucion` date DEFAULT NULL,
  `estado` enum('ACTIVO','DEVUELTO') DEFAULT 'ACTIVO',
  PRIMARY KEY (`id_prestamo`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_libro` (`id_libro`),
  CONSTRAINT `prestamos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  CONSTRAINT `prestamos_ibfk_2` FOREIGN KEY (`id_libro`) REFERENCES `libros` (`id_libro`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prestamos`
--

LOCK TABLES `prestamos` WRITE;
/*!40000 ALTER TABLE `prestamos` DISABLE KEYS */;
INSERT INTO `prestamos` VALUES (1,3,1,'2026-03-01',NULL,'ACTIVO'),(2,4,2,'2026-03-02','2026-03-10','DEVUELTO'),(3,5,3,'2026-03-03',NULL,'ACTIVO'),(4,6,4,'2026-03-04','2026-03-12','DEVUELTO'),(5,7,5,'2026-03-05',NULL,'ACTIVO'),(6,8,6,'2026-03-06',NULL,'ACTIVO'),(7,9,7,'2026-03-07','2026-03-15','DEVUELTO'),(8,10,8,'2026-03-08',NULL,'ACTIVO'),(9,11,9,'2026-03-09',NULL,'ACTIVO'),(10,12,10,'2026-03-10','2026-03-18','DEVUELTO'),(11,13,11,'2026-03-11',NULL,'ACTIVO'),(12,14,12,'2026-03-12',NULL,'ACTIVO'),(13,15,13,'2026-03-13','2026-03-20','DEVUELTO'),(14,16,14,'2026-03-14',NULL,'ACTIVO'),(15,17,15,'2026-03-15',NULL,'ACTIVO'),(16,18,16,'2026-03-16','2026-03-22','DEVUELTO'),(17,19,17,'2026-03-17',NULL,'ACTIVO'),(18,20,18,'2026-03-18',NULL,'ACTIVO'),(19,3,19,'2026-03-19','2026-03-25','DEVUELTO'),(20,4,20,'2026-03-20',NULL,'ACTIVO'),(21,19,1,'2026-04-06',NULL,'ACTIVO');
/*!40000 ALTER TABLE `prestamos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `rol` enum('ADMIN','ESTUDIANTE') DEFAULT 'ESTUDIANTE',
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `correo` (`correo`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Admin Principal','admin1@correo.com','123456','ADMIN'),(2,'Admin Secundario','admin2@correo.com','123456','ADMIN'),(3,'Juan Perez','juan1@correo.com','123456','ESTUDIANTE'),(4,'Maria Gomez','maria1@correo.com','123456','ESTUDIANTE'),(5,'Carlos Lopez','carlos1@correo.com','123456','ESTUDIANTE'),(6,'Ana Torres','ana1@correo.com','123456','ESTUDIANTE'),(7,'Luis Ramirez','luis1@correo.com','123456','ESTUDIANTE'),(8,'Sofia Martinez','sofia1@correo.com','123456','ESTUDIANTE'),(9,'Pedro Sanchez','pedro1@correo.com','123456','ESTUDIANTE'),(10,'Laura Diaz','laura1@correo.com','123456','ESTUDIANTE'),(11,'Diego Castro','diego1@correo.com','123456','ESTUDIANTE'),(12,'Valentina Rojas','valen1@correo.com','123456','ESTUDIANTE'),(13,'Andres Ruiz','andres1@correo.com','123456','ESTUDIANTE'),(14,'Camila Vargas','camila1@correo.com','123456','ESTUDIANTE'),(15,'Jorge Herrera','jorge1@correo.com','123456','ESTUDIANTE'),(16,'Paula Medina','paula1@correo.com','123456','ESTUDIANTE'),(17,'Ricardo Moreno','ricardo1@correo.com','123456','ESTUDIANTE'),(18,'Daniela Ortiz','daniela1@correo.com','123456','ESTUDIANTE'),(19,'Fernando Silva','fernando1@correo.com','123456','ESTUDIANTE'),(20,'Natalia Reyes','natalia1@correo.com','123456','ESTUDIANTE');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-06  0:33:17
