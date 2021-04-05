USE pokemon;


/*
-------------------------------------
POKEMON PROCEDURES
-------------------------------------
*/

-- ADDING POKEMON

DROP PROCEDURE IF EXISTS add_pokemon;
DELIMITER $$

CREATE PROCEDURE add_pokemon(IN name VARCHAR(50), IN type1 VARCHAR(20), IN type2 VARCHAR(20))
BEGIN
	INSERT INTO pokemon VALUES(NULL, name, type1, type2);
END $$

DELIMITER ;
CALL add_pokemon("thing", 1, NULL);


-- GETTING POKEMON

DROP PROCEDURE IF EXISTS get_pokemon_by_id;
DELIMITER $$

CREATE PROCEDURE get_pokemon_by_id(IN pk_id INT)
BEGIN
	SELECT * FROM pokemon WHERE pokemon_id = pk_id;
END $$

DELIMITER ;
CALL get_pokemon_by_id(1);

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



/*
-------------------------------------
STATS PROCEDURES
-------------------------------------
*/


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
CALL remove_pokemon(720);



/*
-------------------------------------
CAPTURED POKEMON PROCEDURES
-------------------------------------
*/




-- GETTING ALL OF TRAINERS CAPTURED POKEMON

DROP PROCEDURE IF EXISTS get_trainers_pokemon;
DELIMITER $$

CREATE PROCEDURE get_trainers_pokemon(IN tr_id INT)
BEGIN
	SELECT * FROM capturedpokemon WHERE trainer_id = tr_id;
END $$

DELIMITER ;


-- GETTING CAPTURED POKEMON

DROP PROCEDURE IF EXISTS get_captured_pokemon;
DELIMITER $$

CREATE PROCEDURE get_captured_pokemon(IN cpk_id INT)
BEGIN
	SELECT * FROM capturedpokemon WHERE capt_pokemon_id = cpk_id;
END $$

DELIMITER ;


-- GETTING CAPTURED POKEMON WITH STATS AND MOVES

DROP PROCEDURE IF EXISTS get_captured_pokemon_with_moves_and_stats;
DELIMITER $$

CREATE PROCEDURE get_captured_pokemon_with_moves_and_stats(IN cpk_id INT)
BEGIN
	SELECT * FROM capturedpokemon
    NATURAL JOIN stats
    NATURAL JOIN moves
    NATURAL JOIN learnedmvoes
	WHERE capt_pokemon_id = cpk_id;
END $$

DELIMITER ;


-- ADDING CAPTURED POKEMON

DROP PROCEDURE IF EXISTS add_captured_pokemon;
DELIMITER $$

CREATE PROCEDURE add_captured_pokemon(IN pk_id INT, IN lvl INT, in nickname VARCHAR(50), IN tr_id INT)
BEGIN
	INSERT INTO capturedpokemon VALUES (NULL, pk_id, lvl, nickname, tr_id);
END $$


-- DELETING CAPTURED POKEMON

DROP PROCEDURE IF EXISTS remove_captured_pokemon;
DELIMITER $$

CREATE PROCEDURE remove_captured_pokemon(IN cpk_id INT)
BEGIN
	DELETE FROM capturedpokemon WHERE capt_pokemon_id = cpk_id;
END $$

DELIMITER ;


-- LEVEL CAPTURED POKEMON

DROP PROCEDURE IF EXISTS level_captured_pokemon;
DELIMITER $$

CREATE PROCEDURE level_captured_pokemon(IN cpk_id INT)
BEGIN
	UPDATE capturedpokemon SET level = level + 1 WHERE capt_pokemon_id = cpk_id;
END $$

DELIMITER ;



/*
-------------------------------------
MOVE PROCEDURES
-------------------------------------
*/


-- GETTING A MOVE

DROP PROCEDURE IF EXISTS get_move_by_id;
DELIMITER $$

CREATE PROCEDURE get_move_by_id(IN mv_id INT)
BEGIN
	SELECT * FROM move WHERE move_id = mv_id;
END $$


-- GETTING A MOVE BY NAME

DROP PROCEDURE IF EXISTS get_move_by_name;
DELIMITER $$

CREATE PROCEDURE get_move_by_name(IN move_name VARCHAR(50))
BEGIN
	SELECT * FROM move WHERE name = move_name;
END $$

-- ADDING A MOVE

DROP PROCEDURE IF EXISTS add_move;
DELIMITER $$

CREATE PROCEDURE add_move(IN name VARCHAR(50),
	IN type_name VARCHAR(20),
    IN power INT,
    IN accuracy INT,
    IN pp INT,
    IN category VARCHAR(20))
BEGIN
	INSERT INTO move VALUES (NULL, name, type_name, power, accuracy, pp, category);
END $$


-- DELETING A MOVE

DROP PROCEDURE IF EXISTS remove_move;
DELIMITER $$

CREATE PROCEDURE remove_move(IN mv_id INT)
BEGIN
	DELETE FROM move WHERE move_id = mv_id;
END $$

DELIMITER ;



/*
-------------------------------------
LEARNED MOVES PROCEDURES
-------------------------------------
*/


-- GETTING A POKEMON'S MOVES

DROP PROCEDURE IF EXISTS get_pokemon_moves;
DELIMITER $$

CREATE PROCEDURE get_pokemon_moves(IN cpt_pk_id INT)
BEGIN
	SELECT move.* FROM move 
    NATURAL JOIN capturedpokemon
    WHERE capt_pokemon_id = cpt_pk_id;
END $$


-- LEARNING A MOVE BY ID

DROP PROCEDURE IF EXISTS learn_move_by_id;
DELIMITER $$

CREATE PROCEDURE learn_move_by_id(IN move_id INT, IN cpt_pk_id INT)
BEGIN
	INSERT INTO learnedmoves VALUES (move_id, cpt_pk_id);
END $$


-- LEARNING A MOVE BY NAME

DROP PROCEDURE IF EXISTS learn_move_by_name;
DELIMITER $$

CREATE PROCEDURE learn_move_by_name(IN move_name VARCHAR(50), IN cpt_pk_id INT)
BEGIN
	INSERT INTO learnedmoves VALUES (
		(SELECT move_id FROM move WHERE name = move_name), 
        cpt_pk_id);
END $$


-- FORGET A MOVE BY ID

DROP PROCEDURE IF EXISTS forget_move_by_id;
DELIMITER $$

CREATE PROCEDURE forget_move_by_id(IN mv_id INT, IN cpt_pk_id INT)
BEGIN
	DELETE FROM learnedmoves 
    WHERE move_id = mv_id AND capt_pokemon_id = cpt_pk_id;
END $$


-- FORGET A MOVE BY NAME

DROP PROCEDURE IF EXISTS forget_move_by_name;
DELIMITER $$

CREATE PROCEDURE forget_move_by_name(IN move_name VARCHAR(50), IN cpt_pk_id INT)
BEGIN
	DELETE FROM learnedmoves 
    WHERE move_id = (SELECT move_id FROM move WHERE name = move_name) 
    AND capt_pokemon_id = cpt_pk_id;
END $$



/*
-------------------------------------
TRAINER PROCEDURES
-------------------------------------
*/


-- GETTING A TRAINER

DROP PROCEDURE IF EXISTS get_trainer;
DELIMITER $$

CREATE PROCEDURE get_trainer(IN tr_id INT)
BEGIN
	SELECT * FROM trainer WHERE trainer_id = tr_id;
END $$


-- ADDING A TRAINER

DROP PROCEDURE IF EXISTS add_trainer;
DELIMITER $$

CREATE PROCEDURE add_trainer(name VARCHAR(50))
BEGIN
	INSERT INTO trainer VALUES (NULL, name, 0, "Pallet Town", 0);
END $$


-- REMOVE A TRAINER

DROP PROCEDURE IF EXISTS remove_trainer;
DELIMITER $$

CREATE PROCEDURE remove_trainer(IN tr_id VARCHAR(50))
BEGIN
	DELETE FROM trainer WHERE trainer_id = tr_id;
END $$

DELIMITER ;



/*
-------------------------------------
TYPING PROCEDURES
-------------------------------------
*/


-- GETTING ALL TYPINGS

DROP PROCEDURE IF EXISTS get_types;
DELIMITER $$

CREATE PROCEDURE get_types()
BEGIN
	SELECT * FROM typing;
END $$


-- ADDING A TYPING

DROP PROCEDURE IF EXISTS add_type;
DELIMITER $$

CREATE PROCEDURE add_type(name VARCHAR(20))
BEGIN
	INSERT INTO typing VALUES (NULL, name);
END $$


-- REMOVE A TYPE

DROP PROCEDURE IF EXISTS remove_type;
DELIMITER $$

CREATE PROCEDURE remove_type(IN t_id INT)
BEGIN
	DELETE FROM typing WHERE type_id = t_id;
END $$

DELIMITER ;



/*
-------------------------------------
EVOLUTIONS PROCEDURES
-------------------------------------
*/


-- GETTING ALL EVOLUTIONS

DROP PROCEDURE IF EXISTS get_evolutions;
DELIMITER $$

CREATE PROCEDURE get_evolutions()
BEGIN
	SELECT base_pokeomn, evolved_pokemon FROM evolutions e
    INNER JOIN (SELECT name as base_pokeomn, pk_id from evolutions) p1
    ON p1.pk_id = e.base_pokemon_id
    INNER JOIN (SELECT name as evolved_pokemon, pk_id from evolutions) p2
    ON p2.pk_id = e.evolved_pokemon_id;
END $$


-- ADDING AN EVOLTUION

DROP PROCEDURE IF EXISTS add_evolution;
DELIMITER $$

CREATE PROCEDURE add_evolution(IN bs_id INT, IN evo_id INT)
BEGIN
	INSERT INTO evolutions VALUES (bs_id, evo_id);
END $$


-- REMOVING AN EVOLUTION

DROP PROCEDURE IF EXISTS remove_evolution;
DELIMITER $$

CREATE PROCEDURE remove_evolution(IN bs_id INT, IN evo_id INT)
BEGIN
	DELETE FROM evolutions 
    WHERE base_pokemon_id = bs_id
    AND evolved_pokemon_id = evo_id;
END $$



/*
-------------------------------------
BATTLE PROCEDURES
-------------------------------------
*/


-- GETTING ALL TRAINER'S BATTLES

DROP PROCEDURE IF EXISTS get_trainer_battles;
DELIMITER $$

CREATE PROCEDURE get_trainer_battles(IN tr_id)
BEGIN
	SELECT * FROM battles
    WHERE trainer1 = tr_id
    OR trainer2 = tr_id;
END $$


-- ADDING A BATTLE

DROP PROCEDURE IF EXISTS add_battle;
DELIMITER $$

CREATE PROCEDURE add_battle(IN tr_id1 INT, IN tr_id2 INT, IN winner INT, IN prize INT)
BEGIN
	INSERT INTO battles VALUES (NULL, tr_id1, tr_id2, winner, prize);
END $$


-- REMOVING A BATTLE

DROP PROCEDURE IF EXISTS remove_battle;
DELIMITER $$

CREATE PROCEDURE remove_battle(IN btl_id INT)
BEGIN
	DELETE FROM battles WHERE battle_id = btl_id;
END $$

