-- TRAINER BATTLE TRIGGERS

DROP TRIGGER IF EXISTS increment_trainer_money;
DELIMITER $$

CREATE TRIGGER increment_trainer_money
	AFTER INSERT ON Battles
	FOR EACH ROW
BEGIN
	UPDATE Trainer
	SET money = (money+NEW.prize)
	WHERE trainer_id = NEW.winner;
    UPDATE Trainer
	SET money = (money-NEW.prize)
	WHERE trainer_id = IF(NEW.winner = NEW.trainer1, NEW.trainer2, NEW.trainer1);
END $$

DELIMITER ;


-- TRAINER CAPTURE TRIGGERS

DROP TRIGGER IF EXISTS increment_trainer_pokemon;
DELIMITER $$

CREATE TRIGGER increment_trainer_pokemon
	AFTER INSERT ON CapturedPokemon
	FOR EACH ROW
BEGIN
	UPDATE Trainer
	SET num_captured_pokemon = (num_captured_pokemon+1)
	WHERE trainer_id = NEW.trainer_id;
END $$

DELIMITER ;

DROP TRIGGER IF EXISTS deincrement_trainer_pokemon;
DELIMITER $$

CREATE TRIGGER deincrement_trainer_pokemon
	BEFORE DELETE ON CapturedPokemon
	FOR EACH ROW
BEGIN
	UPDATE Trainer
	SET num_captured_pokemon = (num_captured_pokemon-1)
	WHERE trainer_id = OLD.trainer_id;
END $$

DELIMITER ;