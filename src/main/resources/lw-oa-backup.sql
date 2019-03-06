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

/*Data for the table `file` */

insert  into `file`(`id`,`remark`,`filename`,`filepath`,`fullpath`,`qiniuUrl`,`filetype`,`flag`,`uploadtime`,`filesize`) values (33,'file6','file6.png','/upload/deleted/file6.png','C:/upload/oa/deleted/file6.png',NULL,5,2,'2019-01-29 16:12:34','3.0KB');
insert  into `file`(`id`,`remark`,`filename`,`filepath`,`fullpath`,`qiniuUrl`,`filetype`,`flag`,`uploadtime`,`filesize`) values (34,'南京環球-成立香港公司费用18.4.4','南京環球-成立香港公司费用18.4.4.pdf','/upload/deleted/南京環球-成立香港公司费用18.4.4.pdf','C:/upload/oa/deleted/南京環球-成立香港公司费用18.4.4.pdf',NULL,4,2,'2019-01-29 16:14:23','219.0KB');
insert  into `file`(`id`,`remark`,`filename`,`filepath`,`fullpath`,`qiniuUrl`,`filetype`,`flag`,`uploadtime`,`filesize`) values (35,'南京環球-成立香港公司费用18.4.4','南京環球-成立香港公司费用18.4.4.pdf','/upload/南京環球-成立香港公司费用18.4.4.pdf','C:/upload/oa/南京環球-成立香港公司费用18.4.4.pdf',NULL,4,1,'2019-01-29 16:17:09','219.0KB');
insert  into `file`(`id`,`remark`,`filename`,`filepath`,`fullpath`,`qiniuUrl`,`filetype`,`flag`,`uploadtime`,`filesize`) values (36,'南京環球-管理香港公司费用','南京環球-管理香港公司费用.pdf','/upload/南京環球-管理香港公司费用.pdf','C:/upload/oa/南京環球-管理香港公司费用.pdf',NULL,4,1,'2019-01-29 16:18:12','142.8KB');
insert  into `file`(`id`,`remark`,`filename`,`filepath`,`fullpath`,`qiniuUrl`,`filetype`,`flag`,`uploadtime`,`filesize`) values (37,'南京環球-核数师报告及报税','南京環球-核数师报告及报税.pdf','/upload/南京環球-核数师报告及报税.pdf','C:/upload/oa/南京環球-核数师报告及报税.pdf',NULL,4,1,'2019-01-29 16:18:18','190.8KB');
insert  into `file`(`id`,`remark`,`filename`,`filepath`,`fullpath`,`qiniuUrl`,`filetype`,`flag`,`uploadtime`,`filesize`) values (38,'2018年NAR1- NJ4083 德欣贸易（香港）有限公司','2018年NAR1- NJ4083 德欣贸易（香港）有限公司.pdf','/upload/2018年NAR1- NJ4083 德欣贸易（香港）有限公司.pdf','C:/upload/oa/2018年NAR1- NJ4083 德欣贸易（香港）有限公司.pdf',NULL,4,1,'2019-01-29 16:18:48','3.5MB');
insert  into `file`(`id`,`remark`,`filename`,`filepath`,`fullpath`,`qiniuUrl`,`filetype`,`flag`,`uploadtime`,`filesize`) values (39,'server20190117','server20190117.txt','/upload/deleted/server20190117.txt','C:/upload/oa/deleted/server20190117.txt',NULL,10,2,'2019-01-29 16:44:35','3.5KB');
insert  into `file`(`id`,`remark`,`filename`,`filepath`,`fullpath`,`qiniuUrl`,`filetype`,`flag`,`uploadtime`,`filesize`) values (40,'5mgutil','5mgutil.dll','/upload/deleted/5mgutil.dll','C:/upload/oa/deleted/5mgutil.dll',NULL,10,2,'2019-01-29 16:50:58','30.8KB');
insert  into `file`(`id`,`remark`,`filename`,`filepath`,`fullpath`,`qiniuUrl`,`filetype`,`flag`,`uploadtime`,`filesize`) values (41,'5hdocvw','5hdocvw.dll','/upload/deleted/5hdocvw.dll','C:/upload/oa/deleted/5hdocvw.dll',NULL,10,2,'2019-01-29 16:54:52','1.1MB');
insert  into `file`(`id`,`remark`,`filename`,`filepath`,`fullpath`,`qiniuUrl`,`filetype`,`flag`,`uploadtime`,`filesize`) values (42,'微信图片_20181029175302','微信图片_20181029175302.jpg','/upload/deleted/微信图片_20181029175302.jpg','C:/upload/oa/deleted/微信图片_20181029175302.jpg',NULL,5,2,'2019-01-29 17:18:53','126.9KB');
insert  into `file`(`id`,`remark`,`filename`,`filepath`,`fullpath`,`qiniuUrl`,`filetype`,`flag`,`uploadtime`,`filesize`) values (43,'hello','hello.java','/upload/deleted/hello.java','C:/upload/oa/deleted/hello.java',NULL,10,2,'2019-01-29 17:19:28','117.0BT');
insert  into `file`(`id`,`remark`,`filename`,`filepath`,`fullpath`,`qiniuUrl`,`filetype`,`flag`,`uploadtime`,`filesize`) values (44,'南京環球-注册香港公司基本情况','南京環球-注册香港公司基本情况.pdf','/upload/南京環球-注册香港公司基本情况.pdf','C:/upload/oa/南京環球-注册香港公司基本情况.pdf',NULL,4,1,'2019-01-30 11:08:03','156.9KB');
insert  into `file`(`id`,`remark`,`filename`,`filepath`,`fullpath`,`qiniuUrl`,`filetype`,`flag`,`uploadtime`,`filesize`) values (45,'2018年NAR1- CZ2207 斯柏林国际（香港）有限公司','2018年NAR1- CZ2207 斯柏林国际（香港）有限公司.pdf','/upload/2018年NAR1- CZ2207 斯柏林国际（香港）有限公司.pdf','C:/upload/oa/2018年NAR1- CZ2207 斯柏林国际（香港）有限公司.pdf',NULL,4,1,'2019-02-13 09:30:18','3.6MB');
insert  into `file`(`id`,`remark`,`filename`,`filepath`,`fullpath`,`qiniuUrl`,`filetype`,`flag`,`uploadtime`,`filesize`) values (46,'2018年NAR1- CZ2207 斯柏林国际（香港）有限公司','2018年NAR1- CZ2207 斯柏林国际（香港）有限公司.pdf','/upload/deleted/2018年NAR1- CZ2207 斯柏林国际（香港）有限公司.pdf','C:/upload/oa/deleted/2018年NAR1- CZ2207 斯柏林国际（香港）有限公司.pdf',NULL,4,2,'2019-02-13 09:31:58','3.6MB');
insert  into `file`(`id`,`remark`,`filename`,`filepath`,`fullpath`,`qiniuUrl`,`filetype`,`flag`,`uploadtime`,`filesize`) values (47,'BR(1Nov2018) - S(HZ2431) Hongkong Shin Light Industry Ltd 香港新明光實業有限公司','BR(1Nov2018) - S(HZ2431) Hongkong Shin Light Industry Ltd 香港新明光實業有限公司.pdf','/upload/BR(1Nov2018) - S(HZ2431) Hongkong Shin Light Industry Ltd 香港新明光實業有限公司.pdf','C:/upload/oa/BR(1Nov2018) - S(HZ2431) Hongkong Shin Light Industry Ltd 香港新明光實業有限公司.pdf',NULL,4,1,'2019-02-13 09:32:19','103.2KB');
insert  into `file`(`id`,`remark`,`filename`,`filepath`,`fullpath`,`qiniuUrl`,`filetype`,`flag`,`uploadtime`,`filesize`) values (48,'UOB_Questionnaire for Foreign Owned Company','UOB_Questionnaire for Foreign Owned Company.docx','/upload/UOB_Questionnaire for Foreign Owned Company.docx','C:/upload/oa/UOB_Questionnaire for Foreign Owned Company.docx',NULL,10,1,'2019-02-14 11:31:30','14.7KB');
insert  into `file`(`id`,`remark`,`filename`,`filepath`,`fullpath`,`qiniuUrl`,`filetype`,`flag`,`uploadtime`,`filesize`) values (49,'甘肃公安-现场问题记录','甘肃公安-现场问题记录.txt','/upload/甘肃公安-现场问题记录.txt','C:/upload/oa/甘肃公安-现场问题记录.txt',NULL,10,1,'2019-03-04 00:02:49','3.6KB');
insert  into `file`(`id`,`remark`,`filename`,`filepath`,`fullpath`,`qiniuUrl`,`filetype`,`flag`,`uploadtime`,`filesize`) values (50,'20190217日志','20190217日志.rar','/upload/20190217日志.rar','C:/upload/oa/20190217日志.rar',NULL,6,1,'2019-03-04 00:02:56','2.5MB');

/*Table structure for table `file_auth` */

DROP TABLE IF EXISTS `file_auth`;

CREATE TABLE `file_auth` (
  `userId` int(11) DEFAULT NULL COMMENT '创建者ID',
  `authFileId` int(11) DEFAULT NULL COMMENT '文件ID',
  `authUserId` int(11) DEFAULT NULL COMMENT '授权者ID',
  KEY `userId` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `file_auth` */

insert  into `file_auth`(`userId`,`authFileId`,`authUserId`) values (2,37,2);
insert  into `file_auth`(`userId`,`authFileId`,`authUserId`) values (2,37,20);
insert  into `file_auth`(`userId`,`authFileId`,`authUserId`) values (2,37,23);
insert  into `file_auth`(`userId`,`authFileId`,`authUserId`) values (2,37,24);
insert  into `file_auth`(`userId`,`authFileId`,`authUserId`) values (2,37,25);
insert  into `file_auth`(`userId`,`authFileId`,`authUserId`) values (2,37,26);
insert  into `file_auth`(`userId`,`authFileId`,`authUserId`) values (2,36,2);
insert  into `file_auth`(`userId`,`authFileId`,`authUserId`) values (2,36,20);
insert  into `file_auth`(`userId`,`authFileId`,`authUserId`) values (2,36,23);
insert  into `file_auth`(`userId`,`authFileId`,`authUserId`) values (2,36,24);
insert  into `file_auth`(`userId`,`authFileId`,`authUserId`) values (2,36,25);
insert  into `file_auth`(`userId`,`authFileId`,`authUserId`) values (2,36,26);
insert  into `file_auth`(`userId`,`authFileId`,`authUserId`) values (2,44,2);
insert  into `file_auth`(`userId`,`authFileId`,`authUserId`) values (2,44,20);
insert  into `file_auth`(`userId`,`authFileId`,`authUserId`) values (2,44,23);
insert  into `file_auth`(`userId`,`authFileId`,`authUserId`) values (2,44,24);
insert  into `file_auth`(`userId`,`authFileId`,`authUserId`) values (2,44,25);
insert  into `file_auth`(`userId`,`authFileId`,`authUserId`) values (2,44,26);
insert  into `file_auth`(`userId`,`authFileId`,`authUserId`) values (2,35,2);
insert  into `file_auth`(`userId`,`authFileId`,`authUserId`) values (2,35,20);
insert  into `file_auth`(`userId`,`authFileId`,`authUserId`) values (2,35,24);
insert  into `file_auth`(`userId`,`authFileId`,`authUserId`) values (2,35,25);
insert  into `file_auth`(`userId`,`authFileId`,`authUserId`) values (2,35,26);
insert  into `file_auth`(`userId`,`authFileId`,`authUserId`) values (2,47,2);
insert  into `file_auth`(`userId`,`authFileId`,`authUserId`) values (2,45,2);
insert  into `file_auth`(`userId`,`authFileId`,`authUserId`) values (2,45,24);
insert  into `file_auth`(`userId`,`authFileId`,`authUserId`) values (2,45,25);
insert  into `file_auth`(`userId`,`authFileId`,`authUserId`) values (2,38,2);
insert  into `file_auth`(`userId`,`authFileId`,`authUserId`) values (23,48,2);
insert  into `file_auth`(`userId`,`authFileId`,`authUserId`) values (23,48,24);
insert  into `file_auth`(`userId`,`authFileId`,`authUserId`) values (23,48,25);

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

/*Data for the table `user` */

insert  into `user`(`id`,`username`,`password`,`phone`,`status`,`level`) values (1,'admin','admin123','15850533159',1,1);
insert  into `user`(`id`,`username`,`password`,`phone`,`status`,`level`) values (2,'susan','135246','1865299490',1,2);
insert  into `user`(`id`,`username`,`password`,`phone`,`status`,`level`) values (20,'测试','123456','15850533159',1,2);
insert  into `user`(`id`,`username`,`password`,`phone`,`status`,`level`) values (23,'linda','123456','13851633151',1,2);
insert  into `user`(`id`,`username`,`password`,`phone`,`status`,`level`) values (24,'anne','123456','',1,2);
insert  into `user`(`id`,`username`,`password`,`phone`,`status`,`level`) values (25,'KIKI','123456','',1,2);
insert  into `user`(`id`,`username`,`password`,`phone`,`status`,`level`) values (26,'Selina','123456','',1,2);

/*Table structure for table `user_file` */

DROP TABLE IF EXISTS `user_file`;

CREATE TABLE `user_file` (
  `userId` int(11) DEFAULT NULL COMMENT '用户ID',
  `fileId` int(11) DEFAULT NULL COMMENT '文件ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户上传文件关联表';

/*Data for the table `user_file` */

insert  into `user_file`(`userId`,`fileId`) values (1,33);
insert  into `user_file`(`userId`,`fileId`) values (1,34);
insert  into `user_file`(`userId`,`fileId`) values (2,35);
insert  into `user_file`(`userId`,`fileId`) values (2,36);
insert  into `user_file`(`userId`,`fileId`) values (2,37);
insert  into `user_file`(`userId`,`fileId`) values (2,38);
insert  into `user_file`(`userId`,`fileId`) values (1,39);
insert  into `user_file`(`userId`,`fileId`) values (1,40);
insert  into `user_file`(`userId`,`fileId`) values (1,41);
insert  into `user_file`(`userId`,`fileId`) values (1,42);
insert  into `user_file`(`userId`,`fileId`) values (1,43);
insert  into `user_file`(`userId`,`fileId`) values (2,44);
insert  into `user_file`(`userId`,`fileId`) values (2,45);
insert  into `user_file`(`userId`,`fileId`) values (2,46);
insert  into `user_file`(`userId`,`fileId`) values (2,47);
insert  into `user_file`(`userId`,`fileId`) values (23,48);
insert  into `user_file`(`userId`,`fileId`) values (1,49);
insert  into `user_file`(`userId`,`fileId`) values (1,50);

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

/*Data for the table `user_record` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
