# Kody Pope
# 11-26-2023
# Assignment 8.2
# Movies: Update & Deletes


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
    def show_films(cursor, title):
        # method to execute an inner join on all tables,
        #  iterate over the dataset and output the results to the terminal window.

        # inner join query
        cursor.execute("select film_name as Name, film_director as Director, genre_name as Genre, studio_name as "
                       "'Studio Name' FROM film INNER JOIN genre ON film.genre_id=genre.genre_id INNER JOIN studio "
                       "ON film.studio_id=studio.studio_id ORDER BY film_id")

        # get the results from the cursor object
        films = cursor.fetchall()

        print("\n -- {} --".format(title))

        # iterate over the film data set and display the results
        for film in films:
         print("Film Name: {}\nDirector: {}\nGenre Name ID: {}\nStudio Name: {}\n".format(film[0], film[1], film[2], film[3]))


    show_films(cursor, "DISPLAYING FILMS")
    def show_insert_films(cursor, title):
        # method to execute an inner join on all tables,
        #  iterate over the dataset and output the results to the terminal window.
        # inner join query
        # cursor.execute("select film_name as Name, film_director as Director, genre_name as Genre, studio_name as "
        #                "'Studio Name' FROM film INNER JOIN genre ON film.genre_id=genre.genre_id INNER JOIN studio ON "
        #                "film.studio_id=studio.studio_id ")
        cursor.execute("INSERT INTO film (film_id, film_name, film_releaseDate, film_runtime, film_director, "
                       "studio_id, genre_id) VALUES (4, 'Jaws', 1975, 124, 'Steven Spielberg', 3, 1);")
        cursor.execute("select film_name as Name, film_director as Director, genre_name as Genre, studio_name as "
                       "'Studio Name' FROM film INNER JOIN genre ON film.genre_id=genre.genre_id INNER JOIN studio ON "
                       "film.studio_id=studio.studio_id ORDER BY film_id")
        # get the results from the cursor object
        films = cursor.fetchall()
        print("\n -- {} --".format(title))
        # iterate over the film data set and display the results
        for film in films:
         print("Film Name: {}\nDirector: {}\nGenre Name ID: {}\nStudio Name: {}\n".format(film[0], film[1], film[2], film[3]))
    show_insert_films(cursor, "DISPLAYING FILMS AFTER INSERT")

    def show_update_films(cursor, title):
        # method to execute an inner join on all tables,
        #  iterate over the dataset and output the results to the terminal window.
        # inner join query
        # cursor.execute("select film_name as Name, film_director as Director, genre_name as Genre, studio_name as "
        #                "'Studio Name' FROM film INNER JOIN genre ON film.genre_id=genre.genre_id INNER JOIN studio ON "
        #                "film.studio_id=studio.studio_id ")
        cursor.execute("UPDATE film SET genre_id = 1 WHERE genre_id = 2;")
        cursor.execute("select film_name as Name, film_director as Director, genre_name as Genre, studio_name as "
                       "'Studio Name' FROM film INNER JOIN genre ON film.genre_id=genre.genre_id INNER JOIN studio ON "
                       "film.studio_id=studio.studio_id ORDER BY film_id")
        # get the results from the cursor object
        films = cursor.fetchall()
        print("\n -- {} --".format(title))
        # iterate over the film data set and display the results
        for film in films:
         print("Film Name: {}\nDirector: {}\nGenre Name ID: {}\nStudio Name: {}\n".format(film[0], film[1], film[2], film[3]))
    show_update_films(cursor, "DISPLAYING FILMS AFTER UPDATE- Changed Alien to Horror")

    def show_delete_films(cursor, title):
        # method to execute an inner join on all tables,
        #  iterate over the dataset and output the results to the terminal window.
        # inner join query
        # cursor.execute("select film_name as Name, film_director as Director, genre_name as Genre, studio_name as "
        #                "'Studio Name' FROM film INNER JOIN genre ON film.genre_id=genre.genre_id INNER JOIN studio ON "
        #                "film.studio_id=studio.studio_id ")
        cursor.execute("DELETE FROM film WHERE film_name = 'Gladiator';")
        cursor.execute("select film_name as Name, film_director as Director, genre_name as Genre, studio_name as "
                       "'Studio Name' FROM film INNER JOIN genre ON film.genre_id=genre.genre_id INNER JOIN studio ON "
                       "film.studio_id=studio.studio_id ORDER BY film_id")
        # get the results from the cursor object
        films = cursor.fetchall()
        print("\n -- {} --".format(title))
        # iterate over the film data set and display the results
        for film in films:
         print("Film Name: {}\nDirector: {}\nGenre Name ID: {}\nStudio Name: {}\n".format(film[0], film[1], film[2], film[3]))
    show_delete_films(cursor, "DISPLAYING FILMS AFTER DELETE")

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