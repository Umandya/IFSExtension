CREATE DATABASE `employeedata` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `employeedata`;
CREATE TABLE `admin` (
  `Admin_ID` varchar(10) NOT NULL,
  `Admin_Name` varchar(45) NOT NULL,
  PRIMARY KEY (`Admin_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `conference_hall` (
  `Conference_Hall_Extension` varchar(15) DEFAULT NULL,
  `Name` varchar(50) NOT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `employee` (
  `EmployeeID` varchar(10) NOT NULL,
  `EmployeeName` varchar(45) NOT NULL,
  `EmployeeExtension` varchar(15) DEFAULT NULL,
  `Employee_Image` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`EmployeeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `floor_detail` (
  `Extension` varchar(10) NOT NULL,
  `Floor_Detail` varchar(40) NOT NULL,
  PRIMARY KEY (`Extension`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `important` (
  `Name` varchar(30) NOT NULL,
  `Extension` varchar(45) NOT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
