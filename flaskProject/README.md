# PokemonDB API Endpoint Descriptions
Below is some documentation of each API endpoint provided by this flask API.
All entries will contain a brief description of it's purpose, as well as the input contract that must be satisfied to use it. The documentation is broken apart into sections, though many of them interact with one another. (For example, the /Pokémon/* group is tightly coupled with the /capturedPokemon/* endpoints).

---

## API Group: Pokémon
#### /Pokémon [GET]
Returns a list of all the Pokémon which exist in the database.

|Input|Input Type|Input Desc.|Required (y/n)|
|---|---|---|----|
|-|-|-|-|

#### /Pokémon/add [POST]
Adds a new Pokémon to the database, including the core information that make it up.

|Input|Input Type|Input Desc.| Required (y/n) |
|---|---|---|---|
|name|String|The name of the Pokémon| y|
|type1|Integer|The primary type of the Pokémon |y
|type2|Integer|The secondary type of the Pokémon|n|

#### /Pokémon/get [GET]
Gathers a specific Pokémon from the database. Includes only it's id, name, and type information.

|Input |Input Type |Input Desc.| Required (y/n) |
|---|---|---|---|
|Pokémon_id|Integer|The id of the Pokémon to retreive| y|

#### /Pokémon/get_with_stats [GET]
Gathers a specific Pokémon from the database. Includes extra info about it's base stats in battle.

|Input |Input Type |Input Desc.| Required (y/n) |
|---|---|---|---|
|Pokémon_id|Integer|The id of the Pokémon to retreive| y|

#### /Pokémon/remove [REMOVE]
Deletes a specific Pokémon from the database.

|Input |Input Type |Input Desc.| Required (y/n) |
|---|---|---|---|
|Pokémon_id|Integer|The id of the Pokémon to remove| y|

---

## API Group: capturedPokemon
#### /capturedPokemon/add [POST]
Adds a captured Pokémon into the database. Please note, this is an instance of a generic Pokémon, not a new Pokémon entirely.

|Input |Input Type |Input Desc.| Required (y/n) |
|---|---|---|---|
|Pokémon_id|Integer|The id of the Pokémon which this captured Pokémon is an instance of. | y|
|level|Integer|The level of the Pokémon being added|y|
|nickname|String|The nickname of the Pokémon being added.|y|
|trainer_id|Integer|The trainer id which owns this captured Pokémon.|y|

#### /capturedPokemon/get [GET]
Retreives base information about a captured Pokémon from the database. This includes its id, level, name, owner's id, and Pokémon_id it is an instance of.

|Input |Input Type |Input Desc.| Required (y/n) |
|---|---|---|---|
|captured_Pokémon_id|Integer| The id of the captured Pokémon you want information about.|y|

#### /capturedPokemon/get/full [GET]
Retrieves complete information about a given captured Pokémon. Includes its stats, if, level, Pokémon name, nickname, and type information.

|Input |Input Type |Input Desc.| Required (y/n) |
|---|---|---|---|
|captured_Pokémon_id|Integer| The id of the captured Pokémon you want information about.|y|

#### /capturedPokemon/get/trainer [GET]
Retreives a list of captured Pokémon associated with a given trainer.

|Input |Input Type |Input Desc.| Required (y/n) |
|---|---|---|---|
|trainer_id|Integer|The id of the trainer you want to lookup.|y|

#### /capturedPokemon/levelUp [POST]
Increments the level of the specified captured Pokémon by one.

|Input |Input Type |Input Desc.| Required (y/n) |
|---|---|---|---|
|captured_Pokémon_id|Integer|The id of the Pokémon you want to level up.|y|

#### /capturedPokemon/remove [POST]
Removes the captured Pokémon from the database (and thus, it's associated trainer).

|Input |Input Type |Input Desc.| Required (y/n) |
|---|---|---|---|
|captured_Pokémon_id|Integer|The id of the Pokémon you want to remove.|y|

#### /capturedPokemon/rename [POST]
Renames the captured Pokémon to have a new nickname.

|Input |Input Type |Input Desc.| Required (y/n) |
|---|---|---|---|
|captured_Pokémon_id|Integer|The id of the Pokémon you want to rename.|y|
|nickname|String|The new nickname you want to give the captured Pokémon.|y|

---

## API Group: Typing
#### /typing/add [POST]
Adds a new type to the database.

|Input |Input Type |Input Desc.| Required (y/n) |
|---|---|---|---|
|type_name| String | The name of the type you want to add. | y|

#### /typing/get [GET]
Gathers information about all of the types which exist in the database.

|Input|Input Type|Input Desc.|Required (y/n)|
|---|---|---|----|
|-|-|-|-|

#### /typing/remove [POST]
Removes a given type from the database.

|Input|Input Type|Input Desc.|Required (y/n)|
|---|---|---|----|
|type_id|Integer|The integer id of the type you want to remove from the database.|y|

---

## API Group: Evolution
#### /evolution/add [POST]
Inserts a new evolution for a Pokémon into the database.

|Input|Input Type|Input Desc.|Required (y/n)|
|---|---|---|----|
|base_Pokémon_id|Integer| The id of the original Pokémon in the evolution.|y|
|evolved_Pokémon_id|Integer| The id of the Pokémon in the evolution, after it's evolved.|y|

#### /evolution/get [GET]
Retrieves a list of all the supported Pokémon evolutions in the database.

|Input|Input Type|Input Desc.|Required (y/n)|
|---|---|---|----|
|-|-|-|-|

#### /evolution/remove [POST]
Removes an evolution from the database.

|Input|Input Type|Input Desc.|Required (y/n)|
|---|---|---|----|
|base_Pokémon_id|Integer| The id of the original Pokémon in the evolution.|y|
|evolved_Pokémon_id|Integer| The id of the Pokémon in the evolution, after it's evolved.|y|

---

## API Group: Move
#### /move/add [POST]
Inserts a new move into the database.

|Input|Input Type|Input Desc.|Required (y/n)|
|---|---|---|----|
|move_name|String| The name of the move. | y|
|type| Integer | The type of damage the move inflicts. | y|
|power|Integer| The strength of the move. | y|
|accuracy|Integer| How often the move hits. | y|
|pp|Integer| The number of times the move can be used. | y|
|category|String| The type of damage/defense this move provides (if any)| y|

#### /move/get/id [GET]
Gets information about a move, by it's id.

|Input|Input Type|Input Desc.|Required (y/n)|
|---|---|---|----|
|move_id|Integer| The id of the move to request information about | y|

#### /move/get/name [GET]
Gets information about a move, by it's name.

|Input|Input Type|Input Desc.|Required (y/n)|
|---|---|---|----|
|move_name|String| The name of the move to request information about | y|

#### /move/remove [POST]
Removes a move from the database.

|Input|Input Type|Input Desc.|Required (y/n)|
|---|---|---|----|
|move_id| Integer| The id of the move to delete.| y|

---

## API Group: learnedMove
#### /learnedMove/add/id [POST]
Teaches a captured Pokémon a move, by it's id.

|Input|Input Type|Input Desc.|Required (y/n)|
|---|---|---|----|
|captured_Pokémon_id|Integer| The id of the captured Pokémon we are teaching a move to. | y|
|move_id| Integer| The id of the move the captured Pokémon is being taught. | y|

#### /learnedMove/add/name [POST]
Teaches a captured Pokémon a move, by it's name.

|Input|Input Type|Input Desc.|Required (y/n)|
|---|---|---|----|
|captured_Pokémon_id|Integer| The id of the captured Pokémon we are teaching a move to. | y|
|move_name| String|The name of the move the captured Pokémon is being taught. | y|

#### /learnedMove/get [GET]
Gets information about all the moves currently learned by the captured pokemon, identified by it's id.

|Input|Input Type|Input Desc.|Required (y/n)|
|---|---|---|----|
|captured_Pokémon_id|Integer| The id of the captured Pokémon we are gettings the moves of. | y|

#### /learnedMove/remove/id [POST]
Removes a Pokémons learned move by id.

|Input|Input Type|Input Desc.|Required (y/n)|
|---|---|---|----|
|captured_Pokémon_id|Integer| The id of the captured Pokémon we are removing a move from. | y|
|move_id| Integer| The id of the move the captured Pokémon is supposed to forget. | y|

#### /learnedMove/remove/name [POST]
Removes a Pokémons learned move by it's name.

|Input|Input Type|Input Desc.|Required (y/n)|
|---|---|---|----|
|captured_Pokémon_id|Integer| The id of the captured Pokémon we are removing a move from. | y|
|move_name| String| The name of the move the captured Pokémon is supposed to forget. | y|

---

## API Group: Stats
#### /stats/add [POST]
Creates a stats entry for a Pokémon in the database.

|Input|Input Type|Input Desc.|Required (y/n)|
|---|---|---|----|
|Pokémon_id|Integer|The id of the Pokémon to associate this stats set with. | y|
|hp|Integer| The base hp for this Pokémon. | y|
|atk|Integer| The base attack for this Pokémon. | y|
|def|Integer| The base defense for this Pokémon. | y|
|spatk|Integer| The base special attack for this Pokémon. | y|
|spdef|Integer| The base special defense for this Pokémon. | y|
|spd|Integer| The base speed defense for this Pokémon. | y|

#### /stats/get [GET]
Retrieves a stats entry for a Pokémon in the database.

|Input|Input Type|Input Desc.|Required (y/n)|
|---|---|---|----|
|captured_Pokémon_id|Integer| The id of the Pokémon we are getting the base stats from. | y|

#### /stats/remove [POST]
Removes a stats entry for a Pokémon in the database.

|Input|Input Type|Input Desc.|Required (y/n)|
|---|---|---|----|
|captured_Pokémon_id|Integer| The id of the Pokémon we are removing the base stats from. | y|

#### /stats/update [POST]
Updates the base stats for a Pokémon in the database.

|Input|Input Type|Input Desc.|Required (y/n)|
|---|---|---|----|
|Pokémon_id|Integer|The id of the Pokémon to update the stats of. | y|
|hp|Integer| The new base hp for this Pokémon. | y|
|atk|Integer| The new base attack for this Pokémon. | y|
|def|Integer| The new base defense for this Pokémon. | y|
|spatk|Integer| The new base special attack for this Pokémon. | y|
|spdef|Integer| The new base special defense for this Pokémon. | y|
|spd|Integer| The new base speed defense for this Pokémon. | y|

---

## API Group: Battle
#### /battle/add [POST]
Adds a record of a battle to the database.

|Input|Input Type|Input Desc.|Required (y/n)|
|---|---|---|----|
|trainer_id1|Integer|The id of the first participant in this battle.|y|
|trainer_id2|Integer|The id of the second participant in this battle.|y|
|winner_id|Integer| The id of the trainer which won this battle.|y|
|prize|Integer| The amount of money awarded to the winning trainer.|y|

#### /battle/get [GET]
Retrieves a list of the battles stored in the database, that a provided trainer participated in.

|Input|Input Type|Input Desc.|Required (y/n)|
|---|---|---|----|
|trainer_id|Integer| The trainer you want to search battles for.|y|

#### /battle/remove [POST]
Removes a battle from the database.

|Input|Input Type|Input Desc.|Required (y/n)|
|---|---|---|----|
|battle_id|Integer| The battle you want to remove from the database.|y|

---

## API Group: Trainer
#### /trainer/add [POST]
Adds a trainer into the database.

|Input|Input Type|Input Desc.|Required (y/n)|
|---|---|---|----|
|trainer_name|String|The name of the trainer to insert.|y|


#### /trainer/get [GET]
Gathers information about a trainer, given it's ID. Specifically, finds the location, amount of money they have, their name, and number of captured Pokémon.

|Input|Input Type|Input Desc.|Required (y/n)|
|---|---|---|----|
|trainer_id|Integer| The id of the trainer to look up|y|

#### /trainer/move [POST]
Updates a trainers location (position in the world) in the database.

|Input|Input Type|Input Desc.|Required (y/n)|
|---|---|---|----|
|trainer_id|Integer| The id of the trainer to relocate/move.|y|
|new_location|String | The new location that this trainer is being moved to. |y|

#### /trainer/remove [POST]
Removes a trainer from the database.

|Input|Input Type|Input Desc.|Required (y/n)|
|---|---|---|----|
|trainer_id|Integer| The id of the trainer to remove from the database. |y|
