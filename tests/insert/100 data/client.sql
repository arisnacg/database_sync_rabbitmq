/*
SQLyog Ultimate v12.4.3 (64 bit)
MySQL - 10.1.36-MariaDB : Database - rabbitmq_client1
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`rabbitmq_client1` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `rabbitmq_client1`;

/*Table structure for table `changelog` */

DROP TABLE IF EXISTS `changelog`;

CREATE TABLE `changelog` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `query` text,
  `table` varchar(255) DEFAULT NULL,
  `pk` bigint(20) DEFAULT NULL,
  `prev_pk` bigint(20) DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `uuid` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=latin1;

/*Data for the table `changelog` */

insert  into `changelog`(`id`,`query`,`table`,`pk`,`prev_pk`,`type`,`created_at`,`uuid`) values 
(1,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'1\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b3c2bc2-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',1,1,1,'2020-11-22 17:01:22','4b3c2bc2-2ca1-11eb-a1dd-88d7f66e68b3'),
(2,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'2\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b409219-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',2,2,1,'2020-11-22 17:01:22','4b409219-2ca1-11eb-a1dd-88d7f66e68b3'),
(3,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'3\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b409a30-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',3,3,1,'2020-11-22 17:01:22','4b409a30-2ca1-11eb-a1dd-88d7f66e68b3'),
(4,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'4\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b40a140-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',4,4,1,'2020-11-22 17:01:22','4b40a140-2ca1-11eb-a1dd-88d7f66e68b3'),
(5,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'5\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b40c2b5-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',5,5,1,'2020-11-22 17:01:22','4b40c2b5-2ca1-11eb-a1dd-88d7f66e68b3'),
(6,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'6\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b40c8b0-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',6,6,1,'2020-11-22 17:01:22','4b40c8b0-2ca1-11eb-a1dd-88d7f66e68b3'),
(7,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'7\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b40ceb3-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',7,7,1,'2020-11-22 17:01:22','4b40ceb3-2ca1-11eb-a1dd-88d7f66e68b3'),
(8,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'8\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b40d291-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',8,8,1,'2020-11-22 17:01:22','4b40d291-2ca1-11eb-a1dd-88d7f66e68b3'),
(9,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'9\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b40d9ec-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',9,9,1,'2020-11-22 17:01:22','4b40d9ec-2ca1-11eb-a1dd-88d7f66e68b3'),
(10,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'10\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b40de68-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',10,10,1,'2020-11-22 17:01:22','4b40de68-2ca1-11eb-a1dd-88d7f66e68b3'),
(11,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'11\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b40e1a9-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',11,11,1,'2020-11-22 17:01:22','4b40e1a9-2ca1-11eb-a1dd-88d7f66e68b3'),
(12,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'12\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b40e4dd-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',12,12,1,'2020-11-22 17:01:22','4b40e4dd-2ca1-11eb-a1dd-88d7f66e68b3'),
(13,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'13\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b40f161-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',13,13,1,'2020-11-22 17:01:22','4b40f161-2ca1-11eb-a1dd-88d7f66e68b3'),
(14,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'14\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b40f922-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',14,14,1,'2020-11-22 17:01:22','4b40f922-2ca1-11eb-a1dd-88d7f66e68b3'),
(15,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'15\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b40fedb-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',15,15,1,'2020-11-22 17:01:22','4b40fedb-2ca1-11eb-a1dd-88d7f66e68b3'),
(16,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'16\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b410256-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',16,16,1,'2020-11-22 17:01:22','4b410256-2ca1-11eb-a1dd-88d7f66e68b3'),
(17,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'17\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b41059d-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',17,17,1,'2020-11-22 17:01:22','4b41059d-2ca1-11eb-a1dd-88d7f66e68b3'),
(18,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'18\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b4108c2-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',18,18,1,'2020-11-22 17:01:22','4b4108c2-2ca1-11eb-a1dd-88d7f66e68b3'),
(19,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'19\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b410bca-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',19,19,1,'2020-11-22 17:01:22','4b410bca-2ca1-11eb-a1dd-88d7f66e68b3'),
(20,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'20\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b410f26-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',20,20,1,'2020-11-22 17:01:22','4b410f26-2ca1-11eb-a1dd-88d7f66e68b3'),
(21,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'21\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b411577-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',21,21,1,'2020-11-22 17:01:22','4b411577-2ca1-11eb-a1dd-88d7f66e68b3'),
(22,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'22\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b4118da-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',22,22,1,'2020-11-22 17:01:22','4b4118da-2ca1-11eb-a1dd-88d7f66e68b3'),
(23,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'23\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b411bf1-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',23,23,1,'2020-11-22 17:01:22','4b411bf1-2ca1-11eb-a1dd-88d7f66e68b3'),
(24,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'24\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b411ef8-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',24,24,1,'2020-11-22 17:01:22','4b411ef8-2ca1-11eb-a1dd-88d7f66e68b3'),
(25,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'25\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b41223d-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',25,25,1,'2020-11-22 17:01:22','4b41223d-2ca1-11eb-a1dd-88d7f66e68b3'),
(26,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'26\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b41253e-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',26,26,1,'2020-11-22 17:01:22','4b41253e-2ca1-11eb-a1dd-88d7f66e68b3'),
(27,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'27\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b412840-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',27,27,1,'2020-11-22 17:01:22','4b412840-2ca1-11eb-a1dd-88d7f66e68b3'),
(28,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'28\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b412b48-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',28,28,1,'2020-11-22 17:01:22','4b412b48-2ca1-11eb-a1dd-88d7f66e68b3'),
(29,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'29\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b412e7f-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',29,29,1,'2020-11-22 17:01:22','4b412e7f-2ca1-11eb-a1dd-88d7f66e68b3'),
(30,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'30\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b41318a-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',30,30,1,'2020-11-22 17:01:22','4b41318a-2ca1-11eb-a1dd-88d7f66e68b3'),
(31,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'31\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b4134c6-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',31,31,1,'2020-11-22 17:01:22','4b4134c6-2ca1-11eb-a1dd-88d7f66e68b3'),
(32,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'32\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b4137d8-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',32,32,1,'2020-11-22 17:01:22','4b4137d8-2ca1-11eb-a1dd-88d7f66e68b3'),
(33,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'33\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b413d14-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',33,33,1,'2020-11-22 17:01:22','4b413d14-2ca1-11eb-a1dd-88d7f66e68b3'),
(34,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'34\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b41415f-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',34,34,1,'2020-11-22 17:01:22','4b41415f-2ca1-11eb-a1dd-88d7f66e68b3'),
(35,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'35\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b4147b7-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',35,35,1,'2020-11-22 17:01:22','4b4147b7-2ca1-11eb-a1dd-88d7f66e68b3'),
(36,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'36\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b414d65-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',36,36,1,'2020-11-22 17:01:22','4b414d65-2ca1-11eb-a1dd-88d7f66e68b3'),
(37,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'37\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b41515c-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',37,37,1,'2020-11-22 17:01:22','4b41515c-2ca1-11eb-a1dd-88d7f66e68b3'),
(38,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'38\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b415470-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',38,38,1,'2020-11-22 17:01:22','4b415470-2ca1-11eb-a1dd-88d7f66e68b3'),
(39,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'39\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b415778-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',39,39,1,'2020-11-22 17:01:22','4b415778-2ca1-11eb-a1dd-88d7f66e68b3'),
(40,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'40\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b415a83-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',40,40,1,'2020-11-22 17:01:22','4b415a83-2ca1-11eb-a1dd-88d7f66e68b3'),
(41,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'41\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b415d8c-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',41,41,1,'2020-11-22 17:01:22','4b415d8c-2ca1-11eb-a1dd-88d7f66e68b3'),
(42,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'42\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b41628d-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',42,42,1,'2020-11-22 17:01:22','4b41628d-2ca1-11eb-a1dd-88d7f66e68b3'),
(43,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'43\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b41665f-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',43,43,1,'2020-11-22 17:01:22','4b41665f-2ca1-11eb-a1dd-88d7f66e68b3'),
(44,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'44\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b416ce0-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',44,44,1,'2020-11-22 17:01:22','4b416ce0-2ca1-11eb-a1dd-88d7f66e68b3'),
(45,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'45\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b4172f9-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',45,45,1,'2020-11-22 17:01:22','4b4172f9-2ca1-11eb-a1dd-88d7f66e68b3'),
(46,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'46\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b417695-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',46,46,1,'2020-11-22 17:01:22','4b417695-2ca1-11eb-a1dd-88d7f66e68b3'),
(47,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'47\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b4179af-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',47,47,1,'2020-11-22 17:01:22','4b4179af-2ca1-11eb-a1dd-88d7f66e68b3'),
(48,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'48\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b417ceb-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',48,48,1,'2020-11-22 17:01:22','4b417ceb-2ca1-11eb-a1dd-88d7f66e68b3'),
(49,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'49\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b417fff-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',49,49,1,'2020-11-22 17:01:22','4b417fff-2ca1-11eb-a1dd-88d7f66e68b3'),
(50,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'50\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b418301-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',50,50,1,'2020-11-22 17:01:22','4b418301-2ca1-11eb-a1dd-88d7f66e68b3'),
(51,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'51\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b41863e-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',51,51,1,'2020-11-22 17:01:22','4b41863e-2ca1-11eb-a1dd-88d7f66e68b3'),
(52,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'52\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b418b0d-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',52,52,1,'2020-11-22 17:01:22','4b418b0d-2ca1-11eb-a1dd-88d7f66e68b3'),
(53,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'53\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b419109-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',53,53,1,'2020-11-22 17:01:22','4b419109-2ca1-11eb-a1dd-88d7f66e68b3'),
(54,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'54\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b41954e-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',54,54,1,'2020-11-22 17:01:22','4b41954e-2ca1-11eb-a1dd-88d7f66e68b3'),
(55,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'55\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b419865-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',55,55,1,'2020-11-22 17:01:22','4b419865-2ca1-11eb-a1dd-88d7f66e68b3'),
(56,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'56\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b419b83-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',56,56,1,'2020-11-22 17:01:22','4b419b83-2ca1-11eb-a1dd-88d7f66e68b3'),
(57,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'57\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b419e94-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',57,57,1,'2020-11-22 17:01:22','4b419e94-2ca1-11eb-a1dd-88d7f66e68b3'),
(58,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'58\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b41a1c5-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',58,58,1,'2020-11-22 17:01:22','4b41a1c5-2ca1-11eb-a1dd-88d7f66e68b3'),
(59,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'59\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b506c1b-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',59,59,1,'2020-11-22 17:01:22','4b506c1b-2ca1-11eb-a1dd-88d7f66e68b3'),
(60,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'60\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b507435-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',60,60,1,'2020-11-22 17:01:22','4b507435-2ca1-11eb-a1dd-88d7f66e68b3'),
(61,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'61\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b507918-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',61,61,1,'2020-11-22 17:01:22','4b507918-2ca1-11eb-a1dd-88d7f66e68b3'),
(62,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'62\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b50a918-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',62,62,1,'2020-11-22 17:01:22','4b50a918-2ca1-11eb-a1dd-88d7f66e68b3'),
(63,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'63\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b50af31-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',63,63,1,'2020-11-22 17:01:22','4b50af31-2ca1-11eb-a1dd-88d7f66e68b3'),
(64,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'64\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b50b7f3-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',64,64,1,'2020-11-22 17:01:22','4b50b7f3-2ca1-11eb-a1dd-88d7f66e68b3'),
(65,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'65\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b50be27-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',65,65,1,'2020-11-22 17:01:22','4b50be27-2ca1-11eb-a1dd-88d7f66e68b3'),
(66,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'66\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b50c1d1-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',66,66,1,'2020-11-22 17:01:22','4b50c1d1-2ca1-11eb-a1dd-88d7f66e68b3'),
(67,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'67\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b50c51b-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',67,67,1,'2020-11-22 17:01:22','4b50c51b-2ca1-11eb-a1dd-88d7f66e68b3'),
(68,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'68\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b50c88a-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',68,68,1,'2020-11-22 17:01:22','4b50c88a-2ca1-11eb-a1dd-88d7f66e68b3'),
(69,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'69\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b50cc42-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',69,69,1,'2020-11-22 17:01:22','4b50cc42-2ca1-11eb-a1dd-88d7f66e68b3'),
(70,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'70\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b50d156-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',70,70,1,'2020-11-22 17:01:22','4b50d156-2ca1-11eb-a1dd-88d7f66e68b3'),
(71,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'71\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b50d75b-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',71,71,1,'2020-11-22 17:01:22','4b50d75b-2ca1-11eb-a1dd-88d7f66e68b3'),
(72,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'72\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b50df66-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',72,72,1,'2020-11-22 17:01:22','4b50df66-2ca1-11eb-a1dd-88d7f66e68b3'),
(73,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'73\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b50e8bb-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',73,73,1,'2020-11-22 17:01:22','4b50e8bb-2ca1-11eb-a1dd-88d7f66e68b3'),
(74,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'74\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b50ec32-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',74,74,1,'2020-11-22 17:01:22','4b50ec32-2ca1-11eb-a1dd-88d7f66e68b3'),
(75,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'75\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b50ef68-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',75,75,1,'2020-11-22 17:01:22','4b50ef68-2ca1-11eb-a1dd-88d7f66e68b3'),
(76,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'76\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b50f316-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',76,76,1,'2020-11-22 17:01:22','4b50f316-2ca1-11eb-a1dd-88d7f66e68b3'),
(77,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'77\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b50f884-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',77,77,1,'2020-11-22 17:01:22','4b50f884-2ca1-11eb-a1dd-88d7f66e68b3'),
(78,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'78\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b50fdf4-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',78,78,1,'2020-11-22 17:01:22','4b50fdf4-2ca1-11eb-a1dd-88d7f66e68b3'),
(79,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'79\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b510618-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',79,79,1,'2020-11-22 17:01:22','4b510618-2ca1-11eb-a1dd-88d7f66e68b3'),
(80,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'80\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b510b6b-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',80,80,1,'2020-11-22 17:01:22','4b510b6b-2ca1-11eb-a1dd-88d7f66e68b3'),
(81,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'81\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b510eb0-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',81,81,1,'2020-11-22 17:01:22','4b510eb0-2ca1-11eb-a1dd-88d7f66e68b3'),
(82,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'82\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b5111d7-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',82,82,1,'2020-11-22 17:01:22','4b5111d7-2ca1-11eb-a1dd-88d7f66e68b3'),
(83,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'83\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b5114f6-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',83,83,1,'2020-11-22 17:01:22','4b5114f6-2ca1-11eb-a1dd-88d7f66e68b3'),
(84,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'84\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b511813-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',84,84,1,'2020-11-22 17:01:22','4b511813-2ca1-11eb-a1dd-88d7f66e68b3'),
(85,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'85\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b511d42-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',85,85,1,'2020-11-22 17:01:22','4b511d42-2ca1-11eb-a1dd-88d7f66e68b3'),
(86,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'86\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b5121a3-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',86,86,1,'2020-11-22 17:01:22','4b5121a3-2ca1-11eb-a1dd-88d7f66e68b3'),
(87,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'87\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b513085-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',87,87,1,'2020-11-22 17:01:22','4b513085-2ca1-11eb-a1dd-88d7f66e68b3'),
(88,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'88\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b5134a0-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',88,88,1,'2020-11-22 17:01:22','4b5134a0-2ca1-11eb-a1dd-88d7f66e68b3'),
(89,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'89\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b5137cb-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',89,89,1,'2020-11-22 17:01:22','4b5137cb-2ca1-11eb-a1dd-88d7f66e68b3'),
(90,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'90\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b513b14-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',90,90,1,'2020-11-22 17:01:22','4b513b14-2ca1-11eb-a1dd-88d7f66e68b3'),
(91,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'91\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b513e2b-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',91,91,1,'2020-11-22 17:01:22','4b513e2b-2ca1-11eb-a1dd-88d7f66e68b3'),
(92,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'92\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b514846-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',92,92,1,'2020-11-22 17:01:22','4b514846-2ca1-11eb-a1dd-88d7f66e68b3'),
(93,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'93\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b515028-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',93,93,1,'2020-11-22 17:01:22','4b515028-2ca1-11eb-a1dd-88d7f66e68b3'),
(94,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'94\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b515749-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',94,94,1,'2020-11-22 17:01:22','4b515749-2ca1-11eb-a1dd-88d7f66e68b3'),
(95,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'95\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b515ac4-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',95,95,1,'2020-11-22 17:01:22','4b515ac4-2ca1-11eb-a1dd-88d7f66e68b3'),
(96,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'96\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b515e2c-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',96,96,1,'2020-11-22 17:01:22','4b515e2c-2ca1-11eb-a1dd-88d7f66e68b3'),
(97,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'97\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b516152-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',97,97,1,'2020-11-22 17:01:22','4b516152-2ca1-11eb-a1dd-88d7f66e68b3'),
(98,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'98\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b516478-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',98,98,1,'2020-11-22 17:01:22','4b516478-2ca1-11eb-a1dd-88d7f66e68b3'),
(99,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'99\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b5167de-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',99,99,1,'2020-11-22 17:01:22','4b5167de-2ca1-11eb-a1dd-88d7f66e68b3'),
(100,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'100\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b516d10-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')','trx',100,100,1,'2020-11-22 17:01:22','4b516d10-2ca1-11eb-a1dd-88d7f66e68b3');

/*Table structure for table `inbox` */

DROP TABLE IF EXISTS `inbox`;

CREATE TABLE `inbox` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `query` text,
  `type` smallint(6) DEFAULT NULL COMMENT '1 = insert, 2 = update, 3 = delete',
  `label` varchar(255) DEFAULT NULL,
  `table` varchar(255) DEFAULT NULL,
  `pk` bigint(20) DEFAULT NULL,
  `prev_pk` bigint(20) DEFAULT NULL,
  `uuid` varchar(36) DEFAULT NULL,
  `id_sender` int(11) DEFAULT NULL,
  `sender_name` varchar(255) DEFAULT NULL,
  `processed_on` datetime DEFAULT NULL,
  `is_process` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `udpated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `inbox` */

/*Table structure for table `outbox` */

DROP TABLE IF EXISTS `outbox`;

CREATE TABLE `outbox` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `query` text,
  `type` smallint(6) DEFAULT NULL COMMENT '1 = insert, 2 = update, 3 = delete',
  `label` varchar(255) DEFAULT NULL,
  `table` varchar(255) DEFAULT NULL,
  `pk` bigint(20) DEFAULT NULL,
  `prev_pk` bigint(20) DEFAULT NULL,
  `uuid` varchar(36) DEFAULT NULL,
  `processed_on` datetime DEFAULT NULL,
  `send_to` varchar(255) DEFAULT NULL,
  `is_sent` tinyint(1) DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=latin1;

/*Data for the table `outbox` */

insert  into `outbox`(`id`,`query`,`type`,`label`,`table`,`pk`,`prev_pk`,`uuid`,`processed_on`,`send_to`,`is_sent`,`created_at`,`updated_at`) values 
(1,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'1\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b3c2bc2-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',1,1,'4b3c2bc2-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(2,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'2\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b409219-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',2,2,'4b409219-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(3,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'3\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b409a30-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',3,3,'4b409a30-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(4,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'4\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b40a140-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',4,4,'4b40a140-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(5,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'5\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b40c2b5-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',5,5,'4b40c2b5-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(6,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'6\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b40c8b0-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',6,6,'4b40c8b0-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(7,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'7\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b40ceb3-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',7,7,'4b40ceb3-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(8,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'8\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b40d291-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',8,8,'4b40d291-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(9,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'9\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b40d9ec-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',9,9,'4b40d9ec-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(10,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'10\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b40de68-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',10,10,'4b40de68-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(11,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'11\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b40e1a9-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',11,11,'4b40e1a9-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(12,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'12\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b40e4dd-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',12,12,'4b40e4dd-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(13,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'13\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b40f161-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',13,13,'4b40f161-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(14,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'14\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b40f922-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',14,14,'4b40f922-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(15,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'15\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b40fedb-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',15,15,'4b40fedb-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(16,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'16\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b410256-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',16,16,'4b410256-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(17,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'17\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b41059d-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',17,17,'4b41059d-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(18,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'18\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b4108c2-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',18,18,'4b4108c2-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(19,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'19\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b410bca-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',19,19,'4b410bca-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(20,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'20\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b410f26-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',20,20,'4b410f26-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(21,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'21\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b411577-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',21,21,'4b411577-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(22,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'22\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b4118da-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',22,22,'4b4118da-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(23,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'23\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b411bf1-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',23,23,'4b411bf1-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(24,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'24\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b411ef8-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',24,24,'4b411ef8-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(25,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'25\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b41223d-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',25,25,'4b41223d-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(26,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'26\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b41253e-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',26,26,'4b41253e-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(27,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'27\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b412840-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',27,27,'4b412840-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(28,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'28\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b412b48-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',28,28,'4b412b48-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(29,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'29\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b412e7f-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',29,29,'4b412e7f-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(30,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'30\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b41318a-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',30,30,'4b41318a-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(31,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'31\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b4134c6-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',31,31,'4b4134c6-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(32,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'32\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b4137d8-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',32,32,'4b4137d8-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(33,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'33\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b413d14-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',33,33,'4b413d14-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(34,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'34\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b41415f-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',34,34,'4b41415f-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(35,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'35\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b4147b7-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',35,35,'4b4147b7-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(36,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'36\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b414d65-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',36,36,'4b414d65-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(37,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'37\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b41515c-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',37,37,'4b41515c-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(38,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'38\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b415470-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',38,38,'4b415470-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(39,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'39\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b415778-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',39,39,'4b415778-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(40,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'40\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b415a83-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',40,40,'4b415a83-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(41,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'41\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b415d8c-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',41,41,'4b415d8c-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(42,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'42\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b41628d-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',42,42,'4b41628d-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(43,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'43\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b41665f-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',43,43,'4b41665f-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(44,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'44\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b416ce0-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',44,44,'4b416ce0-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(45,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'45\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b4172f9-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',45,45,'4b4172f9-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(46,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'46\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b417695-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',46,46,'4b417695-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(47,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'47\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b4179af-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',47,47,'4b4179af-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(48,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'48\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b417ceb-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',48,48,'4b417ceb-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(49,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'49\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b417fff-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',49,49,'4b417fff-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(50,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'50\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b418301-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',50,50,'4b418301-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(51,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'51\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b41863e-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',51,51,'4b41863e-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(52,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'52\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b418b0d-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',52,52,'4b418b0d-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(53,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'53\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b419109-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',53,53,'4b419109-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(54,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'54\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b41954e-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',54,54,'4b41954e-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(55,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'55\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b419865-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',55,55,'4b419865-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(56,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'56\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b419b83-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',56,56,'4b419b83-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(57,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'57\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b419e94-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',57,57,'4b419e94-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(58,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'58\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b41a1c5-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',58,58,'4b41a1c5-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(59,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'59\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b506c1b-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',59,59,'4b506c1b-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(60,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'60\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b507435-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',60,60,'4b507435-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(61,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'61\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b507918-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',61,61,'4b507918-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(62,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'62\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b50a918-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',62,62,'4b50a918-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(63,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'63\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b50af31-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',63,63,'4b50af31-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(64,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'64\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b50b7f3-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',64,64,'4b50b7f3-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(65,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'65\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b50be27-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',65,65,'4b50be27-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(66,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'66\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b50c1d1-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',66,66,'4b50c1d1-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(67,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'67\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b50c51b-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',67,67,'4b50c51b-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(68,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'68\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b50c88a-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',68,68,'4b50c88a-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(69,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'69\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b50cc42-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',69,69,'4b50cc42-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(70,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'70\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b50d156-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',70,70,'4b50d156-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(71,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'71\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b50d75b-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',71,71,'4b50d75b-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(72,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'72\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b50df66-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',72,72,'4b50df66-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(73,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'73\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b50e8bb-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',73,73,'4b50e8bb-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(74,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'74\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b50ec32-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',74,74,'4b50ec32-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(75,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'75\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b50ef68-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',75,75,'4b50ef68-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(76,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'76\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b50f316-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',76,76,'4b50f316-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(77,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'77\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b50f884-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',77,77,'4b50f884-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(78,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'78\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b50fdf4-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',78,78,'4b50fdf4-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(79,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'79\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b510618-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',79,79,'4b510618-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(80,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'80\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b510b6b-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',80,80,'4b510b6b-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(81,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'81\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b510eb0-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',81,81,'4b510eb0-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(82,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'82\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b5111d7-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',82,82,'4b5111d7-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(83,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'83\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b5114f6-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',83,83,'4b5114f6-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(84,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'84\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b511813-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',84,84,'4b511813-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(85,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'85\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b511d42-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',85,85,'4b511d42-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(86,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'86\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b5121a3-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',86,86,'4b5121a3-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(87,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'87\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b513085-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',87,87,'4b513085-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(88,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'88\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b5134a0-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',88,88,'4b5134a0-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(89,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'89\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b5137cb-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',89,89,'4b5137cb-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(90,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'90\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b513b14-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',90,90,'4b513b14-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(91,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'91\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b513e2b-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',91,91,'4b513e2b-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(92,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'92\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b514846-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',92,92,'4b514846-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(93,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'93\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b515028-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',93,93,'4b515028-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(94,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'94\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b515749-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',94,94,'4b515749-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(95,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'95\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b515ac4-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',95,95,'4b515ac4-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(96,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'96\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b515e2c-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',96,96,'4b515e2c-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(97,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'97\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b516152-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',97,97,'4b516152-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(98,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'98\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b516478-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',98,98,'4b516478-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(99,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'99\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b5167de-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',99,99,'4b5167de-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22'),
(100,'INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES (\'100\', \'2017-12-09 12:43:14\', \'11\', \'1\', \'4b516d10-2ca1-11eb-a1dd-88d7f66e68b3\', \'0\')',1,'PRI','trx',100,100,'4b516d10-2ca1-11eb-a1dd-88d7f66e68b3',NULL,NULL,1,'2020-11-22 17:01:22','2020-11-22 17:01:22');

/*Table structure for table `trx` */

DROP TABLE IF EXISTS `trx`;

CREATE TABLE `trx` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nim` varchar(20) DEFAULT NULL,
  `waktu` datetime DEFAULT NULL,
  `nominal_ukt` double DEFAULT NULL,
  `flag` tinyint(4) DEFAULT NULL,
  `uuid` varchar(36) DEFAULT NULL,
  `pk_correction` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=latin1;

/*Data for the table `trx` */

insert  into `trx`(`id`,`nim`,`waktu`,`nominal_ukt`,`flag`,`uuid`,`pk_correction`) values 
(1,'1','2017-12-09 12:43:14',11,1,'4b3c2bc2-2ca1-11eb-a1dd-88d7f66e68b3',0),
(2,'2','2017-12-09 12:43:14',11,1,'4b409219-2ca1-11eb-a1dd-88d7f66e68b3',0),
(3,'3','2017-12-09 12:43:14',11,1,'4b409a30-2ca1-11eb-a1dd-88d7f66e68b3',0),
(4,'4','2017-12-09 12:43:14',11,1,'4b40a140-2ca1-11eb-a1dd-88d7f66e68b3',0),
(5,'5','2017-12-09 12:43:14',11,1,'4b40c2b5-2ca1-11eb-a1dd-88d7f66e68b3',0),
(6,'6','2017-12-09 12:43:14',11,1,'4b40c8b0-2ca1-11eb-a1dd-88d7f66e68b3',0),
(7,'7','2017-12-09 12:43:14',11,1,'4b40ceb3-2ca1-11eb-a1dd-88d7f66e68b3',0),
(8,'8','2017-12-09 12:43:14',11,1,'4b40d291-2ca1-11eb-a1dd-88d7f66e68b3',0),
(9,'9','2017-12-09 12:43:14',11,1,'4b40d9ec-2ca1-11eb-a1dd-88d7f66e68b3',0),
(10,'10','2017-12-09 12:43:14',11,1,'4b40de68-2ca1-11eb-a1dd-88d7f66e68b3',0),
(11,'11','2017-12-09 12:43:14',11,1,'4b40e1a9-2ca1-11eb-a1dd-88d7f66e68b3',0),
(12,'12','2017-12-09 12:43:14',11,1,'4b40e4dd-2ca1-11eb-a1dd-88d7f66e68b3',0),
(13,'13','2017-12-09 12:43:14',11,1,'4b40f161-2ca1-11eb-a1dd-88d7f66e68b3',0),
(14,'14','2017-12-09 12:43:14',11,1,'4b40f922-2ca1-11eb-a1dd-88d7f66e68b3',0),
(15,'15','2017-12-09 12:43:14',11,1,'4b40fedb-2ca1-11eb-a1dd-88d7f66e68b3',0),
(16,'16','2017-12-09 12:43:14',11,1,'4b410256-2ca1-11eb-a1dd-88d7f66e68b3',0),
(17,'17','2017-12-09 12:43:14',11,1,'4b41059d-2ca1-11eb-a1dd-88d7f66e68b3',0),
(18,'18','2017-12-09 12:43:14',11,1,'4b4108c2-2ca1-11eb-a1dd-88d7f66e68b3',0),
(19,'19','2017-12-09 12:43:14',11,1,'4b410bca-2ca1-11eb-a1dd-88d7f66e68b3',0),
(20,'20','2017-12-09 12:43:14',11,1,'4b410f26-2ca1-11eb-a1dd-88d7f66e68b3',0),
(21,'21','2017-12-09 12:43:14',11,1,'4b411577-2ca1-11eb-a1dd-88d7f66e68b3',0),
(22,'22','2017-12-09 12:43:14',11,1,'4b4118da-2ca1-11eb-a1dd-88d7f66e68b3',0),
(23,'23','2017-12-09 12:43:14',11,1,'4b411bf1-2ca1-11eb-a1dd-88d7f66e68b3',0),
(24,'24','2017-12-09 12:43:14',11,1,'4b411ef8-2ca1-11eb-a1dd-88d7f66e68b3',0),
(25,'25','2017-12-09 12:43:14',11,1,'4b41223d-2ca1-11eb-a1dd-88d7f66e68b3',0),
(26,'26','2017-12-09 12:43:14',11,1,'4b41253e-2ca1-11eb-a1dd-88d7f66e68b3',0),
(27,'27','2017-12-09 12:43:14',11,1,'4b412840-2ca1-11eb-a1dd-88d7f66e68b3',0),
(28,'28','2017-12-09 12:43:14',11,1,'4b412b48-2ca1-11eb-a1dd-88d7f66e68b3',0),
(29,'29','2017-12-09 12:43:14',11,1,'4b412e7f-2ca1-11eb-a1dd-88d7f66e68b3',0),
(30,'30','2017-12-09 12:43:14',11,1,'4b41318a-2ca1-11eb-a1dd-88d7f66e68b3',0),
(31,'31','2017-12-09 12:43:14',11,1,'4b4134c6-2ca1-11eb-a1dd-88d7f66e68b3',0),
(32,'32','2017-12-09 12:43:14',11,1,'4b4137d8-2ca1-11eb-a1dd-88d7f66e68b3',0),
(33,'33','2017-12-09 12:43:14',11,1,'4b413d14-2ca1-11eb-a1dd-88d7f66e68b3',0),
(34,'34','2017-12-09 12:43:14',11,1,'4b41415f-2ca1-11eb-a1dd-88d7f66e68b3',0),
(35,'35','2017-12-09 12:43:14',11,1,'4b4147b7-2ca1-11eb-a1dd-88d7f66e68b3',0),
(36,'36','2017-12-09 12:43:14',11,1,'4b414d65-2ca1-11eb-a1dd-88d7f66e68b3',0),
(37,'37','2017-12-09 12:43:14',11,1,'4b41515c-2ca1-11eb-a1dd-88d7f66e68b3',0),
(38,'38','2017-12-09 12:43:14',11,1,'4b415470-2ca1-11eb-a1dd-88d7f66e68b3',0),
(39,'39','2017-12-09 12:43:14',11,1,'4b415778-2ca1-11eb-a1dd-88d7f66e68b3',0),
(40,'40','2017-12-09 12:43:14',11,1,'4b415a83-2ca1-11eb-a1dd-88d7f66e68b3',0),
(41,'41','2017-12-09 12:43:14',11,1,'4b415d8c-2ca1-11eb-a1dd-88d7f66e68b3',0),
(42,'42','2017-12-09 12:43:14',11,1,'4b41628d-2ca1-11eb-a1dd-88d7f66e68b3',0),
(43,'43','2017-12-09 12:43:14',11,1,'4b41665f-2ca1-11eb-a1dd-88d7f66e68b3',0),
(44,'44','2017-12-09 12:43:14',11,1,'4b416ce0-2ca1-11eb-a1dd-88d7f66e68b3',0),
(45,'45','2017-12-09 12:43:14',11,1,'4b4172f9-2ca1-11eb-a1dd-88d7f66e68b3',0),
(46,'46','2017-12-09 12:43:14',11,1,'4b417695-2ca1-11eb-a1dd-88d7f66e68b3',0),
(47,'47','2017-12-09 12:43:14',11,1,'4b4179af-2ca1-11eb-a1dd-88d7f66e68b3',0),
(48,'48','2017-12-09 12:43:14',11,1,'4b417ceb-2ca1-11eb-a1dd-88d7f66e68b3',0),
(49,'49','2017-12-09 12:43:14',11,1,'4b417fff-2ca1-11eb-a1dd-88d7f66e68b3',0),
(50,'50','2017-12-09 12:43:14',11,1,'4b418301-2ca1-11eb-a1dd-88d7f66e68b3',0),
(51,'51','2017-12-09 12:43:14',11,1,'4b41863e-2ca1-11eb-a1dd-88d7f66e68b3',0),
(52,'52','2017-12-09 12:43:14',11,1,'4b418b0d-2ca1-11eb-a1dd-88d7f66e68b3',0),
(53,'53','2017-12-09 12:43:14',11,1,'4b419109-2ca1-11eb-a1dd-88d7f66e68b3',0),
(54,'54','2017-12-09 12:43:14',11,1,'4b41954e-2ca1-11eb-a1dd-88d7f66e68b3',0),
(55,'55','2017-12-09 12:43:14',11,1,'4b419865-2ca1-11eb-a1dd-88d7f66e68b3',0),
(56,'56','2017-12-09 12:43:14',11,1,'4b419b83-2ca1-11eb-a1dd-88d7f66e68b3',0),
(57,'57','2017-12-09 12:43:14',11,1,'4b419e94-2ca1-11eb-a1dd-88d7f66e68b3',0),
(58,'58','2017-12-09 12:43:14',11,1,'4b41a1c5-2ca1-11eb-a1dd-88d7f66e68b3',0),
(59,'59','2017-12-09 12:43:14',11,1,'4b506c1b-2ca1-11eb-a1dd-88d7f66e68b3',0),
(60,'60','2017-12-09 12:43:14',11,1,'4b507435-2ca1-11eb-a1dd-88d7f66e68b3',0),
(61,'61','2017-12-09 12:43:14',11,1,'4b507918-2ca1-11eb-a1dd-88d7f66e68b3',0),
(62,'62','2017-12-09 12:43:14',11,1,'4b50a918-2ca1-11eb-a1dd-88d7f66e68b3',0),
(63,'63','2017-12-09 12:43:14',11,1,'4b50af31-2ca1-11eb-a1dd-88d7f66e68b3',0),
(64,'64','2017-12-09 12:43:14',11,1,'4b50b7f3-2ca1-11eb-a1dd-88d7f66e68b3',0),
(65,'65','2017-12-09 12:43:14',11,1,'4b50be27-2ca1-11eb-a1dd-88d7f66e68b3',0),
(66,'66','2017-12-09 12:43:14',11,1,'4b50c1d1-2ca1-11eb-a1dd-88d7f66e68b3',0),
(67,'67','2017-12-09 12:43:14',11,1,'4b50c51b-2ca1-11eb-a1dd-88d7f66e68b3',0),
(68,'68','2017-12-09 12:43:14',11,1,'4b50c88a-2ca1-11eb-a1dd-88d7f66e68b3',0),
(69,'69','2017-12-09 12:43:14',11,1,'4b50cc42-2ca1-11eb-a1dd-88d7f66e68b3',0),
(70,'70','2017-12-09 12:43:14',11,1,'4b50d156-2ca1-11eb-a1dd-88d7f66e68b3',0),
(71,'71','2017-12-09 12:43:14',11,1,'4b50d75b-2ca1-11eb-a1dd-88d7f66e68b3',0),
(72,'72','2017-12-09 12:43:14',11,1,'4b50df66-2ca1-11eb-a1dd-88d7f66e68b3',0),
(73,'73','2017-12-09 12:43:14',11,1,'4b50e8bb-2ca1-11eb-a1dd-88d7f66e68b3',0),
(74,'74','2017-12-09 12:43:14',11,1,'4b50ec32-2ca1-11eb-a1dd-88d7f66e68b3',0),
(75,'75','2017-12-09 12:43:14',11,1,'4b50ef68-2ca1-11eb-a1dd-88d7f66e68b3',0),
(76,'76','2017-12-09 12:43:14',11,1,'4b50f316-2ca1-11eb-a1dd-88d7f66e68b3',0),
(77,'77','2017-12-09 12:43:14',11,1,'4b50f884-2ca1-11eb-a1dd-88d7f66e68b3',0),
(78,'78','2017-12-09 12:43:14',11,1,'4b50fdf4-2ca1-11eb-a1dd-88d7f66e68b3',0),
(79,'79','2017-12-09 12:43:14',11,1,'4b510618-2ca1-11eb-a1dd-88d7f66e68b3',0),
(80,'80','2017-12-09 12:43:14',11,1,'4b510b6b-2ca1-11eb-a1dd-88d7f66e68b3',0),
(81,'81','2017-12-09 12:43:14',11,1,'4b510eb0-2ca1-11eb-a1dd-88d7f66e68b3',0),
(82,'82','2017-12-09 12:43:14',11,1,'4b5111d7-2ca1-11eb-a1dd-88d7f66e68b3',0),
(83,'83','2017-12-09 12:43:14',11,1,'4b5114f6-2ca1-11eb-a1dd-88d7f66e68b3',0),
(84,'84','2017-12-09 12:43:14',11,1,'4b511813-2ca1-11eb-a1dd-88d7f66e68b3',0),
(85,'85','2017-12-09 12:43:14',11,1,'4b511d42-2ca1-11eb-a1dd-88d7f66e68b3',0),
(86,'86','2017-12-09 12:43:14',11,1,'4b5121a3-2ca1-11eb-a1dd-88d7f66e68b3',0),
(87,'87','2017-12-09 12:43:14',11,1,'4b513085-2ca1-11eb-a1dd-88d7f66e68b3',0),
(88,'88','2017-12-09 12:43:14',11,1,'4b5134a0-2ca1-11eb-a1dd-88d7f66e68b3',0),
(89,'89','2017-12-09 12:43:14',11,1,'4b5137cb-2ca1-11eb-a1dd-88d7f66e68b3',0),
(90,'90','2017-12-09 12:43:14',11,1,'4b513b14-2ca1-11eb-a1dd-88d7f66e68b3',0),
(91,'91','2017-12-09 12:43:14',11,1,'4b513e2b-2ca1-11eb-a1dd-88d7f66e68b3',0),
(92,'92','2017-12-09 12:43:14',11,1,'4b514846-2ca1-11eb-a1dd-88d7f66e68b3',0),
(93,'93','2017-12-09 12:43:14',11,1,'4b515028-2ca1-11eb-a1dd-88d7f66e68b3',0),
(94,'94','2017-12-09 12:43:14',11,1,'4b515749-2ca1-11eb-a1dd-88d7f66e68b3',0),
(95,'95','2017-12-09 12:43:14',11,1,'4b515ac4-2ca1-11eb-a1dd-88d7f66e68b3',0),
(96,'96','2017-12-09 12:43:14',11,1,'4b515e2c-2ca1-11eb-a1dd-88d7f66e68b3',0),
(97,'97','2017-12-09 12:43:14',11,1,'4b516152-2ca1-11eb-a1dd-88d7f66e68b3',0),
(98,'98','2017-12-09 12:43:14',11,1,'4b516478-2ca1-11eb-a1dd-88d7f66e68b3',0),
(99,'99','2017-12-09 12:43:14',11,1,'4b5167de-2ca1-11eb-a1dd-88d7f66e68b3',0),
(100,'100','2017-12-09 12:43:14',11,1,'4b516d10-2ca1-11eb-a1dd-88d7f66e68b3',0);

/* Trigger structure for table `changelog` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `changelog_to_outbox` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `changelog_to_outbox` AFTER INSERT ON `changelog` FOR EACH ROW BEGIN
                DECLARE label VARCHAR(5) DEFAULT 'PRI';
                IF NEW.type = 2 THEN
                    SET label = 'UPD';
                ELSEIF NEW.type = 3 THEN
                    SET label = 'DEL';
                END IF;
                INSERT INTO outbox(`query`, `table`, `pk`, `prev_pk`, `type`, `label`, `uuid`) VALUES (NEW.query, NEW.table, NEW.pk, NEW.prev_pk, NEW.type, label, NEW.uuid);
			END */$$


DELIMITER ;

/* Trigger structure for table `trx` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `before_insert_trx` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `before_insert_trx` BEFORE INSERT ON `trx` FOR EACH ROW BEGIN IF NEW.uuid IS NULL THEN             SET NEW.uuid = UUID(); END IF; END */$$


DELIMITER ;

/* Trigger structure for table `trx` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `after_insert_trx` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `after_insert_trx` AFTER INSERT ON `trx` FOR EACH ROW 		INSERT INTO changelog(`query`, `table`, `pk`, `prev_pk`, `type`, `uuid`) VALUES(CONCAT("INSERT INTO trx (nim, waktu, nominal_ukt, flag, uuid, pk_correction) VALUES ('", NEW.nim,"', '", NEW.waktu,"', '", NEW.nominal_ukt,"', '", NEW.flag,"', '", NEW.uuid,"', '", NEW.pk_correction,"')"), "trx", NEW.id, NEW.id, 1, NEW.uuid) */$$


DELIMITER ;

/* Trigger structure for table `trx` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `after_update_trx` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `after_update_trx` AFTER UPDATE ON `trx` FOR EACH ROW BEGIN IF NEW.pk_correction = 0 AND OLD.pk_correction = 0 THEN			INSERT INTO changelog(`query`, `table`, `pk`, `prev_pk`, `type`, `uuid`) VALUES(CONCAT("UPDATE trx SET nim = '", NEW.nim,"', waktu = '", NEW.waktu,"', nominal_ukt = '", NEW.nominal_ukt,"', flag = '", NEW.flag,"', uuid = '", NEW.uuid,"', pk_correction = '", NEW.pk_correction,"' WHERE id = '", OLD.id,"'"), "trx", NEW.id, OLD.id, 2, NEW.uuid); END IF; END */$$


DELIMITER ;

/* Trigger structure for table `trx` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `after_delete_trx` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `after_delete_trx` BEFORE DELETE ON `trx` FOR EACH ROW INSERT INTO changelog(`query`, `table`, `pk`, `prev_pk`, `type`, `uuid`)			VALUES (CONCAT("DELETE FROM trx WHERE id=", OLD.id), "trx", OLD.id, OLD.id, 3, OLD.uuid) */$$


DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
