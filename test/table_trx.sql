CREATE TABLE IF NOT EXISTS `tb_trx` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `nim` VARCHAR(20) DEFAULT NULL,
  `waktu` DATETIME DEFAULT NULL,
  `nominal_ukt` DOUBLE DEFAULT NULL,
  `flag` TINYINT(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
);
