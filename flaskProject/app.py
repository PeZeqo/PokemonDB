from flask import Flask, request, jsonify
from SETTINGS import config_file_path
import json
from flask_mysqldb import MySQL
from flask_restplus import Api, Resource, fields, reqparse

app = Flask(__name__)
api = Api(app)
cursor = None
mysql = MySQL(app)


def init_db():
    config_json = json.load(open(config_file_path))
    app.config['MYSQL_HOST'] = config_json['host']
    app.config['MYSQL_USER'] = config_json['user']
    app.config['MYSQL_PASSWORD'] = config_json['password']
    app.config['MYSQL_DB'] = config_json['database']


def execute_and_format(query, commit=False):
    cursor = mysql.connection.cursor()
    cursor.execute(query)
    if commit:
        mysql.connection.commit()
    response = [entry for entry in cursor.fetchall()]
    return jsonify(response)


@api.route('/pokemon')
class GetAllPokemon(Resource):
    def get(self):
        query = ("SELECT * FROM pokemon;")
        return execute_and_format(query)


@api.route('/pokemon/get')
class GetPokemon(Resource):
    @api.expect(api.model('Pokemon ID', {'id': fields.Integer}, envelope='resource'))
    def post(self):
        parser = reqparse.RequestParser(bundle_errors=True)
        parser.add_argument('id', type=int, required=True)
        args = parser.parse_args()
        query = ("CALL get_pokemon_by_id({})".format(args['id']))
        return execute_and_format(query)


@api.route('/pokemon/add')
class AddPokemon(Resource):
    @api.expect(api.model('Add Pokemon', {'name': fields.String, 'type1': fields.Integer, 'type2': fields.Integer}),
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
    @api.expect(api.model('Pokemon ID', {'id': fields.Integer}, envelope='resource'))
    def post(self):
        parser = reqparse.RequestParser(bundle_errors=True)
        parser.add_argument('id', type=int, required=True)
        args = parser.parse_args()
        query = ("CALL remove_pokemon({})".format(args['id']))
        return execute_and_format(query, True)


@api.route('/pokemon/get_with_stats')
class GetPokemonWithStats(Resource):
    @api.expect(api.model('Pokemon ID', {'id': fields.Integer}, envelope='resource'))
    def post(self):
        parser = reqparse.RequestParser(bundle_errors=True)
        parser.add_argument('id', type=int, required=True)
        args = parser.parse_args()
        query = ("CALL get_pokemon_and_stats({})".format(args['id']))
        return execute_and_format(query)


if __name__ == '__main__':
    init_db()
    app.run(debug=True)
