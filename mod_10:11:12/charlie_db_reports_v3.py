from mysql.connector import connect, Error, errorcode
from prettytable import PrettyTable
import datetime

root_password = input("Enter your MySQL root password: ")

# Specify MySQL connection details
config = {
    "user": "root",
    "password": root_password,
    "host": "127.0.0.1",
    "raise_on_warnings": False
}

try:
    # Establish MySQL connection
    with connect(**config) as db:
        # Create a cursor object to interact with the database
        cursor = db.cursor()

        # Switch to the 'Charlie' database
        cursor.execute("USE Charlie;")

        # Supplier Delivery Performance Report
        supplier_delivery_report = """
        SELECT 
            S.SupplierName,
            I.ItemName,
            I.Quantity,
            I.ExpectedDeliveryDate,
            I.ActualDeliveryDate,
            CASE WHEN I.ActualDeliveryDate > I.ExpectedDeliveryDate 
                 THEN CONCAT (' Delayed: ', DATEDIFF(I.ActualDeliveryDate, I.ExpectedDeliveryDate), ' Days')
                 WHEN I.ActualDeliveryDate < I.ExpectedDeliveryDate 
                 THEN CONCAT (' Early: ', DATEDIFF(I.ExpectedDeliveryDate, I.ActualDeliveryDate), ' Days')
                 ELSE 'On Time' END AS DeliveryStatus
        FROM 
            Supplier S
        JOIN 
            Item I ON S.SupplierID = I.SupplierID;
        """
        cursor.execute(supplier_delivery_report)
        result_supplier_delivery = cursor.fetchall()
        print("\n-- Supplier Delivery Performance Report --")
        print(f"-- Time of report: {datetime.datetime.now()} --")
        supplier_table = PrettyTable(["Supplier", "Item", "Quantity", "Expected Delivery Date", "Actual Delivery Date", "Delivery Status"])
        supplier_table.add_rows(result_supplier_delivery)
        print(supplier_table)

        # Wine Sales Report
        wine_sales_report = """
        SELECT
            W.WineID,
            W.WineName,
            W.DistributorID,
            D.DistributorName,
            SUM(SO.QuantitySold) AS TotalQuantitySold,
            SO.OrderDate AS 'November 2023',
            CONCAT('$', SUM(SO.QuantitySold * W.Price)) AS TotalRevenue
        FROM
            Wine W
        JOIN
            SalesOrder SO ON W.WineID = SO.WineID
        JOIN
            Distributor D ON W.DistributorID = D.DistributorID
        WHERE  
            MONTH(SO.OrderDate) = 11 AND YEAR(SO.OrderDate) = 2023
        GROUP BY
            W.WineID,
            SO.OrderDate 
        """
        cursor.execute(wine_sales_report)
        result_wine_sales = cursor.fetchall()
        print("\n-- Wine Sales Report --")
        print(f"-- Time of report: {datetime.datetime.now()} --")
        wine_table = PrettyTable(["Wine ID", "Wine Name", "Distributor ID", "Distributor Name", "Total Quantity Sold", "November 2023", "Total Revenue"])
        wine_table.add_rows(result_wine_sales)
        print(wine_table)

        # Employee Work Hours Report
        employee_work_hours_report = """
        SELECT 
            E.EmployeeName,
            SUM(H.Quarter1Hours) AS Q1,
            SUM(H.Quarter2Hours) AS Q2,
            SUM(H.Quarter3Hours) AS Q3,
            SUM(H.Quarter4Hours) AS Q4,
            SUM(H.Quarter1Hours + H.Quarter2Hours + H.Quarter3Hours + H.Quarter4Hours) AS TotalHoursWorked
        FROM 
            Employee E
        JOIN 
            Hours H ON E.EmployeeID = H.EmployeeID
        GROUP BY 
            E.EmployeeID;
        """
        cursor.execute(employee_work_hours_report)
        result_employee_work_hours = cursor.fetchall()
        print("\n-- Employee Work Hours Report --")
        print(f"-- Time of report: {datetime.datetime.now()} --")
        employee_table = PrettyTable(["Employee", "Q1", "Q2", "Q3", "Q4", "Total Hours Worked"])
        employee_table.add_rows(result_employee_work_hours)
        print(employee_table)

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
