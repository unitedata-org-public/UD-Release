-- MySQL dump 10.13  Distrib 5.7.20, for macos10.12 (x86_64)
--
-- Host: 001.spider.mysql.test.wacai.info    Database: ud_eds_db
-- ------------------------------------------------------
-- Server version	5.6.24-72.2-log

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
-- Table structure for table `contract_info`
--

DROP TABLE IF EXISTS `contract_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contract_info` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '合约ID',
  `provider` varchar(255) DEFAULT NULL COMMENT '提供方',
  `contract_account` varchar(255) DEFAULT NULL COMMENT '合约账号',
  `contract_name` varchar(255) DEFAULT NULL COMMENT '合约名称',
  `join_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '参与时间',
  `contract_status_type` int(6) DEFAULT NULL COMMENT '合约状态',
  `table_param_list` varchar(255) DEFAULT NULL COMMENT '合约数据字典',
  `active` tinyint(1) DEFAULT '1' COMMENT '逻辑删除标识:0=无效,1=有效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='合约信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dataserver_info`
--

DROP TABLE IF EXISTS `dataserver_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataserver_info` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `server_name` varchar(255) DEFAULT NULL COMMENT '显示名称',
  `server_ip` varchar(255) DEFAULT NULL COMMENT '主机',
  `server_port` bigint(11) DEFAULT NULL COMMENT '端口号',
  `user_name` varchar(255) DEFAULT NULL COMMENT '用户名',
  `pass_word` varchar(255) DEFAULT NULL COMMENT '密码',
  `db_name` varchar(255) DEFAULT NULL COMMENT '数据库名称',
  `db_type` varchar(255) DEFAULT NULL COMMENT '数据库类型',
  `created_person` varchar(100) DEFAULT NULL COMMENT '创建人',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_person` varchar(100) DEFAULT NULL COMMENT '修改人',
  `updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `active` tinyint(1) DEFAULT '1' COMMENT '逻辑删除标识:0=无效,1=有效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 COMMENT='数据库信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `outputdefinition_info`
--

DROP TABLE IF EXISTS `outputdefinition_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `outputdefinition_info` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `table_name` varchar(255) DEFAULT NULL COMMENT '关联表名称',
  `schema_name` varchar(255) DEFAULT NULL COMMENT '关联表类型名称',
  `def_sql` varchar(1000) DEFAULT NULL COMMENT '定义sql',
  `change_mode` varchar(255) DEFAULT NULL COMMENT '转换模式',
  `ds_id` bigint(11) DEFAULT NULL COMMENT '数据库标识',
  `created_person` varchar(100) DEFAULT NULL COMMENT '创建人',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_person` varchar(100) DEFAULT NULL COMMENT '修改人',
  `updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `active` tinyint(1) DEFAULT '1' COMMENT '逻辑删除标识:0=无效,1=有效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8 COMMENT='输出定义信息';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-08-16 16:09:09
