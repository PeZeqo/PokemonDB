-- CONVERT MOVE ID TO MOVE NAME

DROP FUNCTION IF EXISTS get_move_name_from_id;
DELIMITER $$

CREATE FUNCTION get_move_name_from_id(mv_id INT)
RETURNS VARCHAR(50)
deterministic reads sql data
BEGIN
	SELECT name FROM move WHERE move_id = mv_id LIMIT 1;
END $$


-- CONVERT MOVE NAME TO MOVE ID

DROP FUNCTION IF EXISTS get_move_id_from_name;
DELIMITER $$

CREATE FUNCTION get_move_id_from_name(move_name VARCHAR(50))
RETURNS INT
deterministic reads sql data
BEGIN
	SELECT move_id FROM move WHERE name = move_name;
END $$