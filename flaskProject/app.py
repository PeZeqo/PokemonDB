from flask import Flask, request
from flask_swagger_ui import get_swaggerui_blueprint
# import mysql.connector
from SETTINGS import config_file_path, SWAGGER_URL, API_URL
import json
from flask_mysqldb import MySQL
from flask import jsonify

app = Flask(__name__)
cursor = None
config_json = json.load(open(config_file_path))
app.config['MYSQL_HOST'] = config_json['host']
app.config['MYSQL_USER'] = config_json['user']
app.config['MYSQL_PASSWORD'] = config_json['password']
app.config['MYSQL_DB'] = config_json['database']
mysql = MySQL(app)


def init_swagger():
    return get_swaggerui_blueprint(
        SWAGGER_URL,
        API_URL,
    )


# def init_db():
#     global cursor
#     config_json = json.load(open(config_file_path))
#     cnx = mysql.connector.connect(user=config_json['user'],
#                                   password=config_json['password'],
#                                   host=config_json['host'],
#                                   database=config_json['database'])
#     cursor = cnx.cursor()


@app.route('/types', methods=['GET'])
def get_all_typings():
    cur = mysql.connection.cursor()
    query = ("SELECT * FROM typing;")
    cur.execute(query)
    response = [entry[0] for entry in cur.fetchall()]
    return jsonify(response)


@app.route('/pokemon', methods=['GET'])
def get_all_pokemon():
    cur = mysql.connection.cursor()
    query = ("SELECT * FROM pokemon;")
    cur.execute(query)
    response = [entry for entry in cur.fetchall()]
    return jsonify(response)


@app.route('/pokemon/stats', methods=['GET'])
def get_all_pokemon_stats():
    cur = mysql.connection.cursor()
    query = ("SELECT * FROM stats;")
    cur.execute(query)
    response = [entry for entry in cur.fetchall()]
    return jsonify(response)


if __name__ == '__main__':
    # init_db()
    swaggerui_blueprint = init_swagger()
    app.register_blueprint(swaggerui_blueprint)
    app.run()

# Now point your browser to localhost:5000/api/docs/