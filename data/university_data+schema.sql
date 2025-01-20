CREATE DATABASE  IF NOT EXISTS `university` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `university`;
-- MySQL dump 10.13  Distrib 8.0.40, for Linux (x86_64)
--
-- Host: localhost    Database: university
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `advisor`
--

DROP TABLE IF EXISTS `advisor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `advisor` (
  `s_ID` varchar(5) NOT NULL,
  `i_ID` varchar(5) DEFAULT NULL,
  `timestamp` datetime NOT NULL DEFAULT '2009-04-30 08:30:00',
  PRIMARY KEY (`s_ID`),
  KEY `i_ID` (`i_ID`),
  CONSTRAINT `advisor_ibfk_1` FOREIGN KEY (`i_ID`) REFERENCES `instructor` (`ID`) ON DELETE SET NULL,
  CONSTRAINT `advisor_ibfk_2` FOREIGN KEY (`s_ID`) REFERENCES `student` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advisor`
--

LOCK TABLES `advisor` WRITE;
/*!40000 ALTER TABLE `advisor` DISABLE KEYS */;
INSERT INTO `advisor` VALUES ('00128','45565','2009-04-30 08:30:00'),('12345','10101','2009-04-30 08:30:00'),('23121','76543','2009-04-30 08:30:00'),('44553','22222','2009-04-30 08:30:00'),('45678','22222','2009-04-30 08:30:00'),('76543','45565','2009-04-30 08:30:00'),('76653','98345','2009-04-30 08:30:00'),('98765','98345','2009-04-30 08:30:00'),('98988','76766','2009-04-30 08:30:00');
/*!40000 ALTER TABLE `advisor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classroom`
--

DROP TABLE IF EXISTS `classroom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classroom` (
  `building` varchar(15) NOT NULL,
  `room_number` varchar(7) NOT NULL,
  `capacity` decimal(4,0) DEFAULT NULL,
  PRIMARY KEY (`building`,`room_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom`
--

LOCK TABLES `classroom` WRITE;
/*!40000 ALTER TABLE `classroom` DISABLE KEYS */;
INSERT INTO `classroom` VALUES ('Packard','101',500),('Painter','514',10),('Taylor','3128',70),('Watson','100',30),('Watson','120',50);
/*!40000 ALTER TABLE `classroom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept`
--

DROP TABLE IF EXISTS `concept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `concept` (
  `ID` varchar(20) NOT NULL,
  `type` varchar(20) NOT NULL,
  PRIMARY KEY (`ID`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept`
--

LOCK TABLES `concept` WRITE;
/*!40000 ALTER TABLE `concept` DISABLE KEYS */;
INSERT INTO `concept` VALUES ('00128','student'),('1','section'),('10101','instructor'),('12121','instructor'),('12345','student'),('15151','instructor'),('19991','student'),('2','section'),('22222','instructor'),('23121','student'),('32343','instructor'),('33456','instructor'),('44553','student'),('45565','instructor'),('45678','student'),('54321','student'),('55739','student'),('58583','instructor'),('70557','student'),('76543','instructor'),('76543','student'),('76653','student'),('76766','instructor'),('83821','instructor'),('98345','instructor'),('98765','student'),('98988','student'),('Biology','department'),('Comp. Sci.','department'),('Elec. Eng.','department'),('Finance','department'),('History','department'),('Music','department'),('Physics','department');
/*!40000 ALTER TABLE `concept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course` (
  `course_id` varchar(8) NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `dept_name` varchar(20) DEFAULT NULL,
  `credits` decimal(2,0) DEFAULT NULL,
  PRIMARY KEY (`course_id`),
  KEY `dept_name` (`dept_name`),
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`dept_name`) REFERENCES `department` (`dept_name`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES ('BIO-101','Intro. to Biology','Biology',4),('BIO-301','Genetics','Biology',4),('BIO-399','Computational Biology','Biology',3),('CS-101','Intro. to Computer Science','Comp. Sci.',4),('CS-190','Game Design','Comp. Sci.',4),('CS-315','Robotics','Comp. Sci.',3),('CS-319','Image Processing','Comp. Sci.',3),('CS-347','Database System Concepts','Comp. Sci.',3),('EE-181','Intro. to Digital Systems','Comp. Sci.',3),('FIN-201','Investment Banking','Finance',3),('HIS-351','World History','History',3),('MU-199','Music Video Production','Music',3),('PHY-101','Physical Principles','Physics',4);
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `dept_name` varchar(20) NOT NULL,
  `building` varchar(15) DEFAULT NULL,
  `budget` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`dept_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES ('Biology','Watson',90000.00),('Comp. Sci.','Taylor',100000.00),('Elec. Eng.','Taylor',85000.00),('Finance','Painter',120000.00),('History','Painter',50000.00),('Music','Packard',80000.00),('Physics','Watson',70000.00);
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_log`
--

DROP TABLE IF EXISTS `event_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_log` (
  `event_id` int NOT NULL AUTO_INCREMENT,
  `activity` varchar(20) NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT '2010-10-01 00:30:00',
  `student_id` varchar(20) DEFAULT NULL,
  `instructor_id` varchar(20) DEFAULT NULL,
  `section_id` varchar(20) DEFAULT NULL,
  `course_id` varchar(20) DEFAULT NULL,
  `department_id` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`event_id`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_log`
--

LOCK TABLES `event_log` WRITE;
/*!40000 ALTER TABLE `event_log` DISABLE KEYS */;
INSERT INTO `event_log` VALUES (1,'course_enrolled','2009-11-01 08:30:00','00128','10101','1','CS-101','Comp. Sci.'),(2,'course_enrolled','2009-11-01 08:30:00','12345','10101','1','CS-101','Comp. Sci.'),(3,'course_enrolled','2009-11-01 08:30:00','45678','10101','1','CS-101','Comp. Sci.'),(4,'course_enrolled','2009-11-01 08:30:00','54321','10101','1','CS-101','Comp. Sci.'),(5,'course_enrolled','2009-11-01 08:30:00','76543','10101','1','CS-101','Comp. Sci.'),(6,'course_enrolled','2009-11-01 08:30:00','98765','10101','1','CS-101','Comp. Sci.'),(7,'course_enrolled','2009-11-01 08:30:00','00128','10101','1','CS-347','Comp. Sci.'),(8,'course_enrolled','2009-11-01 08:30:00','12345','10101','1','CS-347','Comp. Sci.'),(9,'course_enrolled','2009-11-01 08:30:00','44553','22222','1','PHY-101','Physics'),(16,'course_enrolled','2009-04-01 08:30:00','98988','76766','1','BIO-101','Biology'),(17,'course_enrolled','2009-04-01 08:30:00','12345','83821','2','CS-190','Comp. Sci.'),(18,'course_enrolled','2009-04-01 08:30:00','54321','83821','2','CS-190','Comp. Sci.'),(19,'course_enrolled','2009-04-01 08:30:00','76653','98345','1','EE-181','Comp. Sci.'),(23,'course_enrolled','2010-04-01 08:30:00','98988','76766','1','BIO-301','Biology'),(24,'course_enrolled','2010-04-01 08:30:00','45678','45565','1','CS-101','Comp. Sci.'),(25,'course_enrolled','2010-04-01 08:30:00','12345','10101','1','CS-315','Comp. Sci.'),(26,'course_enrolled','2010-04-01 08:30:00','98765','10101','1','CS-315','Comp. Sci.'),(27,'course_enrolled','2010-04-01 08:30:00','45678','45565','1','CS-319','Comp. Sci.'),(28,'course_enrolled','2010-04-01 08:30:00','76543','83821','2','CS-319','Comp. Sci.'),(29,'course_enrolled','2010-04-01 08:30:00','23121','12121','1','FIN-201','Finance'),(30,'course_enrolled','2010-04-01 08:30:00','19991','32343','1','HIS-351','History'),(31,'course_enrolled','2010-04-01 08:30:00','55739','15151','1','MU-199','Music'),(38,'course_passed','2010-03-31 18:00:00','00128','10101','1','CS-101','Comp. Sci.'),(39,'course_passed','2010-03-31 18:00:00','00128','10101','1','CS-347','Comp. Sci.'),(40,'course_passed','2010-03-31 18:00:00','12345','10101','1','CS-101','Comp. Sci.'),(41,'course_passed','2009-10-31 18:00:00','12345','83821','2','CS-190','Comp. Sci.'),(42,'course_passed','2010-10-31 18:00:00','12345','10101','1','CS-315','Comp. Sci.'),(43,'course_passed','2010-03-31 18:00:00','12345','10101','1','CS-347','Comp. Sci.'),(44,'course_passed','2010-10-31 18:00:00','19991','32343','1','HIS-351','History'),(45,'course_passed','2010-10-31 18:00:00','23121','12121','1','FIN-201','Finance'),(46,'course_passed','2010-03-31 18:00:00','44553','22222','1','PHY-101','Physics'),(47,'course_passed','2010-10-31 18:00:00','45678','45565','1','CS-101','Comp. Sci.'),(48,'course_passed','2010-10-31 18:00:00','45678','45565','1','CS-319','Comp. Sci.'),(49,'course_passed','2010-03-31 18:00:00','54321','10101','1','CS-101','Comp. Sci.'),(50,'course_passed','2009-10-31 18:00:00','54321','83821','2','CS-190','Comp. Sci.'),(51,'course_passed','2010-10-31 18:00:00','55739','15151','1','MU-199','Music'),(52,'course_passed','2010-03-31 18:00:00','76543','10101','1','CS-101','Comp. Sci.'),(53,'course_passed','2010-10-31 18:00:00','76543','83821','2','CS-319','Comp. Sci.'),(54,'course_passed','2009-10-31 18:00:00','76653','98345','1','EE-181','Comp. Sci.'),(55,'course_passed','2010-03-31 18:00:00','98765','10101','1','CS-101','Comp. Sci.'),(56,'course_passed','2010-10-31 18:00:00','98765','10101','1','CS-315','Comp. Sci.'),(57,'course_passed','2009-10-31 18:00:00','98988','76766','1','BIO-101','Biology'),(69,'course_failed','2010-03-31 18:00:00','45678','10101','1','CS-101','Comp. Sci.'),(70,'advisor_assigned','2009-04-30 08:30:00','00128','45565',NULL,NULL,NULL),(71,'advisor_assigned','2009-04-30 08:30:00','12345','10101',NULL,NULL,NULL),(72,'advisor_assigned','2009-04-30 08:30:00','23121','76543',NULL,NULL,NULL),(73,'advisor_assigned','2009-04-30 08:30:00','44553','22222',NULL,NULL,NULL),(74,'advisor_assigned','2009-04-30 08:30:00','45678','22222',NULL,NULL,NULL),(75,'advisor_assigned','2009-04-30 08:30:00','76543','45565',NULL,NULL,NULL),(76,'advisor_assigned','2009-04-30 08:30:00','76653','98345',NULL,NULL,NULL),(77,'advisor_assigned','2009-04-30 08:30:00','98765','98345',NULL,NULL,NULL),(78,'advisor_assigned','2009-04-30 08:30:00','98988','76766',NULL,NULL,NULL),(85,'student_enrolled','2009-04-01 08:00:00','00128',NULL,NULL,NULL,'Comp. Sci.'),(86,'student_enrolled','2009-04-01 08:00:00','12345',NULL,NULL,NULL,'Comp. Sci.'),(87,'student_enrolled','2009-04-01 08:00:00','19991',NULL,NULL,NULL,'History'),(88,'student_enrolled','2009-04-01 08:00:00','23121',NULL,NULL,NULL,'Finance'),(89,'student_enrolled','2009-04-01 08:00:00','44553',NULL,NULL,NULL,'Physics'),(90,'student_enrolled','2009-04-01 08:00:00','45678',NULL,NULL,NULL,'Physics'),(91,'student_enrolled','2009-04-01 08:00:00','54321',NULL,NULL,NULL,'Comp. Sci.'),(92,'student_enrolled','2009-04-01 08:00:00','55739',NULL,NULL,NULL,'Music'),(93,'student_enrolled','2009-04-01 08:00:00','70557',NULL,NULL,NULL,'Physics'),(94,'student_enrolled','2009-04-01 08:00:00','76543',NULL,NULL,NULL,'Comp. Sci.'),(95,'student_enrolled','2009-04-01 08:00:00','76653',NULL,NULL,NULL,'Elec. Eng.'),(96,'student_enrolled','2009-04-01 08:00:00','98765',NULL,NULL,NULL,'Elec. Eng.'),(97,'student_enrolled','2009-04-01 08:00:00','98988',NULL,NULL,NULL,'Biology'),(100,'student_graduated','2010-03-31 18:00:00','00128','45565',NULL,NULL,'Comp. Sci.'),(101,'student_graduated','2010-10-31 18:00:00','23121','76543',NULL,NULL,'Finance'),(102,'student_graduated','2009-10-31 18:00:00','98988','76766',NULL,NULL,'Biology');
/*!40000 ALTER TABLE `event_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructor`
--

DROP TABLE IF EXISTS `instructor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instructor` (
  `ID` varchar(5) NOT NULL,
  `name` varchar(20) NOT NULL,
  `dept_name` varchar(20) DEFAULT NULL,
  `salary` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `dept_name` (`dept_name`),
  CONSTRAINT `instructor_ibfk_1` FOREIGN KEY (`dept_name`) REFERENCES `department` (`dept_name`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructor`
--

LOCK TABLES `instructor` WRITE;
/*!40000 ALTER TABLE `instructor` DISABLE KEYS */;
INSERT INTO `instructor` VALUES ('10101','Srinivasan','Comp. Sci.',65000.00),('12121','Wu','Finance',90000.00),('15151','Mozart','Music',40000.00),('22222','Einstein','Physics',95000.00),('32343','El Said','History',60000.00),('33456','Gold','Physics',87000.00),('45565','Katz','Comp. Sci.',75000.00),('58583','Califieri','History',62000.00),('76543','Singh','Finance',80000.00),('76766','Crick','Biology',72000.00),('83821','Brandt','Comp. Sci.',92000.00),('98345','Kim','Elec. Eng.',80000.00);
/*!40000 ALTER TABLE `instructor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prereq`
--

DROP TABLE IF EXISTS `prereq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prereq` (
  `course_id` varchar(8) NOT NULL,
  `prereq_id` varchar(8) NOT NULL,
  PRIMARY KEY (`course_id`,`prereq_id`),
  KEY `prereq_id` (`prereq_id`),
  CONSTRAINT `prereq_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE CASCADE,
  CONSTRAINT `prereq_ibfk_2` FOREIGN KEY (`prereq_id`) REFERENCES `course` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prereq`
--

LOCK TABLES `prereq` WRITE;
/*!40000 ALTER TABLE `prereq` DISABLE KEYS */;
INSERT INTO `prereq` VALUES ('BIO-301','BIO-101'),('BIO-399','BIO-101'),('CS-190','CS-101'),('CS-315','CS-101'),('CS-319','CS-101'),('CS-347','CS-101'),('EE-181','PHY-101');
/*!40000 ALTER TABLE `prereq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `section`
--

DROP TABLE IF EXISTS `section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `section` (
  `course_id` varchar(8) NOT NULL,
  `sec_id` varchar(8) NOT NULL,
  `semester` varchar(6) NOT NULL,
  `year` decimal(4,0) NOT NULL,
  `building` varchar(15) DEFAULT NULL,
  `room_number` varchar(7) DEFAULT NULL,
  `time_slot_id` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`course_id`,`sec_id`,`semester`,`year`),
  KEY `building` (`building`,`room_number`),
  CONSTRAINT `section_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE CASCADE,
  CONSTRAINT `section_ibfk_2` FOREIGN KEY (`building`, `room_number`) REFERENCES `classroom` (`building`, `room_number`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `section`
--

LOCK TABLES `section` WRITE;
/*!40000 ALTER TABLE `section` DISABLE KEYS */;
INSERT INTO `section` VALUES ('BIO-101','1','Summer',2009,'Painter','514','B'),('BIO-301','1','Summer',2010,'Painter','514','A'),('CS-101','1','Fall',2009,'Packard','101','H'),('CS-101','1','Spring',2010,'Packard','101','F'),('CS-190','1','Spring',2009,'Taylor','3128','E'),('CS-190','2','Spring',2009,'Taylor','3128','A'),('CS-315','1','Spring',2010,'Watson','120','D'),('CS-319','1','Spring',2010,'Watson','100','B'),('CS-319','2','Spring',2010,'Taylor','3128','C'),('CS-347','1','Fall',2009,'Taylor','3128','A'),('EE-181','1','Spring',2009,'Taylor','3128','C'),('FIN-201','1','Spring',2010,'Packard','101','B'),('HIS-351','1','Spring',2010,'Painter','514','C'),('MU-199','1','Spring',2010,'Packard','101','D'),('PHY-101','1','Fall',2009,'Watson','100','A');
/*!40000 ALTER TABLE `section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `ID` varchar(5) NOT NULL,
  `name` varchar(20) NOT NULL,
  `dept_name` varchar(20) DEFAULT NULL,
  `tot_cred` decimal(3,0) DEFAULT NULL,
  `timestamp` datetime NOT NULL DEFAULT '2009-04-01 08:00:00',
  PRIMARY KEY (`ID`),
  KEY `dept_name` (`dept_name`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`dept_name`) REFERENCES `department` (`dept_name`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES ('00128','Zhang','Comp. Sci.',102,'2009-04-01 08:00:00'),('12345','Shankar','Comp. Sci.',32,'2009-04-01 08:00:00'),('19991','Brandt','History',80,'2009-04-01 08:00:00'),('23121','Chavez','Finance',110,'2009-04-01 08:00:00'),('44553','Peltier','Physics',56,'2009-04-01 08:00:00'),('45678','Levy','Physics',46,'2009-04-01 08:00:00'),('54321','Williams','Comp. Sci.',54,'2009-04-01 08:00:00'),('55739','Sanchez','Music',38,'2009-04-01 08:00:00'),('70557','Snow','Physics',0,'2009-04-01 08:00:00'),('76543','Brown','Comp. Sci.',58,'2009-04-01 08:00:00'),('76653','Aoi','Elec. Eng.',60,'2009-04-01 08:00:00'),('98765','Bourikas','Elec. Eng.',98,'2009-04-01 08:00:00'),('98988','Tanaka','Biology',120,'2009-04-01 08:00:00');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `takes`
--

DROP TABLE IF EXISTS `takes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `takes` (
  `ID` varchar(5) NOT NULL,
  `course_id` varchar(8) NOT NULL,
  `sec_id` varchar(8) NOT NULL,
  `semester` varchar(6) NOT NULL,
  `year` decimal(4,0) NOT NULL,
  `grade` varchar(2) DEFAULT NULL,
  `timestamp` datetime NOT NULL DEFAULT '2010-10-01 20:30:00',
  PRIMARY KEY (`ID`,`course_id`,`sec_id`,`semester`,`year`),
  KEY `course_id` (`course_id`,`sec_id`,`semester`,`year`),
  CONSTRAINT `takes_ibfk_1` FOREIGN KEY (`course_id`, `sec_id`, `semester`, `year`) REFERENCES `section` (`course_id`, `sec_id`, `semester`, `year`) ON DELETE CASCADE,
  CONSTRAINT `takes_ibfk_2` FOREIGN KEY (`ID`) REFERENCES `student` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `takes`
--

LOCK TABLES `takes` WRITE;
/*!40000 ALTER TABLE `takes` DISABLE KEYS */;
INSERT INTO `takes` VALUES ('00128','CS-101','1','Fall',2009,'A','2010-03-31 18:00:00'),('00128','CS-347','1','Fall',2009,'A-','2010-03-31 18:00:00'),('12345','CS-101','1','Fall',2009,'C','2010-03-31 18:00:00'),('12345','CS-190','2','Spring',2009,'A','2009-10-31 18:00:00'),('12345','CS-315','1','Spring',2010,'A','2010-10-31 18:00:00'),('12345','CS-347','1','Fall',2009,'A','2010-03-31 18:00:00'),('19991','HIS-351','1','Spring',2010,'B','2010-10-31 18:00:00'),('23121','FIN-201','1','Spring',2010,'C+','2010-10-31 18:00:00'),('44553','PHY-101','1','Fall',2009,'B-','2010-03-31 18:00:00'),('45678','CS-101','1','Fall',2009,'F','2010-03-31 18:00:00'),('45678','CS-101','1','Spring',2010,'B+','2010-10-31 18:00:00'),('45678','CS-319','1','Spring',2010,'B','2010-10-31 18:00:00'),('54321','CS-101','1','Fall',2009,'A-','2010-03-31 18:00:00'),('54321','CS-190','2','Spring',2009,'B+','2009-10-31 18:00:00'),('55739','MU-199','1','Spring',2010,'A-','2010-10-31 18:00:00'),('76543','CS-101','1','Fall',2009,'A','2010-03-31 18:00:00'),('76543','CS-319','2','Spring',2010,'A','2010-10-31 18:00:00'),('76653','EE-181','1','Spring',2009,'C','2009-10-31 18:00:00'),('98765','CS-101','1','Fall',2009,'C-','2010-03-31 18:00:00'),('98765','CS-315','1','Spring',2010,'B','2010-10-31 18:00:00'),('98988','BIO-101','1','Summer',2009,'A','2009-10-31 18:00:00'),('98988','BIO-301','1','Summer',2010,NULL,'2010-10-31 18:00:00');
/*!40000 ALTER TABLE `takes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teaches`
--

DROP TABLE IF EXISTS `teaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teaches` (
  `ID` varchar(5) NOT NULL,
  `course_id` varchar(8) NOT NULL,
  `sec_id` varchar(8) NOT NULL,
  `semester` varchar(6) NOT NULL,
  `year` decimal(4,0) NOT NULL,
  PRIMARY KEY (`ID`,`course_id`,`sec_id`,`semester`,`year`),
  KEY `course_id` (`course_id`,`sec_id`,`semester`,`year`),
  CONSTRAINT `teaches_ibfk_1` FOREIGN KEY (`course_id`, `sec_id`, `semester`, `year`) REFERENCES `section` (`course_id`, `sec_id`, `semester`, `year`) ON DELETE CASCADE,
  CONSTRAINT `teaches_ibfk_2` FOREIGN KEY (`ID`) REFERENCES `instructor` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teaches`
--

LOCK TABLES `teaches` WRITE;
/*!40000 ALTER TABLE `teaches` DISABLE KEYS */;
INSERT INTO `teaches` VALUES ('76766','BIO-101','1','Summer',2009),('76766','BIO-301','1','Summer',2010),('10101','CS-101','1','Fall',2009),('45565','CS-101','1','Spring',2010),('83821','CS-190','1','Spring',2009),('83821','CS-190','2','Spring',2009),('10101','CS-315','1','Spring',2010),('45565','CS-319','1','Spring',2010),('83821','CS-319','2','Spring',2010),('10101','CS-347','1','Fall',2009),('98345','EE-181','1','Spring',2009),('12121','FIN-201','1','Spring',2010),('32343','HIS-351','1','Spring',2010),('15151','MU-199','1','Spring',2010),('22222','PHY-101','1','Fall',2009);
/*!40000 ALTER TABLE `teaches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_slot`
--

DROP TABLE IF EXISTS `time_slot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `time_slot` (
  `time_slot_id` varchar(4) NOT NULL,
  `day` varchar(1) NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time DEFAULT NULL,
  PRIMARY KEY (`time_slot_id`,`day`,`start_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_slot`
--

LOCK TABLES `time_slot` WRITE;
/*!40000 ALTER TABLE `time_slot` DISABLE KEYS */;
INSERT INTO `time_slot` VALUES ('A','F','08:00:00','08:50:00'),('A','M','08:00:00','08:50:00'),('A','W','08:00:00','08:50:00'),('B','F','09:00:00','09:50:00'),('B','M','09:00:00','09:50:00'),('B','W','09:00:00','09:50:00'),('C','F','11:00:00','11:50:00'),('C','M','11:00:00','11:50:00'),('C','W','11:00:00','11:50:00'),('D','F','13:00:00','13:50:00'),('D','M','13:00:00','13:50:00'),('D','W','13:00:00','13:50:00'),('E','R','10:30:00','11:45:00'),('E','T','10:30:00','11:45:00'),('F','R','14:30:00','15:45:00'),('F','T','14:30:00','15:45:00'),('G','F','16:00:00','16:50:00'),('G','M','16:00:00','16:50:00'),('G','W','16:00:00','16:50:00'),('H','W','10:00:00','12:30:00');
/*!40000 ALTER TABLE `time_slot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'university'
--

--
-- Dumping routines for database 'university'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-09 13:35:56
