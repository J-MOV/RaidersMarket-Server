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
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items_index`
--

LOCK TABLES `items_index` WRITE;
/*!40000 ALTER TABLE `items_index` DISABLE KEYS */;
INSERT INTO `items_index` VALUES (0,'Metal boots','No Description','feet','Boots_1',1,10,0,20,0),(1,'Royal Shirt','No Description','torso','LionShirt',3,5,0,3,0),(2,'Brown tail','No Description','hair','Hair_1',0,10,0,2,0),(3,'Metal Armor Torso','No Description','torso','Armor_1',1,10,0,50,0),(4,'Horn Helemet','No Description','head','HornHelmet',1,10,0,35,0),(12,'Claymore','A sword you can trust!','weapon','Claymore_1',2,10,0,0,15),(13,'Face mask','Keep safe!','face','Facemask',0,1,0,10,0),(14,'Brown beard','No Description','face','Beard_1',0,10,0,3,0),(15,'Starter Shield','A sheild for the Novice','defense','StarterSheild',0,10,0,15,0),(16,'Black Beard','Pirate beard','face','Beard_2',0,5,0,5,0),(17,'Large Beard','The Largest beard in the game','face','LargeBlackBeard',3,10,0,10,0),(18,'Royal Shield','Pure Royalty.','defense','RoyalSheild',3,3,0,40,0),(19,'Plague Mask','Stay extra safe!','face','PlagueMask',4,10,0,50,0),(20,'Spear','This is sparta!','weapon','Spear',0,10,0,0,10),(21,'Plague Boots','Boots for Doc.','feet','PlagueBoots',0,5,0,5,0),(22,'Plague Case','Supplies for Doc.','defense','PlagueCase',1,5,0,30,0),(23,'Plague Hat','Hat for Doc.','head','PlagueHat',2,5,0,10,0),(24,'Plague Robe','Warmth for Doc.','torso','PlagueRobe',3,5,0,10,0),(25,'Plague Staff','Support for Doc.','weapon','PlagueStaff',3,3,0,0,45),(26,'Leather Boots','Very warm boots.','feet','LeatherBoots',0,5,0,7,0),(27,'Cross Robe','Fashionable!','torso','CrossCloth',2,5,0,10,0),(28,'Metal Helmet','Great stats!','head','MetalHelmet',0,10,0,30,0),(29,'Checkered Shield','No Description','defense','CheckeredSheild',2,2,1,30,0),(30,'Cloth Mask','Stay safest!','face','ClothMask',4,6,1,65,0),(31,'Novice Helmet','A beginner helmet','head','NoviceHelmet',0,10,0,25,0),(32,'Halberd','No Description','weapon','Halberd',3,1,0,0,45),(33,'Tower Shield','No Description','defense','TowerShield',2,3,1,50,0),(34,'Scythe','No Description','weapon','Scythe',2,6,0,0,30);
/*!40000 ALTER TABLE `items_index` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-02-26 16:49:11
