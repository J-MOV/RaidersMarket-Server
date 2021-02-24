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
  `pattern` double NOT NULL DEFAULT '0',
  `owner` int NOT NULL DEFAULT '0',
  `for_sale` tinyint(1) NOT NULL DEFAULT '0',
  `price` int NOT NULL DEFAULT '0',
  `equipped` tinyint NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL,
  `creator` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=616 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (587,17,0.8113110942472805,901,0,0,0,'2021-02-24 17:26:39',897),(588,14,0.20541485662485748,901,1,500,0,'2021-02-24 17:26:39',897),(589,2,0.9720400949627923,901,0,0,0,'2021-02-24 19:49:36',901),(590,4,0.078988551129205,901,0,0,0,'2021-02-24 19:49:36',901),(591,0,0.46870926792889933,901,0,0,0,'2021-02-24 19:52:29',901),(592,16,0.7471062752050495,901,0,0,0,'2021-02-24 19:52:29',901),(593,12,0.9561044933492671,901,1,50,0,'2021-02-24 19:52:29',901),(594,15,0.47959925592154673,901,0,0,0,'2021-02-24 19:53:58',901),(595,12,0.3485416950020783,901,1,150,0,'2021-02-24 19:53:58',901),(596,3,0.07213070662987864,901,0,0,0,'2021-02-24 19:53:58',901),(597,0,0.8864986726462254,901,0,0,0,'2021-02-24 19:53:58',901),(598,12,0.2681149642418694,901,0,0,0,'2021-02-24 19:53:58',901),(599,20,0.6137150307403738,901,0,0,0,'2021-02-24 19:55:06',901),(600,3,0.9917172873948616,901,0,0,0,'2021-02-24 19:55:06',901),(601,20,0.09135189950140332,901,0,0,1,'2021-02-24 19:55:06',901),(602,2,0.6011663082312788,901,0,0,0,'2021-02-24 19:55:06',901),(603,2,0.6936787142813612,901,0,0,0,'2021-02-24 19:55:06',901),(604,20,0.22394622356770344,901,0,0,0,'2021-02-24 19:58:24',901),(605,0,0.5606444481534845,901,0,0,0,'2021-02-24 19:58:24',901),(606,14,0.2636669231783533,901,0,0,0,'2021-02-24 21:19:20',901),(607,14,0.8830207403196855,901,0,0,0,'2021-02-24 21:19:20',901),(608,4,0.7312334908775244,901,0,0,0,'2021-02-24 21:19:20',901),(609,2,0.3752494486423559,901,0,0,0,'2021-02-24 21:19:20',901),(610,12,0.8705907186286261,901,0,0,0,'2021-02-24 21:19:20',901),(611,1,0.24946674673433344,901,0,0,0,'2021-02-24 21:19:20',901),(612,20,0.25729759206141645,901,0,0,0,'2021-02-24 21:19:20',901),(613,2,0.5047121635647744,901,0,0,0,'2021-02-24 21:19:20',901),(614,15,0.05575740240430971,901,0,0,0,'2021-02-24 21:21:48',901),(615,2,0.5336853440130487,901,0,0,0,'2021-02-24 21:21:48',901);
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items_index`
--

LOCK TABLES `items_index` WRITE;
/*!40000 ALTER TABLE `items_index` DISABLE KEYS */;
INSERT INTO `items_index` VALUES (0,'Metal boots','No Description','feet','Boots_1',1,10,0,5,0),(1,'Royal Shirt','No Description','torso','LionShirt',3,5,0,3,0),(2,'Brown tail','No Description','hair','Hair_1',0,10,0,2,0),(3,'Metal Armor Torso','No Description','torso','Armor_1',1,10,0,15,0),(4,'Horn Helemet','No Description','head','HornHelmet',1,10,0,35,0),(12,'Claymore','No Description','weapon','Claymore_1',2,10,0,0,15),(13,'Face mask','Keep safe!','face','Facemask',0,1,0,10,0),(14,'Brown beard','No Description','face','Beard_1',0,10,0,3,0),(15,'Starter Sheild','A sheild for the Novice','defense','StarterSheild',0,10,0,15,0),(16,'Black Beard','No Description','face','Beard_2',0,5,0,5,0),(17,'Large Beard','The Largest beard in the game','face','LargeBlackBeard',3,10,0,10,0),(18,'Royal Sheild','Pure Royalty','defense','RoyalSheild',3,3,0,35,0),(19,'Plague Mask','Stay extra safe','face','PlagueMask',4,5,0,50,0),(20,'Spear','This is sparta!','weapon','Spear',0,10,0,0,10);
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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_transactions`
--

LOCK TABLES `market_transactions` WRITE;
/*!40000 ALTER TABLE `market_transactions` DISABLE KEYS */;
INSERT INTO `market_transactions` VALUES (29,897,900,587,56,'2021-02-24 17:29:45'),(30,900,901,587,0,'2021-02-24 17:39:27'),(31,897,901,588,500,'2021-02-24 19:48:55');
/*!40000 ALTER TABLE `market_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `raids`
--

DROP TABLE IF EXISTS `raids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `raids` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user` int DEFAULT NULL,
  `lvl` int DEFAULT NULL,
  `started` timestamp NULL DEFAULT NULL,
  `ended` timestamp NULL DEFAULT NULL,
  `earned_loot` json DEFAULT NULL,
  `earned_gold` int DEFAULT '0',
  `completed` tinyint DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `raids`
--

LOCK TABLES `raids` WRITE;
/*!40000 ALTER TABLE `raids` DISABLE KEYS */;
INSERT INTO `raids` VALUES (94,897,1,'2021-02-24 17:26:23',NULL,'[17, 14]',0,0),(95,901,1,'2021-02-24 19:49:22',NULL,'[2, 4]',0,0),(96,901,2,'2021-02-24 19:52:05',NULL,'[0, 16, 12]',0,0),(97,901,3,'2021-02-24 19:53:22',NULL,'[15, 12, 3, 0, 12]',0,0),(98,901,3,'2021-02-24 19:54:31',NULL,'[20, 3, 20, 2, 2]',0,0),(99,901,99,'2021-02-24 19:56:58',NULL,'[]',0,0),(100,901,100,'2021-02-24 19:57:18',NULL,'[]',0,0),(101,901,1,'2021-02-24 19:57:38',NULL,'[]',0,0),(102,901,1,'2021-02-24 19:58:10',NULL,'[20, 0]',0,0),(103,901,101,'2021-02-24 20:21:03',NULL,'[]',0,0),(104,901,102,'2021-02-24 20:21:35',NULL,'[]',0,0),(105,901,103,'2021-02-24 20:22:13',NULL,'[]',0,0),(106,901,104,'2021-02-24 20:23:21',NULL,'[3]',0,0),(107,901,105,'2021-02-24 20:23:47',NULL,'[]',0,0),(108,901,105,'2021-02-24 20:56:38',NULL,'[]',0,0),(109,901,105,'2021-02-24 20:57:42',NULL,'[]',0,0),(110,901,105,'2021-02-24 21:11:21',NULL,'[]',0,0),(111,901,105,'2021-02-24 21:11:39',NULL,'[]',0,0),(112,901,105,'2021-02-24 21:11:54',NULL,'[]',0,0),(113,901,105,'2021-02-24 21:12:05',NULL,'[]',0,0),(114,901,103,'2021-02-24 21:12:19',NULL,'[]',0,0),(115,901,105,'2021-02-24 21:14:30',NULL,'[]',0,0),(116,901,105,'2021-02-24 21:14:57',NULL,'[20, 4, 0]',0,0),(117,901,103,'2021-02-24 21:15:36',NULL,'[]',0,0),(118,901,103,'2021-02-24 21:15:43',NULL,'[]',0,0),(119,901,5,'2021-02-24 21:18:20',NULL,'[14, 14, 4, 2, 12, 1, 20, 2]',0,0),(120,901,1,'2021-02-24 21:21:36',NULL,'[15, 2]',0,0);
/*!40000 ALTER TABLE `raids` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=902 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (897,'Olle',2168,1,'9152dc48-e615-4bb2-9ef1-ff14bd98dd0b'),(898,'Mehmet',5000,1,'799a345b-9cf0-44ba-98cb-9ba730c6bff5'),(899,'TimmyDeGamer',5100,1,'939dae98-3b09-44f7-ba2e-24b88de96ab6'),(900,'Olletvå',444,1,'b1b94e87-8338-4565-9b19-2fd603d93ad8e5'),(901,'OlleTre',228,6,'98001930-a6df-4446-80c6-8d4df9747c44');
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

-- Dump completed on 2021-02-24 21:29:22
