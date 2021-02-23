-- MySQL dump 10.13  Distrib 8.0.23, for Linux (x86_64)
--
-- Host: localhost    Database: game
-- ------------------------------------------------------
-- Server version	8.0.23-0ubuntu0.20.04.1

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

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `item` int NOT NULL DEFAULT '0',
  `unique` double NOT NULL DEFAULT '0',
  `owner` int NOT NULL DEFAULT '0',
  `for_sale` tinyint(1) NOT NULL DEFAULT '0',
  `price` int NOT NULL DEFAULT '0',
  `equipped` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (1,0,0.95629879832267,27,0,0,0),(2,18,0.48923498,27,0,0,1),(3,2,0,27,0,0,0),(4,3,0,27,0,0,0),(5,4,0,27,0,0,0),(6,12,0,27,0,0,1),(7,13,0,27,0,0,0),(8,14,0,26,1,1500,0),(9,15,0,27,0,0,0),(10,16,0,27,0,0,1),(11,17,0,27,0,0,0),(12,1,0,27,0,0,0),(13,1,0,27,0,0,1),(14,1,0,26,1,162,0),(15,1,0,27,0,0,0);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items_index`
--

DROP TABLE IF EXISTS `items_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items_index` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `description` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `type` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `model` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `rarity` int NOT NULL,
  `loot` float NOT NULL DEFAULT '0',
  `pattern` tinyint NOT NULL DEFAULT '0',
  `hp` float NOT NULL DEFAULT '0',
  `dmg` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items_index`
--

LOCK TABLES `items_index` WRITE;
/*!40000 ALTER TABLE `items_index` DISABLE KEYS */;
INSERT INTO `items_index` VALUES (0,'Metal boots','No Description','feet','Boots_1',1,10,0,5,0),(1,'Royal Shirt','No Description','torso','LionShirt',3,5,0,0,0),(2,'Brown tail','No Description','hair','Hair_1',2,10,0,0,0),(3,'Metal Armor Torso','No Description','torso','Armor_1',1,10,0,15,0),(4,'Horn Helemet','No Description','helmet','HornHelmet',2,10,0,8,0),(12,'Claymore','No Description','weapon','Claymore_1',3,10,0,25,10),(13,'Face mask','Keep safe!','mouth','Facemask',0,1,0,10,0),(14,'Brown beard','No Description','mouth','Beard_1',2,10,0,0,0),(15,'Starter Sheild','A sheild for the Novice','sheild','StarterSheild',1,10,0,0,0),(16,'Black Beard','No Description','mouth','Beard_2',2,5,0,0,0),(17,'Large Beard','The Largest beard in the game','mouth','LargeBlackBeard',3,10,0,0,0),(18,'Royal Sheild','Pure Royalty','sheild','RoyalSheild',3,3,0,0,0);
/*!40000 ALTER TABLE `items_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_transactions`
--

DROP TABLE IF EXISTS `market_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `market_transactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seller` int NOT NULL,
  `buyer` int NOT NULL,
  `item` int NOT NULL,
  `price` int NOT NULL,
  `date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_transactions`
--

LOCK TABLES `market_transactions` WRITE;
/*!40000 ALTER TABLE `market_transactions` DISABLE KEYS */;
INSERT INTO `market_transactions` VALUES (1,27,26,1,30,'2021-02-21 01:00:00'),(2,27,26,1,15,'2021-02-20 23:09:00'),(3,26,27,2,150,'2021-02-22 14:13:06'),(4,26,27,14,350,'2021-02-22 14:17:16'),(5,26,27,9,160,'2021-02-22 14:20:46'),(6,26,27,13,16,'2021-02-22 15:27:53');
/*!40000 ALTER TABLE `market_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` tinytext CHARACTER SET utf8 COLLATE utf8_bin,
  `gold` int NOT NULL DEFAULT '0',
  `lvl` int NOT NULL DEFAULT '1',
  `token` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (26,'TestAcc',676,1,'3a71301e-ee30-4b34-84ce-8be2b853a44e'),(27,'Olle',4712,1,'3641b484-5173-4972-b148-ce13bbb0e246');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-02-23  9:59:12
