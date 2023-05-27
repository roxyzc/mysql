
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

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `belajar` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `belajar`;
DROP TABLE IF EXISTS `barang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `barang` (
  `id` int NOT NULL,
  `name` varchar(200) NOT NULL,
  `harga` int NOT NULL DEFAULT '0',
  `jumlah` int NOT NULL DEFAULT '0',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `barang` WRITE;
/*!40000 ALTER TABLE `barang` DISABLE KEYS */;
/*!40000 ALTER TABLE `barang` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` varchar(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES ('001','Makanan'),('002','Minuman'),('003','Lain-lain'),('004','Elektronik');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'roxyzc@gmail.com','roxyzc','aja'),(2,'roxyzc1@gmail.com','roxyzc','lagi');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `guestBooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guestBooks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(200) DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `content` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `guestBooks` WRITE;
/*!40000 ALTER TABLE `guestBooks` DISABLE KEYS */;
INSERT INTO `guestBooks` VALUES (1,'guest@gmail.com','Hello','Hello'),(2,'guest1@gmail.com','Hello','Hello'),(3,'guest2@gmail.com','Hello','Hello'),(4,'roxyzc@gmail.com','Hello','Hello'),(5,'roxyzc@gmail.com','Hello','Hello'),(6,'roxyzc@gmail.com','Hello','Hello'),(7,'apage@gmail.com','update oleh user 2','ya'),(8,'apage1@gmail.com','contoh','ya'),(9,'apage@gmail.com','contoh','ya'),(10,'apage@gmail.com','contoh','ya'),(11,'apage1@gmail.com','contoh','ya'),(12,'apage@gmail.com','contoh','ya');
/*!40000 ALTER TABLE `guestBooks` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `total` int NOT NULL,
  `order_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,50000,'2023-05-27 11:31:48'),(2,50000,'2023-05-27 11:35:45');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `orders_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_detail` (
  `id_product` varchar(10) NOT NULL,
  `id_order` int NOT NULL,
  `price` int NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`id_product`,`id_order`),
  KEY `fk_orders_detail_orders` (`id_order`),
  CONSTRAINT `fk_orders_detail_orders` FOREIGN KEY (`id_order`) REFERENCES `orders` (`id`),
  CONSTRAINT `fk_orders_detail_product` FOREIGN KEY (`id_product`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `orders_detail` WRITE;
/*!40000 ALTER TABLE `orders_detail` DISABLE KEYS */;
INSERT INTO `orders_detail` VALUES ('C0BB',1,25000,1),('C0BB',2,25000,1),('C0BC',1,25000,1),('C0BC',2,25000,1);
/*!40000 ALTER TABLE `orders_detail` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` varchar(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  `decription` text,
  `price` int unsigned NOT NULL,
  `quantity` int unsigned NOT NULL DEFAULT '0',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_category` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name_index` (`name`),
  KEY `fk_products_categories` (`id_category`),
  FULLTEXT KEY `product_search` (`name`,`decription`),
  CONSTRAINT `fk_products_categories` FOREIGN KEY (`id_category`) REFERENCES `categories` (`id`),
  CONSTRAINT `price_check` CHECK ((`price` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES ('C0BA','cake',NULL,10000000,1,'2023-05-25 12:47:59',NULL),('C0BB','mie goreng',NULL,1000,1,'2023-05-23 12:00:07','001'),('C0BC','mie rebus',NULL,1000,1,'2023-05-23 12:00:07','001'),('C0BD','bakso',NULL,1000,10,'2023-05-23 12:01:30','001'),('C0BE','mie ayam',NULL,25000,10,'2023-05-23 12:01:30','001'),('C0BF','ayam geprek',NULL,30000,15,'2023-05-23 12:03:15','001'),('C0BG','sate ayam',NULL,10000,23,'2023-05-23 12:03:15','001'),('C0BH','ayam penyet',NULL,1500,7,'2023-05-23 12:03:15','001'),('C0BI','permen',NULL,500,100,'2023-05-23 12:04:50','002'),('C0BJ','cokelat',NULL,18000,17,'2023-05-23 12:04:50','002');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `wallet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wallet` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `balance` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `customer_id_unique` (`customer_id`),
  CONSTRAINT `wallet_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `wallet` WRITE;
/*!40000 ALTER TABLE `wallet` DISABLE KEYS */;
INSERT INTO `wallet` VALUES (1,1,0),(2,2,0);
/*!40000 ALTER TABLE `wallet` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `wishList`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishList` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_product` varchar(10) NOT NULL,
  `description` text,
  `id_customer` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_wishList_product` (`id_product`),
  KEY `fk_wishList_customer` (`id_customer`),
  CONSTRAINT `fk_wishList_customer` FOREIGN KEY (`id_customer`) REFERENCES `customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_wishList_product` FOREIGN KEY (`id_product`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `wishList` WRITE;
/*!40000 ALTER TABLE `wishList` DISABLE KEYS */;
INSERT INTO `wishList` VALUES (1,'C0BH','Makanan kesukaan',2);
/*!40000 ALTER TABLE `wishList` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

