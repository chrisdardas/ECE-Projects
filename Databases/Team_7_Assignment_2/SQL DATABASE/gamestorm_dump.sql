-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: gamestorm
-- ------------------------------------------------------
-- Server version	8.0.39

DROP SCHEMA IF EXISTS `gamestorm`;
CREATE SCHEMA `gamestorm`;
USE `gamestorm`;

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
-- Table structure for table `achievement`
--

DROP TABLE IF EXISTS `achievement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `achievement` (
  `achievement_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `achievement_description` text NOT NULL,
  `date_of_completion` date DEFAULT NULL,
  `achievement_difficulty` enum('Easy','Normal','Hard') NOT NULL,
  `achievement_points` int DEFAULT '0',
  `game_id` int NOT NULL,
  PRIMARY KEY (`achievement_id`),
  KEY `game_id` (`game_id`),
  CONSTRAINT `achievement_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `achievement_chk_1` CHECK ((`achievement_points` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=4022 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `achievement`
--

LOCK TABLES `achievement` WRITE;
/*!40000 ALTER TABLE `achievement` DISABLE KEYS */;
INSERT INTO `achievement` VALUES (5,'Speed Runner','Complete the game in under 5 hours','2022-11-08','Hard',95,8734),(48,'Master Explorer','Explore all the game maps.','2024-01-05','Hard',100,1305),(103,'Legendary Collector','Collect all the collectibles in the game','2024-07-10','Normal',75,1305),(496,'First Blood','Kill your first opponent in the game.','2023-12-15','Easy',10,8734),(629,'Master of Stealth','Complete the game using only stealth kills','2020-04-18','Hard',150,8743),(1988,'Unstoppable','Win 10 consecutive ranked matches','2023-01-25','Normal',70,7123),(4021,'Social Butterfly','Play 100 multiplayer matches','2021-07-02','Easy',30,7123);
/*!40000 ALTER TABLE `achievement` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `set_default_date4` BEFORE INSERT ON `achievement` FOR EACH ROW BEGIN
	IF NEW.date_of_completion IS NULL THEN
		SET NEW.date_of_completion = CURDATE();
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `achievementsbygames`
--

DROP TABLE IF EXISTS `achievementsbygames`;
/*!50001 DROP VIEW IF EXISTS `achievementsbygames`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `achievementsbygames` AS SELECT 
 1 AS `achievement_id`,
 1 AS `game_id`,
 1 AS `achievement_points`,
 1 AS `title`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `developer`
--

DROP TABLE IF EXISTS `developer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `developer` (
  `developer_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `email` varchar(30) NOT NULL,
  PRIMARY KEY (`developer_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=112234 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `developer`
--

LOCK TABLES `developer` WRITE;
/*!40000 ALTER TABLE `developer` DISABLE KEYS */;
INSERT INTO `developer` VALUES (22331,'ChanAlik','chanalik@example.com'),(32257,'CharKolio','charilko45@example.com'),(34556,'MasterDev','masterdev@example.com'),(43121,'Selenimia','selenimia@example.com'),(45667,'FlowerRoza','flowerroz23@example.com'),(89711,'RoyalKing','kotiaser@example.com'),(112233,'LittlePrince','lprince18@example.com');
/*!40000 ALTER TABLE `developer` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `prevent_developer_delete` BEFORE DELETE ON `developer` FOR EACH ROW BEGIN
	DECLARE game_count INT;
	SELECT COUNT(*) INTO game_count FROM game_createdby_developer WHERE developer_id = OLD.developer_id;
	
	IF game_count > 0 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Cannot delete developer with associated games';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `dlc`
--

DROP TABLE IF EXISTS `dlc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dlc` (
  `dlc_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `description` text,
  `release_date` date DEFAULT NULL,
  `game_id` int NOT NULL,
  `developer_id` int NOT NULL,
  PRIMARY KEY (`dlc_id`),
  UNIQUE KEY `title` (`title`),
  KEY `game_id` (`game_id`),
  KEY `developer_id` (`developer_id`),
  CONSTRAINT `dlc_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `dlc_ibfk_2` FOREIGN KEY (`developer_id`) REFERENCES `developer` (`developer_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8976 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlc`
--

LOCK TABLES `dlc` WRITE;
/*!40000 ALTER TABLE `dlc` DISABLE KEYS */;
INSERT INTO `dlc` VALUES (324,'Artorias Of The Abyss','Fleshes out the story and adds some of the best bosses.','2012-08-24',8392,112233),(4372,'Crown of the Old Iron King','New stages, maps, bosses, weapons, and armor.','2014-08-26',8743,43121),(4378,'Shadow Of The Erdtree','Explore the Realm of Shadow and fight challenging bosses.','2024-06-21',1305,34556),(7685,'The Old Hunters','Unique bosses, brutal difficulty, and terrifying locations.','2015-11-24',8734,89711),(8392,'The Ringed City','New convoluted region, enemies, and mysteries.','2017-01-23',8392,45667),(8975,'GCPD Lockdown','Nightwing tries to prevent The Penguin from escaping.','2015-09-29',8743,22331);
/*!40000 ALTER TABLE `dlc` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `set_default_date3` BEFORE INSERT ON `dlc` FOR EACH ROW BEGIN
	IF NEW.release_date IS NULL THEN
		SET NEW.release_date = CURDATE();
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `dlc_createdby_developer`
--

DROP TABLE IF EXISTS `dlc_createdby_developer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dlc_createdby_developer` (
  `dlc_id` int NOT NULL,
  `developer_id` int NOT NULL,
  PRIMARY KEY (`dlc_id`,`developer_id`),
  KEY `developer_id` (`developer_id`),
  CONSTRAINT `dlc_createdby_developer_ibfk_1` FOREIGN KEY (`dlc_id`) REFERENCES `dlc` (`dlc_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `dlc_createdby_developer_ibfk_2` FOREIGN KEY (`developer_id`) REFERENCES `developer` (`developer_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlc_createdby_developer`
--

LOCK TABLES `dlc_createdby_developer` WRITE;
/*!40000 ALTER TABLE `dlc_createdby_developer` DISABLE KEYS */;
INSERT INTO `dlc_createdby_developer` VALUES (8975,22331),(4378,34556),(4372,43121),(8392,45667),(7685,89711),(324,112233);
/*!40000 ALTER TABLE `dlc_createdby_developer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game`
--

DROP TABLE IF EXISTS `game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game` (
  `game_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `release_date` date DEFAULT NULL,
  `price` decimal(4,2) DEFAULT '0.00',
  `age_rating` varchar(10) NOT NULL,
  `dlcs_available` tinyint(1) DEFAULT '0',
  `multiplayer_support` tinyint(1) DEFAULT '0',
  `genre_name` varchar(35) DEFAULT NULL,
  `developer_id` int NOT NULL,
  `platform_id` int NOT NULL,
  PRIMARY KEY (`game_id`),
  UNIQUE KEY `title` (`title`),
  KEY `genre_name` (`genre_name`),
  KEY `developer_id` (`developer_id`),
  KEY `platform_id` (`platform_id`),
  CONSTRAINT `game_ibfk_1` FOREIGN KEY (`genre_name`) REFERENCES `genre` (`name`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `game_ibfk_2` FOREIGN KEY (`developer_id`) REFERENCES `developer` (`developer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `game_ibfk_3` FOREIGN KEY (`platform_id`) REFERENCES `platform` (`platform_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `game_chk_1` CHECK ((`price` >= 0.00)),
  CONSTRAINT `game_chk_2` CHECK ((`age_rating` in (_utf8mb4'All Ages',_utf8mb4'12+',_utf8mb4'16+',_utf8mb4'18+')))
) ENGINE=InnoDB AUTO_INCREMENT=9022 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game`
--

LOCK TABLES `game` WRITE;
/*!40000 ALTER TABLE `game` DISABLE KEYS */;
INSERT INTO `game` VALUES (1305,'Elden Ring','2022-02-25',59.90,'16+',1,1,'RPG',34556,509),(3125,'Uncharted 4','2017-05-10',24.90,'16+',0,1,'Adventure',22331,21901),(7123,'Overwatch 2','2022-10-04',0.00,'12+',0,1,'Action',34556,3242),(8392,'God Of War','2018-04-20',19.99,'18+',0,0,'Action',43121,340),(8734,'Bloodborne','2015-03-24',19.99,'16+',1,1,'RPG',89711,3242),(8743,'Batman: Arkham Knight','2015-06-23',14.99,'18+',1,0,'Action',112233,871),(9021,'Red Dead Redemption 2','2018-10-26',59.99,'18+',0,1,'Action',45667,3242);
/*!40000 ALTER TABLE `game` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `set_default_date1` BEFORE INSERT ON `game` FOR EACH ROW BEGIN
    IF NEW.release_date IS NULL THEN
        SET NEW.release_date = CURDATE();
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `increment_genre_game_count` AFTER INSERT ON `game` FOR EACH ROW BEGIN
    UPDATE genre SET number_of_games = number_of_games + 1 WHERE name = NEW.genre_name;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_genre_game_count` AFTER UPDATE ON `game` FOR EACH ROW BEGIN
    IF OLD.genre_name != NEW.genre_name THEN
        UPDATE genre SET number_of_games = number_of_games - 1 WHERE name = OLD.genre_name;
        UPDATE genre SET number_of_games = number_of_games + 1 WHERE name = NEW.genre_name;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `decrement_genre_game_count` AFTER DELETE ON `game` FOR EACH ROW BEGIN
    UPDATE genre SET number_of_games = number_of_games - 1 WHERE name = OLD.genre_name;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `remove_game_from_wishlist_on_delete` AFTER DELETE ON `game` FOR EACH ROW BEGIN
	DELETE FROM game_belongsto_wishlist WHERE game_id = OLD.game_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `remove_achievements_on_game_delete` AFTER DELETE ON `game` FOR EACH ROW BEGIN 
	DELETE FROM achievement WHERE game_id = OLD.game_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `game_belongsto_wishlist`
--

DROP TABLE IF EXISTS `game_belongsto_wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game_belongsto_wishlist` (
  `game_id` int NOT NULL,
  `wishlist_id` int NOT NULL,
  PRIMARY KEY (`game_id`,`wishlist_id`),
  KEY `wishlist_id` (`wishlist_id`),
  CONSTRAINT `game_belongsto_wishlist_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `game_belongsto_wishlist_ibfk_2` FOREIGN KEY (`wishlist_id`) REFERENCES `wishlist` (`wishlist_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_belongsto_wishlist`
--

LOCK TABLES `game_belongsto_wishlist` WRITE;
/*!40000 ALTER TABLE `game_belongsto_wishlist` DISABLE KEYS */;
INSERT INTO `game_belongsto_wishlist` VALUES (7123,12120),(1305,12345),(8392,21312),(8734,23500),(9021,43560),(8743,55668),(3125,56789);
/*!40000 ALTER TABLE `game_belongsto_wishlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_createdby_developer`
--

DROP TABLE IF EXISTS `game_createdby_developer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game_createdby_developer` (
  `game_id` int NOT NULL,
  `developer_id` int NOT NULL,
  PRIMARY KEY (`game_id`,`developer_id`),
  KEY `developer_id` (`developer_id`),
  CONSTRAINT `game_createdby_developer_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `game_createdby_developer_ibfk_2` FOREIGN KEY (`developer_id`) REFERENCES `developer` (`developer_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_createdby_developer`
--

LOCK TABLES `game_createdby_developer` WRITE;
/*!40000 ALTER TABLE `game_createdby_developer` DISABLE KEYS */;
INSERT INTO `game_createdby_developer` VALUES (3125,22331),(1305,34556),(7123,34556),(8392,43121),(9021,45667),(8734,89711),(8743,112233);
/*!40000 ALTER TABLE `game_createdby_developer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `gameachievements`
--

DROP TABLE IF EXISTS `gameachievements`;
/*!50001 DROP VIEW IF EXISTS `gameachievements`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `gameachievements` AS SELECT 
 1 AS `achievement_id`,
 1 AS `title`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `gamesbydeveloper`
--

DROP TABLE IF EXISTS `gamesbydeveloper`;
/*!50001 DROP VIEW IF EXISTS `gamesbydeveloper`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `gamesbydeveloper` AS SELECT 
 1 AS `game_id`,
 1 AS `title`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `genre`
--

DROP TABLE IF EXISTS `genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genre` (
  `name` varchar(35) NOT NULL,
  `target_audience` varchar(10) DEFAULT NULL,
  `number_of_games` int DEFAULT '0',
  PRIMARY KEY (`name`),
  CONSTRAINT `genre_chk_1` CHECK ((`target_audience` in (_utf8mb4'All Ages',_utf8mb4'Teenagers',_utf8mb4'Adults'))),
  CONSTRAINT `genre_chk_2` CHECK ((`number_of_games` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genre`
--

LOCK TABLES `genre` WRITE;
/*!40000 ALTER TABLE `genre` DISABLE KEYS */;
INSERT INTO `genre` VALUES ('Action','Adults',90),('Adventure','Adults',90),('Racing','All Ages',43),('Role-Play','Teenagers',124),('RPG','Teenagers',201),('Simulation','All Ages',36),('Strategy','Adults',78);
/*!40000 ALTER TABLE `genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `multiplayergamesbydeveloper`
--

DROP TABLE IF EXISTS `multiplayergamesbydeveloper`;
/*!50001 DROP VIEW IF EXISTS `multiplayergamesbydeveloper`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `multiplayergamesbydeveloper` AS SELECT 
 1 AS `game_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `platform`
--

DROP TABLE IF EXISTS `platform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `platform` (
  `platform_id` int NOT NULL AUTO_INCREMENT,
  `platform_name` varchar(20) NOT NULL,
  PRIMARY KEY (`platform_id`),
  KEY `platform_name` (`platform_name`),
  CONSTRAINT `platform_ibfk_1` FOREIGN KEY (`platform_name`) REFERENCES `platform_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=21902 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `platform`
--

LOCK TABLES `platform` WRITE;
/*!40000 ALTER TABLE `platform` DISABLE KEYS */;
INSERT INTO `platform` VALUES (340,'Alienware'),(509,'DELL'),(871,'HP'),(7845,'Nintendo Switch'),(21901,'Play Station 5'),(10432,'Xbox One'),(3242,'Xbox X');
/*!40000 ALTER TABLE `platform` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `platform_name`
--

DROP TABLE IF EXISTS `platform_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `platform_name` (
  `name` varchar(20) NOT NULL,
  `type` enum('Console','PC') NOT NULL,
  `operating_system` varchar(15) NOT NULL,
  PRIMARY KEY (`name`),
  CONSTRAINT `platform_name_chk_1` CHECK ((`type` in (_utf8mb4'Console',_utf8mb4'PC'))),
  CONSTRAINT `platform_name_chk_2` CHECK ((`operating_system` in (_utf8mb4'Windows 10',_utf8mb4'Windows 11',_utf8mb4'Xbox OS',_utf8mb4'Orbis OS',_utf8mb4'Nintendo OS')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `platform_name`
--

LOCK TABLES `platform_name` WRITE;
/*!40000 ALTER TABLE `platform_name` DISABLE KEYS */;
INSERT INTO `platform_name` VALUES ('Alienware','PC','Windows 10'),('DELL','PC','Windows 11'),('HP','PC','Windows 11'),('Nintendo Switch','Console','Nintendo OS'),('Play Station 5','Console','Orbis OS'),('Xbox One','Console','Xbox OS'),('Xbox X','Console','Xbox OS');
/*!40000 ALTER TABLE `platform_name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player`
--

DROP TABLE IF EXISTS `player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player` (
  `player_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `email` varchar(30) NOT NULL,
  `total_playtime` int DEFAULT '0',
  `achievement_points` int DEFAULT '0',
  `ban_status` tinyint(1) DEFAULT '0',
  `last_login` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`player_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  CONSTRAINT `player_chk_1` CHECK ((`total_playtime` >= 0)),
  CONSTRAINT `player_chk_2` CHECK ((`achievement_points` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=1757 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player`
--

LOCK TABLES `player` WRITE;
/*!40000 ALTER TABLE `player` DISABLE KEYS */;
INSERT INTO `player` VALUES (9,'ninjaGirl','ninja@example.com',400,2500,0,'2024-11-10 23:05:00'),(56,'stormrage','stormrage@example.com',90,500,1,'2023-10-05 15:30:00'),(99,'termin43','ionsal1995@example.com',123,1008,0,'2023-12-29 18:36:03'),(123,'gourouAE','konst.wert@example.com',48,12,1,'2022-07-04 10:32:09'),(288,'dragonKing','doragon@example.com',150,1200,0,'2024-08-01 12:47:00'),(555,'masterdrag','jhnrot@example.com',987,4089,1,'2024-11-15 22:38:55'),(1756,'littleenem','katke.23@example.com',350,2002,0,'2024-10-27 13:42:59');
/*!40000 ALTER TABLE `player` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `remove_wishlist_on_player_delete` AFTER DELETE ON `player` FOR EACH ROW BEGIN 
	DELETE FROM wishlist WHERE player_id = OLD.player_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `player_owns_game`
--

DROP TABLE IF EXISTS `player_owns_game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player_owns_game` (
  `player_id` int NOT NULL,
  `game_id` int NOT NULL,
  `last_played` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`player_id`,`game_id`),
  KEY `game_id` (`game_id`),
  CONSTRAINT `player_owns_game_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `player` (`player_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `player_owns_game_ibfk_2` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_owns_game`
--

LOCK TABLES `player_owns_game` WRITE;
/*!40000 ALTER TABLE `player_owns_game` DISABLE KEYS */;
INSERT INTO `player_owns_game` VALUES (9,8734,'2024-11-09 20:45:00'),(56,1305,'2023-11-01 15:30:00'),(99,8743,'2023-12-28 18:40:00'),(123,3125,'2022-07-05 12:00:00'),(288,7123,'2024-07-31 10:15:00'),(555,8392,'2024-11-14 19:25:00'),(1756,9021,'2024-10-26 14:00:00');
/*!40000 ALTER TABLE `player_owns_game` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_player_total_playtime` AFTER UPDATE ON `player_owns_game` FOR EACH ROW BEGIN
    DECLARE playtime_increment INT;
    SET playtime_increment = TIMESTAMPDIFF(HOUR, OLD.last_played, NEW.last_played);
    
    UPDATE player
    SET total_playtime = total_playtime + playtime_increment
    WHERE player_id = NEW.player_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `player_unlocks_achievement`
--

DROP TABLE IF EXISTS `player_unlocks_achievement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player_unlocks_achievement` (
  `player_id` int NOT NULL,
  `achievement_id` int NOT NULL,
  PRIMARY KEY (`player_id`,`achievement_id`),
  KEY `achievement_id` (`achievement_id`),
  CONSTRAINT `player_unlocks_achievement_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `player` (`player_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `player_unlocks_achievement_ibfk_2` FOREIGN KEY (`achievement_id`) REFERENCES `achievement` (`achievement_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_unlocks_achievement`
--

LOCK TABLES `player_unlocks_achievement` WRITE;
/*!40000 ALTER TABLE `player_unlocks_achievement` DISABLE KEYS */;
INSERT INTO `player_unlocks_achievement` VALUES (99,5),(56,48),(123,103),(9,496),(288,629),(555,1988),(1756,4021);
/*!40000 ALTER TABLE `player_unlocks_achievement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `review_id` int NOT NULL AUTO_INCREMENT,
  `rating` decimal(3,2) DEFAULT '0.00',
  `comment` text,
  `publication_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `player_id` int NOT NULL,
  PRIMARY KEY (`review_id`),
  KEY `player_id` (`player_id`),
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `player` (`player_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `review_chk_1` CHECK (((`rating` >= 0.00) and (`rating` <= 5.00)))
) ENGINE=InnoDB AUTO_INCREMENT=5934 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (34,2.50,'Το gameplay είναι καλό, αλλά έχει αρκετά bugs.','2021-03-25 00:00:00',56),(85,4.80,'Το καλύτερο Battle Royale που έχω παίξει!','2024-11-30 00:00:00',123),(250,4.90,'Φοβερό παιχνίδι, αξίζει τα χρήματά του!','2023-02-15 00:00:00',9),(325,5.00,'Η ιστορία με καθήλωσε!','2020-07-24 00:00:00',1756),(1024,4.50,'Co-op mode με φίλους είναι ό,τι καλύτερο.','2022-03-18 00:00:00',555),(2001,2.00,'To matchmaking είναι άδικο και οι servers lagάρουν.','2024-12-01 00:00:00',99),(5933,1.50,'Pay-to-win μηχανισμοί παντού.','2020-10-05 00:00:00',288);
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `reviewsfordevelopergames`
--

DROP TABLE IF EXISTS `reviewsfordevelopergames`;
/*!50001 DROP VIEW IF EXISTS `reviewsfordevelopergames`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `reviewsfordevelopergames` AS SELECT 
 1 AS `player_id`,
 1 AS `game_id`,
 1 AS `rating`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `totaldlcsperplayer`
--

DROP TABLE IF EXISTS `totaldlcsperplayer`;
/*!50001 DROP VIEW IF EXISTS `totaldlcsperplayer`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `totaldlcsperplayer` AS SELECT 
 1 AS `game_id`,
 1 AS `TotalDLCs`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `totalgamesperplayer`
--

DROP TABLE IF EXISTS `totalgamesperplayer`;
/*!50001 DROP VIEW IF EXISTS `totalgamesperplayer`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `totalgamesperplayer` AS SELECT 
 1 AS `player_id`,
 1 AS `TotalGames`,
 1 AS `game_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction` (
  `transaction_id` int NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `transaction_amount` decimal(6,2) DEFAULT '0.00',
  `payment_method` varchar(15) DEFAULT NULL,
  `player_id` int NOT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `player_id` (`player_id`),
  CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `player` (`player_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `transaction_chk_1` CHECK ((`transaction_amount` >= 0.00)),
  CONSTRAINT `transaction_chk_2` CHECK ((`payment_method` in (_utf8mb4'Credit Card',_utf8mb4'PayPal',_utf8mb4'PaySafe')))
) ENGINE=InnoDB AUTO_INCREMENT=8944 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (984,'2020-09-30',67.21,'Credit Card',123),(1284,'2022-10-23',76.42,'PayPal',555),(1290,'2023-05-17',45.67,'Credit Card',9),(2312,'2023-10-29',91.87,'PayPal',56),(3223,'2023-12-27',12.85,'Credit Card',555),(3241,'2024-03-12',98.54,'PaySafe',56),(8943,'2024-08-30',34.54,'PaySafe',9);
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `set_default_date5` BEFORE INSERT ON `transaction` FOR EACH ROW BEGIN
	IF NEW.date IS NULL THEN
		SET NEW.date = CURDATE();
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `unlockedachievements`
--

DROP TABLE IF EXISTS `unlockedachievements`;
/*!50001 DROP VIEW IF EXISTS `unlockedachievements`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `unlockedachievements` AS SELECT 
 1 AS `username`,
 1 AS `title`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `wishlist`
--

DROP TABLE IF EXISTS `wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishlist` (
  `wishlist_id` int NOT NULL AUTO_INCREMENT,
  `date_of_addition` date DEFAULT NULL,
  `item_count` int DEFAULT NULL,
  `player_id` int NOT NULL,
  PRIMARY KEY (`wishlist_id`),
  KEY `player_id` (`player_id`),
  CONSTRAINT `wishlist_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `player` (`player_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `wishlist_chk_1` CHECK ((`item_count` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=56790 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlist`
--

LOCK TABLES `wishlist` WRITE;
/*!40000 ALTER TABLE `wishlist` DISABLE KEYS */;
INSERT INTO `wishlist` VALUES (12120,'2021-02-13',25,288),(12345,'2024-10-23',2,56),(21312,'2024-03-24',12,555),(23500,'2023-09-09',8,9),(43560,'2023-12-15',3,1756),(55668,'2022-06-07',9,99),(56789,'2023-09-09',1,123);
/*!40000 ALTER TABLE `wishlist` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `set_default_date2` BEFORE INSERT ON `wishlist` FOR EACH ROW BEGIN
	IF NEW.date_of_addition IS NULL THEN
		SET NEW.date_of_addition = CURDATE();
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `achievementsbygames`
--

/*!50001 DROP VIEW IF EXISTS `achievementsbygames`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `achievementsbygames` AS select `a`.`achievement_id` AS `achievement_id`,`b`.`game_id` AS `game_id`,`a`.`achievement_points` AS `achievement_points`,`a`.`title` AS `title` from (`achievement` `a` join `gamesbydeveloper` `b` on((`a`.`game_id` = `b`.`game_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `gameachievements`
--

/*!50001 DROP VIEW IF EXISTS `gameachievements`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `gameachievements` AS select `a`.`achievement_id` AS `achievement_id`,`a`.`title` AS `title` from (((`game` `g` join `player_owns_game` `b` on((`g`.`game_id` = `b`.`game_id`))) join `player_unlocks_achievement` `c` on((`b`.`player_id` = `c`.`player_id`))) join `achievement` `a` on((`c`.`achievement_id` = `a`.`achievement_id`))) where (`b`.`player_id` = 504) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `gamesbydeveloper`
--

/*!50001 DROP VIEW IF EXISTS `gamesbydeveloper`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `gamesbydeveloper` AS select `a`.`game_id` AS `game_id`,`a`.`title` AS `title` from ((`game` `a` join `game_createdby_developer` `b` on((`a`.`game_id` = `b`.`game_id`))) join `developer` `c` on((`b`.`developer_id` = `c`.`developer_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `multiplayergamesbydeveloper`
--

/*!50001 DROP VIEW IF EXISTS `multiplayergamesbydeveloper`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `multiplayergamesbydeveloper` AS select `a`.`game_id` AS `game_id` from (`game` `a` join `developer` `b` on((`a`.`developer_id` = `b`.`developer_id`))) where ((`b`.`developer_id` = 34556) and (`a`.`multiplayer_support` = 1)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `reviewsfordevelopergames`
--

/*!50001 DROP VIEW IF EXISTS `reviewsfordevelopergames`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `reviewsfordevelopergames` AS select `a`.`player_id` AS `player_id`,`c`.`game_id` AS `game_id`,`b`.`rating` AS `rating` from (((`player` `a` join `review` `b` on((`a`.`player_id` = `b`.`player_id`))) join `player_owns_game` `c` on((`a`.`player_id` = `c`.`player_id`))) join `multiplayergamesbydeveloper` `d` on((`c`.`game_id` = `d`.`game_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `totaldlcsperplayer`
--

/*!50001 DROP VIEW IF EXISTS `totaldlcsperplayer`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `totaldlcsperplayer` AS select `g`.`game_id` AS `game_id`,count(distinct `d`.`dlc_id`) AS `TotalDLCs` from (`game` `g` join `dlc` `d` on((`g`.`game_id` = `d`.`game_id`))) group by `g`.`game_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `totalgamesperplayer`
--

/*!50001 DROP VIEW IF EXISTS `totalgamesperplayer`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `totalgamesperplayer` AS select `a`.`player_id` AS `player_id`,count(distinct `c`.`game_id`) AS `TotalGames`,group_concat(distinct `b`.`game_id` separator ',') AS `game_id` from ((`player` `a` join `player_owns_game` `b` on((`a`.`player_id` = `b`.`player_id`))) join `game` `c` on((`b`.`game_id` = `c`.`game_id`))) group by `a`.`player_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `unlockedachievements`
--

/*!50001 DROP VIEW IF EXISTS `unlockedachievements`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `unlockedachievements` AS select `a`.`username` AS `username`,`c`.`title` AS `title` from ((`player` `a` join `player_unlocks_achievement` `b` on((`a`.`player_id` = `b`.`player_id`))) join `achievementsbygames` `c` on((`b`.`achievement_id` = `c`.`achievement_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-29 12:34:10
