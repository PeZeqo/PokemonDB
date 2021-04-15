# PokemonDB



### How to Run:

1. Clone github 
   - git clone https://github.com/PeZeqo/PokemonDB.git
2. Import dump file in MySQL Workbench (server -> data import -> self contained file)
   - Ensure target DB name is 'pokemon'
3. Install Python 3.6
4. Install requirements (located within flaskProject)
   - 1python -m pip install -r reqs.txt1
5. Update config.json in flaskProject to target your DB correctly
6. Run "app.py" in flaskProject (1python app.py1)
7. Access http://127.0.0.1:5000/ to check Swagger API

