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
HELPER API's
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
    # @api.expect(api.model('Pokemon ID', {'pokemon_id': fields.Integer}, envelope='resource'))
    # def put(self):
    #     parser = reqparse.RequestParser(bundle_errors=True)
    #     parser.add_argument('pokemon_id', type=int, required=True, help="Pokemon's Pokedex ID")
    #     args = parser.parse_args()
    #     query = ("CALL get_pokemon_by_id({})".format(args['pokemon_id']))
    #     return execute_and_format(query)
    parser = reqparse.RequestParser(bundle_errors=True)
    parser.add_argument('pokemon_id', type=int, required=True, help="Pokemon's Pokedex ID")
    # @api.expect(api.model('Pokemon ID', {'pokemon_id': fields.Integer}, envelope='resource'))
    @api.expect(parser)
    def put(self):
        args = self.parser.parse_args()
        query = ("CALL get_pokemon_by_id({})".format(args['pokemon_id']))
        return execute_and_format(query)


@api.route('/pokemon/add')
class AddPokemon(Resource):
    @api.expect(api.model('Pokemon Model', {'name': fields.String, 'type1': fields.Integer, 'type2': fields.Integer}),
                envelope='resource')
    def post(self):
        parser = reqparse.RequestParser(bundle_errors=True)
        parser.add_argument('name', type=str, required=True)
        parser.add_argument('type1', type=int, required=True)
        parser.add_argument('type2', type=int)
        args = parser.parse_args()
        query = ("CALL add_pokemon(\"{}\", {}, {})".format(args['name'], args['type1'],
                                                           args['type2'] if args['type2'] is not None else "NULL"))
        return execute_and_format(query, True)


@api.route('/pokemon/remove')
class AddPokemon(Resource):
    @api.expect(api.model('Pokemon ID', {'pokemon_id': fields.Integer}, envelope='resource'))
    def post(self):
        parser = reqparse.RequestParser(bundle_errors=True)
        parser.add_argument('pokemon_id', type=int, required=True)
        args = parser.parse_args()
        query = ("CALL remove_pokemon({})".format(args['pokemon_id']))
        return execute_and_format(query, True)


@api.route('/pokemon/get_with_stats')
class GetPokemonWithStats(Resource):
    @api.expect(api.model('Pokemon ID', {'pokemon_id': fields.Integer}, envelope='resource'))
    def put(self):
        parser = reqparse.RequestParser(bundle_errors=True)
        parser.add_argument('pokemon_id', type=int, required=True)
        args = parser.parse_args()
        query = ("CALL get_pokemon_and_stats({})".format(args['pokemon_id']))
        return execute_and_format(query)


'''
-------------------------------------
STATS API's
-------------------------------------
'''
@api.route('/stats/get')
class GetStatsByID(Resource):
    @api.expect(api.model('Pokemon ID', {'pokemon_id': fields.Integer}, envelope='resource'))
    def put(self):
        parser = reqparse.RequestParser(bundle_errors=True)
        parser.add_argument('pokemon_id', type=int, required=True)
        args = parser.parse_args()
        query = ("CALL get_pokemon_stats_by_id({})".format(args['pokemon_id']))
        return execute_and_format(query)


@api.route('/stats/add')
class AddStats(Resource):
    @api.expect(api.model('Stats Model', {'pokemon_id': fields.Integer, 'hp': fields.Integer,
                                          'atk': fields.Integer, 'def': fields.Integer, 'spatk': fields.Integer,
                                          'spdef': fields.Integer, 'spd': fields.Integer}, envelope='resource'))
    def post(self):
        parser = reqparse.RequestParser(bundle_errors=True)
        parser.add_argument('pokemon_id', type=int, required=True)
        parser.add_argument('hp', type=int, required=True)
        parser.add_argument('atk', type=int, required=True)
        parser.add_argument('def', type=int, required=True)
        parser.add_argument('spatk', type=int, required=True)
        parser.add_argument('spdef', type=int, required=True)
        parser.add_argument('spd', type=int, required=True)
        args = parser.parse_args()
        query = ("CALL get_pokemon_stats_by_id({}, {}, {}, {}, {}, {}, {})".format(
            args['pokemon_id'], args['hp'], args['atk'], args['def'],
            args['spatk'], args['spdef'], args['spd']))
        return execute_and_format(query)


@api.route('/stats/update')
class UpdateStats(Resource):
    @api.expect(api.model('Stats Model', {'pokemon_id': fields.Integer, 'hp': fields.Integer,
                                          'atk': fields.Integer, 'def': fields.Integer, 'spatk': fields.Integer,
                                          'spdef': fields.Integer, 'spd': fields.Integer}, envelope='resource'))
    def post(self):
        parser = reqparse.RequestParser(bundle_errors=True)
        parser.add_argument('pokemon_id', type=int, required=True)
        parser.add_argument('hp', type=int, required=True)
        parser.add_argument('atk', type=int, required=True)
        parser.add_argument('def', type=int, required=True)
        parser.add_argument('spatk', type=int, required=True)
        parser.add_argument('spdef', type=int, required=True)
        parser.add_argument('spd', type=int, required=True)
        args = parser.parse_args()
        query = ("CALL update_stats({}, {}, {}, {}, {}, {}, {})".format(
            args['pokemon_id'], args['hp'], args['atk'], args['def'],
            args['spatk'], args['spdef'], args['spd']))
        return execute_and_format(query)


@api.route('/stats/remove')
class RemoveStats(Resource):
    @api.expect(api.model('Pokemon ID', {'pokemon_id': fields.Integer}, envelope='resource'))
    def post(self):
        parser = reqparse.RequestParser(bundle_errors=True)
        parser.add_argument('pokemon_id', type=int, required=True)
        args = parser.parse_args()
        query = ("CALL remove_stats({})".format(args['pokemon_id']))
        return execute_and_format(query)


'''
-------------------------------------
CAPTURED POKEMON API's
-------------------------------------
'''
@api.route('/capturedPokemon/get/trainer')
class GetTrainersPokemon(Resource):
    @api.expect(api.model('Trainer ID', {'trainer_id': fields.Integer}, envelope='resource'))
    def put(self):
        parser = reqparse.RequestParser(bundle_errors=True)
        parser.add_argument('trainer_id', type=int, required=True)
        args = parser.parse_args()
        query = ("CALL get_trainers_pokemon({})".format(args['trainer_id']))
        return execute_and_format(query)


@api.route('/capturedPokemon/get')
class GetCapturedPokemon(Resource):
    @api.expect(api.model('Captured Pokemon ID', {'captured_pokemon_id': fields.Integer}, envelope='resource'))
    def put(self):
        parser = reqparse.RequestParser(bundle_errors=True)
        parser.add_argument('captured_pokemon_id', type=int, required=True)
        args = parser.parse_args()
        query = ("CALL get_captured_pokemon({})".format(args['captured_pokemon_id']))
        return execute_and_format(query)


@api.route('/capturedPokemon/get/full')
class GetFullCapturedPokemonInfo(Resource):
    @api.expect(api.model('Captured Pokemon ID', {'captured_pokemon_id': fields.Integer}, envelope='resource'))
    def put(self):
        parser = reqparse.RequestParser(bundle_errors=True)
        parser.add_argument('captured_pokemon_id', type=int, required=True)
        args = parser.parse_args()
        query = ("CALL get_full_captured_pokemon_info({})".format(args['captured_pokemon_id']))
        return execute_and_format(query)


@api.route('/capturedPokemon/add')
class AddCapturedPokemon(Resource):
    @api.expect(api.model('Captured Pokemon Model', {'pokemon_id': fields.Integer, 'level': fields.Integer,
                                                     'nickname': fields.String, 'trainer_id': fields.Integer}, envelope='resource'))
    def post(self):
        parser = reqparse.RequestParser(bundle_errors=True)
        parser.add_argument('pokemon_id', type=int, required=True)
        parser.add_argument('level', type=int, required=True)
        parser.add_argument('nickname', type=str, required=True)
        parser.add_argument('trainer_id', type=int, required=True)
        args = parser.parse_args()
        query = ("CALL add_captured_pokemon({}, {}, \"{}\", {})".format(
            args['pokemon_id'], args['level'], args['nickname'], args['trainer_id']))
        return execute_and_format(query)


@api.route('/capturedPokemon/remove')
class RemoveCapturedPokemon(Resource):
    @api.expect(api.model('Captured Pokemon ID', {'captured_pokemon_id': fields.Integer}, envelope='resource'))
    def post(self):
        parser = reqparse.RequestParser(bundle_errors=True)
        parser.add_argument('captured_pokemon_id', type=int, required=True)
        args = parser.parse_args()
        query = ("CALL remove_captured_pokemon({})".format(args['captured_pokemon_id']))
        return execute_and_format(query)


@api.route('/capturedPokemon/levelUp')
class LevelUpCapturedPokemon(Resource):
    @api.expect(api.model('Captured Pokemon ID', {'captured_pokemon_id': fields.Integer}, envelope='resource'))
    def post(self):
        parser = reqparse.RequestParser(bundle_errors=True)
        parser.add_argument('captured_pokemon_id', type=int, required=True)
        args = parser.parse_args()
        query = ("CALL level_captured_pokemon({})".format(args['captured_pokemon_id']))
        return execute_and_format(query)


@api.route('/capturedPokemon/rename')
class RenameCapturedPokemon(Resource):
    @api.expect(api.model('Rename Captured Pokemon', {'captured_pokemon_id': fields.Integer, 'nickname': fields.String}, envelope='resource'))
    def post(self):
        parser = reqparse.RequestParser(bundle_errors=True)
        parser.add_argument('captured_pokemon_id', type=int, required=True)
        parser.add_argument('nickname', type=str, required=True)
        args = parser.parse_args()
        query = ("CALL level_captured_pokemon({}, \"{}\")".format(args['captured_pokemon_id'], args['nickname']))
        return execute_and_format(query)


'''
-------------------------------------
MOVE API's
-------------------------------------
'''
@api.route('/move/get/id')
class GetMoveById(Resource):
    @api.expect(api.model('Move ID', {'move_id': fields.Integer}, envelope='resource'))
    def put(self):
        parser = reqparse.RequestParser(bundle_errors=True)
        parser.add_argument('move_id', type=int, required=True)
        args = parser.parse_args()
        query = ("CALL get_move_by_id({})".format(args['move_id']))
        return execute_and_format(query)


@api.route('/move/get/name')
class GetMoveByName(Resource):
    @api.expect(api.model('Move Name', {'move_name': fields.String}, envelope='resource'))
    def put(self):
        parser = reqparse.RequestParser(bundle_errors=True)
        parser.add_argument('move_name', type=str, required=True)
        args = parser.parse_args()
        query = ("CALL get_move_by_name(\"{}\")".format(args['move_name']))
        return execute_and_format(query)


@api.route('/move/add')
class AddMove(Resource):
    @api.expect(api.model('Move Model', {'move_name': fields.String, 'type': fields.Integer,
                                         'power': fields.Integer, 'accuracy': fields.Integer,
                                         'pp': fields.Integer, 'category': fields.String}, envelope='resource'))
    def post(self):
        parser = reqparse.RequestParser(bundle_errors=True)
        parser.add_argument('move_name', type=str, required=True)
        parser.add_argument('type', type=int, required=True)
        parser.add_argument('power', type=int, required=True)
        parser.add_argument('accuracy', type=int, required=True)
        parser.add_argument('pp', type=int, required=True)
        parser.add_argument('category', type=str, required=True)
        args = parser.parse_args()
        query = ("CALL add_move(\"{}\", {}, {}, {}, {}, \"{}\")".format(
            args['move_name'], args['type'], args['power'],
            args['accuracy'], args['pp'], args['category']))
        return execute_and_format(query)


@api.route('/move/remove')
class RemoveMove(Resource):
    @api.expect(api.model('Move ID', {'move_id': fields.Integer}, envelope='resource'))
    def post(self):
        parser = reqparse.RequestParser(bundle_errors=True)
        parser.add_argument('move_id', type=int, required=True)
        args = parser.parse_args()
        query = ("CALL remove_move({})".format(args['move_id']))
        return execute_and_format(query)


'''
-------------------------------------
LEARNED MOVE API's
-------------------------------------
'''
@api.route('/learnedMove/get/')
class GetCapturedPokemonMoves(Resource):
    @api.expect(api.model('Captured Pokemon ID', {'captured_pokemon_id': fields.Integer}, envelope='resource'))
    def put(self):
        parser = reqparse.RequestParser(bundle_errors=True)
        parser.add_argument('captured_pokemon_id', type=int, required=True)
        args = parser.parse_args()
        query = ("CALL get_pokemon_moves({})".format(args['captured_pokemon_id']))
        return execute_and_format(query)


@api.route('/learnedMove/add/id')
class LearnMoveById(Resource):
    @api.expect(api.model('Learned Move Model', {'captured_pokemon_id': fields.Integer,
                                                 'move_id': fields.Integer}, envelope='resource'))
    def post(self):
        parser = reqparse.RequestParser(bundle_errors=True)
        parser.add_argument('captured_pokemon_id', type=int, required=True)
        parser.add_argument('move_id', type=int, required=True)
        args = parser.parse_args()
        query = ("CALL learn_move_by_id({})".format(args['captured_pokemon_id'], args['move_id']))
        return execute_and_format(query)


@api.route('/learnedMove/add/name')
class LearnMoveByName(Resource):
    @api.expect(api.model('Learned Move Name Model', {'captured_pokemon_id': fields.Integer,
                                                      'move_name': fields.String}, envelope='resource'))
    def post(self):
        parser = reqparse.RequestParser(bundle_errors=True)
        parser.add_argument('captured_pokemon_id', type=int, required=True)
        parser.add_argument('move_name', type=str, required=True)
        args = parser.parse_args()
        query = ("CALL learn_move_by_name({}, \"{}\")".format(args['captured_pokemon_id'], args['move_name']))
        return execute_and_format(query)


@api.route('/learnedMove/remove/id')
class ForgetMoveById(Resource):
    @api.expect(api.model('Learned Move Model', {'captured_pokemon_id': fields.Integer,
                                                 'move_id': fields.Integer}, envelope='resource'))
    def post(self):
        parser = reqparse.RequestParser(bundle_errors=True)
        parser.add_argument('captured_pokemon_id', type=int, required=True)
        parser.add_argument('move_id', type=int, required=True)
        args = parser.parse_args()
        query = ("CALL forget_move_by_id({})".format(args['captured_pokemon_id'], args['move_id']))
        return execute_and_format(query)


@api.route('/learnedMove/remove/id')
class ForgetMoveByName(Resource):
    @api.expect(api.model('Learned Move Name Model', {'captured_pokemon_id': fields.Integer,
                                                      'move_name': fields.String}, envelope='resource'))
    def post(self):
        parser = reqparse.RequestParser(bundle_errors=True)
        parser.add_argument('captured_pokemon_id', type=int, required=True)
        parser.add_argument('move_name', type=str, required=True)
        args = parser.parse_args()
        query = ("CALL forget_move_by_name({}, \"{}\")".format(args['captured_pokemon_id'], args['move_name']))
        return execute_and_format(query)


'''
-------------------------------------
TRAINER API's
-------------------------------------
'''
@api.route('/trainer/get/')
class GetTrainer(Resource):
    @api.expect(api.model('Trainer ID', {'trainer_id': fields.Integer}, envelope='resource'))
    def put(self):
        parser = reqparse.RequestParser(bundle_errors=True)
        parser.add_argument('trainer_id', type=int, required=True)
        args = parser.parse_args()
        query = ("CALL get_trainer({})".format(args['trainer_id']))
        return execute_and_format(query)


@api.route('/trainer/add/')
class AddTrainer(Resource):
    @api.expect(api.model('Trainer Name', {'trainer_name': fields.String}, envelope='resource'))
    def post(self):
        parser = reqparse.RequestParser(bundle_errors=True)
        parser.add_argument('trainer_name', type=str, required=True)
        args = parser.parse_args()
        query = ("CALL add_trainer(\"{}\")".format(args['trainer_name']))
        return execute_and_format(query)


@api.route('/trainer/remove/')
class RemoveTrainer(Resource):
    @api.expect(api.model('Trainer ID', {'trainer_id': fields.Integer}, envelope='resource'))
    def post(self):
        parser = reqparse.RequestParser(bundle_errors=True)
        parser.add_argument('trainer_id', type=int, required=True)
        args = parser.parse_args()
        query = ("CALL remove_trainer({})".format(args['trainer_id']))
        return execute_and_format(query)


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
    @api.expect(api.model('Typing Name', {'type_name': fields.String}, envelope='resource'))
    def post(self):
        parser = reqparse.RequestParser(bundle_errors=True)
        parser.add_argument('type_name', type=str, required=True)
        args = parser.parse_args()
        query = ("CALL add_type(\"{}\")".format(args['type_name']))
        return execute_and_format(query)


@api.route('/typing/remove/')
class RemoveTyping(Resource):
    @api.expect(api.model('Typing ID', {'type_id': fields.Integer}, envelope='resource'))
    def post(self):
        parser = reqparse.RequestParser(bundle_errors=True)
        parser.add_argument('type_id', type=int, required=True)
        args = parser.parse_args()
        query = ("CALL remove_type({})".format(args['type_id']))
        return execute_and_format(query)


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
    @api.expect(api.model('Evolution Model', {'base_pokemon_name': fields.String,
                                              'evolved_pokemon_name': fields.String}, envelope='resource'))
    def post(self):
        parser = reqparse.RequestParser(bundle_errors=True)
        parser.add_argument('base_pokemon_name', type=str, required=True)
        parser.add_argument('evolved_pokemon_name', type=str, required=True)
        args = parser.parse_args()
        query = ("CALL add_evolution(\"{}\", \"{}\")".format(args['base_pokemon_name'], args['evolved_pokemon_name']))
        return execute_and_format(query)


@api.route('/evolution/remove/')
class RemoveEvolution(Resource):
    @api.expect(api.model('Evolution Model', {'base_pokemon_name': fields.String,
                                              'evolved_pokemon_name': fields.String}, envelope='resource'))
    def post(self):
        parser = reqparse.RequestParser(bundle_errors=True)
        parser.add_argument('base_pokemon_name', type=str, required=True)
        parser.add_argument('evolved_pokemon_name', type=str, required=True)
        args = parser.parse_args()
        query = ("CALL remove_evolution(\"{}\", \"{}\")".format(args['base_pokemon_name'], args['evolved_pokemon_name']))
        return execute_and_format(query)


'''
-------------------------------------
BATTLE API's
-------------------------------------
'''
@api.route('/battle/get/')
class GetTrainerBattles(Resource):
    @api.expect(api.model('Trainer ID', {'trainer_id': fields.Integer}, envelope='resource'))
    def put(self):
        parser = reqparse.RequestParser(bundle_errors=True)
        parser.add_argument('trainer_id', type=int, required=True)
        args = parser.parse_args()
        query = ("CALL get_trainer_battles({})".format(args['trainer_id']))
        return execute_and_format(query)


@api.route('/battle/add/')
class AddBattle(Resource):
    @api.expect(api.model('Battle Model', {'trainer_id1': fields.Integer, 'trainer_id2': fields.Integer,
                                           'winner_id': fields.Integer, 'prize': fields.Integer}, envelope='resource'))
    def post(self):
        parser = reqparse.RequestParser(bundle_errors=True)
        parser.add_argument('trainer_id1', type=int, required=True)
        parser.add_argument('trainer_id2', type=int, required=True)
        parser.add_argument('winner_id', type=int, required=True)
        parser.add_argument('prize', type=int, required=True)
        args = parser.parse_args()
        query = ("CALL add_battle({}, {}, {}, {})".format(
            args['trainer_id1'], args['trainer_id2'], args['winner_id'], args['prize']))
        return execute_and_format(query)


@api.route('/battle/remove/')
class RemoveBattle(Resource):
    @api.expect(api.model('Battle ID', {'battle_id': fields.Integer}, envelope='resource'))
    def post(self):
        parser = reqparse.RequestParser(bundle_errors=True)
        parser.add_argument('battle_id', type=int, required=True)
        args = parser.parse_args()
        query = ("CALL remove_battle({})".format(args['battle_id']))
        return execute_and_format(query)


if __name__ == '__main__':
    init_db()
    app.run(debug=True)
