
from mysql.connector import connect, Error, errorcode

script_path = "charlie_db_script.sql"
root_password = input("Enter your MySQL password: ")

# Specify MySQL connection details
config = {
    "user": "root",
    "password": root_password,
    "host": "127.0.0.1",
    "raise_on_warnings": False
}

# Read SQL script from file
with open(script_path, "r") as file:
    sql_script = file.read()

try:
    # Establish MySQL connection
    with connect(**config) as db:
        # Create a cursor object to interact with the database
        cursor = db.cursor()

        # Create the 'Charlie' database
        cursor.execute("CREATE DATABASE IF NOT EXISTS Charlie;")
        print("Database 'Charlie' created.")

        # Switch to the 'Charlie' database
        cursor.execute("USE Charlie;")

        sql_queries = sql_script.split(';')

        # Execute the SQL script
        for query in sql_queries:
            if query.strip() != '':
                cursor.execute(query)
                db.commit()

        print("SQL script executed successfully.")

        # Query 1: Displaying Supplier Records
        query_supplier = "SELECT * FROM Supplier;"
        cursor.execute(query_supplier)
        result_supplier = cursor.fetchall()
        print("\n--DISPLAYING Supplier Records--")
        for row in result_supplier:
            print(f"Supplier ID: {row[0]}\nSupplier Name: {row[1]}")

        # future queries

except Error as err:
    # Handle MySQL connection errors
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("* The supplied username or password is invalid.")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("* The specified database does not exist.")
    else:
        print(err)

finally:
    # Close the cursor and database connection if open
    if 'cursor' in locals() and cursor:
        cursor.close()
    if 'db' in locals() and db.is_connected():
        db.close()
        print("\nDatabase connection closed.")
