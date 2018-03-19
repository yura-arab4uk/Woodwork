-- MySQL dump 10.13  Distrib 5.7.12, for Win32 (AMD64)
--
-- Host: localhost    Database: webstore
-- ------------------------------------------------------
-- Server version	5.5.51

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
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `parent` int(10) unsigned NOT NULL,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_category_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Всі',0,1),(2,'Двері',1,1),(3,'Вікна',1,1),(4,'Замки',1,1),(5,'Лиштви',1,1),(6,'Шпінгалети',1,1),(7,'Скло',1,1),(8,'Завіси',1,1),(9,'Вхідні',2,1),(10,'Міжкімнатні',2,1),(11,'Чопові',8,1),(12,'Врізні',8,1),(13,'Дверні',4,1),(14,'Інші',4,1),(15,'На вхідні двері',13,1),(16,'На міжкімнатні двері',13,1),(112,'gtgrgt5',2,0),(113,'g554g',8,0),(114,'gdg',113,0),(115,'grdgr',114,0),(116,'grdgrd',115,0),(117,'g4dgr',115,0),(118,'grdgdr',114,0),(119,'hkh',2,0),(120,'',8,0),(121,'ва',10,0),(122,'w',10,0),(123,'vvv',10,0);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_has_property`
--

DROP TABLE IF EXISTS `category_has_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_has_property` (
  `category_id` int(10) unsigned NOT NULL,
  `property_id` int(10) unsigned NOT NULL,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`category_id`,`property_id`),
  KEY `FK_category_has_property_property_id` (`property_id`),
  CONSTRAINT `FK_category_has_property_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_category_has_property_property_id` FOREIGN KEY (`property_id`) REFERENCES `property` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_has_property`
--

LOCK TABLES `category_has_property` WRITE;
/*!40000 ALTER TABLE `category_has_property` DISABLE KEYS */;
INSERT INTO `category_has_property` VALUES (1,4,1),(1,5,1),(2,1,1),(2,2,1),(7,3,1),(8,6,1);
/*!40000 ALTER TABLE `category_has_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `product_id` int(10) unsigned NOT NULL,
  `date` datetime NOT NULL,
  `status_id` int(10) unsigned NOT NULL,
  `status_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Orders_Lots1_idx` (`product_id`),
  KEY `FK_order_user_id` (`user_id`),
  KEY `FK_order_status_id` (`status_id`),
  CONSTRAINT `FK_order_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_order_status_id` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_order_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,1,7,'2016-01-01 00:00:00',1,''),(2,1,9,'2016-01-01 00:00:00',1,''),(3,1,2,'2016-11-03 22:06:29',1,''),(4,1,11,'2016-11-04 00:18:29',1,NULL),(5,1,10,'2016-11-04 00:18:41',1,NULL),(6,1,15,'2016-11-04 00:58:39',1,''),(7,1,9,'2016-11-04 00:58:41',1,NULL),(8,1,85,'2016-11-04 00:58:42',1,''),(9,1,4,'2016-11-04 00:58:43',1,''),(10,1,18,'2016-11-04 00:58:43',1,NULL),(11,1,1,'2016-11-04 00:58:44',1,''),(12,1,16,'2016-11-04 00:58:45',1,''),(13,1,6,'2016-11-04 00:58:49',1,''),(14,1,8,'2016-11-04 00:58:50',1,NULL),(15,1,15,'2016-11-04 01:02:31',1,''),(16,1,85,'2016-11-04 01:02:56',1,''),(17,1,17,'2016-11-04 01:02:58',1,''),(18,1,7,'2016-11-04 01:03:26',1,NULL),(19,1,5,'2016-11-04 01:03:49',1,''),(20,1,10,'2016-11-04 01:06:36',1,NULL),(21,1,4,'2016-11-04 01:06:41',1,''),(22,1,2,'2016-11-04 01:06:48',1,''),(23,1,1,'2016-11-04 01:06:49',1,''),(24,1,4,'2016-11-08 23:52:45',1,NULL),(25,1,23,'2016-11-08 23:52:51',1,NULL),(26,1,4,'2016-11-09 15:32:35',1,NULL),(27,1,1,'2016-11-09 21:24:49',1,NULL),(28,2,4,'2016-11-09 22:14:48',1,NULL),(29,1,2,'2016-11-09 22:15:12',1,NULL),(30,18,1,'2016-11-15 19:38:10',1,NULL),(31,1,4,'2016-11-15 20:43:33',1,NULL);
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `condition` enum('new','used') NOT NULL DEFAULT 'new',
  `category_id` int(10) unsigned NOT NULL,
  `price` int(10) unsigned DEFAULT '0',
  `image` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_Lots_Categories1_idx` (`category_id`),
  CONSTRAINT `fk_Product_Category1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'Двері нові D1','Якість понад усе','new',9,6300,'1.png',1),(2,'Двері ок D2','Не пожалієте','new',10,4000,'2.png',1),(4,'Двері звичайні D3','Краще не буває','new',9,7000,'3.png',1),(5,'Двері D10','Швидко виготовляються','new',10,4500,'4.png',1),(6,'Двері сильні D7','Хіт сезону','new',10,5000,'5.png',1),(7,'Вікно заводське W1','якість понад усе','new',3,3000,'6.png',1),(8,'Вікно W2','Хіт сезону','new',3,2000,'7.png',1),(9,'Лиштва F1','Найкраще','new',5,100,'8.png',1),(10,'Лиштва крута F2','Популярні','new',5,120,'9.png',1),(11,'Лиштва вічна F3','Найкраща кондиція','new',5,140,'10.png',1),(12,'Скло G1','надміцне','used',7,200,'11.png',1),(13,'Скло клас G2','міцне','new',7,250,'12.png',1),(14,'Скло G3','краса','new',7,300,'13.png',1),(15,'Замок перший L1','ніхто не пройде','new',15,600,'14.png',1),(16,'Замок другий L2','не пробуйте','new',16,700,'15.png',1),(17,'Замок шик L3','кращих не буває','new',15,800,'16.png',1),(18,'Шпінгалет C1','шпінгалет бест','used',6,200,'17.png',1),(19,'Шпінгалет клас C2','міцність перше','new',6,250,'18.png',1),(20,'Завіса K1','Врізні','used',12,100,'19.png',1),(21,'Завіса K2','Чопові','used',11,150,'20.png',1),(22,'Завіса кулK3','Врізні','new',12,110,'21.png',1),(23,'Двері повітря D5','Надлегкі','new',10,7000,'22.png',1),(85,'Бомбезний замок','Якість неперевершена','new',16,250,'24.png',1),(86,'1111','1111111','new',3,9999,'86.png',1),(87,'15','5','new',3,5,'87.png',1),(88,'gfdg','gdfg','new',3,42949,'88.png',1),(89,'32','233','new',5,321,'89.png',1);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_has_property`
--

DROP TABLE IF EXISTS `product_has_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_has_property` (
  `product_id` int(10) unsigned NOT NULL,
  `property_id` int(10) unsigned NOT NULL,
  `value_as_string` varchar(250) NOT NULL,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`property_id`,`product_id`),
  KEY `FK_product_has_property_product_id` (`product_id`),
  CONSTRAINT `FK_product_has_property_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Product_has_Property_Property1` FOREIGN KEY (`property_id`) REFERENCES `property` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_has_property`
--

LOCK TABLES `product_has_property` WRITE;
/*!40000 ALTER TABLE `product_has_property` DISABLE KEYS */;
INSERT INTO `product_has_property` VALUES (1,1,'Дуб,Ялина',1),(2,1,'Ялина',1),(4,1,'Дуб',1),(5,1,'Ялина',1),(6,1,'Граб',1),(23,1,'Граб,Ялина',1),(89,5,'231',1);
/*!40000 ALTER TABLE `product_has_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `property`
--

DROP TABLE IF EXISTS `property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `property` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `type` varchar(45) NOT NULL,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `property`
--

LOCK TABLES `property` WRITE;
/*!40000 ALTER TABLE `property` DISABLE KEYS */;
INSERT INTO `property` VALUES (1,'Material','String',1),(2,'Desk width','Integer',1),(3,'Might','String',1),(4,'Гарантія (роки)','String',1),(5,'Cool','String',1),(6,'Good','String',1);
/*!40000 ALTER TABLE `property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `status` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` VALUES (1,'new',1),(2,'ready',1),(3,'processing...',1),(4,'canseled',1);
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(45) NOT NULL,
  `login` varchar(45) NOT NULL,
  `phone_number` int(10) unsigned NOT NULL,
  `firstname` varchar(45) NOT NULL,
  `lastname` varchar(45) NOT NULL,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `password` varchar(45) NOT NULL,
  `role` varchar(45) NOT NULL DEFAULT 'ROLE_USER',
  PRIMARY KEY (`id`),
  UNIQUE KEY `login` (`login`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'aaa@mail.com','abb',970000011,'Стів','Джобс',1,'b59c67bf196a4758191e42f76670ceba','ROLE_ADMIN'),(2,'bbb@mail.com','bbb',973333333,'Аня','Кудрява',1,'b59c67bf196a4758191e42f76670ceba','ROLE_USER'),(3,'ссс@mail.com','ccc',978888888,'Гріша','Білявський1',1,'b59c67bf196a4758191e42f76670ceba','ROLE_USER'),(4,'ddd@mail.com','ddd',917777777,'Оля','Гавадзин',1,'b59c67bf196a4758191e42f76670ceba','ROLE_USER'),(5,'eee@ukr.net','eee',973332355,'Михась','Заліський',1,'b59c67bf196a4758191e42f76670ceba','ROLE_USER'),(6,'ggg@ukr.net','ggg',687777789,'Павло','Котовський',1,'b59c67bf196a4758191e42f76670ceba','ROLE_USER'),(7,'uuu@gmai.com','dfd',665566765,'Андрій1','Зарубіжний',1,'b59c67bf196a4758191e42f76670ceba','ROLE_USER'),(8,'kjl@jl.com','fdfd',665564444,'Антон','Заник',1,'b59c67bf196a4758191e42f76670ceba','ROLE_USER'),(16,'qqq@ukr.net','qqq',973333334,'Василь','Петровський1',1,'b59c67bf196a4758191e42f76670ceba','ROLE_USER'),(17,'fd@fd','fr',33,'vcvc','fd',1,'0ded1aa71dc2ea6aebbd43a7d06b19d0','ROLE_USER'),(18,'aaa@mail.com1','s',3,'s','s',1,'0b4e7a0e5fe84ad35fb5f95b9ceeac79','ROLE_USER'),(19,'aaa@mail.comd','fdf',970004011,'Мирон','Калаш',1,'0b4e7a0e5fe84ad35fb5f95b9ceeac79','ROLE_USER');
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

-- Dump completed on 2016-11-15 21:07:07
