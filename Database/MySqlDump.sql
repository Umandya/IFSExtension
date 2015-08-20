-- MySQL dump 10.13  Distrib 5.6.25, for Win32 (x86)
--
-- Host: localhost    Database: employeedata
-- ------------------------------------------------------
-- Server version	5.6.25-log

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
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin` (
  `Admin_ID` varchar(10) NOT NULL,
  `Admin_Name` varchar(45) NOT NULL,
  PRIMARY KEY (`Admin_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES ('DIHELK','Dinesh Hemachandra'),('JANPLK','Janaka Peiris'),('KAYOLK','Kandasamy Yogendrakumar'),('LAKALK','Lakshitha Kasun');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conference_hall`
--

DROP TABLE IF EXISTS `conference_hall`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conference_hall` (
  `Conference_Hall_Extension` varchar(15) DEFAULT NULL,
  `Name` varchar(50) NOT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conference_hall`
--

LOCK TABLES `conference_hall` WRITE;
/*!40000 ALTER TABLE `conference_hall` DISABLE KEYS */;
INSERT INTO `conference_hall` VALUES ('3050','Conference Rm   (Ground Floor)'),('3150','Conference Rm  1 ( East )'),('1122','Conference Rm  1 ( Large - North )'),('1123','Conference Rm  1 ( Large - South )'),('3160','Conference Rm  1 ( West )'),('1124','Conference Rm  1 (small )'),('3250','Conference Rm  2 ( East)'),('1222','Conference Rm  2 ( Large )'),('1224','Conference Rm  2 ( Small )'),('3260','Conference Rm  2 ( West )'),('1322','Conference Rm  3 ( Large )'),('1325','Conference Rm  3 ( Small )l '),('1425','Conference Rm  4 ( Small )'),('1423','Conference Rm  4 ( South )'),('1422','Conference Rm  4 (North )'),('1525','Conference Rm  5 ( Small )'),('1522','Conference Rm  5 (Large )'),('1622','Conference Rm  6 ( Large - North)'),('1623','Conference Rm  6 ( Large - South)'),('1625','Conference Rm  6 (Small )'),('1725','Conference Rm  7 ( Small )'),('1722','Conference Rm 7 ( Large - S'),('1723','Conference Rm 7 ( Large- N');
/*!40000 ALTER TABLE `conference_hall` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee` (
  `EmployeeID` varchar(10) NOT NULL,
  `EmployeeName` varchar(45) NOT NULL,
  `EmployeeExtension` varchar(15) DEFAULT NULL,
  `Employee_Image` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`EmployeeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES ('AAAAA','AAAAA','2212','Images/IFS.png'),('AASILK','Aan de Silva','1319','Images/IFS.png'),('ACBHLK','Achala Bhagya','1507','Images/IFS.png'),('ACVELK','Achini Veediyarachi','1203','Images/IFS.png'),('AFA','vfd','4444','Images/IFS.png'),('AFZULK','Afifa Zuhair','3229','Images/IFS.png'),('AJIRLK','Ajith Ranasinghe','2215','Images/IFS.png'),('AJSHLK','Ajith Shaminda','1307','Images/IFS.png'),('AMANLK','Amanjanee N','3036','Images/IFS.png'),('AMCHLK','Amalka Chandrasiri','3204','Images/IFS.png'),('AMNALK','Amaranatha na','3202','Images/IFS.png'),('AMTHLK','Amal Thilakarath','2106','Images/IFS.png'),('CFGHC','fchdhgcf','6666','Images/IFS.png'),('DANALK','Dasun Navodha','1601','Images/IFS.png'),('DASILK','Dasun Silva','1515','Images/IFS.png'),('DEHALK','Deepthi Hambange','1609','Images/IFS.png'),('DEHELK','Deepani Hewavitharan','1619','Images/IFS.png'),('DEIDLK','Deepani Idamekorala','1207','Images/IFS.png'),('DEKOLK','Devinda Kolonnage','3239','Images/IFS.png'),('DESOLK','Deepthi Somaweera','3224','Images/IFS.png'),('DHEMLK','Dinesh Hemachandra','6666','Images/IFS.png'),('DHJALK','Dhananga Jayathila','1507','Images/IFS.png'),('DHKULK','Dharshan S Kuruppu','1317','Images/IFS.png'),('DHPALK','Dhanushki Pahathaku','1612','Images/IFS.png'),('DHSOLK','Dhanushka Sovis','1617','Images/IFS.png'),('DHWILK','Dhanika Wijesekera','1514','Images/IFS.png'),('DWICLK','Dilshan wickramsinghe','8888','Images/IFS.png'),('HISALK','Hirantha Sangalpa','6666','Images/IFS.png'),('JANPLK','Janaka Peiris','8888','Images/IFS.png'),('KAYOLK','Kandasamy Yogendrakumar','8888','Images/IFS.png'),('LAKALK','Lakshitha Kasun','8712','Images/IFS.png'),('SAHELK','Samudra Herath','2222','Images/IFS.png'),('TODELETE','to delete','4545','Images/IFS.png');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `floor_detail`
--

DROP TABLE IF EXISTS `floor_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `floor_detail` (
  `Extension` varchar(10) NOT NULL,
  `Floor_Detail` varchar(40) NOT NULL,
  PRIMARY KEY (`Extension`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `floor_detail`
--

LOCK TABLES `floor_detail` WRITE;
/*!40000 ALTER TABLE `floor_detail` DISABLE KEYS */;
INSERT INTO `floor_detail` VALUES ('1000','1'),('1020','8'),('1200','1'),('1207','1'),('1317','1'),('1507','1'),('1515','1'),('1601','1'),('1612','1'),('1617','1'),('1619','1'),('2006','Ext-Building 2'),('2212','2'),('2222','1'),('2234','2'),('2324','2'),('3219','Ext-Building 1'),('3224','3'),('3239','3'),('3333','3'),('4242','4'),('4423','4'),('4424','3'),('4444','8'),('4545','4'),('5353','9'),('5505','5'),('5508','5'),('5509','5'),('5525','5'),('5545','5'),('5555','6'),('6010','6'),('6666','6'),('7765','7'),('7776','7'),('7777','7'),('7878','7'),('8484','8'),('8686','8'),('8712','8'),('8746','8'),('8888','8'),('9865','3'),('9988','9');
/*!40000 ALTER TABLE `floor_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `important`
--

DROP TABLE IF EXISTS `important`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `important` (
  `Name` varchar(30) NOT NULL,
  `Extension` varchar(45) NOT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `important`
--

LOCK TABLES `important` WRITE;
/*!40000 ALTER TABLE `important` DISABLE KEYS */;
INSERT INTO `important` VALUES ('Ground Floor Security','1170'),('Jayantha de Silva','1900'),('Pubudu Liyanage ','1803'),('Ranil Rajapakse ','1800'),('Rifky','1850'),('Sharon','1820');
/*!40000 ALTER TABLE `important` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-08-20  9:43:02
