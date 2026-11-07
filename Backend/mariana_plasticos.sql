-- MySQL dump 10.13  Distrib 26.7.0, for Win64 (x86_64)
--
-- Host: localhost    Database: mariana_plasticos
-- ------------------------------------------------------
-- Server version	26.7.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '86ddbdec-c382-11f1-8fe9-0cc11915f699:1-211';

--
-- Current Database: `mariana_plasticos`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `mariana_plasticos` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `mariana_plasticos`;

--
-- Table structure for table `asistente_ia`
--

DROP TABLE IF EXISTS `asistente_ia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asistente_ia` (
  `id_asistente` int unsigned NOT NULL AUTO_INCREMENT,
  `id_servicio` int unsigned DEFAULT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `modelo_ia` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `endpoint_api` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_asistente`),
  KEY `fk_asistente_servicio` (`id_servicio`),
  CONSTRAINT `fk_asistente_servicio` FOREIGN KEY (`id_servicio`) REFERENCES `servicio_externo` (`id_servicio`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asistente_ia`
--

LOCK TABLES `asistente_ia` WRITE;
/*!40000 ALTER TABLE `asistente_ia` DISABLE KEYS */;
INSERT INTO `asistente_ia` VALUES (1,2,'Asistente de prueba para responder preguntas frecuentes','modelo-demo',1,'https://api.ejemplo.com/ia/asistente'),(2,1,'Asistente de prueba para consultar el estado de envíos','modelo-demo',0,'https://api.ejemplo.com/ia/envios');
/*!40000 ALTER TABLE `asistente_ia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `id_categoria` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_categoria`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'Envases','Envases y recipientes de plástico'),(2,'Bolsas','Bolsas de plástico de distintos tamaños'),(3,'Desechables','Productos desechables de plástico'),(4,'Accesorios','Accesorios y complementos para productos desechables');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `id_cliente` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `negocio` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correo` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefono` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `categoria` int DEFAULT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `correo` (`correo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'Carmelo Lopez Ortiz','Comercial La Central','carmelo.lopez.ortiz@gmail.com','7221234567','Toluca, Estado de México',1),(2,'Paola de Jesus Mendez','Papelería El Sol','paola.dejesus.mendez@gmail.com','7229876543','Metepec, Estado de México',2),(3,'Doricela del Valle Morales','Distribuidora del Valle','doricela.delvalle.morales@gmail.com','7295551234','Lerma, Estado de México',1),(4,'venta de la tienda','Mariana plasticos','MarianaPlasticos@gmail.com','5534367891','la cuarta, Estado de Mexico',2);
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalles_movimiento`
--

DROP TABLE IF EXISTS `detalles_movimiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalles_movimiento` (
  `id_detalle` int unsigned NOT NULL AUTO_INCREMENT,
  `id_movimiento` int unsigned NOT NULL,
  `id_producto` int unsigned NOT NULL,
  `cantidad` int unsigned NOT NULL,
  `precio_unitario` decimal(12,2) NOT NULL DEFAULT '0.00',
  `subtotal` decimal(14,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id_detalle`),
  KEY `fk_detmov_movimiento` (`id_movimiento`),
  KEY `fk_detmov_producto` (`id_producto`),
  CONSTRAINT `fk_detmov_movimiento` FOREIGN KEY (`id_movimiento`) REFERENCES `movimientos` (`id_movimiento`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_detmov_producto` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `chk_det_mov_cantidad` CHECK ((`cantidad` > 0)),
  CONSTRAINT `chk_det_mov_precio` CHECK ((`precio_unitario` >= 0)),
  CONSTRAINT `chk_det_mov_subtotal` CHECK ((`subtotal` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalles_movimiento`
--

LOCK TABLES `detalles_movimiento` WRITE;
/*!40000 ALTER TABLE `detalles_movimiento` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalles_movimiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalles_pedido`
--

DROP TABLE IF EXISTS `detalles_pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalles_pedido` (
  `id_detalles_pedido` int unsigned NOT NULL AUTO_INCREMENT,
  `id_pedido` int unsigned NOT NULL,
  `id_producto` int unsigned NOT NULL,
  `cantidad` int unsigned NOT NULL,
  `precio_unitario` decimal(10,2) DEFAULT NULL,
  `subtotal` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_detalles_pedido`),
  KEY `fk_detpedido_pedido` (`id_pedido`),
  KEY `fk_detpedido_producto` (`id_producto`),
  CONSTRAINT `fk_detpedido_pedido` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id_pedido`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_detpedido_producto` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `chk_det_pedido_cantidad` CHECK ((`cantidad` > 0)),
  CONSTRAINT `chk_det_pedido_precio` CHECK ((`precio_unitario` >= 0)),
  CONSTRAINT `chk_det_pedido_subtotal` CHECK ((`subtotal` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalles_pedido`
--

LOCK TABLES `detalles_pedido` WRITE;
/*!40000 ALTER TABLE `detalles_pedido` DISABLE KEYS */;
INSERT INTO `detalles_pedido` VALUES (11,12,18,8,4.20,33.60),(12,12,28,8,4.80,38.40);
/*!40000 ALTER TABLE `detalles_pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `envios`
--

DROP TABLE IF EXISTS `envios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `envios` (
  `id_envio` int unsigned NOT NULL AUTO_INCREMENT,
  `id_pedido` int unsigned NOT NULL,
  `numero_guia` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado_envio` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Pendiente',
  `fecha_entrega` date DEFAULT NULL,
  `rastreo_url` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_envio`),
  UNIQUE KEY `id_pedido` (`id_pedido`),
  CONSTRAINT `fk_envios_pedido` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id_pedido`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `envios`
--

LOCK TABLES `envios` WRITE;
/*!40000 ALTER TABLE `envios` DISABLE KEYS */;
/*!40000 ALTER TABLE `envios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventario`
--

DROP TABLE IF EXISTS `inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventario` (
  `id_inventario` int unsigned NOT NULL AUTO_INCREMENT,
  `id_producto` int unsigned NOT NULL,
  `cantidad_actual` int NOT NULL DEFAULT '0',
  `ubicacion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_inventario`),
  UNIQUE KEY `id_producto` (`id_producto`),
  CONSTRAINT `fk_inventario_producto` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `chk_inventario_cantidad` CHECK ((`cantidad_actual` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario`
--

LOCK TABLES `inventario` WRITE;
/*!40000 ALTER TABLE `inventario` DISABLE KEYS */;
INSERT INTO `inventario` VALUES (14,17,100,'Almacén General'),(15,18,42,'Almacén General'),(16,19,40,'Almacén General'),(17,20,30,'Almacén General'),(18,21,20,'Almacén General'),(19,22,120,'Almacén General'),(20,23,120,'Almacén General'),(21,24,100,'Almacén General'),(22,25,50,'Almacén General'),(23,26,40,'Almacén General'),(24,27,10,'Almacén General'),(25,28,92,'Almacén General'),(26,29,100,'Almacén General'),(27,30,60,'Almacén General'),(28,31,1,'Almacén General'),(29,32,1,'Almacén General'),(30,33,200,'Almacén General'),(31,34,40,'Almacén General'),(32,35,200,'Almacén General'),(33,36,24,'Almacén General'),(34,37,16,'Almacén General'),(35,38,90,'Almacén General'),(36,39,100,'Almacén General'),(37,40,100,'Almacén General'),(38,41,100,'Almacén General'),(39,42,100,'Almacén General'),(40,43,100,'Almacén General'),(41,44,20,'Almacén General'),(42,45,10,'Almacén General'),(43,46,10,'Almacén General'),(44,47,100,'Almacén General'),(45,48,100,'Almacén General'),(46,49,100,'Almacén General'),(47,50,100,'Almacén General'),(48,51,100,'Almacén General'),(49,52,50,'Almacén General'),(50,53,100,'Almacén General'),(51,54,100,'Almacén General'),(52,55,50,'Almacén General'),(53,56,50,'Almacén General'),(54,57,50,'Almacén General'),(55,58,50,'Almacén General'),(56,59,50,'Almacén General'),(57,60,25,'Almacén General'),(58,61,25,'Almacén General'),(59,62,50,'Almacén General'),(60,63,50,'Almacén General'),(61,64,50,'Almacén General'),(62,65,25,'Almacén General'),(63,66,25,'Almacén General'),(64,67,50,'Almacén General'),(65,68,50,'Almacén General'),(66,69,25,'Almacén General'),(67,70,20,'Almacén General'),(68,71,50,'Almacén General'),(69,72,1,'Almacén General'),(70,73,10,'Almacén General'),(71,74,100,'Almacén General'),(72,75,50,'Almacén General'),(73,76,40,'Almacén General'),(74,77,100,'Almacén General'),(75,78,100,'Almacén General'),(76,79,100,'Almacén General'),(77,80,50,'Almacén General'),(78,81,100,'Almacén General'),(79,82,100,'Almacén General'),(80,83,100,'Almacén General'),(81,84,500,'Almacén General'),(82,85,100,'Almacén General'),(83,86,1,'Almacén General');
/*!40000 ALTER TABLE `inventario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movimientos`
--

DROP TABLE IF EXISTS `movimientos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movimientos` (
  `id_movimiento` int unsigned NOT NULL AUTO_INCREMENT,
  `id_usuario` int unsigned NOT NULL,
  `tipo_movimiento` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_movimiento` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `observaciones` text COLLATE utf8mb4_unicode_ci,
  `id_producto` int DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  PRIMARY KEY (`id_movimiento`),
  KEY `fk_movimientos_usuario` (`id_usuario`),
  KEY `idx_movimientos_fecha` (`fecha_movimiento`),
  CONSTRAINT `fk_movimientos_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movimientos`
--

LOCK TABLES `movimientos` WRITE;
/*!40000 ALTER TABLE `movimientos` DISABLE KEYS */;
/*!40000 ALTER TABLE `movimientos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `id_pedido` int unsigned NOT NULL AUTO_INCREMENT,
  `id_cliente` int unsigned NOT NULL,
  `fecha_pedido` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `observaciones` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id_pedido`),
  KEY `fk_pedidos_cliente` (`id_cliente`),
  KEY `idx_pedidos_fecha` (`fecha_pedido`),
  KEY `idx_pedidos_estado` (`estado`),
  CONSTRAINT `fk_pedidos_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `chk_pedidos_total` CHECK ((`total` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (12,4,'2026-11-01 21:45:14','Entregado',72.00,'compra');
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `id_producto` int unsigned NOT NULL AUTO_INCREMENT,
  `id_categoria` int unsigned NOT NULL,
  `sku` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `marca` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `precio_unitario` decimal(10,2) DEFAULT NULL,
  `precio_mayoreo` decimal(10,2) DEFAULT NULL,
  `stock_minimo` int unsigned NOT NULL DEFAULT '0',
  `stock_actual` int NOT NULL DEFAULT '0',
  `estado` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Activo',
  `url_imagen` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_producto`),
  UNIQUE KEY `sku` (`sku`),
  KEY `fk_productos_categoria` (`id_categoria`),
  KEY `idx_productos_nombre` (`nombre`),
  CONSTRAINT `fk_productos_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `chk_productos_precio` CHECK ((`precio_unitario` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (17,1,'GEM-ENV-001','Botella PET 500 ml transparente','Géminis','Grado alimenticio, tapa incluida',2.80,2.52,10,100,'Activo',NULL),(18,1,'GEM-ENV-002','Botella PET 1 litro transparente','Géminis','Cuello estándar, ideal jugos y agua',4.20,3.78,10,42,'Activo',NULL),(19,1,'GEM-ENV-003','Botella PET 1.5 litros','Géminis','Alta resistencia',5.50,4.95,10,40,'Activo',NULL),(20,1,'GEM-ENV-004','Botella PET 2 litros','Géminis','Formato familiar',6.80,6.12,10,30,'Activo',NULL),(21,1,'GEM-ENV-005','Botella PET 3 litros','Géminis','Retornable / mayor calibre',9.50,8.55,10,20,'Activo',NULL),(22,1,'GEM-ENV-006','Botella PET 350 ml (mini)','Géminis','Porción individual',2.20,1.98,10,120,'Activo',NULL),(23,1,'GEM-ENV-007','Envase con tapa 250 ml (deli)','Géminis','Redondo PP, microondas',2.40,2.16,10,120,'Activo',NULL),(24,1,'GEM-ENV-008','Envase con tapa 500 ml (deli)','Géminis','Redondo PP, hermético',3.60,3.24,10,100,'Activo',NULL),(25,1,'GEM-ENV-009','Envase con tapa 750 ml','Géminis','Rectangular, tapa segura',5.20,4.68,10,50,'Activo',NULL),(26,1,'GEM-ENV-010','Envase con tapa 1 litro','Géminis','Ideal ensaladas y guisados',6.50,5.85,10,40,'Activo',NULL),(27,1,'GEM-ENV-011','Envase almeja PET 500 ml','Géminis','Bisagra, transparente',3.40,3.06,10,10,'Activo',NULL),(28,1,'GEM-ENV-012','Envase almeja PET 750 ml','Géminis','Para comida para llevar',4.80,4.32,10,92,'Activo',NULL),(29,1,'GEM-ENV-013','Tarro PET 250 ml con tapa','Géminis','Rosca, salsas y cremas',2.90,2.61,10,100,'Activo',NULL),(30,1,'GEM-ENV-014','Tarro PET 500 ml con tapa','Géminis','Uso alimenticio / cosmético',4.30,3.87,10,60,'Activo',NULL),(31,1,'GEM-ENV-015','Garrafón PET 5 litros','Géminis','Con asa, grado alimenticio',16.50,14.85,10,1,'Activo',NULL),(32,1,'GEM-ENV-016','Garrafón PET 20 litros','Géminis','Retornable estándar',42.00,37.80,10,1,'Activo',NULL),(33,1,'GEM-ENV-017','Envase rectangular 250 ml','Géminis','Porciones individuales',2.50,2.25,10,200,'Activo',NULL),(34,1,'GEM-ENV-018','Envase cuadrado 1 litro con tapa','Géminis','Apilable',6.20,5.58,10,40,'Activo',NULL),(35,1,'GEM-ENV-019','Frasco PET 100 ml con tapa','Géminis','Muestras y porciones',1.70,1.53,10,200,'Activo',NULL),(36,1,'GEM-ENV-020','Envase redondo 2 litros con tapa','Géminis','Gran capacidad',9.80,8.82,10,24,'Activo',NULL),(37,1,'GEM-ENV-021','Botella PET 4 litros','Géminis','Botellón',11.50,10.35,10,16,'Activo',NULL),(38,1,'GEM-ENV-022','Envase con tapa 350 ml (deli)','Géminis','Tamaño intermedio',3.10,2.79,10,90,'Activo',NULL),(39,2,'GEM-BOL-001','Bolsa camiseta chica 30x40 cm','Géminis','Alta densidad, natural',0.32,0.29,10,100,'Activo',NULL),(40,2,'GEM-BOL-002','Bolsa camiseta mediana 40x50 cm','Géminis','Alta densidad, natural',0.48,0.43,10,100,'Activo',NULL),(41,2,'GEM-BOL-003','Bolsa camiseta grande 50x60 cm','Géminis','Alta densidad, natural',0.75,0.68,10,100,'Activo',NULL),(42,2,'GEM-BOL-004','Bolsa camiseta reforzada mediana','Géminis','Mayor calibre',0.65,0.59,10,100,'Activo',NULL),(43,2,'GEM-BOL-005','Bolsa camiseta negra mediana','Géminis','Color negro',0.52,0.47,10,100,'Activo',NULL),(44,2,'GEM-BOL-006','Bolsa de basura 50x70 cm (paq. 20)','Géminis','Negra, calibre medio',14.50,13.05,10,20,'Activo',NULL),(45,2,'GEM-BOL-007','Bolsa de basura 60x90 cm (paq. 10)','Géminis','Negra, uso general',12.80,11.52,10,10,'Activo',NULL),(46,2,'GEM-BOL-008','Bolsa de basura 90x120 cm (paq. 10)','Géminis','Industrial, calibre alto',21.50,19.35,10,10,'Activo',NULL),(47,2,'GEM-BOL-009','Bolsa ziploc chica (caja 100)','Géminis','Cierre hermético',19.50,17.55,10,100,'Activo',NULL),(48,2,'GEM-BOL-010','Bolsa ziploc mediana (caja 100)','Géminis','Cierre hermético',28.00,25.20,10,100,'Activo',NULL),(49,2,'GEM-BOL-011','Bolsa ziploc grande (caja 100)','EcoDesechables','Cierre hermético',38.00,34.20,10,100,'Activo',NULL),(50,2,'GEM-BOL-012','Bolsa biodegradable camiseta mediana','EcoDesechables','Oxo-biodegradable',1.35,1.22,10,100,'Activo',NULL),(51,2,'GEM-BOL-013','Bolsa biodegradable camiseta grande','Géminis','Compostable',2.10,1.89,10,100,'Activo',NULL),(52,2,'GEM-BOL-014','Bolsa para hielo 5 kg','Géminis','Gruesa con asa',1.70,1.53,10,50,'Activo',NULL),(53,2,'GEM-BOL-015','Bolsa plana 40x50 cm (rollo 100)','Géminis','Sin asa, baja densidad',34.00,30.60,10,100,'Activo',NULL),(54,2,'GEM-BOL-016','Bolsa plana 50x70 cm (rollo 100)','Géminis','Sin asa, baja densidad',48.00,43.20,10,100,'Activo',NULL),(55,2,'GEM-BOL-017','Bolsa tipo boutique / riñón','Géminis','Asa reforzada para retail',3.20,2.88,10,50,'Activo',NULL),(56,2,'GEM-BOL-018','Bolsa de seguridad con sello','Géminis','Para valores y documentos',3.80,3.42,10,50,'Activo',NULL),(57,3,'GEM-DES-001','Vaso plástico 250 ml transparente','Géminis','PP transparente',1.05,0.95,10,50,'Activo',NULL),(58,3,'GEM-DES-002','Vaso plástico 350 ml transparente','Géminis','PP transparente',1.35,1.22,10,50,'Activo',NULL),(59,3,'GEM-DES-003','Vaso plástico 500 ml transparente','Géminis','PP transparente',1.75,1.57,10,50,'Activo',NULL),(60,3,'GEM-DES-004','Vaso térmico unicel 8 oz','REYMA','Blanco, bebidas calientes',1.10,0.99,10,25,'Activo',NULL),(61,3,'GEM-DES-005','Vaso térmico unicel 12 oz','REYMA','Blanco, tamaño grande',1.40,1.26,10,25,'Activo',NULL),(62,3,'GEM-DES-006','Vaso PET 12 oz + tapa','Géminis','Transparente premium',2.80,2.52,10,50,'Activo',NULL),(63,3,'GEM-DES-007','Plato plástico 15 cm','Géminis','Redondo blanco',0.95,0.85,10,50,'Activo',NULL),(64,3,'GEM-DES-008','Plato plástico 20 cm','Géminis','Redondo blanco',1.35,1.22,10,50,'Activo',NULL),(65,3,'GEM-DES-009','Plato dividido 3 secciones','Géminis','Menú combinado',2.40,2.16,10,25,'Activo',NULL),(66,3,'GEM-DES-010','Plato hondo unicel 12 oz','REYMA','Para sopas',1.55,1.40,10,25,'Activo',NULL),(67,3,'GEM-DES-011','Charola unicel mediana','REYMA','Blanca estándar',1.40,1.26,10,50,'Activo',NULL),(68,3,'GEM-DES-012','Charola unicel 1/4','REYMA','Catering / eventos',1.90,1.71,10,50,'Activo',NULL),(69,3,'GEM-DES-013','Envase unicel 500 ml con tapa','REYMA','Comidas calientes',2.80,2.52,10,25,'Activo',NULL),(70,3,'GEM-DES-014','Envase unicel 1 litro con tapa','REYMA','Sopas y guisados',4.20,3.78,10,20,'Activo',NULL),(71,3,'GEM-DES-015','Contenedor alimentos 750 ml','Géminis','Con tapa, microondas',3.50,3.15,10,50,'Activo',NULL),(72,3,'GEM-DES-016','Domo para pastel PET 30 cm','Géminis','Transparente con base',11.50,10.35,10,1,'Activo',NULL),(73,3,'GEM-DES-017','Charola aluminio + tapa (mediana)','Géminis','Para hornear y llevar',4.80,4.32,10,10,'Activo',NULL),(74,3,'GEM-DES-018','Vaso shot 50 ml','Payasifiestas','Degustaciones y eventos',0.45,0.41,10,100,'Activo',NULL),(75,3,'GEM-DES-019','Tapa para vaso 500 ml','Géminis','Plana o con orificio',0.65,0.59,10,50,'Activo',NULL),(76,3,'GEM-DES-020','Contenedor cuadrado 1 L con tapa','Géminis','Apilable, uso intensivo',4.80,4.32,10,40,'Activo',NULL),(77,4,'GEM-ACC-001','Cuchara plástica grande (paq. 100)','Géminis','PP blanca',13.50,12.15,10,100,'Activo',NULL),(78,4,'GEM-ACC-002','Tenedor plástico (paq. 100)','Géminis','PP blanca',13.50,12.15,10,100,'Activo',NULL),(79,4,'GEM-ACC-003','Cuchillo plástico (paq. 100)','Géminis','PP con filo',13.50,12.15,10,100,'Activo',NULL),(80,4,'GEM-ACC-004','Set cubiertos 3 piezas (x50 sets)','Géminis','Cuchara + tenedor + cuchillo',24.00,21.60,10,50,'Activo',NULL),(81,4,'GEM-ACC-005','Popote plástico recto (paq. 100)','Géminis','Colores surtidos',10.50,9.45,10,100,'Activo',NULL),(82,4,'GEM-ACC-006','Popote biodegradable (paq. 100)','EcoDesechables','Papel / PLA',19.00,17.10,10,100,'Activo',NULL),(83,4,'GEM-ACC-007','Servilletas de papel (paq. 100)','Géminis','Blancas estándar',15.50,13.95,10,100,'Activo',NULL),(84,4,'GEM-ACC-008','Palillos de madera (caja 500)','Géminis','Envueltos individual',28.00,25.20,10,500,'Activo',NULL),(85,4,'GEM-ACC-009','Guantes de plástico (caja 100)','Géminis','Polietileno, talla única',38.00,34.20,10,100,'Activo',NULL),(86,4,'GEM-ACC-010','Film stretch 45 cm x 300 m','Géminis','Película estirable',85.00,76.50,10,1,'Activo',NULL);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id_rol` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre_rol` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_rol`),
  UNIQUE KEY `nombre_rol` (`nombre_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Administrador','Acceso completo al sistema'),(2,'Gerente','Registro de productos y movimientos'),(3,'Subgerente','Gestión de clientes y pedidos');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servicio_externo`
--

DROP TABLE IF EXISTS `servicio_externo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servicio_externo` (
  `id_servicio` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre_servicio` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `url_api` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Activo',
  PRIMARY KEY (`id_servicio`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicio_externo`
--

LOCK TABLES `servicio_externo` WRITE;
/*!40000 ALTER TABLE `servicio_externo` DISABLE KEYS */;
INSERT INTO `servicio_externo` VALUES (1,'Servicio de rastreo','Servicio ficticio para probar el seguimiento de envíos','https://api.ejemplo.com/rastreo','Activo'),(2,'Servicio de notificaciones','Servicio ficticio para notificaciones del sistema','https://api.ejemplo.com/notificaciones','Activo');
/*!40000 ALTER TABLE `servicio_externo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` int unsigned NOT NULL AUTO_INCREMENT,
  `id_rol` int unsigned NOT NULL,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `correo` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contrasena` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Activo',
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `correo` (`correo`),
  KEY `fk_usuarios_roles` (`id_rol`),
  CONSTRAINT `fk_usuarios_roles` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,1,'Oswaldo Ortega','Oswaldo.admin@gmail.com','Oswaldo1234','Activo'),(2,2,'Humberto Juarez','humberto.gerente@gmail.com','HumbertoG123','Activo'),(3,3,'Armando Hernandez','Armando.ventasAlmacen@gmail.com','Armando234','Activo');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-03 22:02:10
