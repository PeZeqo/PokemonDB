import mysql.connector

if __name__ == '__main__':
    user = input("User Name: ")
    password = input("Password: ")

    cnx = mysql.connector.connect(user=user, password=password,
                                  host='127.0.0.1',
                                  database='lotrfinal_1')

    cursor = cnx.cursor()
    query = ("SELECT character_name FROM lotr_character;")
    cursor.execute(query)

    all_chars = []
    for name in cursor:
        all_chars.append(name[0].lower())

    character = ""
    while True:
        character = input("Character name: ").lower()
        if character in all_chars:
            break
        print("Character: {} doesn't exist in table, try again!".format(character))

    query = ("CALL track_character('{}');".format(character))
    cursor.execute(query)

    for entry in cursor:
        print(entry)

    cursor.close()
    cnx.close()
