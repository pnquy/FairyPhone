-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: phone
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admins` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `First_Name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Last_Name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (1,'admin1','Nguyễn','Văn A','nguyen.a@example.com','admin123'),(2,'admin2','Trần','Thị B','tran.b@example.com','admin456'),(3,'admin3','Lê','Văn C','le.c@example.com','admin789');
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `User_Id` int DEFAULT NULL,
  `Phone_Id` int DEFAULT NULL,
  `Quantity` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `User_Id` (`User_Id`,`Phone_Id`),
  KEY `cart_ibfk_2` (`Phone_Id`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`User_Id`) REFERENCES `users` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`Phone_Id`) REFERENCES `smartphones` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (1,11,1,2),(2,11,3,1),(3,11,5,1),(4,12,2,2),(5,12,4,1),(6,13,3,1),(7,13,5,2),(8,14,1,1),(9,14,10,1),(10,15,11,2),(11,15,7,1);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoiceitems`
--

DROP TABLE IF EXISTS `invoiceitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoiceitems` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `InvoiceId` int DEFAULT NULL,
  `PhoneId` int DEFAULT NULL,
  `Quantity` int NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `invoiceitems_ibfk_1` (`InvoiceId`),
  KEY `invoiceitems_ibfk_2` (`PhoneId`),
  CONSTRAINT `invoiceitems_ibfk_1` FOREIGN KEY (`InvoiceId`) REFERENCES `invoices` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `invoiceitems_ibfk_2` FOREIGN KEY (`PhoneId`) REFERENCES `smartphones` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoiceitems`
--

LOCK TABLES `invoiceitems` WRITE;
/*!40000 ALTER TABLE `invoiceitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoiceitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoices` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `UserId` int DEFAULT NULL,
  `TotalAmount` decimal(10,3) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`),
  KEY `invoices_ibfk_1` (`UserId`),
  CONSTRAINT `invoices_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `users` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoices`
--

LOCK TABLES `invoices` WRITE;
/*!40000 ALTER TABLE `invoices` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `smartphones`
--

DROP TABLE IF EXISTS `smartphones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `smartphones` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Brand` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Ram` int NOT NULL,
  `Rom` int NOT NULL,
  `Price` decimal(65,3) NOT NULL,
  `Discount` decimal(65,3) DEFAULT NULL,
  `Color` varchar(255) DEFAULT 'Black',
  `Picture` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Id_UNIQUE` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `smartphones`
--

LOCK TABLES `smartphones` WRITE;
/*!40000 ALTER TABLE `smartphones` DISABLE KEYS */;
INSERT INTO `smartphones` VALUES (1,'Galaxy S21','Samsung',8,128,799.990,0.100,'white','galaxy_s21_white'),(2,'iPhone 13','Apple',6,256,999.990,0.050,'blue','iphone_13_blue'),(3,'Pixel 6','Google',8,128,699.990,0.000,'red','pixel_6_red'),(4,'OnePlus 9','OnePlus',12,256,899.990,0.150,'white','oneplus_9_white'),(5,'Xperia 5 III','Sony',8,128,849.990,0.100,'blue','xperia_5_iii_blue'),(6,'Mi 11','Xiaomi',12,256,799.990,0.200,'black','mi_11_black'),(7,'Mate 40 Pro','Huawei',8,256,1099.990,0.100,'blue','mate_40_pro_blue'),(8,'Galaxy Z Fold 3','Samsung',12,512,1799.990,0.150,'black','galaxy_z_fold_3_black'),(9,'iPhone SE','Apple',4,64,399.990,0.000,'blue','iphone_se_blue'),(10,'Pixel 5a','Google',6,128,499.990,0.050,'red','pixel_5a_red'),(11,'Galaxy A52','Samsung',6,128,349.990,0.000,'blue','galaxy_a52_blue'),(12,'iPhone 12 Mini','Apple',4,64,699.990,0.000,'blue','iphone_12_mini_blue'),(13,'Redmi Note 10','Xiaomi',6,128,229.990,0.000,'white','redmi_note_10_white'),(14,'P40 Pro','Huawei',8,256,899.990,0.100,'white','p40_pro_white'),(15,'Pixel 4a','Google',6,128,349.990,0.000,'red','pixel_4a_red'),(16,'Galaxy A32','Samsung',4,64,249.990,0.000,'white','galaxy_a32_white'),(17,'iPhone XR','Apple',3,64,599.990,0.000,'white','iphone_xr_white'),(18,'Redmi 9','Xiaomi',4,64,169.990,0.000,'blue','redmi_9_blue'),(19,'Nova 7i','Huawei',6,128,299.990,0.000,'red','nova_7i_red'),(20,'Pixel 3a','Google',4,64,399.990,0.000,'blue','pixel_3a_blue'),(21,'iPhone 6','Apple',1,16,499.990,0.000,'blue','iphone_6_blue'),(22,'iPhone 6S','Apple',2,32,549.990,0.000,'white','iphone_6s_white'),(23,'iPhone 7','Apple',2,64,649.990,0.000,'black','iphone_7_black'),(24,'iPhone 8','Apple',3,128,749.990,0.000,'black','iphone_8_black'),(25,'iPhone X','Apple',4,256,999.990,0.000,'blue','iphone_x_blue'),(26,'iPhone XS','Apple',4,256,1099.990,0.000,'red','iphone_xs_red'),(27,'iPhone 11','Apple',4,128,799.990,0.000,'blue','iphone_11_blue'),(28,'iPhone 12','Apple',4,128,1099.990,0.000,'black','iphone_12_black'),(29,'iPhone 12 Pro','Apple',6,256,1299.990,0.000,'black','iphone_12_pro_black'),(30,'iPhone 12 Pro Max','Apple',6,512,1399.990,0.000,'white','iphone_12_pro_max_white'),(31,'iPhone 13 Mini','Apple',4,128,799.990,0.000,'blue','iphone_13_mini_blue'),(32,'iPhone 13 Pro','Apple',6,256,1199.990,0.000,'black','iphone_13_pro_black'),(33,'iPhone 13 Pro Max','Apple',6,512,1299.990,0.000,'black','iphone_13_pro_max_black'),(34,'iPhone 14','Apple',8,512,1499.990,0.000,'blue','iphone_14_blue'),(35,'iPhone 14 Pro','Apple',8,512,1699.990,0.000,'white','iphone_14_pro_white'),(36,'Galaxy S7','Samsung',4,32,599.990,0.000,'white','galaxy_s7_white'),(37,'Galaxy S8','Samsung',4,64,699.990,0.000,'white','galaxy_s8_white'),(38,'Galaxy Note 8','Samsung',6,128,899.990,0.000,'white','galaxy_note_8_white'),(39,'Galaxy S9','Samsung',6,128,799.990,0.000,'black','galaxy_s9_black'),(40,'Galaxy Note 9','Samsung',8,256,999.990,0.000,'black','galaxy_note_9_black'),(41,'Galaxy S10','Samsung',8,128,899.990,0.000,'red','galaxy_s10_red'),(42,'Galaxy Note 10','Samsung',12,256,1099.990,0.000,'white','galaxy_note_10_white'),(43,'Galaxy S20','Samsung',12,256,1199.990,0.000,'white','galaxy_s20_white'),(44,'Galaxy Note 20','Samsung',12,512,1299.990,0.000,'white','galaxy_note_20_white'),(45,'Galaxy S22','Samsung',16,512,1699.990,0.000,'red','galaxy_s22_red'),(46,'Mi 5','Xiaomi',3,32,399.990,0.000,'red','mi_5_red'),(47,'Mi 6','Xiaomi',4,64,499.990,0.000,'blue','mi_6_blue'),(48,'Mi Mix 2','Xiaomi',6,128,599.990,0.000,'black','mi_mix_2_black'),(49,'Mi 8','Xiaomi',6,128,699.990,0.000,'red','mi_8_red'),(50,'Mi 9','Xiaomi',8,256,799.990,0.000,'red','mi_9_red'),(51,'Redmi Note 7','Xiaomi',4,64,199.990,0.000,'red','redmi_note_7_red'),(52,'Mi Note 10','Xiaomi',8,256,899.990,0.000,'white','mi_note_10_white'),(53,'Redmi Note 8 Pro','Xiaomi',6,128,249.990,0.000,'black','redmi_note_8_pro_black'),(54,'Mi 10','Xiaomi',12,256,1099.990,0.000,'red','mi_10_red'),(55,'Redmi Note 9','Xiaomi',4,128,229.990,0.000,'red','redmi_note_9_red'),(56,'Mi 11','Xiaomi',12,512,1199.990,0.000,'red','mi_11_red'),(57,'Redmi Note 10','Xiaomi',6,128,249.990,0.000,'blue','redmi_note_10_blue'),(58,'Mi 11 Pro','Xiaomi',16,512,1299.990,0.000,'red','mi_11_pro_red'),(59,'Redmi 9','Xiaomi',3,32,149.990,0.000,'black','redmi_9_black'),(60,'Mi 11 Ultra','Xiaomi',16,512,1499.990,0.000,'blue','mi_11_ultra_blue'),(61,'Redmi Note 10 Pro','Xiaomi',6,128,349.990,0.000,'black','redmi_note_10_pro_black'),(62,'Mi Mix 4','Xiaomi',12,256,1599.990,0.000,'red','mi_mix_4_red'),(63,'Redmi Note 11','Xiaomi',6,128,399.990,0.000,'red','redmi_note_11_red'),(64,'Redmi 10','Xiaomi',4,64,179.990,0.000,'black','redmi_10_black'),(65,'Mi Pad 5','Xiaomi',6,128,499.990,0.000,'blue','mi_pad_5_blue'),(66,'Poco X4','Xiaomi',8,128,299.990,0.000,'white','poco_x4_white'),(67,'Galaxy S21','Samsung',8,256,899.990,0.100,'blue','galaxy_s21_blue'),(68,'iPhone 13','Apple',6,512,1299.990,0.050,'white','iphone_13_white'),(69,'Pixel 6','Google',8,256,799.990,0.000,'white','pixel_6_white'),(70,'OnePlus 9','OnePlus',12,512,1099.990,0.150,'white','oneplus_9_white'),(71,'Xperia 5 III','Sony',8,256,999.990,0.100,'red','xperia_5_iii_red'),(72,'Mi 11','Xiaomi',12,512,1099.990,0.200,'white','mi_11_white'),(73,'Mate 40 Pro','Huawei',8,512,1299.990,0.100,'black','mate_40_pro_black'),(74,'Galaxy Z Fold 3','Samsung',12,1024,1999.990,0.150,'blue','galaxy_z_fold_3_blue'),(75,'iPhone SE','Apple',4,128,499.990,0.000,'white','iphone_se_white'),(76,'Pixel 5a','Google',6,256,599.990,0.050,'black','pixel_5a_black'),(77,'Galaxy A52','Samsung',6,256,449.990,0.000,'red','galaxy_a52_red'),(78,'iPhone 12 Mini','Apple',4,128,849.990,0.000,'red','iphone_12_mini_red'),(79,'Redmi Note 10','Xiaomi',6,256,299.990,0.000,'red','redmi_note_10_red'),(80,'P40 Pro','Huawei',8,512,999.990,0.100,'blue','p40_pro_blue'),(81,'Pixel 4a','Google',6,256,449.990,0.000,'black','pixel_4a_black'),(82,'Galaxy A32','Samsung',4,128,349.990,0.000,'white','galaxy_a32_white'),(83,'iPhone XR','Apple',3,128,699.990,0.000,'blue','iphone_xr_blue'),(84,'Redmi 9','Xiaomi',4,128,199.990,0.000,'white','redmi_9_white'),(85,'Nova 7i','Huawei',6,256,399.990,0.000,'black','nova_7i_black'),(86,'Pixel 3a','Google',4,128,499.990,0.000,'black','pixel_3a_black'),(87,'iPhone 6','Apple',1,32,549.990,0.000,'red','iphone_6_red'),(88,'iPhone 6S','Apple',2,64,599.990,0.000,'blue','iphone_6s_blue'),(89,'iPhone 7','Apple',2,128,699.990,0.000,'blue','iphone_7_blue'),(90,'iPhone 8','Apple',3,256,799.990,0.000,'blue','iphone_8_blue'),(91,'iPhone X','Apple',4,512,1199.990,0.000,'white','iphone_x_white'),(92,'iPhone XS','Apple',4,512,1299.990,0.000,'black','iphone_xs_black'),(93,'iPhone 11','Apple',4,256,899.990,0.000,'white','iphone_11_white'),(94,'iPhone 12','Apple',4,256,1299.990,0.000,'black','iphone_12_black'),(95,'iPhone 12 Pro','Apple',6,512,1499.990,0.000,'black','iphone_12_pro_black'),(96,'iPhone 12 Pro Max','Apple',6,1024,1699.990,0.000,'black','iphone_12_pro_max_black'),(97,'iPhone 13 Mini','Apple',4,256,899.990,0.000,'blue','iphone_13_mini_blue'),(98,'iPhone 13 Pro','Apple',6,512,1299.990,0.000,'blue','iphone_13_pro_blue'),(99,'iPhone 13 Pro Max','Apple',6,1024,1499.990,0.000,'white','iphone_13_pro_max_white'),(100,'iPhone 14','Apple',8,1024,1799.990,0.000,'blue','iphone_14_blue'),(101,'iPhone 14 Pro','Apple',8,1024,1999.990,0.000,'red','iphone_14_pro_red'),(102,'Galaxy S7','Samsung',4,64,699.990,0.000,'black','galaxy_s7_black'),(103,'Galaxy S8','Samsung',4,128,799.990,0.000,'blue','galaxy_s8_blue'),(104,'Galaxy Note 8','Samsung',6,256,999.990,0.000,'white','galaxy_note_8_white'),(105,'Galaxy S9','Samsung',6,256,1099.990,0.000,'black','galaxy_s9_black'),(106,'Galaxy Note 9','Samsung',8,512,1299.990,0.000,'white','galaxy_note_9_white'),(107,'Galaxy S10','Samsung',8,256,1199.990,0.000,'blue','galaxy_s10_blue'),(108,'Galaxy Note 10','Samsung',12,512,1499.990,0.000,'black','galaxy_note_10_black'),(109,'Galaxy S20','Samsung',12,512,1599.990,0.000,'black','galaxy_s20_black'),(110,'Galaxy Note 20','Samsung',12,1024,1899.990,0.000,'red','galaxy_note_20_red'),(111,'Galaxy S22','Samsung',16,1024,2099.990,0.000,'black','galaxy_s22_black'),(112,'Mi 5','Xiaomi',3,64,499.990,0.000,'red','mi_5_red'),(113,'Mi 6','Xiaomi',4,128,599.990,0.000,'blue','mi_6_blue'),(114,'Mi Mix 2','Xiaomi',6,256,799.990,0.000,'black','mi_mix_2_black'),(115,'Mi 8','Xiaomi',6,256,899.990,0.000,'red','mi_8_red'),(116,'Mi 9','Xiaomi',8,512,1099.990,0.000,'white','mi_9_white'),(117,'Redmi Note 7','Xiaomi',4,128,249.990,0.000,'white','redmi_note_7_white'),(118,'Mi Note 10','Xiaomi',8,512,999.990,0.000,'red','mi_note_10_red'),(119,'Redmi Note 8 Pro','Xiaomi',6,256,349.990,0.000,'blue','redmi_note_8_pro_blue'),(120,'Mi 10','Xiaomi',12,512,1299.990,0.000,'black','mi_10_black'),(121,'Redmi Note 9','Xiaomi',4,256,299.990,0.000,'white','redmi_note_9_white'),(122,'Mi 11','Xiaomi',12,1024,1499.990,0.000,'red','mi_11_red'),(123,'Redmi Note 10','Xiaomi',6,256,399.990,0.000,'white','redmi_note_10_white'),(124,'Mi 11 Pro','Xiaomi',16,1024,1599.990,0.000,'red','mi_11_pro_red'),(125,'Redmi 9','Xiaomi',3,64,199.990,0.000,'white','redmi_9_white'),(126,'Mi 11 Ultra','Xiaomi',16,1024,1699.990,0.000,'red','mi_11_ultra_red'),(127,'Redmi Note 10 Pro','Xiaomi',6,256,499.990,0.000,'white','redmi_note_10_pro_white'),(128,'Mi Mix 4','Xiaomi',12,512,1799.990,0.000,'white','mi_mix_4_white'),(129,'Redmi Note 11','Xiaomi',6,256,449.990,0.000,'white','redmi_note_11_white'),(130,'Redmi 10','Xiaomi',4,128,229.990,0.000,'red','redmi_10_red'),(131,'Mi Pad 5','Xiaomi',6,256,699.990,0.000,'white','mi_pad_5_white'),(132,'Poco X4','Xiaomi',8,256,399.990,0.000,'black','poco_x4_black');
/*!40000 ALTER TABLE `smartphones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Full_Name` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Phone_Number` varchar(255) DEFAULT NULL,
  `Province_City` varchar(255) DEFAULT NULL,
  `District` varchar(255) DEFAULT NULL,
  `Ward` varchar(255) DEFAULT NULL,
  `Specific_Address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Username` (`Username`),
  UNIQUE KEY `Email` (`Email`),
  UNIQUE KEY `Phone_Number_UNIQUE` (`Phone_Number`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (11,'user1','password1','Nguyễn Văn A','nguyen.a@example.com','1234567890','Hà Nội','Cầu Giấy','Khuất Duy Tiến','Số 123, Đường ABC'),(12,'user2','password2','Trần Thị B','tran.b@example.com','9876543210','Hồ Chí Minh','Quận 1','Phường Bến Thành','Số 456, Đường XYZ'),(13,'user3','password3','Lê Văn C','le.c@example.com','5556667777','Đà Nẵng','Quận Hải Châu','Phường Thanh Khê','Số 789, Đường MNO'),(14,'user4','password4','Phạm Thị D','pham.d@example.com','1112223333','Hải Phòng','Quận Ngô Quyền','Phường Lê Chân','Số 101, Đường PQR'),(15,'user5','password5','Vũ Văn E','vu.e@example.com','9998887777','Cần Thơ','Quận Ninh Kiều','Phường An Bình','Số 202, Đường STU'),(16,'user6','password6','Nguyễn Thị F','nguyen.f@example.com','7778889999','Bình Dương','Thành phố Thủ Dầu Một','Phường Phú Thọ','Số 303, Đường VWX'),(17,'user7','password7','Trần Văn G','tran.g@example.com','4445556666','Huế','Thành phố Huế','Phường Phú Nhuận','Số 404, Đường YZ'),(18,'user8','password8','Hoàng Thị H','hoang.h@example.com','2223334444','Quảng Ninh','Thành phố Hạ Long','Phường Bãi Cháy','Số 505, Đường ABCD'),(19,'user9','password9','Lý Văn I','ly.i@example.com','8889990000','Vũng Tàu','Thành phố Vũng Tàu','Phường 1','Số 606, Đường EFG'),(20,'user10','password10','Nguyễn Thị K','nguyen.k@example.com','6667778888','Đồng Nai','Thành phố Biên Hòa','Phường Trung Dũng','Số 707, Đường HIJK');
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

-- Dump completed on 2024-09-13  8:45:25
