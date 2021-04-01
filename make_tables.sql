DROP DATABASE IF EXISTS pokemon;

CREATE DATABASE pokemon;

USE pokemon;


CREATE TABLE Typing (
	type_name VARCHAR(20) PRIMARY KEY
);


CREATE TABLE Pokemon (
	pokemon_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    type1 VARCHAR(20) NOT NULL,
    type2 VARCHAR(20),
	FOREIGN KEY (type1) REFERENCES Typing(type_name) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY (type2) REFERENCES Typing(type_name) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Stats (
	pokemon_id INT NOT NULL PRIMARY KEY,
    health_points INT NOT NULL,
    attack INT NOT NULL,
    special_attack INT NOT NULL,
    defense INT NOT NULL,
    special_defense INT NOT NULL,
    speed INT NOT NULL,
	FOREIGN KEY (pokemon_id) REFERENCES Pokemon(pokemon_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Trainer (
	trainer_id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	money INT NOT NULL,
	location VARCHAR(50) NOT NULL,
    num_captured_pokemon INT NOT NULL
);

CREATE TABLE CapturedPokemon (
	capt_pokemon_id INT AUTO_INCREMENT PRIMARY KEY,
	pokemon_id INT NOT NULL,
    level INT NOT NULL,
	nickname VARCHAR(50) NOT NULL,
    trainer_id INT,
	FOREIGN KEY (pokemon_id) REFERENCES Pokemon(pokemon_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (trainer_id) REFERENCES Trainer(trainer_id) ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE Move (
	move_id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	type_name VARCHAR(20) NOT NULL,
    power INT,
    accuracy INT,
    pp INT NOT NULL,
    category VARCHAR(20) NOT NULL,
	FOREIGN KEY (type_name) REFERENCES Typing(type_name) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE LearnedMoves (
	move_id INT NOT NULL,
	capt_pokemon_id INT NOT NULL,
	PRIMARY KEY (move_id, capt_pokemon_id),
	FOREIGN KEY (move_id) REFERENCES Move(move_id) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY (capt_pokemon_id) REFERENCES CapturedPokemon(capt_pokemon_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Evolutions (
	base_pokemon_id INT NOT NULL,
	evolved_pokemon_id INT NOT NULL,
	PRIMARY KEY (base_pokemon_id, evolved_pokemon_id),
	FOREIGN KEY (base_pokemon_id) REFERENCES Pokemon(pokemon_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (evolved_pokemon_id) REFERENCES Pokemon(pokemon_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Battles (
	battle_id INT AUTO_INCREMENT PRIMARY KEY,
	trainer1 INT NOT NULL,
	trainer2 INT NOT NULL,
    winner INT NOT NULL,
    prize INT NOT NULL,
	FOREIGN KEY (trainer1) REFERENCES Trainer(trainer_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (trainer1) REFERENCES Trainer(trainer_id) ON DELETE CASCADE ON UPDATE CASCADE
);