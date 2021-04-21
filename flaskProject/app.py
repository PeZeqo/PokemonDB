from flask import Flask, request, jsonify
from flask_mysqldb import MySQL
from flask_restplus import Api, Resource, fields, reqparse
from SETTINGS import config_file_path
import json
import sys


app = Flask(__name__)
api = Api(app)
cursor = None
mysql = MySQL(app)


'''
-------------------------------------
HELPER FUNCTION'S
-------------------------------------
'''
def init_db():
    config_json = json.load(open(config_file_path))
    app.config['MYSQL_HOST'] = config_json['host']
    app.config['MYSQL_USER'] = config_json['user']
    app.config['MYSQL_PASSWORD'] = config_json['password']
    app.config['MYSQL_DB'] = config_json['database']


def execute_and_format(query, commit=False):
    cursor = mysql.connection.cursor()
    try:
        cursor.execute(query)
        if commit:
            mysql.connection.commit()
        if cursor.description is None:
            response = "Success"
        else:
            column_names = [col[0] for col in cursor.description]
            response = [dict(zip(column_names, row)) for row in cursor.fetchall()]
    except:
        return jsonify("Unexpected error:", sys.exc_info()[0])
    return jsonify(response)


'''
-------------------------------------
POKEMON API's
-------------------------------------
'''
@api.route('/pokemon')
class GetAllPokemon(Resource):
    def get(self):
        query = ("SELECT * FROM pokemon;")
        return execute_and_format(query)


@api.route('/pokemon/get')
class GetPokemon(Resource):
    parser = reqparse.RequestParser(bundle_errors=True)
    parser.add_argument('pokemon_id', type=int, required=True, help="Pokemon's ID")
    @api.expect(parser)
    def get(self):
        args = self.parser.parse_args()
        query = ("CALL get_pokemon_by_id({})".format(args['pokemon_id']))
        return execute_and_format(query)


@api.route('/pokemon/add')
class AddPokemon(Resource):
    parser = reqparse.RequestParser(bundle_errors=True)
    parser.add_argument('name', type=str, required=True, help="New Pokemon Name")
    parser.add_argument('type1', type=int, required=True, help="Pokemon Primary Typing")
    parser.add_argument('type2', type=int, help="Pokemon Secondary Typing")
    @api.expect(parser)
    @api.response(200, 'Pokemon added to DB')
    def post(self):
        args = self.parser.parse_args()
        query = ("CALL add_pokemon(\"{}\", {}, {})".format(args['name'], args['type1'],
                                                           args['type2'] if args['type2'] is not None else "NULL"))
        return execute_and_format(query, True)


@api.route('/pokemon/remove')
class AddPokemon(Resource):
    parser = reqparse.RequestParser(bundle_errors=True)
    parser.add_argument('pokemon_id', type=int, required=True, help="Pokemon's ID")
    @api.expect(parser)
    @api.response(200, 'Pokemon removed from DB')
    def post(self):
        args = self.parser.parse_args()
        query = ("CALL remove_pokemon({})".format(args['pokemon_id']))
        return execute_and_format(query, True)


@api.route('/pokemon/get_with_stats')
class GetPokemonWithStats(Resource):
    parser = reqparse.RequestParser(bundle_errors=True)
    parser.add_argument('pokemon_id', type=int, required=True, help="Pokemon's ID")
    @api.expect(parser)
    def get(self):
        args = self.parser.parse_args()
        query = ("CALL get_pokemon_and_stats({})".format(args['pokemon_id']))
        return execute_and_format(query)


'''
-------------------------------------
STATS API's
-------------------------------------
'''
@api.route('/stats/get')
class GetStatsByID(Resource):
    parser = reqparse.RequestParser(bundle_errors=True)
    parser.add_argument('pokemon_id', type=int, required=True, help="Pokemon's ID")
    @api.expect(parser)
    def get(self):
        args = self.parser.parse_args()
        query = ("CALL get_pokemon_stats_by_id({})".format(args['pokemon_id']))
        return execute_and_format(query)


@api.route('/stats/add')
class AddStats(Resource):
    parser = reqparse.RequestParser(bundle_errors=True)
    parser.add_argument('pokemon_id', type=int, required=True, help="Pokemon's ID")
    parser.add_argument('hp', type=int, required=True, help="Health Point Stat")
    parser.add_argument('atk', type=int, required=True, help="Attack Stat")
    parser.add_argument('def', type=int, required=True, help="Defense Stat")
    parser.add_argument('spatk', type=int, required=True, help="Special Attack Stat")
    parser.add_argument('spdef', type=int, required=True, help="Special Defense Stat")
    parser.add_argument('spd', type=int, required=True, help="Speed Stat")
    @api.expect(parser)
    @api.response(200, 'Stats for Pokemon added to DB')
    def post(self):
        args = self.parser.parse_args()
        query = ("CALL add_stats({}, {}, {}, {}, {}, {}, {})".format(
            args['pokemon_id'], args['hp'], args['atk'], args['def'],
            args['spatk'], args['spdef'], args['spd']))
        return execute_and_format(query, True)


@api.route('/stats/update')
class UpdateStats(Resource):
    parser = reqparse.RequestParser(bundle_errors=True)
    parser.add_argument('pokemon_id', type=int, required=True, help="Pokemon's ID")
    parser.add_argument('hp', type=int, required=True, help="Health Point Stat")
    parser.add_argument('atk', type=int, required=True, help="Attack Stat")
    parser.add_argument('def', type=int, required=True, help="Defense Stat")
    parser.add_argument('spatk', type=int, required=True, help="Special Attack Stat")
    parser.add_argument('spdef', type=int, required=True, help="Special Defense Stat")
    parser.add_argument('spd', type=int, required=True, help="Speed Stat")
    @api.expect(parser)
    @api.response(200, 'Stats for Pokemon updated in DB')
    def post(self):
        args = self.parser.parse_args()
        query = ("CALL update_stats({}, {}, {}, {}, {}, {}, {})".format(
            args['pokemon_id'], args['hp'], args['atk'], args['def'],
            args['spatk'], args['spdef'], args['spd']))
        return execute_and_format(query, True)


@api.route('/stats/remove')
class RemoveStats(Resource):
    parser = reqparse.RequestParser(bundle_errors=True)
    parser.add_argument('pokemon_id', type=int, required=True, help="Pokemon's ID")
    @api.expect(parser)
    @api.response(200, 'Stats for Pokemon removed from DB')
    def post(self):
        args = self.parser.parse_args()
        query = ("CALL remove_stats({})".format(args['pokemon_id']))
        return execute_and_format(query, True)


'''
-------------------------------------
CAPTURED POKEMON API's
-------------------------------------
'''
@api.route('/capturedPokemon/get/trainer')
class GetTrainersPokemon(Resource):
    parser = reqparse.RequestParser(bundle_errors=True)
    parser.add_argument('trainer_id', type=int, required=True, help="Trainer's ID")
    @api.expect(parser)
    def get(self):
        args = self.parser.parse_args()
        query = ("CALL get_trainers_pokemon({})".format(args['trainer_id']))
        return execute_and_format(query)


@api.route('/capturedPokemon/get')
class GetCapturedPokemon(Resource):
    parser = reqparse.RequestParser(bundle_errors=True)
    parser.add_argument('captured_pokemon_id', type=int, required=True, help="Captured Pokemon's ID")
    @api.expect(parser)
    def get(self):
        args = self.parser.parse_args()
        query = ("CALL get_captured_pokemon({})".format(args['captured_pokemon_id']))
        return execute_and_format(query)


@api.route('/capturedPokemon/get/full')
class GetFullCapturedPokemonInfo(Resource):
    parser = reqparse.RequestParser(bundle_errors=True)
    parser.add_argument('captured_pokemon_id', type=int, required=True, help="Captured Pokemon's ID")
    @api.expect(parser)
    def get(self):
        args = self.parser.parse_args()
        query = ("CALL get_full_captured_pokemon_info({})".format(args['captured_pokemon_id']))
        return execute_and_format(query)


@api.route('/capturedPokemon/add')
class AddCapturedPokemon(Resource):
    parser = reqparse.RequestParser(bundle_errors=True)
    parser.add_argument('pokemon_id', type=int, required=True, help="Pokemon's ID")
    parser.add_argument('level', type=int, required=True, help="Pokemon's Level on Capture")
    parser.add_argument('nickname', type=str, required=True, help="Pokemon's Nickname")
    parser.add_argument('trainer_id', type=int, required=True, help="Capturing Trainer's ID")
    @api.expect(parser)
    @api.response(200, 'New Captured Pokemon added to DB')
    def post(self):
        args = self.parser.parse_args()
        query = ("CALL add_captured_pokemon({}, {}, \"{}\", {})".format(
            args['pokemon_id'], args['level'], args['nickname'], args['trainer_id']))
        return execute_and_format(query, True)


@api.route('/capturedPokemon/remove')
class RemoveCapturedPokemon(Resource):
    parser = reqparse.RequestParser(bundle_errors=True)
    parser.add_argument('captured_pokemon_id', type=int, required=True, help="Captured Pokemon's ID")
    @api.expect(parser)
    @api.response(200, 'Captured Pokemon removed from DB')
    def post(self):
        args = self.parser.parse_args()
        query = ("CALL remove_captured_pokemon({})".format(args['captured_pokemon_id']))
        return execute_and_format(query, True)


@api.route('/capturedPokemon/levelUp')
class LevelUpCapturedPokemon(Resource):
    parser = reqparse.RequestParser(bundle_errors=True)
    parser.add_argument('captured_pokemon_id', type=int, required=True, help="Captured Pokemon's ID")
    @api.expect(parser)
    @api.response(200, 'Captured Pokemon leveled up (max 100)')
    def post(self):
        args = self.parser.parse_args()
        query = ("CALL level_captured_pokemon({})".format(args['captured_pokemon_id']))
        return execute_and_format(query, True)


@api.route('/capturedPokemon/rename')
class RenameCapturedPokemon(Resource):
    parser = reqparse.RequestParser(bundle_errors=True)
    parser.add_argument('captured_pokemon_id', type=int, required=True, help="Captured Pokemon's ID")
    parser.add_argument('nickname', type=str, required=True, help="New Nickname")
    @api.expect(parser)
    @api.response(200, 'Captured Pokemon renamed')
    def post(self):
        args = self.parser.parse_args()
        query = ("CALL rename_captured_pokemon({}, \"{}\")".format(args['captured_pokemon_id'], args['nickname']))
        return execute_and_format(query, True)


'''
-------------------------------------
MOVE API's
-------------------------------------
'''
@api.route('/move/get/id')
class GetMoveById(Resource):
    parser = reqparse.RequestParser(bundle_errors=True)
    parser.add_argument('move_id', type=int, required=True, help="Move's ID")
    @api.expect(parser)
    def get(self):
        args = self.parser.parse_args()
        query = ("CALL get_move_by_id({})".format(args['move_id']))
        return execute_and_format(query)


@api.route('/move/get/name')
class GetMoveByName(Resource):
    parser = reqparse.RequestParser(bundle_errors=True)
    parser.add_argument('move_name', type=str, required=True, help="Move's Name")
    @api.expect(parser)
    def get(self):
        args = self.parser.parse_args()
        query = ("CALL get_move_by_name(\"{}\")".format(args['move_name']))
        return execute_and_format(query)


@api.route('/move/add')
class AddMove(Resource):
    parser = reqparse.RequestParser(bundle_errors=True)
    parser.add_argument('move_name', type=str, required=True, help="Move's Name")
    parser.add_argument('type', type=int, required=True, help="Move's Typing")
    parser.add_argument('power', type=int, required=True, help="Move's Power")
    parser.add_argument('accuracy', type=int, required=True, help="Move's Accuracy")
    parser.add_argument('pp', type=int, required=True, help="Move's Power Points")
    parser.add_argument('category', type=str, required=True, help="Move's Category")
    @api.expect(parser)
    @api.response(200, 'Move added to DB')
    def post(self):
        args = self.parser.parse_args()
        query = ("CALL add_move(\"{}\", {}, {}, {}, {}, \"{}\")".format(
            args['move_name'], args['type'], args['power'],
            args['accuracy'], args['pp'], args['category']))
        return execute_and_format(query, True)


@api.route('/move/remove')
class RemoveMove(Resource):
    parser = reqparse.RequestParser(bundle_errors=True)
    parser.add_argument('move_id', type=int, required=True, help="Move's ID")
    @api.expect(parser)
    @api.response(200, 'Move removed from DB')
    def post(self):
        args = self.parser.parse_args()
        query = ("CALL remove_move({})".format(args['move_id']))
        return execute_and_format(query, True)


'''
-------------------------------------
LEARNED MOVE API's
-------------------------------------
'''
@api.route('/learnedMove/get/')
class GetCapturedPokemonMoves(Resource):
    parser = reqparse.RequestParser(bundle_errors=True)
    parser.add_argument('captured_pokemon_id', type=int, required=True, help="Captured Pokemon's ID")
    @api.expect(parser)
    def get(self):
        args = self.parser.parse_args()
        query = ("CALL get_pokemon_moves({})".format(args['captured_pokemon_id']))
        return execute_and_format(query)


@api.route('/learnedMove/add/id')
class LearnMoveById(Resource):
    parser = reqparse.RequestParser(bundle_errors=True)
    parser.add_argument('captured_pokemon_id', type=int, required=True, help="Captured Pokemon's ID")
    parser.add_argument('move_id', type=int, required=True, help="Move's ID")
    @api.expect(parser)
    @api.response(200, 'Learned Move added to DB')
    def post(self):
        args = self.parser.parse_args()
        query = ("CALL learn_move_by_id({}, {})".format(args['captured_pokemon_id'], args['move_id']))
        return execute_and_format(query, True)


@api.route('/learnedMove/add/name')
class LearnMoveByName(Resource):
    parser = reqparse.RequestParser(bundle_errors=True)
    parser.add_argument('captured_pokemon_id', type=int, required=True, help="Captured Pokemon's ID")
    parser.add_argument('move_name', type=str, required=True, help="Move's Name")
    @api.expect(parser)
    @api.response(200, 'Learned Move added to DB')
    def post(self):
        args = self.parser.parse_args()
        query = ("CALL learn_move_by_name({}, \"{}\")".format(args['captured_pokemon_id'], args['move_name']))
        return execute_and_format(query, True)


@api.route('/learnedMove/remove/id')
class ForgetMoveById(Resource):
    parser = reqparse.RequestParser(bundle_errors=True)
    parser.add_argument('captured_pokemon_id', type=int, required=True, help="Captured Pokemon's ID")
    parser.add_argument('move_id', type=int, required=True, help="Move's ID")
    @api.expect(parser)
    @api.response(200, 'Learned Move removed from DB')
    def post(self):
        args = self.parser.parse_args()
        query = ("CALL forget_move_by_id({}, {})".format(args['captured_pokemon_id'], args['move_id']))
        return execute_and_format(query, True)


@api.route('/learnedMove/remove/name')
class ForgetMoveByName(Resource):
    parser = reqparse.RequestParser(bundle_errors=True)
    parser.add_argument('captured_pokemon_id', type=int, required=True, help="Captured Pokemon's ID")
    parser.add_argument('move_name', type=str, required=True, help="Move's Name")
    @api.expect(parser)
    @api.response(200, 'Learned Move removed from DB')
    def post(self):
        args = self.parser.parse_args()
        query = ("CALL forget_move_by_name({}, \"{}\")".format(args['captured_pokemon_id'], args['move_name']))
        return execute_and_format(query, True)


'''
-------------------------------------
TRAINER API's
-------------------------------------
'''
@api.route('/trainer/get/')
class GetTrainer(Resource):
    parser = reqparse.RequestParser(bundle_errors=True)
    parser.add_argument('trainer_id', type=int, required=True, help="Trainer's ID")
    @api.expect(parser)
    def get(self):
        args = self.parser.parse_args()
        query = ("CALL get_trainer({})".format(args['trainer_id']))
        return execute_and_format(query)


@api.route('/trainer/add/')
class AddTrainer(Resource):
    parser = reqparse.RequestParser(bundle_errors=True)
    parser.add_argument('trainer_name', type=str, required=True, help="Trainer's Name")
    @api.expect(parser)
    @api.response(200, 'Trainer added to DB')
    def post(self):
        args = self.parser.parse_args()
        query = ("CALL add_trainer(\"{}\")".format(args['trainer_name']))
        return execute_and_format(query, True)
        return execute_and_format(query)


@api.route('/trainer/move/')
class MoveTrainer(Resource):
    parser = reqparse.RequestParser(bundle_errors=True)
    parser.add_argument('trainer_id', type=int, required=True, help="Trainer's ID")
    parser.add_argument('new_location', type=str, required=True, help="Trainer's Destination")
    @api.expect(parser)
    @api.response(200, 'Trainer moved to New Location')
    def post(self):
        args = self.parser.parse_args()
        query = ("CALL move_trainer({}, \"{}\")".format(args['trainer_id'], args['new_location']))
        return execute_and_format(query, True)


@api.route('/trainer/remove/')
class RemoveTrainer(Resource):
    parser = reqparse.RequestParser(bundle_errors=True)
    parser.add_argument('trainer_id', type=int, required=True, help="Trainer's ID")
    @api.expect(parser)
    @api.response(200, 'Trainer removed from DB')
    def post(self):
        args = self.parser.parse_args()
        query = ("CALL remove_trainer({})".format(args['trainer_id']))
        return execute_and_format(query, True)


'''
-------------------------------------
TYPING API's
-------------------------------------
'''
@api.route('/typing/get/')
class GetTyping(Resource):
    def get(self):
        query = ("CALL get_types()")
        return execute_and_format(query)


@api.route('/typing/add/')
class AddTyping(Resource):
    parser = reqparse.RequestParser(bundle_errors=True)
    parser.add_argument('type_name', type=str, required=True, help="Typing's Name")
    @api.expect(parser)
    @api.response(200, 'Typing added to DB')
    def post(self):
        args = self.parser.parse_args()
        query = ("CALL add_type(\"{}\")".format(args['type_name']))
        return execute_and_format(query, True)


@api.route('/typing/remove/')
class RemoveTyping(Resource):
    parser = reqparse.RequestParser(bundle_errors=True)
    parser.add_argument('type_id', type=int, required=True, help="Typing's ID")
    @api.expect(parser)
    @api.response(200, 'Typing removed from DB')
    def post(self):
        args = self.parser.parse_args()
        query = ("CALL remove_type({})".format(args['type_id']))
        return execute_and_format(query, True)


'''
-------------------------------------
EVOLUTIONS API's
-------------------------------------
'''
@api.route('/evolution/get/')
class GetEvolutions(Resource):
    def get(self):
        query = ("CALL get_evolutions()")
        return execute_and_format(query)


@api.route('/evolution/add/')
class AddEvolution(Resource):
    parser = reqparse.RequestParser(bundle_errors=True)
    parser.add_argument('base_pokemon_id', type=int, required=True, help="Evolving Pokemon's ID")
    parser.add_argument('evolved_pokemon_id', type=int, required=True, help="Resulting Evolved Pokemon's ID")
    @api.expect(parser)
    @api.response(200, 'Evolution Pairing added to DB')
    def post(self):
        args = self.parser.parse_args()
        query = ("CALL add_evolution(\"{}\", \"{}\")".format(args['base_pokemon_id'], args['evolved_pokemon_id']))
        return execute_and_format(query, True)


@api.route('/evolution/remove/')
class RemoveEvolution(Resource):
    parser = reqparse.RequestParser(bundle_errors=True)
    parser.add_argument('base_pokemon_id', type=int, required=True, help="Evolving Pokemon's ID")
    parser.add_argument('evolved_pokemon_id', type=int, required=True, help="Resulting Evolved Pokemon's ID")
    @api.expect(parser)
    @api.response(200, 'Evolution Pairing removed from DB')
    def post(self):
        args = self.parser.parse_args()
        query = ("CALL remove_evolution(\"{}\", \"{}\")".format(args['base_pokemon_id'], args['evolved_pokemon_id']))
        return execute_and_format(query, True)


'''
-------------------------------------
BATTLE API's
-------------------------------------
'''
@api.route('/battle/get/')
class GetTrainerBattles(Resource):
    parser = reqparse.RequestParser(bundle_errors=True)
    parser.add_argument('trainer_id', type=int, required=True, help="Trainer's ID")
    @api.expect(parser)
    def get(self):
        args = self.parser.parse_args()
        query = ("CALL get_trainer_battles({})".format(args['trainer_id']))
        return execute_and_format(query)


@api.route('/battle/add/')
class AddBattle(Resource):
    parser = reqparse.RequestParser(bundle_errors=True)
    parser.add_argument('trainer_id1', type=int, required=True, help="First Participant's Trainer ID")
    parser.add_argument('trainer_id2', type=int, required=True, help="Second Participant's Trainer ID")
    parser.add_argument('winner_id', type=int, required=True, help="Flag for winner: 0 if Trainer 1 won, 1 if Trainer 2 won")
    parser.add_argument('prize', type=int, required=True)
    @api.expect(parser)
    @api.response(200, 'Battle added to DB')
    def post(self):
        args = self.parser.parse_args()
        if args['winner_id'] not in [0, 1]:
            return "winner_id must be 0 or 1"
        query = ("CALL add_battle({}, {}, {}, {})".format(
            args['trainer_id1'], args['trainer_id2'], args['winner_id'], args['prize']))
        return execute_and_format(query, True)


@api.route('/battle/remove/')
class RemoveBattle(Resource):
    parser = reqparse.RequestParser(bundle_errors=True)
    parser.add_argument('battle_id', type=int, required=True, help="Battle ID")
    @api.expect(parser)
    @api.response(200, 'Battle removed from DB')
    def post(self):
        args = self.parser.parse_args()
        query = ("CALL remove_battle({})".format(args['battle_id']))
        return execute_and_format(query, True)


if __name__ == '__main__':
    init_db()
    app.run(debug=True)
