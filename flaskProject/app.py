from flask import Flask, request, jsonify
from SETTINGS import config_file_path
import json
from flask_mysqldb import MySQL
from flask_restplus import Api, Resource

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


@api.route('/types')
class GetAllTypings(Resource):
    def get(self):
        cur = mysql.connection.cursor()
        query = ("SELECT * FROM typing;")
        cur.execute(query)
        response = [entry[0] for entry in cur.fetchall()]
        return jsonify(response)


@api.route('/pokemon')
class GetAllPokemon(Resource):
    def get(self):
        cur = mysql.connection.cursor()
        query = ("SELECT * FROM pokemon;")
        cur.execute(query)
        response = [entry for entry in cur.fetchall()]
        return jsonify(response)


@api.route('/pokemon/stats')
class GetAllPokemonStats(Resource):
    def get(self):
        cur = mysql.connection.cursor()
        query = ("SELECT * FROM stats;")
        cur.execute(query)
        response = [entry for entry in cur.fetchall()]
        return jsonify(response)


if __name__ == '__main__':
    init_db()
    app.run(debug=True)
