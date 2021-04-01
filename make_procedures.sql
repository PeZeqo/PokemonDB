USE pokemon;


-- GETTING POKEMON

DROP PROCEDURE IF EXISTS get_pokemon_by_id;
DELIMITER $$

CREATE PROCEDURE get_pokemon_by_id(IN pk_id INT)
BEGIN
	SELECT * FROM pokemon WHERE pokemon_id = pk_id;
END $$

DELIMITER ;
CALL get_pokemon_by_id(1);


-- ADDING POKEMON

DROP PROCEDURE IF EXISTS add_pokemon;
DELIMITER $$

CREATE PROCEDURE add_pokemon(IN pk_id INT, IN name VARCHAR(50), IN type1 VARCHAR(20), IN type2 VARCHAR(20))
BEGIN
	INSERT INTO pokemon VALUES(pk_id, name, type1, type2);
END $$

DELIMITER ;

CALL add_pokemon(720, "thing", "Normal", NULL);
CALL get_pokemon_by_id(720);


-- GET POKEMON WITH STATS

DROP PROCEDURE IF EXISTS get_pokemon_and_stats;
DELIMITER $$

CREATE PROCEDURE get_pokemon_and_stats(IN pk_id INT)
BEGIN
	SELECT * FROM pokemon pk
    NATURAL JOIN stats
    WHERE pokemon_id = pk_id;
END $$

DELIMITER ;
CALL get_pokemon_and_stats(1);


-- REMOVE POKEMON

DROP PROCEDURE IF EXISTS remove_pokemon;
DELIMITER $$

CREATE PROCEDURE remove_pokemon(IN pk_id INT)
BEGIN
	DELETE FROM pokemon WHERE pokemon_id = pk_id;
END $$

DELIMITER ;

CALL remove_pokemon(720);




-- GETTING STATS

DROP PROCEDURE IF EXISTS get_pokemon_stats_by_id;
DELIMITER $$

CREATE PROCEDURE get_pokemon_stats_by_id(IN pk_id INT)
BEGIN
	SELECT * FROM stats WHERE pokemon_id = pk_id;
END $$

DELIMITER ;
CALL get_pokemon_stats_by_id(1);


-- ADDING STATS

DROP PROCEDURE IF EXISTS add_stats;
DELIMITER $$

CREATE PROCEDURE add_stats(IN pk_id INT, IN hp INT, IN atk INT, IN def INT, IN spatk INT, IN spdef INT, IN spd INT)
BEGIN
	INSERT INTO stats VALUES(pk_id, hp, atk, def, spatk, spdef, spd);
END $$

DELIMITER ;

CALL add_pokemon(720, "thing", "Normal", NULL);
CALL add_stats(720, 10, 9, 8, 7, 6, 5);
CALL get_pokemon_stats_by_id(720);


-- UPDATE STATS

DROP PROCEDURE IF EXISTS update_stats;
DELIMITER $$

CREATE PROCEDURE update_stats(IN pk_id INT, IN hp INT, IN atk INT, IN def INT, IN spatk INT, IN spdef INT, IN spd INT)
BEGIN
	UPDATE Stats
    SET health_points = hp,
    attack = atk,
    defense = def,
    special_defense = spdef,
    special_attack = spatk,
    speed = spd
    WHERE pokemon_id = pk_id;
END $$

DELIMITER ;

CALL update_stats(720, 11, 12, 13, 14, 15, 16);
CALL get_pokemon_stats_by_id(720);


-- REMOVE STATS

DROP PROCEDURE IF EXISTS remove_stats;
DELIMITER $$

CREATE PROCEDURE remove_stats(IN pk_id INT)
BEGIN
	DELETE FROM stats WHERE pokemon_id = pk_id;
END $$

DELIMITER ;

CALL remove_stats(720);






-- TRAINER BATTLE TRIGGERS

DROP TRIGGER IF EXISTS increment_trainer_money;
DELIMITER $$

CREATE TRIGGER increment_trainer_money
	AFTER INSERT ON Battle
	FOR EACH ROW
BEGIN
	UPDATE Trainer
	SET money = (money+NEW.prize)
	WHERE trainer_id = NEW.winner;
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