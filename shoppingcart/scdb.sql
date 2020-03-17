CREATE DATABASE  IF NOT EXISTS `scdb` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `scdb`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: scdb
-- ------------------------------------------------------
-- Server version	5.7.29-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart` (
  `user_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_quantity` int(11) NOT NULL,
  UNIQUE KEY `user_id_item_id_UNIQUE` (`user_id`,`item_id`),
  KEY `fk_cart_item_idx` (`item_id`),
  CONSTRAINT `fk_cart_item` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_cart_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (24,1,10),(24,2,1);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_name` varchar(45) NOT NULL,
  `item_price` decimal(10,2) NOT NULL,
  `item_desc` text,
  `product_type_id` int(11) NOT NULL,
  `item_quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  KEY `fk_item_product_type_idx` (`product_type_id`),
  CONSTRAINT `fk_item_product_type` FOREIGN KEY (`product_type_id`) REFERENCES `product_type` (`product_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES (1,'Samsung 50 inch',1000.00,'Sony 720p Plasma TV',1,29),(2,'Samsung 65 inch',1400.00,'Sony 1080p Plasma TV',1,29),(3,'Dell 14 inch',450.00,'Dell 500Gb 6Mb RAM',2,40),(4,'HP 17 inch',799.00,'HP 1TB 16Gb RAM',2,0);
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_item`
--

DROP TABLE IF EXISTS `order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_item` (
  `order_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_price` decimal(10,2) NOT NULL,
  `item_quantity` int(11) DEFAULT NULL,
  KEY `fk_oder_item__idx` (`order_id`),
  KEY `fk_order_item_item_idx` (`item_id`),
  CONSTRAINT `fk_oder_item_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_item_item` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_item`
--

LOCK TABLES `order_item` WRITE;
/*!40000 ALTER TABLE `order_item` DISABLE KEYS */;
INSERT INTO `order_item` VALUES (10010,3,2700.00,6),(10011,1,2000.00,2),(10012,2,1400.00,1),(10012,3,450.00,1),(10012,4,3995.00,5),(10013,1,2000.00,2),(10013,2,15400.00,11),(10013,4,2397.00,3),(10014,1,10000.00,10),(10015,3,4500.00,10),(10016,2,14000.00,10),(10017,1,50000.00,50),(10017,2,1400.00,1),(10018,4,1598.00,2),(10019,4,30362.00,38),(10020,1,10000.00,10),(10020,2,14000.00,10),(10021,1,1000.00,1);
/*!40000 ALTER TABLE `order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `ship_first_name` varchar(45) NOT NULL,
  `ship_last_name` varchar(45) NOT NULL,
  `ship_address1` varchar(100) NOT NULL,
  `ship_address2` varchar(45) DEFAULT NULL,
  `ship_city` varchar(45) NOT NULL,
  `ship_state_id` char(2) NOT NULL,
  `ship_country` varchar(100) NOT NULL,
  `ship_charge` decimal(10,2) DEFAULT NULL,
  `order_amout` decimal(10,2) DEFAULT NULL,
  `order_status` varchar(45) NOT NULL,
  `order_date_time` datetime NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `fk_order_state_id_state_idx` (`ship_state_id`),
  KEY `fk order_user_idx` (`user_id`),
  CONSTRAINT `fk order_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_state_id_state` FOREIGN KEY (`ship_state_id`) REFERENCES `state` (`state_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10022 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (10010,18,'ben','ben','123 street','120','Lincroft','NJ','United States',0.00,2700.00,'PROCESSING','2020-02-12 12:09:45'),(10011,17,'sama','sama','123 town','111','eatontown','NJ','United States',0.00,2000.00,'PROCESSING','2020-02-12 14:48:34'),(10012,19,'mary','mary','123 Street','500','Lincroft','NJ','United States',0.00,5845.00,'PROCESSING','2020-02-19 19:03:45'),(10013,17,'sama','sama','123 town','222','eatontown','NJ','United States',0.00,19797.00,'PROCESSING','2020-02-20 10:17:21'),(10014,17,'sama','Maharjan','0000','555','eatontown','NY','United States',0.00,10000.00,'PROCESSING','2020-02-21 16:33:30'),(10015,17,'sama','Maharjan','0000','555','eatontown','NY','United States',0.00,4500.00,'PROCESSING','2020-02-27 13:52:51'),(10016,17,'sama','Maharjan','0000','555','eatontown','NY','United States',0.00,14000.00,'PROCESSING','2020-02-27 17:48:06'),(10017,24,'Sama','Maharjan','25596 Colonists Ter','111','Chantilly','VA','United States',0.00,51400.00,'PROCESSING','2020-03-01 06:36:33'),(10018,24,'Sama','Maharjan','25596 Colonists Ter','11','Chantilly','VA','United States',0.00,1598.00,'PROCESSING','2020-03-01 06:43:10'),(10019,24,'Sama','Maharjan','25596 Colonists Ter','3333','Chantilly','VA','United States',0.00,30362.00,'PROCESSING','2020-03-01 06:44:05'),(10020,24,'Sama','Maharjan','25596 Colonists Ter','555','Chantilly','VA','United States',0.00,24000.00,'PROCESSING','2020-03-02 19:27:09'),(10021,17,'Sama','Maharjan','83 white street','','Eatontown','NJ','United States',0.00,1000.00,'PROCESSING','2020-03-17 18:31:04');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_type`
--

DROP TABLE IF EXISTS `product_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_type` (
  `product_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_type_name` varchar(45) NOT NULL,
  PRIMARY KEY (`product_type_id`),
  UNIQUE KEY `product_type_name_UNIQUE` (`product_type_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_type`
--

LOCK TABLES `product_type` WRITE;
/*!40000 ALTER TABLE `product_type` DISABLE KEYS */;
INSERT INTO `product_type` VALUES (2,'Laptop'),(1,'Television');
/*!40000 ALTER TABLE `product_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `state`
--

DROP TABLE IF EXISTS `state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `state` (
  `state_id` char(2) NOT NULL,
  `state_name` varchar(45) NOT NULL,
  PRIMARY KEY (`state_id`),
  UNIQUE KEY `state_name_UNIQUE` (`state_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `state`
--

LOCK TABLES `state` WRITE;
/*!40000 ALTER TABLE `state` DISABLE KEYS */;
INSERT INTO `state` VALUES ('AL','Alabama'),('CA','California'),('NJ','New Jersey'),('NY','New York'),('TX','Texas'),('UT','Utah'),('VA','Virginia');
/*!40000 ALTER TABLE `state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `first_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `address1` varchar(100) DEFAULT NULL,
  `address2` varchar(45) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `state_id` char(2) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_name_UNIQUE` (`user_name`),
  KEY `fk_state_id_state_idx` (`state_id`),
  CONSTRAINT `fk_state_id_state` FOREIGN KEY (`state_id`) REFERENCES `state` (`state_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (17,'sama','sama','Sama','Maharjan','samamaharjan@yahoo.com','83 white street','','Eatontown','NJ','United States'),(18,'ben','ben','ben','ben','ben@gmail.com','123 street','120','Lincroft','NJ','United States'),(19,'mary','mary','mary','mary','mary@gmail.com','123 Street','500','Lincroft','NJ','United States'),(20,'sama21','sama21','Sama','Maharjan','samamaharjan@yahoo.com','25596 Colonists Ter','','Chantilly','NY','United States'),(23,'sama123','sama123','Sama','Maharjan','smahar1@wgu.edu','25596 Colonists Ter','','Chantilly','NY','United States'),(24,'sama2020','sama2020','Sama','Maharjan','smahar1@wgu.edu','25596 Colonists Ter','12345','Chantilly','VA','United States');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-17 18:33:27
