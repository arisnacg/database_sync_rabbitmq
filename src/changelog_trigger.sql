DELIMITER $$

USE `demo`$$

DROP TRIGGER /*!50032 IF EXISTS */ `changelog_to_outbox`$$

CREATE
    TRIGGER `changelog_to_outbox` AFTER INSERT ON `changelog` 
    FOR EACH ROW BEGIN
                DECLARE label VARCHAR(5) DEFAULT 'INS';
                DECLARE blocklist VARCHAR(100) DEFAULT NULL;
                IF NEW.type = 2 THEN
                    SET label = 'UPD';
                ELSEIF NEW.type = 3 THEN
                    SET label = 'DEL';
                END IF;
				IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'demo' AND TABLE_NAME = 'clients') THEN
					SELECT id_sender INTO blocklist FROM inbox WHERE `table` = NEW.table AND `type` = NEW.type AND `query` = NEW.query AND is_process = 1 ORDER BY created_at DESC LIMIT 1;
					IF blocklist IS NOT NULL THEN
						SET blocklist = CONCAT('.', blocklist);
					END IF;
				END IF;
				INSERT INTO outbox(`query`, `table`, `pk`, `prev_pk`, `type`, `label`, `block_list`) VALUES (NEW.query, NEW.table, NEW.pk, NEW.prev_pk, NEW.type, label, blocklist);
			END;
$$

DELIMITER ;
