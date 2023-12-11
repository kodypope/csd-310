from mysql.connector import connect, Error, errorcode

script_path = "charlie_db_script_v2.sql"
root_password = input("Enter your MySQL root password: ")

# Specify MySQL connection details
config = {
    "user": "root",
    "password": root_password,
    "host": "127.0.0.1",
    "raise_on_warnings": False
}

def queryTable2(table_name, field1, field2):
    query_table = "SELECT * FROM " + table_name + ";"
    cursor.execute(query_table)
    result = cursor.fetchall()
    print("\n--DISPLAYING " + table_name + " Records--")
    for row in result:
        print(f"{field1}: {row[0]:<5} {field2}: {row[1]}")

def queryTable3(table_name, field1, field2, field3):
    query_table = "SELECT * FROM " + table_name + ";"
    cursor.execute(query_table)
    result = cursor.fetchall()
    print("\n--DISPLAYING " + table_name + " Records--")
    for row in result:
        print(f"{field1}: {row[0]:<5} {field2}: {row[1]:<12} {field3}: {row[2]}")
    
def queryTable4(table_name, field1, field2, field3, field4):
    query_table = "SELECT * FROM " + table_name + ";"
    cursor.execute(query_table)
    result = cursor.fetchall()
    print("\n--DISPLAYING " + table_name + " Records--")
    for row in result:
        print(f"{field1}: {row[0]:<5} {field2}: {row[1]:<12} {field3}: {row[2]:<8} {field4}: {row[3]}")

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

        print("SUCCESS: SQL script executed successfully.")

        # Query through all the tables and show contents
        queryTable3("Wine", "Wine ID", "Wine Name", "Distributor ID")
        queryTable3("WineType", "Type_ID", "Wine Name", "Variety_ID")
        queryTable4("Item", "Item ID:", "Item Name", "Quantity", "Supplier ID")
        queryTable2("Supplier", "Supplier ID", "Supplier Name")
        queryTable2("JobPosition", "Position ID", "Position Title")
        queryTable4("Employee", "Employee ID", "Employee Name", "Job Position ID", "Manager ID")
        queryTable2("Variety", "Variety ID", "Variety Name")
        queryTable2("Owner", "Owner ID", "Owner Name")
        queryTable3("Successor", "Successor ID", "Successor Name", "Owner ID")
        queryTable2("Manager", "Manager ID", "Manager Name")
        queryTable2("Distributor", "Distributor ID", "Distributor Name")
        queryTable2("User", "User Id", "User Name")
        queryTable2("UserDistributor", "User ID", "Distributor ID")
        queryTable2("Supervisor", "Supervisor ID", "Supervisor Name")
        queryTable3("Subordinate", "Subordinate ID", "Subordinate Name", "Supervisor ID")
        queryTable3("Client", "Client ID", "Client Name", "Coordinator ID")
        queryTable2("Coordinator", "Coordinator ID", "Coordinator Name")
        queryTable2("Customer", "Customer ID", "Customer Name")
        queryTable2("CustomerSupplier", "Customer ID", "Supplier ID")

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
