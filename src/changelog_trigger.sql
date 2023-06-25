DELIMITER $$

USE `demo`$$

DROP TRIGGER /*!50032 IF EXISTS */ `changelog_to_outbox`$$

CREATE
    /*!50017 DEFINER = 'root'@'%' */
    TRIGGER `changelog_to_outbox` AFTER INSERT ON `changelog` 

    FOR EACH ROW BEGIN

                DECLARE label VARCHAR(5) DEFAULT 'INS';
                IF NEW.type = 2 THEN
                    SET label = 'UPD';
                ELSEIF NEW.type = 3 THEN
                    SET label = 'DEL';
                END IF;
                INSERT INTO outbox(`query`, `table`, `pk`, `prev_pk`, `type`, `label`) VALUES (NEW.query, NEW.table, NEW.pk, NEW.prev_pk, NEW.type, label);
			END;
$$


DELIMITER ;
