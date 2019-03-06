/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.6.40-log : Database - lw-oa
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`lw-oa` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `lw-oa`;

/*Table structure for table `file` */

DROP TABLE IF EXISTS `file`;

CREATE TABLE `file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `remark` varchar(500) DEFAULT NULL COMMENT '备注：默认文件名',
  `filename` varchar(500) DEFAULT NULL COMMENT '文件名',
  `filepath` varchar(200) DEFAULT NULL COMMENT '文件路径',
  `fullpath` varchar(500) DEFAULT NULL COMMENT '文件全路径',
  `qiniuUrl` varchar(500) DEFAULT NULL COMMENT '七牛云路径',
  `filetype` int(1) DEFAULT NULL COMMENT '文件类型：1EXCEL 2PPT 3WORD',
  `flag` int(1) DEFAULT NULL COMMENT '文件状态：1正常 2删除',
  `uploadtime` timestamp NULL DEFAULT NULL COMMENT '上传时间',
  `filesize` varchar(100) DEFAULT NULL COMMENT '文件大小',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;

/*Table structure for table `file_auth` */

DROP TABLE IF EXISTS `file_auth`;

CREATE TABLE `file_auth` (
  `userId` int(11) DEFAULT NULL COMMENT '创建者ID',
  `authFileId` int(11) DEFAULT NULL COMMENT '文件ID',
  `authUserId` int(11) DEFAULT NULL COMMENT '授权者ID',
  KEY `userId` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(100) DEFAULT NULL COMMENT '用户名=姓名',
  `password` varchar(100) DEFAULT NULL COMMENT '登录密码',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机号',
  `status` int(1) DEFAULT NULL COMMENT '用户状态:0禁用 1启用',
  `level` int(1) DEFAULT NULL COMMENT '用户级别：1超级用户admin 2系统管理员 3普通员工',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

/*Table structure for table `user_file` */

DROP TABLE IF EXISTS `user_file`;

CREATE TABLE `user_file` (
  `userId` int(11) DEFAULT NULL COMMENT '用户ID',
  `fileId` int(11) DEFAULT NULL COMMENT '文件ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户上传文件关联表';

/*Table structure for table `user_record` */

DROP TABLE IF EXISTS `user_record`;

CREATE TABLE `user_record` (
  `fileId` int(11) DEFAULT NULL,
  `fileName` int(11) DEFAULT NULL,
  `filePath` varchar(500) DEFAULT NULL,
  `userName` varchar(100) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `operation` int(1) DEFAULT NULL COMMENT '操作类型：1上传，2下载 3删除',
  `recordTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `fileName` (`fileName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
