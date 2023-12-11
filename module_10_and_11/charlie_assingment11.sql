-- Supplier Delivery Performance Report
SELECT 
    S.SupplierName,
    I.ItemName,
    I.Quantity,
    I.ExpectedDeliveryDate,
    I.ActualDeliveryDate,
    CASE WHEN I.ActualDeliveryDate > I.ExpectedDeliveryDate THEN 'Delayed'
         WHEN I.ActualDeliveryDate < I.ExpectedDeliveryDate THEN 'Early'
         ELSE 'On Time' END AS DeliveryStatus
FROM 
    Supplier S
JOIN 
    Item I ON S.SupplierID = I.SupplierID;

-- Wine Sales Report
SELECT 
    W.WineName,
    WT.WineTypeName,
    C.ClientName,
    CS.Quantity,
    CS.Revenue,
    D.DistributorName
FROM 
    Wine W
JOIN 
    WineType WT ON W.WineTypeID = WT.WineTypeID
JOIN 
    Distributor D ON W.DistributorID = D.DistributorID
JOIN 
    CustomerSupplier CS ON W.WineID = CS.WineID
JOIN 
    Client C ON CS.CustomerID = C.CustomerID;

-- Employee Work Hours Report
SELECT 
    E.EmployeeName,
    QUARTER(WH.WorkDate) AS Quarter,
    SUM(WH.HoursWorked) AS TotalHoursWorked
FROM 
    Employee E
JOIN 
    WorkHours WH ON E.EmployeeID = WH.EmployeeID
WHERE 
    WH.WorkDate >= CURDATE() - INTERVAL 1 YEAR
GROUP BY 
    E.EmployeeID, QUARTER(WH.WorkDate);


-- Creating the Purchase Order table
CREATE TABLE PurchaseOrder (
    PurchaseOrderID INT,
    ItemID INT,
    QuantityOrdered INT,
    OrderDate DATE,
    PRIMARY KEY (PurchaseOrderID, ItemID)
);

-- Creating the Inbound Delivery table
CREATE TABLE InboundDelivery (
    IBDeliveryID INT PRIMARY KEY,
    ScheduledDate DATE,
    DeliveryDate DATE,
    PurchaseOrderID INT,
    FOREIGN KEY (PurchaseOrderID) REFERENCES PurchaseOrder(PurchaseOrderID)
);

-- Creating the Sales Order table
CREATE TABLE SalesOrder (
    SalesOrderID INT,
    WineID INT,
    QuantitySold INT,
    OrderDate DATE,
    PRIMARY KEY (SalesOrderID, WineID)
);

-- Creating the Outbound Delivery table
CREATE TABLE OutboundDelivery (
    OBDeliveryID INT PRIMARY KEY,
    ScheduledDate DATE,
    DeliveryDate DATE,
    SalesOrderID INT,
    FOREIGN KEY (SalesOrderID) REFERENCES SalesOrder(SalesOrderID)
);

-- Creating the Hours table
CREATE TABLE Hours (
    EmployeeID INT PRIMARY KEY,
    Quarter1Hours INT,
    Quarter2Hours INT,
    Quarter3Hours INT,
    Quarter4Hours INT
);

-- Creating the UserDistributor table
CREATE TABLE UserDistributor (
    UserID INT PRIMARY KEY,
    DistributorID INT,
    FOREIGN KEY (DistributorID) REFERENCES Distributor(DistributorID)
);

-- Creating the Variety table
CREATE TABLE Variety (
    VarietyID INT PRIMARY KEY,
    VarietyName VARCHAR(255)
);

-- Creating the WineType table
CREATE TABLE WineType (
    WineTypeID INT PRIMARY KEY,
    TypeName VARCHAR(255)
);

-- Creating the WorkHours table
CREATE TABLE WorkHours (
    EmployeeID INT PRIMARY KEY,
    WorkDate DATE,
    HoursWorked INT
);

ALTER TABLE Wine
ADD COLUMN Price DECIMAL(10, 2)
;

CREATE TABLE Price (
    WineID INT PRIMARY KEY,
    Price DECIMAL(10, 2),
    FOREIGN KEY (WineID) REFERENCES Wine(WineID)
);

-- Insert Prices into the Price Table
INSERT INTO Price (WineID, Price)
VALUES
    (301, 15.99),
    (305, 19.99),
    (308, 22.50),
    (302, 24.99),
    (306, 18.75),
    (307, 21.50),
    (303, 14.99),
    (304, 17.25);

-- Insert Prices for Each Wine
UPDATE Wine
SET Price = CASE
    WHEN WineName = 'Merlot A' THEN 15.99
    WHEN WineName = 'Merlot B' THEN 19.99
    WHEN WineName = 'Cabernet A' THEN 22.50
    WHEN WineName = 'Cabernet B' THEN 24.99
    WHEN WineName = 'Chablis A' THEN 18.75
    WHEN WineName = 'Chablis B' THEN 21.50
    WHEN WineName = 'Chardonnay A' THEN 14.99
    WHEN WineName = 'Chardonnay B' THEN 17.25
END;

INSERT INTO employee_table (EmployeeID, EmployeeName, JobPositionID, ManagerID)
VALUES
  (1101, 'Employee1', 504, 1001),
  (1102, 'Employee2', 504, 1001),
  (1103, 'Employee3', 504, 1001),
  (1104, 'Employee4', 504, 1001),
  (1105, 'Employee5', 504, 1001),
  (1106, 'Employee6', 504, 1001),
  (1107, 'Employee7', 504, 1001),
  (1108, 'Employee8', 504, 1001),
  (1109, 'Employee9', 504, 1001),
  (1110, 'Employee10', 504, 1001),
  (1111, 'Employee11', 504, 1001),
  (1112, 'Employee12', 504, 1001),
  (1113, 'Employee13', 504, 1001),
  (1114, 'Employee14', 504, 1001),
  (1115, 'Employee15', 504, 1001),
  (1116, 'Employee16', 504, 1001),
  (1117, 'Employee17', 504, 1001),
  (1118, 'Employee18', 504, 1001),
  (1119, 'Employee19', 504, 1001),
  (1120, 'Employee20', 504, 1001);

INSERT INTO hours (EmployeeID, Quarter1Hours, Quarter2Hours, Quarter3Hours, Quarter4Hours)
VALUES
  (96, 88, 215, 26, 96),
  (86, 32, 32, 64, 32),
  (32, 46, 56, 112, 32),
  (30, 46, 64, 112, 64),
  (59, 85, 66, 0, 0),
  (85, 23, 78, 59, 59),
  (46, 59, 72, 45, 64),
  (58, 52, 74, 17, 32),
  (63, 21, 86, 16, 56),
  (74, 35, 23, 72, 64),
  (23, 72, 76, 36, 76),
  (88, 63, 18, 103, 103),
  (74, 57, 22, 14, 22),
  (65, 23, 14, 22, 98),
  (98, 74, 98, 86, 74),
  (55, 44, 112, 5, 44),
  (53, 43, 96, 115, 112),
  (86, 71, 15, 113, 5),
  (42, 16, 85, 72, 115),
  (85, 61, 6, 69, 113);


