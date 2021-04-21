USE pokemon;


/*
-------------------------------------
POKEMON PROCEDURES
-------------------------------------
*/

-- ADDING POKEMON

DROP PROCEDURE IF EXISTS add_pokemon;
DELIMITER $$

CREATE PROCEDURE add_pokemon(IN name VARCHAR(50), IN type1 INT, IN type2 INT)
BEGIN
	INSERT INTO pokemon VALUES(NULL, name, type1, type2);
END $$

DELIMITER ;


-- GETTING POKEMON

DROP PROCEDURE IF EXISTS get_pokemon_by_id;
DELIMITER $$

CREATE PROCEDURE get_pokemon_by_id(IN pk_id INT)
BEGIN
	SELECT * FROM pokemon WHERE pokemon_id = pk_id;
END $$

DELIMITER ;

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


-- REMOVE POKEMON

DROP PROCEDURE IF EXISTS remove_pokemon;
DELIMITER $$

CREATE PROCEDURE remove_pokemon(IN pk_id INT)
BEGIN
	DELETE FROM pokemon WHERE pokemon_id = pk_id;
END $$

DELIMITER ;



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


-- ADDING STATS

DROP PROCEDURE IF EXISTS add_stats;
DELIMITER $$

CREATE PROCEDURE add_stats(IN pk_id INT, IN hp INT, IN atk INT, IN def INT, IN spatk INT, IN spdef INT, IN spd INT)
BEGIN
	INSERT INTO stats VALUES(pk_id, hp, atk, def, spatk, spdef, spd);
END $$

DELIMITER ;


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


-- REMOVE STATS

DROP PROCEDURE IF EXISTS remove_stats;
DELIMITER $$

CREATE PROCEDURE remove_stats(IN pk_id INT)
BEGIN
	DELETE FROM stats WHERE pokemon_id = pk_id;
END $$

DELIMITER ;



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

DROP PROCEDURE IF EXISTS get_full_captured_pokemon_info;
DELIMITER $$

CREATE PROCEDURE get_full_captured_pokemon_info(IN cpk_id INT)
BEGIN
	SELECT * FROM capturedpokemon cp
    INNER JOIN stats s
    on s.pokemon_id = cp.pokemon_id
    INNER JOIN pokemon p
    on p.pokemon_id = cp.pokemon_id
    INNER JOIN (select type_name as type1_name, type_id from typing) t1
    on p.type1 = t1.type_id
    LEFT JOIN (select type_name as type2_name, type_id from typing) t2
    on p.type2 = t2.type_id
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

DELIMITER ;


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
	UPDATE capturedpokemon SET level = if(level = 100, 100, level + 1) WHERE capt_pokemon_id = cpk_id;
END $$

DELIMITER ;


-- RENAME CAPTURED POKEMON

DROP PROCEDURE IF EXISTS rename_captured_pokemon;
DELIMITER $$

CREATE PROCEDURE rename_captured_pokemon(IN cpk_id INT, IN name VARCHAR(50))
BEGIN
	UPDATE capturedpokemon SET nickname = name WHERE capt_pokemon_id = cpk_id;
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

DELIMITER ;


-- GETTING A MOVE BY NAME

DROP PROCEDURE IF EXISTS get_move_by_name;
DELIMITER $$

CREATE PROCEDURE get_move_by_name(IN move_name VARCHAR(50))
BEGIN
	SELECT * FROM move WHERE name = move_name;
END $$

DELIMITER ;

-- ADDING A MOVE

DROP PROCEDURE IF EXISTS add_move;
DELIMITER $$

CREATE PROCEDURE add_move(IN name VARCHAR(50),
	IN type INT,
    IN power INT,
    IN accuracy INT,
    IN pp INT,
    IN category VARCHAR(20))
BEGIN
	INSERT INTO move VALUES (NULL, name, type, power, accuracy, pp, category);
END $$

DELIMITER ;


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
	SELECT m.* FROM learnedmoves lm
    INNER JOIN move m
    ON m.move_id = lm.move_id
    INNER JOIN capturedpokemon cp
    ON cp.capt_pokemon_id = lm.capt_pokemon_id
    WHERE lm.capt_pokemon_id = cpt_pk_id;
END $$

DELIMITER ;


-- LEARNING A MOVE BY ID

DROP PROCEDURE IF EXISTS learn_move_by_id;
DELIMITER $$

CREATE PROCEDURE learn_move_by_id(IN cpt_pk_id INT, IN move_id INT)
BEGIN
	INSERT INTO learnedmoves VALUES (move_id, cpt_pk_id);
END $$

DELIMITER ;


-- LEARNING A MOVE BY NAME

DROP PROCEDURE IF EXISTS learn_move_by_name;
DELIMITER $$

CREATE PROCEDURE learn_move_by_name(IN cpt_pk_id INT, IN move_name VARCHAR(50))
BEGIN
	INSERT INTO learnedmoves VALUES (
		(SELECT move_id FROM move WHERE name = move_name), 
        cpt_pk_id);
END $$

DELIMITER ;


-- FORGET A MOVE BY ID

DROP PROCEDURE IF EXISTS forget_move_by_id;
DELIMITER $$

CREATE PROCEDURE forget_move_by_id(IN cpt_pk_id INT, IN mv_id INT)
BEGIN
	DELETE FROM learnedmoves 
    WHERE move_id = mv_id AND capt_pokemon_id = cpt_pk_id;
END $$

DELIMITER ;


-- FORGET A MOVE BY NAME

DROP PROCEDURE IF EXISTS forget_move_by_name;
DELIMITER $$

CREATE PROCEDURE forget_move_by_name(IN cpt_pk_id INT, IN move_name VARCHAR(50))
BEGIN
	DELETE FROM learnedmoves 
    WHERE move_id = (SELECT move_id FROM move WHERE name = move_name) 
    AND capt_pokemon_id = cpt_pk_id;
END $$

DELIMITER ;



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

DELIMITER ;


-- ADDING A TRAINER

DROP PROCEDURE IF EXISTS add_trainer;
DELIMITER $$

CREATE PROCEDURE add_trainer(name VARCHAR(50))
BEGIN
	INSERT INTO trainer VALUES (NULL, name, DEFAULT, DEFAULT, DEFAULT);
END $$

DELIMITER ;


-- Move A TRAINER

DROP PROCEDURE IF EXISTS move_trainer;
DELIMITER $$

CREATE PROCEDURE move_trainer(IN tr_id INT, IN new_loc VARCHAR(50))
BEGIN
	UPDATE trainer SET location=new_loc WHERE trainer_id = tr_id;
END $$

DELIMITER ;


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

DELIMITER ;


-- ADDING A TYPING

DROP PROCEDURE IF EXISTS add_type;
DELIMITER $$

CREATE PROCEDURE add_type(name VARCHAR(20))
BEGIN
	INSERT INTO typing VALUES (NULL, name);
END $$

DELIMITER ;


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
	INNER JOIN (SELECT name as base_pokeomn, pokemon_id from pokemon) p1
	ON p1.pokemon_id = e.base_pokemon_id
	INNER JOIN (SELECT name as evolved_pokemon, pokemon_id from pokemon) p2
	ON p2.pokemon_id = e.evolved_pokemon_id;
END $$

DELIMITER ;


-- ADDING AN EVOLTUION

DROP PROCEDURE IF EXISTS add_evolution;
DELIMITER $$

CREATE PROCEDURE add_evolution(IN bs_id INT, IN evo_id INT)
BEGIN
	INSERT INTO evolutions VALUES (bs_id, evo_id);
END $$

DELIMITER ;


-- REMOVING AN EVOLUTION

DROP PROCEDURE IF EXISTS remove_evolution;
DELIMITER $$

CREATE PROCEDURE remove_evolution(IN bs_id INT, IN evo_id INT)
BEGIN
	DELETE FROM evolutions 
    WHERE base_pokemon_id = bs_id
    AND evolved_pokemon_id = evo_id;
END $$

DELIMITER ;



/*
-------------------------------------
BATTLE PROCEDURES
-------------------------------------
*/


-- GETTING ALL TRAINER'S BATTLES

DROP PROCEDURE IF EXISTS get_trainer_battles;
DELIMITER $$

CREATE PROCEDURE get_trainer_battles(IN tr_id INT)
BEGIN
	SELECT * FROM battles
    WHERE trainer1 = tr_id
    OR trainer2 = tr_id;
END $$

DELIMITER ;


-- ADDING A BATTLE

DROP PROCEDURE IF EXISTS add_battle;
DELIMITER $$

CREATE PROCEDURE add_battle(IN tr_id1 INT, IN tr_id2 INT, IN winner INT, IN prize INT)
BEGIN
	INSERT INTO battles VALUES (NULL, tr_id1, tr_id2, winner, prize);
END $$

DELIMITER ;


-- REMOVING A BATTLE

DROP PROCEDURE IF EXISTS remove_battle;
DELIMITER $$

CREATE PROCEDURE remove_battle(IN btl_id INT)
BEGIN
	DELETE FROM battles WHERE battle_id = btl_id;
END $$

DELIMITER ;


