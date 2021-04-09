CREATE DATABASE  IF NOT EXISTS `pokemon` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `pokemon`;
-- MySQL dump 10.13  Distrib 8.0.17, for Win64 (x86_64)
--
-- Host: localhost    Database: pokemon
-- ------------------------------------------------------
-- Server version	8.0.17

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
-- Table structure for table `battles`
--

DROP TABLE IF EXISTS `battles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `battles` (
  `battle_id` int(11) NOT NULL AUTO_INCREMENT,
  `trainer1` int(11) NOT NULL,
  `trainer2` int(11) NOT NULL,
  `winner` int(11) NOT NULL,
  `prize` int(11) NOT NULL,
  PRIMARY KEY (`battle_id`),
  KEY `trainer1` (`trainer1`),
  CONSTRAINT `battles_ibfk_1` FOREIGN KEY (`trainer1`) REFERENCES `trainer` (`trainer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `battles_ibfk_2` FOREIGN KEY (`trainer1`) REFERENCES `trainer` (`trainer_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `battles`
--

LOCK TABLES `battles` WRITE;
/*!40000 ALTER TABLE `battles` DISABLE KEYS */;
/*!40000 ALTER TABLE `battles` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `increment_trainer_money` AFTER INSERT ON `battles` FOR EACH ROW BEGIN
	UPDATE Trainer
	SET money = (money+NEW.prize)
	WHERE trainer_id = NEW.winner;
    UPDATE Trainer
	SET money = (money-NEW.prize)
	WHERE trainer_id = IF(NEW.winner = NEW.trainer1, trainer2, trainer1);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `capturedpokemon`
--

DROP TABLE IF EXISTS `capturedpokemon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `capturedpokemon` (
  `capt_pokemon_id` int(11) NOT NULL AUTO_INCREMENT,
  `pokemon_id` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  `nickname` varchar(50) NOT NULL,
  `trainer_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`capt_pokemon_id`),
  KEY `pokemon_id` (`pokemon_id`),
  KEY `trainer_id` (`trainer_id`),
  CONSTRAINT `capturedpokemon_ibfk_1` FOREIGN KEY (`pokemon_id`) REFERENCES `pokemon` (`pokemon_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `capturedpokemon_ibfk_2` FOREIGN KEY (`trainer_id`) REFERENCES `trainer` (`trainer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `capturedpokemon`
--

LOCK TABLES `capturedpokemon` WRITE;
/*!40000 ALTER TABLE `capturedpokemon` DISABLE KEYS */;
INSERT INTO `capturedpokemon` VALUES (1,1,5,'Bulbasaur',1),(2,4,5,'Charmander',2),(3,7,5,'Squirtle',3),(4,151,70,'Mewtwo',4),(5,31,70,'Nidoqueen',4),(6,34,70,'Nidoking',4);
/*!40000 ALTER TABLE `capturedpokemon` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `increment_trainer_pokemon` AFTER INSERT ON `capturedpokemon` FOR EACH ROW BEGIN
	UPDATE Trainer
	SET num_captured_pokemon = (num_captured_pokemon+1)
	WHERE trainer_id = NEW.trainer_id;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `deincrement_trainer_pokemon` BEFORE DELETE ON `capturedpokemon` FOR EACH ROW BEGIN
	UPDATE Trainer
	SET num_captured_pokemon = (num_captured_pokemon-1)
	WHERE trainer_id = OLD.trainer_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `evolutions`
--

DROP TABLE IF EXISTS `evolutions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evolutions` (
  `base_pokemon_id` int(11) NOT NULL,
  `evolved_pokemon_id` int(11) NOT NULL,
  PRIMARY KEY (`base_pokemon_id`,`evolved_pokemon_id`),
  KEY `evolved_pokemon_id` (`evolved_pokemon_id`),
  CONSTRAINT `evolutions_ibfk_1` FOREIGN KEY (`base_pokemon_id`) REFERENCES `pokemon` (`pokemon_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `evolutions_ibfk_2` FOREIGN KEY (`evolved_pokemon_id`) REFERENCES `pokemon` (`pokemon_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evolutions`
--

LOCK TABLES `evolutions` WRITE;
/*!40000 ALTER TABLE `evolutions` DISABLE KEYS */;
INSERT INTO `evolutions` VALUES (1,2),(2,3),(4,5),(5,6),(7,8),(8,9),(10,11),(11,12),(13,14),(14,15),(16,17),(17,18),(19,20),(21,22),(23,24),(172,25),(25,26),(27,28),(29,30),(30,31),(32,33),(33,34),(173,35),(35,36),(37,38),(174,39),(39,40),(41,42),(43,44),(44,45),(46,47),(48,49),(50,51),(52,53),(56,57),(58,59),(60,61),(61,62),(63,64),(64,65),(66,67),(67,68),(42,169),(44,182),(61,186);
/*!40000 ALTER TABLE `evolutions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `learnedmoves`
--

DROP TABLE IF EXISTS `learnedmoves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `learnedmoves` (
  `move_id` int(11) NOT NULL,
  `capt_pokemon_id` int(11) NOT NULL,
  PRIMARY KEY (`move_id`,`capt_pokemon_id`),
  KEY `capt_pokemon_id` (`capt_pokemon_id`),
  CONSTRAINT `learnedmoves_ibfk_1` FOREIGN KEY (`move_id`) REFERENCES `move` (`move_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `learnedmoves_ibfk_2` FOREIGN KEY (`capt_pokemon_id`) REFERENCES `capturedpokemon` (`capt_pokemon_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `learnedmoves`
--

LOCK TABLES `learnedmoves` WRITE;
/*!40000 ALTER TABLE `learnedmoves` DISABLE KEYS */;
INSERT INTO `learnedmoves` VALUES (33,1),(45,1),(10,2),(45,2),(33,3),(39,3),(94,4),(105,4),(133,4),(396,4),(30,5),(89,5),(224,5),(342,5),(30,6),(89,6),(224,6),(342,6);
/*!40000 ALTER TABLE `learnedmoves` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `move`
--

DROP TABLE IF EXISTS `move`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `move` (
  `move_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `type` int(11) NOT NULL,
  `power` int(11) DEFAULT NULL,
  `accuracy` int(11) DEFAULT NULL,
  `pp` int(11) NOT NULL,
  `category` varchar(20) NOT NULL,
  PRIMARY KEY (`move_id`),
  KEY `type` (`type`),
  CONSTRAINT `move_ibfk_1` FOREIGN KEY (`type`) REFERENCES `typing` (`type_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=729 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `move`
--

LOCK TABLES `move` WRITE;
/*!40000 ALTER TABLE `move` DISABLE KEYS */;
INSERT INTO `move` VALUES (1,'Pound',13,40,100,35,'Physical'),(2,'Karate Chop',6,50,100,25,'Physical'),(3,'Double Slap',13,15,85,10,'Physical'),(4,'Comet Punch',13,18,85,15,'Physical'),(5,'Mega Punch',13,80,85,20,'Physical'),(6,'Pay Day',13,40,100,20,'Physical'),(7,'Fire Punch',7,75,100,15,'Physical'),(8,'Ice Punch',12,75,100,15,'Physical'),(9,'Thunder Punch',4,75,100,15,'Physical'),(10,'Scratch',13,40,100,35,'Physical'),(11,'Vice Grip',13,55,100,30,'Physical'),(12,'Guillotine',13,NULL,NULL,5,'Physical'),(13,'Razor Wind',13,80,NULL,10,'Special'),(14,'Swords Dance',13,NULL,NULL,20,'Status'),(15,'Cut',13,50,95,30,'Physical'),(16,'Gust',8,40,100,35,'Special'),(17,'Wing Attack',8,60,100,35,'Physical'),(18,'Whirlwind',13,NULL,NULL,20,'Status'),(19,'Fly',8,90,95,15,'Physical'),(20,'Bind',13,15,NULL,20,'Physical'),(21,'Slam',13,80,75,20,'Physical'),(22,'Vine Whip',10,45,100,25,'Physical'),(23,'Stomp',13,65,100,20,'Physical'),(24,'Double Kick',6,30,100,30,'Physical'),(25,'Mega Kick',13,120,75,5,'Physical'),(26,'Jump Kick',6,100,95,10,'Physical'),(27,'Rolling Kick',6,60,85,15,'Physical'),(28,'Sand Attack',9,NULL,100,15,'Status'),(29,'Headbutt',13,70,100,15,'Physical'),(30,'Horn Attack',13,65,100,25,'Physical'),(31,'Fury Attack',13,15,85,20,'Physical'),(32,'Horn Drill',13,NULL,NULL,5,'Physical'),(33,'Tackle',13,40,NULL,35,'Physical'),(34,'Body Slam',13,85,100,15,'Physical'),(35,'Wrap',13,15,NULL,20,'Physical'),(36,'Take Down',13,90,85,20,'Physical'),(37,'Thrash',13,120,100,10,'Physical'),(38,'Double-Edge',13,120,100,15,'Physical'),(39,'Tail Whip',13,NULL,100,30,'Status'),(40,'Poison Sting',14,15,100,35,'Physical'),(41,'Twineedle',1,25,100,20,'Physical'),(42,'Pin Missile',1,25,NULL,20,'Physical'),(43,'Leer',13,NULL,100,30,'Status'),(44,'Bite',2,60,100,25,'Physical'),(45,'Growl',13,NULL,100,40,'Status'),(46,'Roar',13,NULL,NULL,20,'Status'),(47,'Sing',13,NULL,55,15,'Status'),(48,'Supersonic',13,NULL,55,20,'Status'),(49,'Sonic Boom',13,NULL,90,20,'Special'),(50,'Disable',13,NULL,NULL,20,'Status'),(51,'Acid',14,40,100,30,'Special'),(52,'Ember',7,40,100,25,'Special'),(53,'Flamethrower',7,90,100,15,'Special'),(54,'Mist',12,NULL,NULL,30,'Status'),(55,'Water Gun',15,40,100,25,'Special'),(56,'Hydro Pump',15,110,80,5,'Special'),(57,'Surf',15,90,100,15,'Special'),(58,'Ice Beam',12,90,100,10,'Special'),(59,'Blizzard',12,110,NULL,5,'Special'),(60,'Psybeam',16,65,100,20,'Special'),(61,'Bubble Beam',15,65,100,20,'Special'),(62,'Aurora Beam',12,65,100,20,'Special'),(63,'Hyper Beam',13,150,90,5,'Special'),(64,'Peck',8,35,100,35,'Physical'),(65,'Drill Peck',8,80,100,20,'Physical'),(66,'Submission',6,80,80,20,'Physical'),(67,'Low Kick',6,NULL,NULL,20,'Physical'),(68,'Counter',6,NULL,100,20,'Physical'),(69,'Seismic Toss',6,NULL,100,20,'Physical'),(70,'Strength',13,80,100,15,'Physical'),(71,'Absorb',10,20,100,25,'Special'),(72,'Mega Drain',10,40,100,15,'Special'),(73,'Leech Seed',10,NULL,90,10,'Status'),(74,'Growth',13,NULL,NULL,20,'Status'),(75,'Razor Leaf',10,55,95,25,'Physical'),(76,'Solar Beam',10,120,100,10,'Special'),(77,'Poison Powder',14,NULL,75,35,'Status'),(78,'Stun Spore',10,NULL,75,30,'Status'),(79,'Sleep Powder',10,NULL,75,15,'Status'),(80,'Petal Dance',10,120,100,10,'Special'),(81,'String Shot',1,NULL,95,40,'Status'),(82,'Dragon Rage',3,NULL,100,10,'Special'),(83,'Fire Spin',7,35,NULL,15,'Special'),(84,'Thunder Shock',4,40,100,30,'Special'),(85,'Thunderbolt',4,90,100,15,'Special'),(86,'Thunder Wave',4,NULL,NULL,20,'Status'),(87,'Thunder',4,110,70,10,'Special'),(88,'Rock Throw',17,50,NULL,15,'Physical'),(89,'Earthquake',9,100,100,10,'Physical'),(90,'Fissure',9,NULL,NULL,5,'Physical'),(91,'Dig',9,80,100,10,'Physical'),(92,'Toxic',14,NULL,NULL,10,'Status'),(93,'Confusion',16,50,100,25,'Special'),(94,'Psychic',16,90,100,10,'Special'),(95,'Hypnosis',16,NULL,NULL,20,'Status'),(96,'Meditate',16,NULL,NULL,40,'Status'),(97,'Agility',16,NULL,NULL,30,'Status'),(98,'Quick Attack',13,40,100,30,'Physical'),(99,'Rage',13,20,100,20,'Physical'),(100,'Teleport',16,NULL,NULL,20,'Status'),(101,'Night Shade',11,NULL,100,15,'Special'),(102,'Mimic',13,NULL,NULL,10,'Status'),(103,'Screech',13,NULL,85,40,'Status'),(104,'Double Team',13,NULL,NULL,15,'Status'),(105,'Recover',13,NULL,NULL,10,'Status'),(106,'Harden',13,NULL,NULL,30,'Status'),(107,'Minimize',13,NULL,NULL,10,'Status'),(108,'Smokescreen',13,NULL,100,20,'Status'),(109,'Confuse Ray',11,NULL,100,10,'Status'),(110,'Withdraw',15,NULL,NULL,40,'Status'),(111,'Defense Curl',13,NULL,NULL,40,'Status'),(112,'Barrier',16,NULL,NULL,20,'Status'),(113,'Light Screen',16,NULL,NULL,30,'Status'),(114,'Haze',12,NULL,NULL,30,'Status'),(115,'Reflect',16,NULL,NULL,20,'Status'),(116,'Focus Energy',13,NULL,NULL,30,'Status'),(117,'Bide',13,NULL,NULL,10,'Physical'),(118,'Metronome',13,NULL,NULL,10,'Status'),(119,'Mirror Move',8,NULL,NULL,20,'Status'),(120,'Self-Destruct',13,200,100,5,'Physical'),(121,'Egg Bomb',13,100,75,10,'Physical'),(122,'Lick',11,30,100,30,'Physical'),(123,'Smog',14,30,70,20,'Special'),(124,'Sludge',14,65,100,20,'Special'),(125,'Bone Club',9,65,85,20,'Physical'),(126,'Fire Blast',7,110,85,5,'Special'),(127,'Waterfall',15,80,100,15,'Physical'),(128,'Clamp',15,35,NULL,15,'Physical'),(129,'Swift',13,60,NULL,20,'Special'),(130,'Skull Bash',13,130,100,10,'Physical'),(131,'Spike Cannon',13,20,100,15,'Physical'),(132,'Constrict',13,10,100,35,'Physical'),(133,'Amnesia',16,NULL,NULL,20,'Status'),(134,'Kinesis',16,NULL,80,15,'Status'),(135,'Soft-Boiled',13,NULL,NULL,10,'Status'),(136,'High Jump Kick',6,130,90,10,'Physical'),(137,'Glare',13,NULL,NULL,30,'Status'),(138,'Dream Eater',16,100,100,15,'Special'),(139,'Poison Gas',14,NULL,NULL,40,'Status'),(140,'Barrage',13,15,85,20,'Physical'),(141,'Leech Life',1,80,100,10,'Physical'),(142,'Lovely Kiss',13,NULL,75,10,'Status'),(143,'Sky Attack',8,140,90,5,'Physical'),(144,'Transform',13,NULL,NULL,10,'Status'),(145,'Bubble',15,40,100,30,'Special'),(146,'Dizzy Punch',13,70,100,10,'Physical'),(147,'Spore',10,NULL,100,15,'Status'),(148,'Flash',13,NULL,NULL,20,'Status'),(149,'Psywave',16,NULL,NULL,15,'Special'),(150,'Splash',13,NULL,NULL,40,'Status'),(151,'Acid Armor',14,NULL,NULL,20,'Status'),(152,'Crabhammer',15,100,NULL,10,'Physical'),(153,'Explosion',13,250,100,5,'Physical'),(154,'Fury Swipes',13,18,80,15,'Physical'),(155,'Bonemerang',9,50,90,10,'Physical'),(156,'Rest',16,NULL,NULL,10,'Status'),(157,'Rock Slide',17,75,90,10,'Physical'),(158,'Hyper Fang',13,80,90,15,'Physical'),(159,'Sharpen',13,NULL,NULL,30,'Status'),(160,'Conversion',13,NULL,NULL,30,'Status'),(161,'Tri Attack',13,80,100,10,'Special'),(162,'Super Fang',13,NULL,90,10,'Physical'),(163,'Slash',13,70,100,20,'Physical'),(164,'Substitute',13,NULL,NULL,10,'Status'),(165,'Struggle',13,50,NULL,1,'Physical'),(166,'Sketch',13,NULL,NULL,1,'Status'),(167,'Triple Kick',6,10,90,10,'Physical'),(168,'Thief',2,60,100,25,'Physical'),(169,'Spider Web',1,NULL,NULL,10,'Status'),(170,'Mind Reader',13,NULL,NULL,5,'Status'),(171,'Nightmare',11,NULL,100,15,'Status'),(172,'Flame Wheel',7,60,100,25,'Physical'),(173,'Snore',13,50,100,15,'Special'),(174,'Curse',11,NULL,NULL,10,'Status'),(175,'Flail',13,NULL,100,15,'Physical'),(176,'Conversion 2',13,NULL,NULL,30,'Status'),(177,'Aeroblast',8,100,95,5,'Special'),(178,'Cotton Spore',10,NULL,NULL,40,'Status'),(179,'Reversal',6,NULL,100,15,'Physical'),(180,'Spite',11,NULL,100,10,'Status'),(181,'Powder Snow',12,40,100,25,'Special'),(182,'Protect',13,NULL,NULL,10,'Status'),(183,'Mach Punch',6,40,100,30,'Physical'),(184,'Scary Face',13,NULL,NULL,10,'Status'),(185,'Feint Attack',2,60,NULL,20,'Physical'),(186,'Sweet Kiss',5,NULL,75,10,'Status'),(187,'Belly Drum',13,NULL,NULL,10,'Status'),(188,'Sludge Bomb',14,90,100,10,'Special'),(189,'Mud-Slap',9,20,100,10,'Special'),(190,'Octazooka',15,65,85,10,'Special'),(191,'Spikes',9,NULL,NULL,20,'Status'),(192,'Zap Cannon',4,120,50,5,'Special'),(193,'Foresight',13,NULL,NULL,40,'Status'),(194,'Destiny Bond',11,NULL,NULL,5,'Status'),(195,'Perish Song',13,NULL,NULL,5,'Status'),(196,'Icy Wind',12,55,95,15,'Special'),(197,'Detect',6,NULL,NULL,5,'Status'),(198,'Bone Rush',9,25,NULL,10,'Physical'),(199,'Lock-On',13,NULL,NULL,5,'Status'),(200,'Outrage',3,120,100,10,'Physical'),(201,'Sandstorm',17,NULL,NULL,10,'Status'),(202,'Giga Drain',10,75,100,10,'Special'),(203,'Endure',13,NULL,NULL,10,'Status'),(204,'Charm',5,NULL,100,20,'Status'),(205,'Rollout',17,30,90,20,'Physical'),(206,'False Swipe',13,40,100,40,'Physical'),(207,'Swagger',13,NULL,NULL,15,'Status'),(208,'Milk Drink',13,NULL,NULL,10,'Status'),(209,'Spark',4,65,100,20,'Physical'),(210,'Fury Cutter',1,40,95,20,'Physical'),(211,'Steel Wing',18,70,90,25,'Physical'),(212,'Mean Look',13,NULL,NULL,5,'Status'),(213,'Attract',13,NULL,100,15,'Status'),(214,'Sleep Talk',13,NULL,NULL,10,'Status'),(215,'Heal Bell',13,NULL,NULL,5,'Status'),(216,'Return',13,NULL,100,20,'Physical'),(217,'Present',13,NULL,90,15,'Physical'),(218,'Frustration',13,NULL,100,20,'Physical'),(219,'Safeguard',13,NULL,NULL,25,'Status'),(220,'Pain Split',13,NULL,NULL,20,'Status'),(221,'Sacred Fire',7,100,95,5,'Physical'),(222,'Magnitude',9,NULL,100,30,'Physical'),(223,'Dynamic Punch',6,100,50,5,'Physical'),(224,'Megahorn',1,120,85,10,'Physical'),(225,'Dragon Breath',3,60,100,20,'Special'),(226,'Baton Pass',13,NULL,NULL,40,'Status'),(227,'Encore',13,NULL,100,5,'Status'),(228,'Pursuit',2,40,100,20,'Physical'),(229,'Rapid Spin',13,20,100,40,'Physical'),(230,'Sweet Scent',13,NULL,100,20,'Status'),(231,'Iron Tail',18,100,75,15,'Physical'),(232,'Metal Claw',18,50,95,35,'Physical'),(233,'Vital Throw',6,70,NULL,10,'Physical'),(234,'Morning Sun',13,NULL,NULL,5,'Status'),(235,'Synthesis',10,NULL,NULL,5,'Status'),(236,'Moonlight',5,NULL,NULL,5,'Status'),(237,'Hidden Power',13,60,100,15,'Special'),(238,'Cross Chop',6,100,80,5,'Physical'),(239,'Twister',3,40,100,20,'Special'),(240,'Rain Dance',15,NULL,NULL,5,'Status'),(241,'Sunny Day',7,NULL,NULL,5,'Status'),(242,'Crunch',2,80,100,15,'Physical'),(243,'Mirror Coat',16,NULL,100,20,'Special'),(244,'Psych Up',13,NULL,NULL,10,'Status'),(245,'Extreme Speed',13,80,100,5,'Physical'),(246,'Ancient Power',17,60,100,5,'Special'),(247,'Shadow Ball',11,80,100,15,'Special'),(248,'Future Sight',16,120,NULL,10,'Special'),(249,'Rock Smash',6,40,100,15,'Physical'),(250,'Whirlpool',15,35,NULL,15,'Special'),(251,'Beat Up',2,NULL,100,10,'Physical'),(252,'Fake Out',13,40,100,10,'Physical'),(253,'Uproar',13,90,100,10,'Special'),(254,'Stockpile',13,NULL,NULL,20,'Status'),(255,'Spit Up',13,NULL,100,10,'Special'),(256,'Swallow',13,NULL,NULL,10,'Status'),(257,'Heat Wave',7,95,90,10,'Special'),(258,'Hail',12,NULL,NULL,10,'Status'),(259,'Torment',2,NULL,100,15,'Status'),(260,'Flatter',2,NULL,100,15,'Status'),(261,'Will-O-Wisp',7,NULL,NULL,15,'Status'),(262,'Memento',2,NULL,100,10,'Status'),(263,'Facade',13,70,100,20,'Physical'),(264,'Focus Punch',6,150,100,20,'Physical'),(265,'Smelling Salts',13,70,100,10,'Physical'),(266,'Follow Me',13,NULL,NULL,20,'Status'),(267,'Nature Power',13,NULL,NULL,20,'Status'),(268,'Charge',4,NULL,NULL,20,'Status'),(269,'Taunt',2,NULL,100,20,'Status'),(270,'Helping Hand',13,NULL,NULL,20,'Status'),(271,'Trick',16,NULL,100,10,'Status'),(272,'Role Play',16,NULL,NULL,10,'Status'),(273,'Wish',13,NULL,NULL,10,'Status'),(274,'Assist',13,NULL,NULL,20,'Status'),(275,'Ingrain',10,NULL,NULL,20,'Status'),(276,'Superpower',6,120,100,5,'Physical'),(277,'Magic Coat',16,NULL,NULL,15,'Status'),(278,'Recycle',13,NULL,NULL,10,'Status'),(279,'Revenge',6,60,100,10,'Physical'),(280,'Brick Break',6,75,100,15,'Physical'),(281,'Yawn',13,NULL,NULL,10,'Status'),(282,'Knock Off',2,65,100,20,'Physical'),(283,'Endeavor',13,NULL,100,5,'Physical'),(284,'Eruption',7,150,100,5,'Special'),(285,'Skill Swap',16,NULL,NULL,10,'Status'),(286,'Imprison',16,NULL,NULL,10,'Status'),(287,'Refresh',13,NULL,NULL,20,'Status'),(288,'Grudge',11,NULL,NULL,5,'Status'),(289,'Snatch',2,NULL,NULL,10,'Status'),(290,'Secret Power',13,70,100,20,'Physical'),(291,'Dive',15,80,100,10,'Physical'),(292,'Arm Thrust',6,15,100,20,'Physical'),(293,'Camouflage',13,NULL,NULL,20,'Status'),(294,'Tail Glow',1,NULL,NULL,20,'Status'),(295,'Luster Purge',16,70,100,5,'Special'),(296,'Mist Ball',16,70,100,5,'Special'),(297,'Feather Dance',8,NULL,100,15,'Status'),(298,'Teeter Dance',13,NULL,100,20,'Status'),(299,'Blaze Kick',7,85,90,10,'Physical'),(300,'Mud Sport',9,NULL,NULL,15,'Status'),(301,'Ice Ball',12,30,90,20,'Physical'),(302,'Needle Arm',10,60,100,15,'Physical'),(303,'Slack Off',13,NULL,NULL,10,'Status'),(304,'Hyper Voice',13,90,100,10,'Special'),(305,'Poison Fang',14,50,100,15,'Physical'),(306,'Crush Claw',13,75,95,10,'Physical'),(307,'Blast Burn',7,150,90,5,'Special'),(308,'Hydro Cannon',15,150,90,5,'Special'),(309,'Meteor Mash',18,90,NULL,10,'Physical'),(310,'Astonish',11,30,100,15,'Physical'),(311,'Weather Ball',13,50,100,10,'Special'),(312,'Aromatherapy',10,NULL,NULL,5,'Status'),(313,'Fake Tears',2,NULL,100,20,'Status'),(314,'Air Cutter',8,60,95,25,'Special'),(315,'Overheat',7,130,90,5,'Special'),(316,'Odor Sleuth',13,NULL,NULL,40,'Status'),(317,'Rock Tomb',17,60,NULL,15,'Physical'),(318,'Silver Wind',1,60,100,5,'Special'),(319,'Metal Sound',18,NULL,85,40,'Status'),(320,'Grass Whistle',10,NULL,55,15,'Status'),(321,'Tickle',13,NULL,100,20,'Status'),(322,'Cosmic Power',16,NULL,NULL,20,'Status'),(323,'Water Spout',15,150,100,5,'Special'),(324,'Signal Beam',1,75,100,15,'Special'),(325,'Shadow Punch',11,60,NULL,20,'Physical'),(326,'Extrasensory',16,80,100,20,'Special'),(327,'Sky Uppercut',6,85,90,15,'Physical'),(328,'Sand Tomb',9,35,NULL,15,'Physical'),(329,'Sheer Cold',12,NULL,NULL,5,'Special'),(330,'Muddy Water',15,90,85,10,'Special'),(331,'Bullet Seed',10,25,100,30,'Physical'),(332,'Aerial Ace',8,60,NULL,20,'Physical'),(333,'Icicle Spear',12,25,100,30,'Physical'),(334,'Iron Defense',18,NULL,NULL,15,'Status'),(335,'Block',13,NULL,NULL,5,'Status'),(336,'Howl',13,NULL,NULL,40,'Status'),(337,'Dragon Claw',3,80,100,15,'Physical'),(338,'Frenzy Plant',10,150,90,5,'Special'),(339,'Bulk Up',6,NULL,NULL,20,'Status'),(340,'Bounce',8,85,85,5,'Physical'),(341,'Mud Shot',9,55,95,15,'Special'),(342,'Poison Tail',14,50,100,25,'Physical'),(343,'Covet',13,60,100,25,'Physical'),(344,'Volt Tackle',4,120,100,15,'Physical'),(345,'Magical Leaf',10,60,NULL,20,'Special'),(346,'Water Sport',15,NULL,NULL,15,'Status'),(347,'Calm Mind',16,NULL,NULL,20,'Status'),(348,'Leaf Blade',10,90,100,15,'Physical'),(349,'Dragon Dance',3,NULL,NULL,20,'Status'),(350,'Rock Blast',17,25,NULL,10,'Physical'),(351,'Shock Wave',4,60,NULL,20,'Special'),(352,'Water Pulse',15,60,100,20,'Special'),(353,'Doom Desire',18,140,NULL,5,'Special'),(354,'Psycho Boost',16,140,90,5,'Special'),(355,'Roost',8,NULL,NULL,10,'Status'),(356,'Gravity',16,NULL,NULL,5,'Status'),(357,'Miracle Eye',16,NULL,NULL,40,'Status'),(358,'Wake-Up Slap',6,70,100,10,'Physical'),(359,'Hammer Arm',6,100,90,10,'Physical'),(360,'Gyro Ball',18,NULL,100,5,'Physical'),(361,'Healing Wish',16,NULL,NULL,10,'Status'),(362,'Brine',15,65,100,10,'Special'),(363,'Natural Gift',13,NULL,100,15,'Physical'),(364,'Feint',13,30,100,10,'Physical'),(365,'Pluck',8,60,100,20,'Physical'),(366,'Tailwind',8,NULL,NULL,15,'Status'),(367,'Acupressure',13,NULL,NULL,30,'Status'),(368,'Metal Burst',18,NULL,100,10,'Physical'),(369,'U-turn',1,70,100,20,'Physical'),(370,'Close Combat',6,120,100,5,'Physical'),(371,'Payback',2,50,100,10,'Physical'),(372,'Assurance',2,60,100,10,'Physical'),(373,'Embargo',2,NULL,100,15,'Status'),(374,'Fling',2,NULL,100,10,'Physical'),(375,'Psycho Shift',16,NULL,NULL,10,'Status'),(376,'Trump Card',13,NULL,NULL,5,'Special'),(377,'Heal Block',16,NULL,100,15,'Status'),(378,'Wring Out',13,NULL,100,5,'Special'),(379,'Power Trick',16,NULL,NULL,10,'Status'),(380,'Gastro Acid',14,NULL,100,10,'Status'),(381,'Lucky Chant',13,NULL,NULL,30,'Status'),(382,'Me First',13,NULL,NULL,20,'Status'),(383,'Copycat',13,NULL,NULL,20,'Status'),(384,'Power Swap',16,NULL,NULL,10,'Status'),(385,'Guard Swap',16,NULL,NULL,10,'Status'),(386,'Punishment',2,NULL,100,5,'Physical'),(387,'Last Resort',13,140,100,5,'Physical'),(388,'Worry Seed',10,NULL,100,10,'Status'),(389,'Sucker Punch',2,70,100,5,'Physical'),(390,'Toxic Spikes',14,NULL,NULL,20,'Status'),(391,'Heart Swap',16,NULL,NULL,10,'Status'),(392,'Aqua Ring',15,NULL,NULL,20,'Status'),(393,'Magnet Rise',4,NULL,NULL,10,'Status'),(394,'Flare Blitz',7,120,100,15,'Physical'),(395,'Force Palm',6,60,100,10,'Physical'),(396,'Aura Sphere',6,80,NULL,20,'Special'),(397,'Rock Polish',17,NULL,NULL,20,'Status'),(398,'Poison Jab',14,80,100,20,'Physical'),(399,'Dark Pulse',2,80,100,15,'Special'),(400,'Night Slash',2,70,100,15,'Physical'),(401,'Aqua Tail',15,90,90,10,'Physical'),(402,'Seed Bomb',10,80,100,15,'Physical'),(403,'Air Slash',8,75,95,15,'Special'),(404,'X-Scissor',1,80,100,15,'Physical'),(405,'Bug Buzz',1,90,100,10,'Special'),(406,'Dragon Pulse',3,85,100,10,'Special'),(407,'Dragon Rush',3,100,75,10,'Physical'),(408,'Power Gem',17,80,100,20,'Special'),(409,'Drain Punch',6,75,100,10,'Physical'),(410,'Vacuum Wave',6,40,100,30,'Special'),(411,'Focus Blast',6,120,70,5,'Special'),(412,'Energy Ball',10,90,100,10,'Special'),(413,'Brave Bird',8,120,100,15,'Physical'),(414,'Earth Power',9,90,100,10,'Special'),(415,'Switcheroo',2,NULL,100,10,'Status'),(416,'Giga Impact',13,150,90,5,'Physical'),(417,'Nasty Plot',2,NULL,NULL,20,'Status'),(418,'Bullet Punch',18,40,100,30,'Physical'),(419,'Avalanche',12,60,100,10,'Physical'),(420,'Ice Shard',12,40,100,30,'Physical'),(421,'Shadow Claw',11,70,100,15,'Physical'),(422,'Thunder Fang',4,65,95,15,'Physical'),(423,'Ice Fang',12,65,95,15,'Physical'),(424,'Fire Fang',7,65,95,15,'Physical'),(425,'Shadow Sneak',11,40,100,30,'Physical'),(426,'Mud Bomb',9,65,85,10,'Special'),(427,'Psycho Cut',16,70,100,20,'Physical'),(428,'Zen Headbutt',16,80,90,15,'Physical'),(429,'Mirror Shot',18,65,85,10,'Special'),(430,'Flash Cannon',18,80,100,10,'Special'),(431,'Rock Climb',13,90,85,20,'Physical'),(432,'Defog',8,NULL,NULL,15,'Status'),(433,'Trick Room',16,NULL,NULL,5,'Status'),(434,'Draco Meteor',3,130,90,5,'Special'),(435,'Discharge',4,80,100,15,'Special'),(436,'Lava Plume',7,80,100,15,'Special'),(437,'Leaf Storm',10,130,90,5,'Special'),(438,'Power Whip',10,120,85,10,'Physical'),(439,'Rock Wrecker',17,150,90,5,'Physical'),(440,'Cross Poison',14,70,100,20,'Physical'),(441,'Gunk Shot',14,120,NULL,5,'Physical'),(442,'Iron Head',18,80,100,15,'Physical'),(443,'Magnet Bomb',18,60,NULL,20,'Physical'),(444,'Stone Edge',17,100,80,5,'Physical'),(445,'Captivate',13,NULL,100,20,'Status'),(446,'Stealth Rock',17,NULL,NULL,20,'Status'),(447,'Grass Knot',10,NULL,100,20,'Special'),(448,'Chatter',8,65,100,20,'Special'),(449,'Judgment',13,100,100,10,'Special'),(450,'Bug Bite',1,60,100,20,'Physical'),(451,'Charge Beam',4,50,90,10,'Special'),(452,'Wood Hammer',10,120,100,15,'Physical'),(453,'Aqua Jet',15,40,100,20,'Physical'),(454,'Attack Order',1,90,100,15,'Physical'),(455,'Defend Order',1,NULL,NULL,10,'Status'),(456,'Heal Order',1,NULL,NULL,10,'Status'),(457,'Head Smash',17,150,80,5,'Physical'),(458,'Double Hit',13,35,90,10,'Physical'),(459,'Roar of Time',3,150,90,5,'Special'),(460,'Spacial Rend',3,100,95,5,'Special'),(461,'Lunar Dance',16,NULL,NULL,10,'Status'),(462,'Crush Grip',13,NULL,100,5,'Physical'),(463,'Magma Storm',7,100,NULL,5,'Special'),(464,'Dark Void',2,NULL,NULL,10,'Status'),(465,'Seed Flare',10,120,85,5,'Special'),(466,'Ominous Wind',11,60,100,5,'Special'),(467,'Shadow Force',11,120,100,5,'Physical'),(468,'Hone Claws',2,NULL,NULL,15,'Status'),(469,'Wide Guard',17,NULL,NULL,10,'Status'),(470,'Guard Split',16,NULL,NULL,10,'Status'),(471,'Power Split',16,NULL,NULL,10,'Status'),(472,'Wonder Room',16,NULL,NULL,10,'Status'),(473,'Psyshock',16,80,100,10,'Special'),(474,'Venoshock',14,65,100,10,'Special'),(475,'Autotomize',18,NULL,NULL,15,'Status'),(476,'Rage Powder',1,NULL,NULL,20,'Status'),(477,'Telekinesis',16,NULL,NULL,15,'Status'),(478,'Magic Room',16,NULL,NULL,10,'Status'),(479,'Smack Down',17,50,100,15,'Physical'),(480,'Storm Throw',6,60,100,10,'Physical'),(481,'Flame Burst',7,70,100,15,'Special'),(482,'Sludge Wave',14,95,100,10,'Special'),(483,'Quiver Dance',1,NULL,NULL,20,'Status'),(484,'Heavy Slam',18,NULL,100,10,'Physical'),(485,'Synchronoise',16,120,100,10,'Special'),(486,'Electro Ball',4,NULL,100,10,'Special'),(487,'Soak',15,NULL,100,20,'Status'),(488,'Flame Charge',7,50,100,20,'Physical'),(489,'Coil',14,NULL,NULL,20,'Status'),(490,'Low Sweep',6,65,100,20,'Physical'),(491,'Acid Spray',14,40,100,20,'Special'),(492,'Foul Play',2,95,100,15,'Physical'),(493,'Simple Beam',13,NULL,100,15,'Status'),(494,'Entrainment',13,NULL,100,15,'Status'),(495,'After You',13,NULL,NULL,15,'Status'),(496,'Round',13,60,100,15,'Special'),(497,'Echoed Voice',13,40,100,15,'Special'),(498,'Chip Away',13,70,100,20,'Physical'),(499,'Clear Smog',14,50,NULL,15,'Special'),(500,'Stored Power',16,20,100,10,'Special'),(501,'Quick Guard',6,NULL,NULL,15,'Status'),(502,'Ally Switch',16,NULL,NULL,15,'Status'),(503,'Scald',15,80,100,15,'Special'),(504,'Shell Smash',13,NULL,NULL,15,'Status'),(505,'Heal Pulse',16,NULL,NULL,10,'Status'),(506,'Hex',11,65,100,10,'Special'),(507,'Sky Drop',8,60,100,10,'Physical'),(508,'Shift Gear',18,NULL,NULL,10,'Status'),(509,'Circle Throw',6,60,90,10,'Physical'),(510,'Incinerate',7,60,100,15,'Special'),(511,'Quash',2,NULL,100,15,'Status'),(512,'Acrobatics',8,55,100,15,'Physical'),(513,'Reflect Type',13,NULL,NULL,15,'Status'),(514,'Retaliate',13,70,100,5,'Physical'),(515,'Final Gambit',6,NULL,100,5,'Special'),(516,'Bestow',13,NULL,NULL,15,'Status'),(517,'Inferno',7,100,50,5,'Special'),(518,'Water Pledge',15,80,100,10,'Special'),(519,'Fire Pledge',7,80,100,10,'Special'),(520,'Grass Pledge',10,80,100,10,'Special'),(521,'Volt Switch',4,70,100,20,'Special'),(522,'Struggle Bug',1,50,100,20,'Special'),(523,'Bulldoze',9,60,100,20,'Physical'),(524,'Frost Breath',12,60,90,10,'Special'),(525,'Dragon Tail',3,60,90,10,'Physical'),(526,'Work Up',13,NULL,NULL,30,'Status'),(527,'Electroweb',4,55,95,15,'Special'),(528,'Wild Charge',4,90,100,15,'Physical'),(529,'Drill Run',9,80,95,10,'Physical'),(530,'Dual Chop',3,40,90,15,'Physical'),(531,'Heart Stamp',16,60,100,25,'Physical'),(532,'Horn Leech',10,75,100,10,'Physical'),(533,'Sacred Sword',6,90,100,15,'Physical'),(534,'Razor Shell',15,75,95,10,'Physical'),(535,'Heat Crash',7,NULL,100,10,'Physical'),(536,'Leaf Tornado',10,65,90,10,'Special'),(537,'Steamroller',1,65,100,20,'Physical'),(538,'Cotton Guard',10,NULL,NULL,10,'Status'),(539,'Night Daze',2,85,95,10,'Special'),(540,'Psystrike',16,100,100,10,'Special'),(541,'Tail Slap',13,25,85,10,'Physical'),(542,'Hurricane',8,110,70,10,'Special'),(543,'Head Charge',13,120,100,15,'Physical'),(544,'Gear Grind',18,50,85,15,'Physical'),(545,'Searing Shot',7,100,100,5,'Special'),(546,'Techno Blast',13,120,100,5,'Special'),(547,'Relic Song',13,75,100,10,'Special'),(548,'Secret Sword',6,85,100,10,'Special'),(549,'Glaciate',12,65,95,10,'Special'),(550,'Bolt Strike',4,130,85,5,'Physical'),(551,'Blue Flare',7,130,85,5,'Special'),(552,'Fiery Dance',7,80,100,10,'Special'),(553,'Freeze Shock',12,140,90,5,'Physical'),(554,'Ice Burn',12,140,90,5,'Special'),(555,'Snarl',2,55,95,15,'Special'),(556,'Icicle Crash',12,85,90,10,'Physical'),(557,'V-create',7,180,95,5,'Physical'),(558,'Fusion Flare',7,100,100,5,'Special'),(559,'Fusion Bolt',4,100,100,5,'Physical'),(560,'Flying Press',6,100,95,10,'Physical'),(561,'Mat Block',6,NULL,NULL,10,'Status'),(562,'Belch',14,120,90,10,'Special'),(563,'Rototiller',9,NULL,NULL,10,'Status'),(564,'Sticky Web',1,NULL,NULL,20,'Status'),(565,'Fell Stinger',1,50,100,25,'Physical'),(566,'Phantom Force',11,90,100,10,'Physical'),(567,'Trick-or-Treat',11,NULL,100,20,'Status'),(568,'Noble Roar',13,NULL,100,30,'Status'),(569,'Ion Deluge',4,NULL,NULL,25,'Status'),(570,'Parabolic Charge',4,65,100,20,'Special'),(571,'Forest\'s Curse',10,NULL,100,20,'Status'),(572,'Petal Blizzard',10,90,100,15,'Physical'),(573,'Freeze-Dry',12,70,100,20,'Special'),(574,'Disarming Voice',5,40,NULL,15,'Special'),(575,'Parting Shot',2,NULL,100,20,'Status'),(576,'Topsy-Turvy',2,NULL,NULL,20,'Status'),(577,'Draining Kiss',5,50,100,10,'Special'),(578,'Crafty Shield',5,NULL,NULL,10,'Status'),(579,'Flower Shield',5,NULL,NULL,10,'Status'),(580,'Grassy Terrain',10,NULL,NULL,10,'Status'),(581,'Misty Terrain',5,NULL,NULL,10,'Status'),(582,'Electrify',4,NULL,NULL,20,'Status'),(583,'Play Rough',5,90,90,10,'Physical'),(584,'Fairy Wind',5,40,100,30,'Special'),(585,'Moonblast',5,95,100,15,'Special'),(586,'Boomburst',13,140,100,10,'Special'),(587,'Fairy Lock',5,NULL,NULL,10,'Status'),(588,'King\'s Shield',18,NULL,NULL,10,'Status'),(589,'Play Nice',13,NULL,NULL,20,'Status'),(590,'Confide',13,NULL,NULL,20,'Status'),(591,'Diamond Storm',17,100,95,5,'Physical'),(592,'Steam Eruption',15,110,95,5,'Special'),(593,'Hyperspace Hole',16,80,NULL,5,'Special'),(594,'Water Shuriken',15,15,100,20,'Special'),(595,'Mystical Fire',7,75,100,10,'Special'),(596,'Spiky Shield',10,NULL,NULL,10,'Status'),(597,'Aromatic Mist',5,NULL,NULL,20,'Status'),(598,'Eerie Impulse',4,NULL,100,15,'Status'),(599,'Venom Drench',14,NULL,100,20,'Status'),(600,'Powder',1,NULL,100,20,'Status'),(601,'Geomancy',5,NULL,NULL,10,'Status'),(602,'Magnetic Flux',4,NULL,NULL,20,'Status'),(603,'Happy Hour',13,NULL,NULL,30,'Status'),(604,'Electric Terrain',4,NULL,NULL,10,'Status'),(605,'Dazzling Gleam',5,80,100,10,'Special'),(606,'Celebrate',13,NULL,NULL,40,'Status'),(607,'Hold Hands',13,NULL,NULL,40,'Status'),(608,'Baby-Doll Eyes',5,NULL,100,30,'Status'),(609,'Nuzzle',4,20,100,20,'Physical'),(610,'Hold Back',13,40,100,40,'Physical'),(611,'Infestation',1,20,100,20,'Special'),(612,'Power-Up Punch',6,40,100,20,'Physical'),(613,'Oblivion Wing',8,80,100,10,'Special'),(614,'Thousand Arrows',9,90,100,10,'Physical'),(615,'Thousand Waves',9,90,100,10,'Physical'),(616,'Land\'s Wrath',9,90,100,10,'Physical'),(617,'Light of Ruin',5,140,90,5,'Special'),(618,'Origin Pulse',15,110,85,10,'Special'),(619,'Precipice Blades',9,120,85,10,'Physical'),(620,'Dragon Ascent',8,120,100,5,'Physical'),(621,'Hyperspace Fury',2,100,NULL,5,'Physical'),(622,'Breakneck Blitz',13,NULL,NULL,1,'Physical'),(623,'Breakneck Blitz',13,NULL,NULL,1,'Special'),(624,'All-Out Pummeling',6,NULL,NULL,1,'Physical'),(625,'All-Out Pummeling',6,NULL,NULL,1,'Special'),(626,'Supersonic Skystrike',8,NULL,NULL,1,'Physical'),(627,'Supersonic Skystrike',8,NULL,NULL,1,'Special'),(628,'Acid Downpour',14,NULL,NULL,1,'Physical'),(629,'Acid Downpour',14,NULL,NULL,1,'Special'),(630,'Tectonic Rage',9,NULL,NULL,1,'Physical'),(631,'Tectonic Rage',9,NULL,NULL,1,'Special'),(632,'Continental Crush',17,NULL,NULL,1,'Physical'),(633,'Continental Crush',17,NULL,NULL,1,'Special'),(634,'Savage Spin-Out',1,NULL,NULL,1,'Physical'),(635,'Savage Spin-Out',1,NULL,NULL,1,'Special'),(636,'Never-Ending Nightmare',11,NULL,NULL,1,'Physical'),(637,'Never-Ending Nightmare',11,NULL,NULL,1,'Special'),(638,'Corkscrew Crash',18,NULL,NULL,1,'Physical'),(639,'Corkscrew Crash',18,NULL,NULL,1,'Special'),(640,'Inferno Overdrive',7,NULL,NULL,1,'Physical'),(641,'Inferno Overdrive',7,NULL,NULL,1,'Special'),(642,'Hydro Vortex',15,NULL,NULL,1,'Physical'),(643,'Hydro Vortex',15,NULL,NULL,1,'Special'),(644,'Bloom Doom',10,NULL,NULL,1,'Physical'),(645,'Bloom Doom',10,NULL,NULL,1,'Special'),(646,'Gigavolt Havoc',4,NULL,NULL,1,'Physical'),(647,'Gigavolt Havoc',4,NULL,NULL,1,'Special'),(648,'Shattered Psyche',16,NULL,NULL,1,'Physical'),(649,'Shattered Psyche',16,NULL,NULL,1,'Special'),(650,'Subzero Slammer',12,NULL,NULL,1,'Physical'),(651,'Subzero Slammer',12,NULL,NULL,1,'Special'),(652,'Devastating Drake',3,NULL,NULL,1,'Physical'),(653,'Devastating Drake',3,NULL,NULL,1,'Special'),(654,'Black Hole Eclipse',2,NULL,NULL,1,'Physical'),(655,'Black Hole Eclipse',2,NULL,NULL,1,'Special'),(656,'Twinkle Tackle',5,NULL,NULL,1,'Physical'),(657,'Twinkle Tackle',5,NULL,NULL,1,'Special'),(658,'Catastropika',4,210,NULL,1,'Physical'),(659,'Shore Up',9,NULL,NULL,10,'Status'),(660,'First Impression',1,90,100,10,'Physical'),(661,'Baneful Bunker',14,NULL,NULL,10,'Status'),(662,'Spirit Shackle',11,80,100,10,'Physical'),(663,'Darkest Lariat',2,85,100,10,'Physical'),(664,'Sparkling Aria',15,90,100,10,'Special'),(665,'Ice Hammer',12,100,90,10,'Physical'),(666,'Floral Healing',5,NULL,NULL,10,'Status'),(667,'High Horsepower',9,95,95,10,'Physical'),(668,'Strength Sap',10,NULL,100,10,'Status'),(669,'Solar Blade',10,125,100,10,'Physical'),(670,'Leafage',10,40,100,40,'Physical'),(671,'Spotlight',13,NULL,NULL,15,'Status'),(672,'Toxic Thread',14,NULL,100,20,'Status'),(673,'Laser Focus',13,NULL,NULL,30,'Status'),(674,'Gear Up',18,NULL,NULL,20,'Status'),(675,'Throat Chop',2,80,100,15,'Physical'),(676,'Pollen Puff',1,90,100,15,'Special'),(677,'Anchor Shot',18,80,100,20,'Physical'),(678,'Psychic Terrain',16,NULL,NULL,10,'Status'),(679,'Lunge',1,80,100,15,'Physical'),(680,'Fire Lash',7,80,100,15,'Physical'),(681,'Power Trip',2,20,100,10,'Physical'),(682,'Burn Up',7,130,100,5,'Special'),(683,'Speed Swap',16,NULL,NULL,10,'Status'),(684,'Smart Strike',18,70,NULL,10,'Physical'),(685,'Purify',14,NULL,NULL,20,'Status'),(686,'Revelation Dance',13,90,100,15,'Special'),(687,'Core Enforcer',3,100,100,10,'Special'),(688,'Trop Kick',10,70,100,15,'Physical'),(689,'Instruct',16,NULL,NULL,15,'Status'),(690,'Beak Blast',8,100,100,15,'Physical'),(691,'Clanging Scales',3,110,100,5,'Special'),(692,'Dragon Hammer',3,90,100,15,'Physical'),(693,'Brutal Swing',2,60,100,20,'Physical'),(694,'Aurora Veil',12,NULL,NULL,20,'Status'),(695,'Sinister Arrow Raid',11,180,NULL,1,'Physical'),(696,'Malicious Moonsault',2,180,NULL,1,'Physical'),(697,'Oceanic Operetta',15,195,NULL,1,'Special'),(698,'Guardian of Alola',5,NULL,NULL,1,'Special'),(699,'Soul-Stealing 7-Star Strike',11,195,NULL,1,'Physical'),(700,'Stoked Sparksurfer',4,175,NULL,1,'Special'),(701,'Pulverizing Pancake',13,210,NULL,1,'Physical'),(702,'Extreme Evoboost',13,NULL,NULL,1,'Status'),(703,'Genesis Supernova',16,185,NULL,1,'Special'),(704,'Shell Trap',7,150,100,5,'Special'),(705,'Fleur Cannon',5,130,90,5,'Special'),(706,'Psychic Fangs',16,85,100,10,'Physical'),(707,'Stomping Tantrum',9,75,100,10,'Physical'),(708,'Shadow Bone',11,85,100,10,'Physical'),(709,'Accelerock',17,40,100,20,'Physical'),(710,'Liquidation',15,85,100,10,'Physical'),(711,'Prismatic Laser',16,160,100,10,'Special'),(712,'Spectral Thief',11,90,100,10,'Physical'),(713,'Sunsteel Strike',18,100,100,5,'Physical'),(714,'Moongeist Beam',11,100,100,5,'Special'),(715,'Tearful Look',13,NULL,NULL,20,'Status'),(716,'Zing Zap',4,80,100,10,'Physical'),(717,'Nature\'s Madness',5,NULL,90,10,'Special'),(718,'Multi-Attack',13,90,100,10,'Physical'),(719,'10,000,000 Volt Thunderbolt',4,195,NULL,1,'Special'),(720,'Mind Blown',7,150,100,5,'Special'),(721,'Plasma Fists',4,100,100,15,'Physical'),(722,'Photon Geyser',16,100,100,5,'Special'),(723,'Light That Burns the Sky',16,200,NULL,1,'Special'),(724,'Searing Sunraze Smash',18,200,NULL,1,'Special'),(725,'Menacing Moonraze Maelstrom',11,200,NULL,1,'Special'),(726,'Let\'s Snuggle Forever',5,190,NULL,1,'Physical'),(727,'Splintered Stormshards',17,190,NULL,1,'Physical'),(728,'Clangorous Soulblaze',3,185,NULL,1,'Special');
/*!40000 ALTER TABLE `move` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pokemon`
--

DROP TABLE IF EXISTS `pokemon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pokemon` (
  `pokemon_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `type1` int(11) NOT NULL,
  `type2` int(11) DEFAULT NULL,
  PRIMARY KEY (`pokemon_id`),
  KEY `type1` (`type1`),
  KEY `type2` (`type2`),
  CONSTRAINT `pokemon_ibfk_1` FOREIGN KEY (`type1`) REFERENCES `typing` (`type_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pokemon_ibfk_2` FOREIGN KEY (`type2`) REFERENCES `typing` (`type_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=733 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pokemon`
--

LOCK TABLES `pokemon` WRITE;
/*!40000 ALTER TABLE `pokemon` DISABLE KEYS */;
INSERT INTO `pokemon` VALUES (1,'Bulbasaur',10,14),(2,'Ivysaur',10,14),(3,'Venusaur',10,14),(4,'Charmander',7,NULL),(5,'Charmeleon',7,NULL),(6,'Charizard',7,8),(7,'Squirtle',15,NULL),(8,'Wartortle',15,NULL),(9,'Blastoise',15,NULL),(10,'Caterpie',1,NULL),(11,'Metapod',1,NULL),(12,'Butterfree',1,8),(13,'Weedle',1,14),(14,'Kakuna',1,14),(15,'Beedrill',1,14),(16,'Pidgey',13,8),(17,'Pidgeotto',13,8),(18,'Pidgeot',13,8),(19,'Rattata',13,NULL),(20,'Raticate',13,NULL),(21,'Spearow',13,8),(22,'Fearow',13,8),(23,'Ekans',14,NULL),(24,'Arbok',14,NULL),(25,'Pikachu',4,NULL),(26,'Raichu',4,NULL),(27,'Sandshrew',9,NULL),(28,'Sandslash',9,NULL),(29,'Nidoranƒ??',14,NULL),(30,'Nidorina',14,NULL),(31,'Nidoqueen',14,9),(32,'Nidoranƒ??',14,NULL),(33,'Nidorino',14,NULL),(34,'Nidoking',14,9),(35,'Clefairy',5,NULL),(36,'Clefable',5,NULL),(37,'Vulpix',7,NULL),(38,'Ninetales',7,NULL),(39,'Jigglypuff',13,5),(40,'Wigglytuff',13,5),(41,'Zubat',14,8),(42,'Golbat',14,8),(43,'Oddish',10,14),(44,'Gloom',10,14),(45,'Vileplume',10,14),(46,'Paras',1,10),(47,'Parasect',1,10),(48,'Venonat',1,14),(49,'Venomoth',1,14),(50,'Diglett',9,NULL),(51,'Dugtrio',9,NULL),(52,'Meowth',13,NULL),(53,'Persian',13,NULL),(54,'Psyduck',15,NULL),(55,'Golduck',15,NULL),(56,'Mankey',6,NULL),(57,'Primeape',6,NULL),(58,'Growlithe',7,NULL),(59,'Arcanine',7,NULL),(60,'Poliwag',15,NULL),(61,'Poliwhirl',15,NULL),(62,'Poliwrath',15,6),(63,'Abra',16,NULL),(64,'Kadabra',16,NULL),(65,'Alakazam',16,NULL),(66,'Machop',6,NULL),(67,'Machoke',6,NULL),(68,'Machamp',6,NULL),(69,'Bellsprout',10,14),(70,'Weepinbell',10,14),(71,'Victreebel',10,14),(72,'Tentacool',15,14),(73,'Tentacruel',15,14),(74,'Geodude',17,9),(75,'Graveler',17,9),(76,'Golem',17,9),(77,'Ponyta',7,NULL),(78,'Rapidash',7,NULL),(79,'Slowpoke',15,16),(80,'Slowbro',15,16),(81,'Magnemite',4,18),(82,'Magneton',4,18),(83,'Farfetch\'d',13,8),(84,'Doduo',13,8),(85,'Dodrio',13,8),(86,'Seel',15,NULL),(87,'Dewgong',15,12),(88,'Grimer',14,NULL),(89,'Muk',14,NULL),(90,'Shellder',15,NULL),(91,'Cloyster',15,12),(92,'Gastly',11,14),(93,'Haunter',11,14),(94,'Gengar',11,14),(95,'Onix',17,9),(96,'Drowzee',16,NULL),(97,'Hypno',16,NULL),(98,'Krabby',15,NULL),(99,'Kingler',15,NULL),(100,'Voltorb',4,NULL),(101,'Electrode',4,NULL),(102,'Exeggcute',10,16),(103,'Exeggutor',10,16),(104,'Cubone',9,NULL),(105,'Marowak',9,NULL),(106,'Hitmonlee',6,NULL),(107,'Hitmonchan',6,NULL),(108,'Lickitung',13,NULL),(109,'Koffing',14,NULL),(110,'Weezing',14,NULL),(111,'Rhyhorn',9,17),(112,'Rhydon',9,17),(113,'Chansey',13,NULL),(114,'Tangela',10,NULL),(115,'Kangaskhan',13,NULL),(116,'Horsea',15,NULL),(117,'Seadra',15,NULL),(118,'Goldeen',15,NULL),(119,'Seaking',15,NULL),(120,'Staryu',15,NULL),(121,'Starmie',15,16),(122,'Mr. Mime',16,5),(123,'Scyther',1,8),(124,'Jynx',12,16),(125,'Electabuzz',4,NULL),(126,'Magmar',7,NULL),(127,'Pinsir',1,NULL),(128,'Tauros',13,NULL),(129,'Magikarp',15,NULL),(130,'Gyarados',15,8),(131,'Lapras',15,12),(132,'Ditto',13,NULL),(133,'Eevee',13,NULL),(134,'Vaporeon',15,NULL),(135,'Jolteon',4,NULL),(136,'Flareon',7,NULL),(137,'Porygon',13,NULL),(138,'Omanyte',17,15),(139,'Omastar',17,15),(140,'Kabuto',17,15),(141,'Kabutops',17,15),(142,'Aerodactyl',17,8),(143,'Snorlax',13,NULL),(144,'Articuno',12,8),(145,'Zapdos',4,8),(146,'Moltres',7,8),(147,'Dratini',3,NULL),(148,'Dragonair',3,NULL),(149,'Dragonite',3,8),(150,'Mewtwo',16,NULL),(151,'Mew',16,NULL),(152,'Chikorita',10,NULL),(153,'Bayleef',10,NULL),(154,'Meganium',10,NULL),(155,'Cyndaquil',7,NULL),(156,'Quilava',7,NULL),(157,'Typhlosion',7,NULL),(158,'Totodile',15,NULL),(159,'Croconaw',15,NULL),(160,'Feraligatr',15,NULL),(161,'Sentret',13,NULL),(162,'Furret',13,NULL),(163,'Hoothoot',13,8),(164,'Noctowl',13,8),(165,'Ledyba',1,8),(166,'Ledian',1,8),(167,'Spinarak',1,14),(168,'Ariados',1,14),(169,'Crobat',14,8),(170,'Chinchou',15,4),(171,'Lanturn',15,4),(172,'Pichu',4,NULL),(173,'Cleffa',5,NULL),(174,'Igglybuff',13,5),(175,'Togepi',5,NULL),(176,'Togetic',5,8),(177,'Natu',16,8),(178,'Xatu',16,8),(179,'Mareep',4,NULL),(180,'Flaaffy',4,NULL),(181,'Ampharos',4,NULL),(182,'Bellossom',10,NULL),(183,'Marill',15,5),(184,'Azumarill',15,5),(185,'Sudowoodo',17,NULL),(186,'Politoed',15,NULL),(187,'Hoppip',10,8),(188,'Skiploom',10,8),(189,'Jumpluff',10,8),(190,'Aipom',13,NULL),(191,'Sunkern',10,NULL),(192,'Sunflora',10,NULL),(193,'Yanma',1,8),(194,'Wooper',15,9),(195,'Quagsire',15,9),(196,'Espeon',16,NULL),(197,'Umbreon',2,NULL),(198,'Murkrow',2,8),(199,'Slowking',15,16),(200,'Misdreavus',11,NULL),(201,'Unown',16,NULL),(202,'Wobbuffet',16,NULL),(203,'Girafarig',13,16),(204,'Pineco',1,NULL),(205,'Forretress',1,18),(206,'Dunsparce',13,NULL),(207,'Gligar',9,8),(208,'Steelix',18,9),(209,'Snubbull',5,NULL),(210,'Granbull',5,NULL),(211,'Qwilfish',15,14),(212,'Scizor',1,18),(213,'Shuckle',1,17),(214,'Heracross',1,6),(215,'Sneasel',2,12),(216,'Teddiursa',13,NULL),(217,'Ursaring',13,NULL),(218,'Slugma',7,NULL),(219,'Magcargo',7,17),(220,'Swinub',12,9),(221,'Piloswine',12,9),(222,'Corsola',15,17),(223,'Remoraid',15,NULL),(224,'Octillery',15,NULL),(225,'Delibird',12,8),(226,'Mantine',15,8),(227,'Skarmory',18,8),(228,'Houndour',2,7),(229,'Houndoom',2,7),(230,'Kingdra',15,3),(231,'Phanpy',9,NULL),(232,'Donphan',9,NULL),(233,'Porygon2',13,NULL),(234,'Stantler',13,NULL),(235,'Smeargle',13,NULL),(236,'Tyrogue',6,NULL),(237,'Hitmontop',6,NULL),(238,'Smoochum',12,16),(239,'Elekid',4,NULL),(240,'Magby',7,NULL),(241,'Miltank',13,NULL),(242,'Blissey',13,NULL),(243,'Raikou',4,NULL),(244,'Entei',7,NULL),(245,'Suicune',15,NULL),(246,'Larvitar',17,9),(247,'Pupitar',17,9),(248,'Tyranitar',17,2),(249,'Lugia',16,8),(250,'Ho-oh',7,8),(251,'Celebi',16,10),(252,'Treecko',10,NULL),(253,'Grovyle',10,NULL),(254,'Sceptile',10,NULL),(255,'Torchic',7,NULL),(256,'Combusken',7,6),(257,'Blaziken',7,6),(258,'Mudkip',15,NULL),(259,'Marshtomp',15,9),(260,'Swampert',15,9),(261,'Poochyena',2,NULL),(262,'Mightyena',2,NULL),(263,'Zigzagoon',13,NULL),(264,'Linoone',13,NULL),(265,'Wurmple',1,NULL),(266,'Silcoon',1,NULL),(267,'Beautifly',1,8),(268,'Cascoon',1,NULL),(269,'Dustox',1,14),(270,'Lotad',15,10),(271,'Lombre',15,10),(272,'Ludicolo',15,10),(273,'Seedot',10,NULL),(274,'Nuzleaf',10,2),(275,'Shiftry',10,2),(276,'Taillow',13,8),(277,'Swellow',13,8),(278,'Wingull',15,8),(279,'Pelipper',15,8),(280,'Ralts',16,5),(281,'Kirlia',16,5),(282,'Gardevoir',16,5),(283,'Surskit',1,15),(284,'Masquerain',1,8),(285,'Shroomish',10,NULL),(286,'Breloom',10,6),(287,'Slakoth',13,NULL),(288,'Vigoroth',13,NULL),(289,'Slaking',13,NULL),(290,'Nincada',1,9),(291,'Ninjask',1,8),(292,'Shedinja',1,11),(293,'Whismur',13,NULL),(294,'Loudred',13,NULL),(295,'Exploud',13,NULL),(296,'Makuhita',6,NULL),(297,'Hariyama',6,NULL),(298,'Azurill',13,5),(299,'Nosepass',17,NULL),(300,'Skitty',13,NULL),(301,'Delcatty',13,NULL),(302,'Sableye',2,11),(303,'Mawile',18,5),(304,'Aron',18,17),(305,'Lairon',18,17),(306,'Aggron',18,17),(307,'Meditite',6,16),(308,'Medicham',6,16),(309,'Electrike',4,NULL),(310,'Manectric',4,NULL),(311,'Plusle',4,NULL),(312,'Minun',4,NULL),(313,'Volbeat',1,NULL),(314,'Illumise',1,NULL),(315,'Roselia',10,14),(316,'Gulpin',14,NULL),(317,'Swalot',14,NULL),(318,'Carvanha',15,2),(319,'Sharpedo',15,2),(320,'Wailmer',15,NULL),(321,'Wailord',15,NULL),(322,'Numel',7,9),(323,'Camerupt',7,9),(324,'Torkoal',7,NULL),(325,'Spoink',16,NULL),(326,'Grumpig',16,NULL),(327,'Spinda',13,NULL),(328,'Trapinch',9,NULL),(329,'Vibrava',9,3),(330,'Flygon',9,3),(331,'Cacnea',10,NULL),(332,'Cacturne',10,2),(333,'Swablu',13,8),(334,'Altaria',3,8),(335,'Zangoose',13,NULL),(336,'Seviper',14,NULL),(337,'Lunatone',17,16),(338,'Solrock',17,16),(339,'Barboach',15,9),(340,'Whiscash',15,9),(341,'Corphish',15,NULL),(342,'Crawdaunt',15,2),(343,'Baltoy',9,16),(344,'Claydol',9,16),(345,'Lileep',17,10),(346,'Cradily',17,10),(347,'Anorith',17,1),(348,'Armaldo',17,1),(349,'Feebas',15,NULL),(350,'Milotic',15,NULL),(351,'Castform',13,NULL),(352,'Kecleon',13,NULL),(353,'Shuppet',11,NULL),(354,'Banette',11,NULL),(355,'Duskull',11,NULL),(356,'Dusclops',11,NULL),(357,'Tropius',10,8),(358,'Chimecho',16,NULL),(359,'Absol',2,NULL),(360,'Wynaut',16,NULL),(361,'Snorunt',12,NULL),(362,'Glalie',12,NULL),(363,'Spheal',12,15),(364,'Sealeo',12,15),(365,'Walrein',12,15),(366,'Clamperl',15,NULL),(367,'Huntail',15,NULL),(368,'Gorebyss',15,NULL),(369,'Relicanth',15,17),(370,'Luvdisc',15,NULL),(371,'Bagon',3,NULL),(372,'Shelgon',3,NULL),(373,'Salamence',3,8),(374,'Beldum',18,16),(375,'Metang',18,16),(376,'Metagross',18,16),(377,'Regirock',17,NULL),(378,'Regice',12,NULL),(379,'Registeel',18,NULL),(380,'Latias',3,16),(381,'Latios',3,16),(382,'Kyogre',15,NULL),(383,'Groudon',9,NULL),(384,'Rayquaza',3,8),(385,'Jirachi',18,16),(386,'DeoxysNormal Forme',16,NULL),(387,'Turtwig',10,NULL),(388,'Grotle',10,NULL),(389,'Torterra',10,9),(390,'Chimchar',7,NULL),(391,'Monferno',7,6),(392,'Infernape',7,6),(393,'Piplup',15,NULL),(394,'Prinplup',15,NULL),(395,'Empoleon',15,18),(396,'Starly',13,8),(397,'Staravia',13,8),(398,'Staraptor',13,8),(399,'Bidoof',13,NULL),(400,'Bibarel',13,15),(401,'Kricketot',1,NULL),(402,'Kricketune',1,NULL),(403,'Shinx',4,NULL),(404,'Luxio',4,NULL),(405,'Luxray',4,NULL),(406,'Budew',10,14),(407,'Roserade',10,14),(408,'Cranidos',17,NULL),(409,'Rampardos',17,NULL),(410,'Shieldon',17,18),(411,'Bastiodon',17,18),(412,'Burmy',1,NULL),(413,'WormadamPlant Cloak',1,10),(414,'Mothim',1,8),(415,'Combee',1,8),(416,'Vespiquen',1,8),(417,'Pachirisu',4,NULL),(418,'Buizel',15,NULL),(419,'Floatzel',15,NULL),(420,'Cherubi',10,NULL),(421,'Cherrim',10,NULL),(422,'Shellos',15,NULL),(423,'Gastrodon',15,9),(424,'Ambipom',13,NULL),(425,'Drifloon',11,8),(426,'Drifblim',11,8),(427,'Buneary',13,NULL),(428,'Lopunny',13,NULL),(429,'Mismagius',11,NULL),(430,'Honchkrow',2,8),(431,'Glameow',13,NULL),(432,'Purugly',13,NULL),(433,'Chingling',16,NULL),(434,'Stunky',14,2),(435,'Skuntank',14,2),(436,'Bronzor',18,16),(437,'Bronzong',18,16),(438,'Bonsly',17,NULL),(439,'Mime Jr.',16,5),(440,'Happiny',13,NULL),(441,'Chatot',13,8),(442,'Spiritomb',11,2),(443,'Gible',3,9),(444,'Gabite',3,9),(445,'Garchomp',3,9),(446,'Munchlax',13,NULL),(447,'Riolu',6,NULL),(448,'Lucario',6,18),(449,'Hippopotas',9,NULL),(450,'Hippowdon',9,NULL),(451,'Skorupi',14,1),(452,'Drapion',14,2),(453,'Croagunk',14,6),(454,'Toxicroak',14,6),(455,'Carnivine',10,NULL),(456,'Finneon',15,NULL),(457,'Lumineon',15,NULL),(458,'Mantyke',15,8),(459,'Snover',10,12),(460,'Abomasnow',10,12),(461,'Weavile',2,12),(462,'Magnezone',4,18),(463,'Lickilicky',13,NULL),(464,'Rhyperior',9,17),(465,'Tangrowth',10,NULL),(466,'Electivire',4,NULL),(467,'Magmortar',7,NULL),(468,'Togekiss',5,8),(469,'Yanmega',1,8),(470,'Leafeon',10,NULL),(471,'Glaceon',12,NULL),(472,'Gliscor',9,8),(473,'Mamoswine',12,9),(474,'Porygon-Z',13,NULL),(475,'Gallade',16,6),(476,'Probopass',17,18),(477,'Dusknoir',11,NULL),(478,'Froslass',12,11),(479,'Rotom',4,11),(480,'Uxie',16,NULL),(481,'Mesprit',16,NULL),(482,'Azelf',16,NULL),(483,'Dialga',18,3),(484,'Palkia',15,3),(485,'Heatran',7,18),(486,'Regigigas',13,NULL),(487,'GiratinaAltered Forme',11,3),(488,'Cresselia',16,NULL),(489,'Phione',15,NULL),(490,'Manaphy',15,NULL),(491,'Darkrai',2,NULL),(492,'ShayminLand Forme',10,NULL),(493,'Arceus',13,NULL),(494,'Victini',16,7),(495,'Snivy',10,NULL),(496,'Servine',10,NULL),(497,'Serperior',10,NULL),(498,'Tepig',7,NULL),(499,'Pignite',7,6),(500,'Emboar',7,6),(501,'Oshawott',15,NULL),(502,'Dewott',15,NULL),(503,'Samurott',15,NULL),(504,'Patrat',13,NULL),(505,'Watchog',13,NULL),(506,'Lillipup',13,NULL),(507,'Herdier',13,NULL),(508,'Stoutland',13,NULL),(509,'Purrloin',2,NULL),(510,'Liepard',2,NULL),(511,'Pansage',10,NULL),(512,'Simisage',10,NULL),(513,'Pansear',7,NULL),(514,'Simisear',7,NULL),(515,'Panpour',15,NULL),(516,'Simipour',15,NULL),(517,'Munna',16,NULL),(518,'Musharna',16,NULL),(519,'Pidove',13,8),(520,'Tranquill',13,8),(521,'Unfezant',13,8),(522,'Blitzle',4,NULL),(523,'Zebstrika',4,NULL),(524,'Roggenrola',17,NULL),(525,'Boldore',17,NULL),(526,'Gigalith',17,NULL),(527,'Woobat',16,8),(528,'Swoobat',16,8),(529,'Drilbur',9,NULL),(530,'Excadrill',9,18),(531,'Audino',13,NULL),(532,'Timburr',6,NULL),(533,'Gurdurr',6,NULL),(534,'Conkeldurr',6,NULL),(535,'Tympole',15,NULL),(536,'Palpitoad',15,9),(537,'Seismitoad',15,9),(538,'Throh',6,NULL),(539,'Sawk',6,NULL),(540,'Sewaddle',1,10),(541,'Swadloon',1,10),(542,'Leavanny',1,10),(543,'Venipede',1,14),(544,'Whirlipede',1,14),(545,'Scolipede',1,14),(546,'Cottonee',10,5),(547,'Whimsicott',10,5),(548,'Petilil',10,NULL),(549,'Lilligant',10,NULL),(550,'Basculin',15,NULL),(551,'Sandile',9,2),(552,'Krokorok',9,2),(553,'Krookodile',9,2),(554,'Darumaka',7,NULL),(555,'DarmanitanStandard Mode',7,NULL),(556,'Maractus',10,NULL),(557,'Dwebble',1,17),(558,'Crustle',1,17),(559,'Scraggy',2,6),(560,'Scrafty',2,6),(561,'Sigilyph',16,8),(562,'Yamask',11,NULL),(563,'Cofagrigus',11,NULL),(564,'Tirtouga',15,17),(565,'Carracosta',15,17),(566,'Archen',17,8),(567,'Archeops',17,8),(568,'Trubbish',14,NULL),(569,'Garbodor',14,NULL),(570,'Zorua',2,NULL),(571,'Zoroark',2,NULL),(572,'Minccino',13,NULL),(573,'Cinccino',13,NULL),(574,'Gothita',16,NULL),(575,'Gothorita',16,NULL),(576,'Gothitelle',16,NULL),(577,'Solosis',16,NULL),(578,'Duosion',16,NULL),(579,'Reuniclus',16,NULL),(580,'Ducklett',15,8),(581,'Swanna',15,8),(582,'Vanillite',12,NULL),(583,'Vanillish',12,NULL),(584,'Vanilluxe',12,NULL),(585,'Deerling',13,10),(586,'Sawsbuck',13,10),(587,'Emolga',4,8),(588,'Karrablast',1,NULL),(589,'Escavalier',1,18),(590,'Foongus',10,14),(591,'Amoonguss',10,14),(592,'Frillish',15,11),(593,'Jellicent',15,11),(594,'Alomomola',15,NULL),(595,'Joltik',1,4),(596,'Galvantula',1,4),(597,'Ferroseed',10,18),(598,'Ferrothorn',10,18),(599,'Klink',18,NULL),(600,'Klang',18,NULL),(601,'Klinklang',18,NULL),(602,'Tynamo',4,NULL),(603,'Eelektrik',4,NULL),(604,'Eelektross',4,NULL),(605,'Elgyem',16,NULL),(606,'Beheeyem',16,NULL),(607,'Litwick',11,7),(608,'Lampent',11,7),(609,'Chandelure',11,7),(610,'Axew',3,NULL),(611,'Fraxure',3,NULL),(612,'Haxorus',3,NULL),(613,'Cubchoo',12,NULL),(614,'Beartic',12,NULL),(615,'Cryogonal',12,NULL),(616,'Shelmet',1,NULL),(617,'Accelgor',1,NULL),(618,'Stunfisk',9,4),(619,'Mienfoo',6,NULL),(620,'Mienshao',6,NULL),(621,'Druddigon',3,NULL),(622,'Golett',9,11),(623,'Golurk',9,11),(624,'Pawniard',2,18),(625,'Bisharp',2,18),(626,'Bouffalant',13,NULL),(627,'Rufflet',13,8),(628,'Braviary',13,8),(629,'Vullaby',2,8),(630,'Mandibuzz',2,8),(631,'Heatmor',7,NULL),(632,'Durant',1,18),(633,'Deino',2,3),(634,'Zweilous',2,3),(635,'Hydreigon',2,3),(636,'Larvesta',1,7),(637,'Volcarona',1,7),(638,'Cobalion',18,6),(639,'Terrakion',17,6),(640,'Virizion',10,6),(641,'TornadusIncarnate Forme',8,NULL),(642,'ThundurusIncarnate Forme',4,8),(643,'Reshiram',3,7),(644,'Zekrom',3,4),(645,'LandorusIncarnate Forme',9,8),(646,'Kyurem',3,12),(647,'KeldeoOrdinary Forme',15,6),(648,'MeloettaAria Forme',13,16),(649,'Genesect',1,18),(650,'Chespin',10,NULL),(651,'Quilladin',10,NULL),(652,'Chesnaught',10,6),(653,'Fennekin',7,NULL),(654,'Braixen',7,NULL),(655,'Delphox',7,16),(656,'Froakie',15,NULL),(657,'Frogadier',15,NULL),(658,'Greninja',15,2),(659,'Bunnelby',13,NULL),(660,'Diggersby',13,9),(661,'Fletchling',13,8),(662,'Fletchinder',7,8),(663,'Talonflame',7,8),(664,'Scatterbug',1,NULL),(665,'Spewpa',1,NULL),(666,'Vivillon',1,8),(667,'Litleo',7,13),(668,'Pyroar',7,13),(669,'Flab??b??',5,NULL),(670,'Floette',5,NULL),(671,'Florges',5,NULL),(672,'Skiddo',10,NULL),(673,'Gogoat',10,NULL),(674,'Pancham',6,NULL),(675,'Pangoro',6,2),(676,'Furfrou',13,NULL),(677,'Espurr',16,NULL),(678,'MeowsticMale',16,NULL),(679,'Honedge',18,11),(680,'Doublade',18,11),(681,'AegislashBlade Forme',18,11),(682,'Spritzee',5,NULL),(683,'Aromatisse',5,NULL),(684,'Swirlix',5,NULL),(685,'Slurpuff',5,NULL),(686,'Inkay',2,16),(687,'Malamar',2,16),(688,'Binacle',17,15),(689,'Barbaracle',17,15),(690,'Skrelp',14,15),(691,'Dragalge',14,3),(692,'Clauncher',15,NULL),(693,'Clawitzer',15,NULL),(694,'Helioptile',4,13),(695,'Heliolisk',4,13),(696,'Tyrunt',17,3),(697,'Tyrantrum',17,3),(698,'Amaura',17,12),(699,'Aurorus',17,12),(700,'Sylveon',5,NULL),(701,'Hawlucha',6,8),(702,'Dedenne',4,5),(703,'Carbink',17,5),(704,'Goomy',3,NULL),(705,'Sliggoo',3,NULL),(706,'Goodra',3,NULL),(707,'Klefki',18,5),(708,'Phantump',11,10),(709,'Trevenant',11,10),(710,'PumpkabooAverage Size',11,10),(711,'GourgeistAverage Size',11,10),(712,'Bergmite',12,NULL),(713,'Avalugg',12,NULL),(714,'Noibat',8,3),(715,'Noivern',8,3),(716,'Xerneas',5,NULL),(717,'Yveltal',2,8),(718,'Zygarde50% Forme',3,9),(719,'Diancie',17,5),(720,'HoopaHoopa Confined',16,11),(721,'Volcanion',7,15),(724,'test',1,NULL),(726,'test',1,NULL);
/*!40000 ALTER TABLE `pokemon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stats`
--

DROP TABLE IF EXISTS `stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stats` (
  `pokemon_id` int(11) NOT NULL,
  `health_points` int(11) NOT NULL,
  `attack` int(11) NOT NULL,
  `special_attack` int(11) NOT NULL,
  `defense` int(11) NOT NULL,
  `special_defense` int(11) NOT NULL,
  `speed` int(11) NOT NULL,
  PRIMARY KEY (`pokemon_id`),
  CONSTRAINT `stats_ibfk_1` FOREIGN KEY (`pokemon_id`) REFERENCES `pokemon` (`pokemon_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stats`
--

LOCK TABLES `stats` WRITE;
/*!40000 ALTER TABLE `stats` DISABLE KEYS */;
INSERT INTO `stats` VALUES (1,45,49,65,49,65,45),(2,60,62,80,63,80,60),(3,80,82,100,83,100,80),(4,39,52,60,43,50,65),(5,58,64,80,58,65,80),(6,78,84,109,78,85,100),(7,44,48,50,65,64,43),(8,59,63,65,80,80,58),(9,79,83,85,100,105,78),(10,45,30,20,35,20,45),(11,50,20,25,55,25,30),(12,60,45,90,50,80,70),(13,40,35,20,30,20,50),(14,45,25,25,50,25,35),(15,65,90,45,40,80,75),(16,40,45,35,40,35,56),(17,63,60,50,55,50,71),(18,83,80,70,75,70,101),(19,30,56,25,35,35,72),(20,55,81,50,60,70,97),(21,40,60,31,30,31,70),(22,65,90,61,65,61,100),(23,35,60,40,44,54,55),(24,60,85,65,69,79,80),(25,35,55,50,40,50,90),(26,60,90,90,55,80,110),(27,50,75,20,85,30,40),(28,75,100,45,110,55,65),(29,55,47,40,52,40,41),(30,70,62,55,67,55,56),(31,90,92,75,87,85,76),(32,46,57,40,40,40,50),(33,61,72,55,57,55,65),(34,81,102,85,77,75,85),(35,70,45,60,48,65,35),(36,95,70,95,73,90,60),(37,38,41,50,40,65,65),(38,73,76,81,75,100,100),(39,115,45,45,20,25,20),(40,140,70,85,45,50,45),(41,40,45,30,35,40,55),(42,75,80,65,70,75,90),(43,45,50,75,55,65,30),(44,60,65,85,70,75,40),(45,75,80,110,85,90,50),(46,35,70,45,55,55,25),(47,60,95,60,80,80,30),(48,60,55,40,50,55,45),(49,70,65,90,60,75,90),(50,10,55,35,25,45,95),(51,35,80,50,50,70,120),(52,40,45,40,35,40,90),(53,65,70,65,60,65,115),(54,50,52,65,48,50,55),(55,80,82,95,78,80,85),(56,40,80,35,35,45,70),(57,65,105,60,60,70,95),(58,55,70,70,45,50,60),(59,90,110,100,80,80,95),(60,40,50,40,40,40,90),(61,65,65,50,65,50,90),(62,90,95,70,95,90,70),(63,25,20,105,15,55,90),(64,40,35,120,30,70,105),(65,55,50,135,45,95,120),(66,70,80,35,50,35,35),(67,80,100,50,70,60,45),(68,90,130,65,80,85,55),(69,50,75,70,35,30,40),(70,65,90,85,50,45,55),(71,80,105,100,65,70,70),(72,40,40,50,35,100,70),(73,80,70,80,65,120,100),(74,40,80,30,100,30,20),(75,55,95,45,115,45,35),(76,80,120,55,130,65,45),(77,50,85,65,55,65,90),(78,65,100,80,70,80,105),(79,90,65,40,65,40,15),(80,95,75,100,110,80,30),(81,25,35,95,70,55,45),(82,50,60,120,95,70,70),(83,52,65,58,55,62,60),(84,35,85,35,45,35,75),(85,60,110,60,70,60,100),(86,65,45,45,55,70,45),(87,90,70,70,80,95,70),(88,80,80,40,50,50,25),(89,105,105,65,75,100,50),(90,30,65,45,100,25,40),(91,50,95,85,180,45,70),(92,30,35,100,30,35,80),(93,45,50,115,45,55,95),(94,60,65,130,60,75,110),(95,35,45,30,160,45,70),(96,60,48,43,45,90,42),(97,85,73,73,70,115,67),(98,30,105,25,90,25,50),(99,55,130,50,115,50,75),(100,40,30,55,50,55,100),(101,60,50,80,70,80,140),(102,60,40,60,80,45,40),(103,95,95,125,85,65,55),(104,50,50,40,95,50,35),(105,60,80,50,110,80,45),(106,50,120,35,53,110,87),(107,50,105,35,79,110,76),(108,90,55,60,75,75,30),(109,40,65,60,95,45,35),(110,65,90,85,120,70,60),(111,80,85,30,95,30,25),(112,105,130,45,120,45,40),(113,250,5,35,5,105,50),(114,65,55,100,115,40,60),(115,105,95,40,80,80,90),(116,30,40,70,70,25,60),(117,55,65,95,95,45,85),(118,45,67,35,60,50,63),(119,80,92,65,65,80,68),(120,30,45,70,55,55,85),(121,60,75,100,85,85,115),(122,40,45,100,65,120,90),(123,70,110,55,80,80,105),(124,65,50,115,35,95,95),(125,65,83,95,57,85,105),(126,65,95,100,57,85,93),(127,65,125,55,100,70,85),(128,75,100,40,95,70,110),(129,20,10,15,55,20,80),(130,95,125,60,79,100,81),(131,130,85,85,80,95,60),(132,48,48,48,48,48,48),(133,55,55,45,50,65,55),(134,130,65,110,60,95,65),(135,65,65,110,60,95,130),(136,65,130,95,60,110,65),(137,65,60,85,70,75,40),(138,35,40,90,100,55,35),(139,70,60,115,125,70,55),(140,30,80,55,90,45,55),(141,60,115,65,105,70,80),(142,80,105,60,65,75,130),(143,160,110,65,65,110,30),(144,90,85,95,100,125,85),(145,90,90,125,85,90,100),(146,90,100,125,90,85,90),(147,41,64,50,45,50,50),(148,61,84,70,65,70,70),(149,91,134,100,95,100,80),(150,106,110,154,90,90,130),(151,100,100,100,100,100,100),(152,45,49,49,65,65,45),(153,60,62,63,80,80,60),(154,80,82,83,100,100,80),(155,39,52,60,43,50,65),(156,58,64,80,58,65,80),(157,78,84,109,78,85,100),(158,50,65,44,64,48,43),(159,65,80,59,80,63,58),(160,85,105,79,100,83,78),(161,35,46,35,34,45,20),(162,85,76,45,64,55,90),(163,60,30,36,30,56,50),(164,100,50,76,50,96,70),(165,40,20,40,30,80,55),(166,55,35,55,50,110,85),(167,40,60,40,40,40,30),(168,70,90,60,70,60,40),(169,85,90,70,80,80,130),(170,75,38,56,38,56,67),(171,125,58,76,58,76,67),(172,20,40,35,15,35,60),(173,50,25,45,28,55,15),(174,90,30,40,15,20,15),(175,35,20,40,65,65,20),(176,55,40,80,85,105,40),(177,40,50,70,45,45,70),(178,65,75,95,70,70,95),(179,55,40,65,40,45,35),(180,70,55,80,55,60,45),(181,90,75,115,85,90,55),(182,75,80,90,95,100,50),(183,70,20,20,50,50,40),(184,100,50,60,80,80,50),(185,70,100,30,115,65,30),(186,90,75,90,75,100,70),(187,35,35,35,40,55,50),(188,55,45,45,50,65,80),(189,75,55,55,70,95,110),(190,55,70,40,55,55,85),(191,30,30,30,30,30,30),(192,75,75,105,55,85,30),(193,65,65,75,45,45,95),(194,55,45,25,45,25,15),(195,95,85,65,85,65,35),(196,65,65,130,60,95,110),(197,95,65,60,110,130,65),(198,60,85,85,42,42,91),(199,95,75,100,80,110,30),(200,60,60,85,60,85,85),(201,48,72,72,48,48,48),(202,190,33,33,58,58,33),(203,70,80,90,65,65,85),(204,50,65,35,90,35,15),(205,75,90,60,140,60,40),(206,100,70,65,70,65,45),(207,65,75,35,105,65,85),(208,75,85,55,200,65,30),(209,60,80,40,50,40,30),(210,90,120,60,75,60,45),(211,65,95,55,75,55,85),(212,70,130,55,100,80,65),(213,20,10,10,230,230,5),(214,80,125,40,75,95,85),(215,55,95,35,55,75,115),(216,60,80,50,50,50,40),(217,90,130,75,75,75,55),(218,40,40,70,40,40,20),(219,50,50,80,120,80,30),(220,50,50,30,40,30,50),(221,100,100,60,80,60,50),(222,55,55,65,85,85,35),(223,35,65,65,35,35,65),(224,75,105,105,75,75,45),(225,45,55,65,45,45,75),(226,65,40,80,70,140,70),(227,65,80,40,140,70,70),(228,45,60,80,30,50,65),(229,75,90,110,50,80,95),(230,75,95,95,95,95,85),(231,90,60,40,60,40,40),(232,90,120,60,120,60,50),(233,85,80,105,90,95,60),(234,73,95,85,62,65,85),(235,55,20,20,35,45,75),(236,35,35,35,35,35,35),(237,50,95,35,95,110,70),(238,45,30,85,15,65,65),(239,45,63,65,37,55,95),(240,45,75,70,37,55,83),(241,95,80,40,105,70,100),(242,255,10,75,10,135,55),(243,90,85,115,75,100,115),(244,115,115,90,85,75,100),(245,100,75,90,115,115,85),(246,50,64,45,50,50,41),(247,70,84,65,70,70,51),(248,100,134,95,110,100,61),(249,106,90,90,130,154,110),(250,106,130,110,90,154,90),(251,100,100,100,100,100,100),(252,40,45,65,35,55,70),(253,50,65,85,45,65,95),(254,70,85,105,65,85,120),(255,45,60,70,40,50,45),(256,60,85,85,60,60,55),(257,80,120,110,70,70,80),(258,50,70,50,50,50,40),(259,70,85,60,70,70,50),(260,100,110,85,90,90,60),(261,35,55,30,35,30,35),(262,70,90,60,70,60,70),(263,38,30,30,41,41,60),(264,78,70,50,61,61,100),(265,45,45,20,35,30,20),(266,50,35,25,55,25,15),(267,60,70,100,50,50,65),(268,50,35,25,55,25,15),(269,60,50,50,70,90,65),(270,40,30,40,30,50,30),(271,60,50,60,50,70,50),(272,80,70,90,70,100,70),(273,40,40,30,50,30,30),(274,70,70,60,40,40,60),(275,90,100,90,60,60,80),(276,40,55,30,30,30,85),(277,60,85,50,60,50,125),(278,40,30,55,30,30,85),(279,60,50,85,100,70,65),(280,28,25,45,25,35,40),(281,38,35,65,35,55,50),(282,68,65,125,65,115,80),(283,40,30,50,32,52,65),(284,70,60,80,62,82,60),(285,60,40,40,60,60,35),(286,60,130,60,80,60,70),(287,60,60,35,60,35,30),(288,80,80,55,80,55,90),(289,150,160,95,100,65,100),(290,31,45,30,90,30,40),(291,61,90,50,45,50,160),(292,1,90,30,45,30,40),(293,64,51,51,23,23,28),(294,84,71,71,43,43,48),(295,104,91,91,63,73,68),(296,72,60,20,30,30,25),(297,144,120,40,60,60,50),(298,50,20,20,40,40,20),(299,30,45,45,135,90,30),(300,50,45,35,45,35,50),(301,70,65,55,65,55,70),(302,50,75,65,75,65,50),(303,50,85,55,85,55,50),(304,50,70,40,100,40,30),(305,60,90,50,140,50,40),(306,70,110,60,180,60,50),(307,30,40,40,55,55,60),(308,60,60,60,75,75,80),(309,40,45,65,40,40,65),(310,70,75,105,60,60,105),(311,60,50,85,40,75,95),(312,60,40,75,50,85,95),(313,65,73,47,55,75,85),(314,65,47,73,55,75,85),(315,50,60,100,45,80,65),(316,70,43,43,53,53,40),(317,100,73,73,83,83,55),(318,45,90,65,20,20,65),(319,70,120,95,40,40,95),(320,130,70,70,35,35,60),(321,170,90,90,45,45,60),(322,60,60,65,40,45,35),(323,70,100,105,70,75,40),(324,70,85,85,140,70,20),(325,60,25,70,35,80,60),(326,80,45,90,65,110,80),(327,60,60,60,60,60,60),(328,45,100,45,45,45,10),(329,50,70,50,50,50,70),(330,80,100,80,80,80,100),(331,50,85,85,40,40,35),(332,70,115,115,60,60,55),(333,45,40,40,60,75,50),(334,75,70,70,90,105,80),(335,73,115,60,60,60,90),(336,73,100,100,60,60,65),(337,70,55,95,65,85,70),(338,70,95,55,85,65,70),(339,50,48,46,43,41,60),(340,110,78,76,73,71,60),(341,43,80,50,65,35,35),(342,63,120,90,85,55,55),(343,40,40,40,55,70,55),(344,60,70,70,105,120,75),(345,66,41,61,77,87,23),(346,86,81,81,97,107,43),(347,45,95,40,50,50,75),(348,75,125,70,100,80,45),(349,20,15,10,20,55,80),(350,95,60,100,79,125,81),(351,70,70,70,70,70,70),(352,60,90,60,70,120,40),(353,44,75,63,35,33,45),(354,64,115,83,65,63,65),(355,20,40,30,90,90,25),(356,40,70,60,130,130,25),(357,99,68,72,83,87,51),(358,65,50,95,70,80,65),(359,65,130,75,60,60,75),(360,95,23,23,48,48,23),(361,50,50,50,50,50,50),(362,80,80,80,80,80,80),(363,70,40,55,50,50,25),(364,90,60,75,70,70,45),(365,110,80,95,90,90,65),(366,35,64,74,85,55,32),(367,55,104,94,105,75,52),(368,55,84,114,105,75,52),(369,100,90,45,130,65,55),(370,43,30,40,55,65,97),(371,45,75,40,60,30,50),(372,65,95,60,100,50,50),(373,95,135,110,80,80,100),(374,40,55,35,80,60,30),(375,60,75,55,100,80,50),(376,80,135,95,130,90,70),(377,80,100,50,200,100,50),(378,80,50,100,100,200,50),(379,80,75,75,150,150,50),(380,80,80,110,90,130,110),(381,80,90,130,80,110,110),(382,100,100,150,90,140,90),(383,100,150,100,140,90,90),(384,105,150,150,90,90,95),(385,100,100,100,100,100,100),(386,50,150,150,50,50,150),(387,55,68,45,64,55,31),(388,75,89,55,85,65,36),(389,95,109,75,105,85,56),(390,44,58,58,44,44,61),(391,64,78,78,52,52,81),(392,76,104,104,71,71,108),(393,53,51,61,53,56,40),(394,64,66,81,68,76,50),(395,84,86,111,88,101,60),(396,40,55,30,30,30,60),(397,55,75,40,50,40,80),(398,85,120,50,70,60,100),(399,59,45,35,40,40,31),(400,79,85,55,60,60,71),(401,37,25,25,41,41,25),(402,77,85,55,51,51,65),(403,45,65,40,34,34,45),(404,60,85,60,49,49,60),(405,80,120,95,79,79,70),(406,40,30,50,35,70,55),(407,60,70,125,65,105,90),(408,67,125,30,40,30,58),(409,97,165,65,60,50,58),(410,30,42,42,118,88,30),(411,60,52,47,168,138,30),(412,40,29,29,45,45,36),(413,60,59,79,85,105,36),(414,70,94,94,50,50,66),(415,30,30,30,42,42,70),(416,70,80,80,102,102,40),(417,60,45,45,70,90,95),(418,55,65,60,35,30,85),(419,85,105,85,55,50,115),(420,45,35,62,45,53,35),(421,70,60,87,70,78,85),(422,76,48,57,48,62,34),(423,111,83,92,68,82,39),(424,75,100,60,66,66,115),(425,90,50,60,34,44,70),(426,150,80,90,44,54,80),(427,55,66,44,44,56,85),(428,65,76,54,84,96,105),(429,60,60,105,60,105,105),(430,100,125,105,52,52,71),(431,49,55,42,42,37,85),(432,71,82,64,64,59,112),(433,45,30,65,50,50,45),(434,63,63,41,47,41,74),(435,103,93,71,67,61,84),(436,57,24,24,86,86,23),(437,67,89,79,116,116,33),(438,50,80,10,95,45,10),(439,20,25,70,45,90,60),(440,100,5,15,5,65,30),(441,76,65,92,45,42,91),(442,50,92,92,108,108,35),(443,58,70,40,45,45,42),(444,68,90,50,65,55,82),(445,108,130,80,95,85,102),(446,135,85,40,40,85,5),(447,40,70,35,40,40,60),(448,70,110,115,70,70,90),(449,68,72,38,78,42,32),(450,108,112,68,118,72,47),(451,40,50,30,90,55,65),(452,70,90,60,110,75,95),(453,48,61,61,40,40,50),(454,83,106,86,65,65,85),(455,74,100,90,72,72,46),(456,49,49,49,56,61,66),(457,69,69,69,76,86,91),(458,45,20,60,50,120,50),(459,60,62,62,50,60,40),(460,90,92,92,75,85,60),(461,70,120,45,65,85,125),(462,70,70,130,115,90,60),(463,110,85,80,95,95,50),(464,115,140,55,130,55,40),(465,100,100,110,125,50,50),(466,75,123,95,67,85,95),(467,75,95,125,67,95,83),(468,85,50,120,95,115,80),(469,86,76,116,86,56,95),(470,65,110,60,130,65,95),(471,65,60,130,110,95,65),(472,75,95,45,125,75,95),(473,110,130,70,80,60,80),(474,85,80,135,70,75,90),(475,68,125,65,65,115,80),(476,60,55,75,145,150,40),(477,45,100,65,135,135,45),(478,70,80,80,70,70,110),(479,50,50,95,77,77,91),(480,75,75,75,130,130,95),(481,80,105,105,105,105,80),(482,75,125,125,70,70,115),(483,100,120,150,120,100,90),(484,90,120,150,100,120,100),(485,91,90,130,106,106,77),(486,110,160,80,110,110,100),(487,150,100,100,120,120,90),(488,120,70,75,120,130,85),(489,80,80,80,80,80,80),(490,100,100,100,100,100,100),(491,70,90,135,90,90,125),(492,100,100,100,100,100,100),(493,120,120,120,120,120,120),(494,100,100,100,100,100,100),(495,45,45,45,55,55,63),(496,60,60,60,75,75,83),(497,75,75,75,95,95,113),(498,65,63,45,45,45,45),(499,90,93,70,55,55,55),(500,110,123,100,65,65,65),(501,55,55,63,45,45,45),(502,75,75,83,60,60,60),(503,95,100,108,85,70,70),(504,45,55,35,39,39,42),(505,60,85,60,69,69,77),(506,45,60,25,45,45,55),(507,65,80,35,65,65,60),(508,85,110,45,90,90,80),(509,41,50,50,37,37,66),(510,64,88,88,50,50,106),(511,50,53,53,48,48,64),(512,75,98,98,63,63,101),(513,50,53,53,48,48,64),(514,75,98,98,63,63,101),(515,50,53,53,48,48,64),(516,75,98,98,63,63,101),(517,76,25,67,45,55,24),(518,116,55,107,85,95,29),(519,50,55,36,50,30,43),(520,62,77,50,62,42,65),(521,80,115,65,80,55,93),(522,45,60,50,32,32,76),(523,75,100,80,63,63,116),(524,55,75,25,85,25,15),(525,70,105,50,105,40,20),(526,85,135,60,130,80,25),(527,55,45,55,43,43,72),(528,67,57,77,55,55,114),(529,60,85,30,40,45,68),(530,110,135,50,60,65,88),(531,103,60,60,86,86,50),(532,75,80,25,55,35,35),(533,85,105,40,85,50,40),(534,105,140,55,95,65,45),(535,50,50,50,40,40,64),(536,75,65,65,55,55,69),(537,105,95,85,75,75,74),(538,120,100,30,85,85,45),(539,75,125,30,75,75,85),(540,45,53,40,70,60,42),(541,55,63,50,90,80,42),(542,75,103,70,80,80,92),(543,30,45,30,59,39,57),(544,40,55,40,99,79,47),(545,60,100,55,89,69,112),(546,40,27,37,60,50,66),(547,60,67,77,85,75,116),(548,45,35,70,50,50,30),(549,70,60,110,75,75,90),(550,70,92,80,65,55,98),(551,50,72,35,35,35,65),(552,60,82,45,45,45,74),(553,95,117,65,80,70,92),(554,70,90,15,45,45,50),(555,105,140,30,55,55,95),(556,75,86,106,67,67,60),(557,50,65,35,85,35,55),(558,70,95,65,125,75,45),(559,50,75,35,70,70,48),(560,65,90,45,115,115,58),(561,72,58,103,80,80,97),(562,38,30,55,85,65,30),(563,58,50,95,145,105,30),(564,54,78,53,103,45,22),(565,74,108,83,133,65,32),(566,55,112,74,45,45,70),(567,75,140,112,65,65,110),(568,50,50,40,62,62,65),(569,80,95,60,82,82,75),(570,40,65,80,40,40,65),(571,60,105,120,60,60,105),(572,55,50,40,40,40,75),(573,75,95,65,60,60,115),(574,45,30,55,50,65,45),(575,60,45,75,70,85,55),(576,70,55,95,95,110,65),(577,45,30,105,40,50,20),(578,65,40,125,50,60,30),(579,110,65,125,75,85,30),(580,62,44,44,50,50,55),(581,75,87,87,63,63,98),(582,36,50,65,50,60,44),(583,51,65,80,65,75,59),(584,71,95,110,85,95,79),(585,60,60,40,50,50,75),(586,80,100,60,70,70,95),(587,55,75,75,60,60,103),(588,50,75,40,45,45,60),(589,70,135,60,105,105,20),(590,69,55,55,45,55,15),(591,114,85,85,70,80,30),(592,55,40,65,50,85,40),(593,100,60,85,70,105,60),(594,165,75,40,80,45,65),(595,50,47,57,50,50,65),(596,70,77,97,60,60,108),(597,44,50,24,91,86,10),(598,74,94,54,131,116,20),(599,40,55,45,70,60,30),(600,60,80,70,95,85,50),(601,60,100,70,115,85,90),(602,35,55,45,40,40,60),(603,65,85,75,70,70,40),(604,85,115,105,80,80,50),(605,55,55,85,55,55,30),(606,75,75,125,75,95,40),(607,50,30,65,55,55,20),(608,60,40,95,60,60,55),(609,60,55,145,90,90,80),(610,46,87,30,60,40,57),(611,66,117,40,70,50,67),(612,76,147,60,90,70,97),(613,55,70,60,40,40,40),(614,95,110,70,80,80,50),(615,70,50,95,30,135,105),(616,50,40,40,85,65,25),(617,80,70,100,40,60,145),(618,109,66,81,84,99,32),(619,45,85,55,50,50,65),(620,65,125,95,60,60,105),(621,77,120,60,90,90,48),(622,59,74,35,50,50,35),(623,89,124,55,80,80,55),(624,45,85,40,70,40,60),(625,65,125,60,100,70,70),(626,95,110,40,95,95,55),(627,70,83,37,50,50,60),(628,100,123,57,75,75,80),(629,70,55,45,75,65,60),(630,110,65,55,105,95,80),(631,85,97,105,66,66,65),(632,58,109,48,112,48,109),(633,52,65,45,50,50,38),(634,72,85,65,70,70,58),(635,92,105,125,90,90,98),(636,55,85,50,55,55,60),(637,85,60,135,65,105,100),(638,91,90,90,129,72,108),(639,91,129,72,90,90,108),(640,91,90,90,72,129,108),(641,79,115,125,70,80,111),(642,79,115,125,70,80,111),(643,100,120,150,100,120,90),(644,100,150,120,120,100,90),(645,89,125,115,90,80,101),(646,125,130,130,90,90,95),(647,91,72,129,90,90,108),(648,100,77,128,77,128,90),(649,71,120,120,95,95,99),(650,56,61,48,65,45,38),(651,61,78,56,95,58,57),(652,88,107,74,122,75,64),(653,40,45,62,40,60,60),(654,59,59,90,58,70,73),(655,75,69,114,72,100,104),(656,41,56,62,40,44,71),(657,54,63,83,52,56,97),(658,72,95,103,67,71,122),(659,38,36,32,38,36,57),(660,85,56,50,77,77,78),(661,45,50,40,43,38,62),(662,62,73,56,55,52,84),(663,78,81,74,71,69,126),(664,38,35,27,40,25,35),(665,45,22,27,60,30,29),(666,80,52,90,50,50,89),(667,62,50,73,58,54,72),(668,86,68,109,72,66,106),(669,44,38,61,39,79,42),(670,54,45,75,47,98,52),(671,78,65,112,68,154,75),(672,66,65,62,48,57,52),(673,123,100,97,62,81,68),(674,67,82,46,62,48,43),(675,95,124,69,78,71,58),(676,75,80,65,60,90,102),(677,62,48,63,54,60,68),(678,74,48,83,76,81,104),(679,45,80,35,100,37,28),(680,59,110,45,150,49,35),(681,60,150,150,50,50,60),(682,78,52,63,60,65,23),(683,101,72,99,72,89,29),(684,62,48,59,66,57,49),(685,82,80,85,86,75,72),(686,53,54,37,53,46,45),(687,86,92,68,88,75,73),(688,42,52,39,67,56,50),(689,72,105,54,115,86,68),(690,50,60,60,60,60,30),(691,65,75,97,90,123,44),(692,50,53,58,62,63,44),(693,71,73,120,88,89,59),(694,44,38,61,33,43,70),(695,62,55,109,52,94,109),(696,58,89,45,77,45,48),(697,82,121,69,119,59,71),(698,77,59,67,50,63,46),(699,123,77,99,72,92,58),(700,95,65,110,65,130,60),(701,78,92,74,75,63,118),(702,67,58,81,57,67,101),(703,50,50,50,150,150,50),(704,45,50,55,35,75,40),(705,68,75,83,53,113,60),(706,90,100,110,70,150,80),(707,57,80,80,91,87,75),(708,43,70,50,48,60,38),(709,85,110,65,76,82,56),(710,49,66,44,70,55,51),(711,65,90,58,122,75,84),(712,55,69,32,85,35,28),(713,95,117,44,184,46,28),(714,40,30,45,35,40,55),(715,85,70,97,80,80,123),(716,126,131,131,95,98,99),(717,126,131,131,95,98,99),(718,108,100,81,121,95,95),(719,50,100,100,150,150,50),(720,80,110,150,60,130,70),(721,80,110,130,120,90,70);
/*!40000 ALTER TABLE `stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trainer`
--

DROP TABLE IF EXISTS `trainer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trainer` (
  `trainer_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `money` int(11) NOT NULL DEFAULT '0',
  `location` varchar(50) NOT NULL DEFAULT 'Pallet Town',
  `num_captured_pokemon` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`trainer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trainer`
--

LOCK TABLES `trainer` WRITE;
/*!40000 ALTER TABLE `trainer` DISABLE KEYS */;
INSERT INTO `trainer` VALUES (1,'Peter',513,'Lavendar Town',1),(2,'Ryan',317,'Cinnabar Island',1),(3,'Oak',50000,'Pallet Town',1),(4,'Giovani',1000000,'Cerulian Cave',3);
/*!40000 ALTER TABLE `trainer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `typing`
--

DROP TABLE IF EXISTS `typing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `typing` (
  `type_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `typing`
--

LOCK TABLES `typing` WRITE;
/*!40000 ALTER TABLE `typing` DISABLE KEYS */;
INSERT INTO `typing` VALUES (1,'Bug'),(2,'Dark'),(3,'Dragon'),(4,'Electric'),(5,'Fairy'),(6,'Fighting'),(7,'Fire'),(8,'Flying'),(9,'Ground'),(10,'Grass'),(11,'Ghost'),(12,'Ice'),(13,'Normal'),(14,'Poison'),(15,'Water'),(16,'Psychic'),(17,'Rock'),(18,'Steel');
/*!40000 ALTER TABLE `typing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'pokemon'
--
/*!50003 DROP PROCEDURE IF EXISTS `add_battle` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_battle`(IN tr_id1 INT, IN tr_id2 INT, IN winner INT, IN prize INT)
BEGIN
	INSERT INTO battles VALUES (NULL, tr_id1, tr_id2, winner, prize);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_captured_pokemon` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_captured_pokemon`(IN pk_id INT, IN lvl INT, in nickname VARCHAR(50), IN tr_id INT)
BEGIN
	INSERT INTO capturedpokemon VALUES (NULL, pk_id, lvl, nickname, tr_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_evolution` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_evolution`(IN bs_id INT, IN evo_id INT)
BEGIN
	INSERT INTO evolutions VALUES (bs_id, evo_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_move` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_move`(IN name VARCHAR(50),
	IN type INT,
    IN power INT,
    IN accuracy INT,
    IN pp INT,
    IN category VARCHAR(20))
BEGIN
	INSERT INTO move VALUES (NULL, name, type, power, accuracy, pp, category);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_pokemon` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_pokemon`(IN name VARCHAR(50), IN type1 INT, IN type2 INT)
BEGIN
	INSERT INTO pokemon VALUES(NULL, name, type1, type2);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_stats` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_stats`(IN pk_id INT, IN hp INT, IN atk INT, IN def INT, IN spatk INT, IN spdef INT, IN spd INT)
BEGIN
	INSERT INTO stats VALUES(pk_id, hp, atk, def, spatk, spdef, spd);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_trainer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_trainer`(name VARCHAR(50))
BEGIN
	INSERT INTO trainer VALUES (NULL, name, DEFAULT, DEFAULT, DEFAULT);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_type` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_type`(name VARCHAR(20))
BEGIN
	INSERT INTO typing VALUES (NULL, name);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `forget_move_by_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `forget_move_by_id`(IN mv_id INT, IN cpt_pk_id INT)
BEGIN
	DELETE FROM learnedmoves 
    WHERE move_id = mv_id AND capt_pokemon_id = cpt_pk_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `forget_move_by_name` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `forget_move_by_name`(IN move_name VARCHAR(50), IN cpt_pk_id INT)
BEGIN
	DELETE FROM learnedmoves 
    WHERE move_id = (SELECT move_id FROM move WHERE name = move_name) 
    AND capt_pokemon_id = cpt_pk_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_captured_pokemon` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_captured_pokemon`(IN cpk_id INT)
BEGIN
	SELECT * FROM capturedpokemon WHERE capt_pokemon_id = cpk_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_captured_pokemon_with_moves_and_stats` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_captured_pokemon_with_moves_and_stats`(IN cpk_id INT)
BEGIN
	SELECT * FROM capturedpokemon
    NATURAL JOIN stats
    NATURAL JOIN move
    NATURAL JOIN learnedmoves
	WHERE capt_pokemon_id = cpk_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_evolutions` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_evolutions`()
BEGIN
	SELECT base_pokeomn, evolved_pokemon FROM evolutions e
    INNER JOIN (SELECT name as base_pokeomn, pk_id from evolutions) p1
    ON p1.pk_id = e.base_pokemon_id
    INNER JOIN (SELECT name as evolved_pokemon, pk_id from evolutions) p2
    ON p2.pk_id = e.evolved_pokemon_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_full_captured_pokemon_info` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_full_captured_pokemon_info`(IN cpk_id INT)
BEGIN
	SELECT * FROM capturedpokemon
    NATURAL JOIN stats
    NATURAL JOIN pokemon p
    INNER JOIN (select type_name as type1_name, type_id from typing) t1
    on p.type1 = t1.type_id
    INNER JOIN (select type_name as type2_name, type_id from typing) t2
    on p.type2 = t2.type_id
	WHERE capt_pokemon_id = cpk_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_move_by_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_move_by_id`(IN mv_id INT)
BEGIN
	SELECT * FROM move WHERE move_id = mv_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_move_by_name` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_move_by_name`(IN move_name VARCHAR(50))
BEGIN
	SELECT * FROM move WHERE name = move_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_pokemon_and_stats` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_pokemon_and_stats`(IN pk_id INT)
BEGIN
	SELECT * FROM pokemon pk
    NATURAL JOIN stats
    WHERE pokemon_id = pk_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_pokemon_by_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_pokemon_by_id`(IN pk_id INT)
BEGIN
	SELECT * FROM pokemon WHERE pokemon_id = pk_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_pokemon_moves` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_pokemon_moves`(IN cpt_pk_id INT)
BEGIN
	SELECT move.* FROM move 
    NATURAL JOIN capturedpokemon
    WHERE capt_pokemon_id = cpt_pk_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_pokemon_stats_by_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_pokemon_stats_by_id`(IN pk_id INT)
BEGIN
	SELECT * FROM stats WHERE pokemon_id = pk_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_trainer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_trainer`(IN tr_id INT)
BEGIN
	SELECT * FROM trainer WHERE trainer_id = tr_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_trainers_pokemon` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_trainers_pokemon`(IN tr_id INT)
BEGIN
	SELECT * FROM capturedpokemon WHERE trainer_id = tr_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_trainer_battles` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_trainer_battles`(IN tr_id INT)
BEGIN
	SELECT * FROM battles
    WHERE trainer1 = tr_id
    OR trainer2 = tr_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_types` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_types`()
BEGIN
	SELECT * FROM typing;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `learn_move_by_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `learn_move_by_id`(IN move_id INT, IN cpt_pk_id INT)
BEGIN
	INSERT INTO learnedmoves VALUES (move_id, cpt_pk_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `learn_move_by_name` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `learn_move_by_name`(IN move_name VARCHAR(50), IN cpt_pk_id INT)
BEGIN
	INSERT INTO learnedmoves VALUES (
		(SELECT move_id FROM move WHERE name = move_name), 
        cpt_pk_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `level_captured_pokemon` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `level_captured_pokemon`(IN cpk_id INT)
BEGIN
	UPDATE capturedpokemon SET level = if(level = 100, 100, level + 1) WHERE capt_pokemon_id = cpk_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `remove_battle` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_battle`(IN btl_id INT)
BEGIN
	DELETE FROM battles WHERE battle_id = btl_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `remove_captured_pokemon` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_captured_pokemon`(IN cpk_id INT)
BEGIN
	DELETE FROM capturedpokemon WHERE capt_pokemon_id = cpk_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `remove_evolution` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_evolution`(IN bs_id INT, IN evo_id INT)
BEGIN
	DELETE FROM evolutions 
    WHERE base_pokemon_id = bs_id
    AND evolved_pokemon_id = evo_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `remove_move` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_move`(IN mv_id INT)
BEGIN
	DELETE FROM move WHERE move_id = mv_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `remove_pokemon` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_pokemon`(IN pk_id INT)
BEGIN
	DELETE FROM pokemon WHERE pokemon_id = pk_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `remove_stats` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_stats`(IN pk_id INT)
BEGIN
	DELETE FROM stats WHERE pokemon_id = pk_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `remove_trainer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_trainer`(IN tr_id VARCHAR(50))
BEGIN
	DELETE FROM trainer WHERE trainer_id = tr_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `remove_type` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_type`(IN t_id INT)
BEGIN
	DELETE FROM typing WHERE type_id = t_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rename_captured_pokemon` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `rename_captured_pokemon`(IN cpk_id INT, IN name VARCHAR(50))
BEGIN
	UPDATE capturedpokemon SET nickname = name WHERE capt_pokemon_id = cpk_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_stats` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_stats`(IN pk_id INT, IN hp INT, IN atk INT, IN def INT, IN spatk INT, IN spdef INT, IN spd INT)
BEGIN
	UPDATE Stats
    SET health_points = hp,
    attack = atk,
    defense = def,
    special_defense = spdef,
    special_attack = spatk,
    speed = spd
    WHERE pokemon_id = pk_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-08 22:26:22
