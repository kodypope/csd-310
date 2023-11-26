# Kody Pope
# 11-26-2023
# Assignment 7.2
# Movies: Table Queries


import mysql.connector
from mysql.connector import errorcode

config = {
    "user": "root",
    "password": "Thegrass110",
    "host": "127.0.0.1",
    "database": "movies",
    "raise_on_warnings": True
}

try:
    db = mysql.connector.connect(**config)

    print("\n Database user {} connected to MysQL on host {} with database {}".format(config["user"], config["host"], config["database"]))


    cursor = db.cursor()
    # Displaying studio records.
    print("\n-- DISPLAYING Studio RECORDS --")
    cursor.execute("SELECT studio_id, studio_name FROM studio")
    studios = cursor.fetchall()
    for studio in studios:
        print("Studio ID: {}\nStudio Name: {}\n".format(studio[0], studio[1]))

    # Displaying genre records.
    print("\n-- DISPLAYING Genre RECORDS --")
    cursor.execute("SELECT genre_id, genre_name FROM genre")
    genres = cursor.fetchall()
    for genre in genres:
        print("Genre ID: {}\nGenre Name: {}\n".format(genre[0], genre[1]))

    # Displaying short film records.
    print("\n-- DISPLAYING Short Film RECORDS --")
    cursor.execute("SELECT film_name, film_runtime FROM film WHERE film_runtime <= 120")
    films = cursor.fetchall()
    for film in films:
        print("Film Name: {}\nRuntime: {}\n".format(film[0], film[1]))

    # Displaying director records in alphabetic order by first name.
    print("\n-- DISPLAYING Director RECORDS in Order --")
    cursor.execute("SELECT film_name, film_director FROM film ORDER BY film_director")
    films = cursor.fetchall()
    for film in films:
        print("Film Name: {}\nDirector: {}\n".format(film[0], film[1]))

    # Prompting user to end program.
    input("\n\n Press any key to continue...\n")

except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("  The supplied username or password are invalid")

    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("  The specified database does not exist")

    else:
        print(err)

finally:
    db.close()