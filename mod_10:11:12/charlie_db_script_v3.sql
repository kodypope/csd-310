-- Drop user if exists
DROP USER IF EXISTS 'charlie_user'@'localhost';

-- Create charlie_user and grant them all privileges to the Charlie.db database
CREATE USER 'charlie_user'@'localhost' IDENTIFIED WITH mysql_native_password BY '1234';

-- Grant all privileges to the Charlie.db database to user charlie_user on localhost
GRANT ALL PRIVILEGES ON `Charlie.db`.* TO 'charlie_user'@'localhost';

-- Drop tables if they exist
DROP TABLE IF EXISTS Item;
DROP TABLE IF EXISTS CustomerSupplier;
DROP TABLE IF EXISTS Supplier;
DROP TABLE IF EXISTS Price;
DROP TABLE IF EXISTS Wine;
DROP TABLE IF EXISTS UserDistributor;
DROP TABLE IF EXISTS Distributor;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS JobPosition;
DROP TABLE IF EXISTS Successor;
DROP TABLE IF EXISTS Owner;
DROP TABLE IF EXISTS Subordinate;
DROP TABLE IF EXISTS Supervisor;
DROP TABLE IF EXISTS ProductionLineEmployee;
DROP TABLE IF EXISTS Manager;
DROP TABLE IF EXISTS Client;
DROP TABLE IF EXISTS Coordinator;
DROP TABLE IF EXISTS WineType;
DROP TABLE IF EXISTS Variety;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS InboundDelivery;
DROP TABLE IF EXISTS PurchaseOrder;
DROP TABLE IF EXISTS OutboundDelivery;
DROP TABLE IF EXISTS SalesOrder;
DROP TABLE IF EXISTS Hours;
DROP TABLE IF EXISTS WorkHours;



-- Supplier Table
CREATE TABLE Supplier (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(255)
    -- Other attributes
);

-- Item Table
CREATE TABLE Item (
    ItemID INT PRIMARY KEY,
    ItemName VARCHAR(255),
    Quantity INT,
    ActualDeliveryDate DATE,
    ExpectedDeliveryDate DATE,
    SupplierID INT,
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
    -- Other attributes
);

-- Distributor Table
CREATE TABLE Distributor (
    DistributorID INT PRIMARY KEY,
    DistributorName VARCHAR(255)
    -- Other attributes
);

-- Wine Table
CREATE TABLE Wine (
    WineID INT PRIMARY KEY,
    WineName VARCHAR(255),
    Price DECIMAL(10, 2),
    DistributorID INT,
    FOREIGN KEY (DistributorID) REFERENCES Distributor(DistributorID)
    -- Other attributes
);

-- JobPosition Table
CREATE TABLE JobPosition (
    JobPositionID INT PRIMARY KEY,
    PositionTitle VARCHAR(255)
    -- Other attributes
);

-- Manager Table
CREATE TABLE Manager (
    ManagerID INT PRIMARY KEY,
    ManagerName VARCHAR(255)
    -- Other attributes
);

-- Employee Table
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(255),
    JobPositionID INT,
    ManagerID INT,
    FOREIGN KEY (JobPositionID) REFERENCES JobPosition(JobPositionID),
    FOREIGN KEY (ManagerID) REFERENCES Manager(ManagerID)
    -- Other attributes
);

-- Owner Table
CREATE TABLE Owner (
    OwnerID INT PRIMARY KEY,
    OwnerName VARCHAR(255)
    -- Other attributes
);

-- Successor Table
CREATE TABLE Successor (
    SuccessorID INT PRIMARY KEY,
    SuccessorName VARCHAR(255),
    OwnerID INT,
    FOREIGN KEY (OwnerID) REFERENCES Owner(OwnerID)
    -- Other attributes
);

-- Supervisor Table
CREATE TABLE Supervisor (
    SupervisorID INT PRIMARY KEY,
    SupervisorName VARCHAR(255)
    -- Other attributes
);

-- Subordinate Table
CREATE TABLE Subordinate (
    SubordinateID INT PRIMARY KEY,
    SubordinateName VARCHAR(255),
    SupervisorID INT,
    FOREIGN KEY (SupervisorID) REFERENCES Supervisor(SupervisorID)
    -- Other attributes
);

-- Coordinator Table
CREATE TABLE Coordinator (
    CoordinatorID INT PRIMARY KEY,
    CoordinatorName VARCHAR(255)
    -- Other attributes
);

-- Client Table
CREATE TABLE Client (
    ClientID INT PRIMARY KEY,
    ClientName VARCHAR(255),
    CoordinatorID INT,
    FOREIGN KEY (CoordinatorID) REFERENCES Coordinator(CoordinatorID)
    -- Other attributes
);

-- Variety Table
CREATE TABLE Variety (
    VarietyID INT PRIMARY KEY,
    VarietyName VARCHAR(255)
    -- Other attributes
);

-- WineType Table
CREATE TABLE WineType (
    WineTypeID INT PRIMARY KEY,
    WineTypeName VARCHAR(255),
    VarietyID INT,
    FOREIGN KEY (VarietyID) REFERENCES Variety(VarietyID)
    -- Other attributes
);

-- Customer Table
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
    -- Other attributes
);

-- CustomerSupplier Junction Table for M:N Relationship
CREATE TABLE CustomerSupplier (
    CustomerID INT,
    SupplierID INT,
    PRIMARY KEY (CustomerID, SupplierID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);

-- User Table
CREATE TABLE User (
    UserID INT PRIMARY KEY,
    UserName VARCHAR(255)
    -- Other attributes
);

-- UserDistributor Junction Table for M:N Relationship
CREATE TABLE UserDistributor (
    UserID INT,
    DistributorID INT,
    PRIMARY KEY (UserID, DistributorID),
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (DistributorID) REFERENCES Distributor(DistributorID)
);

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
    SalesOrderID INT NOT NULL AUTO_INCREMENT,
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

-- Creating the WorkHours table
CREATE TABLE WorkHours (
    EmployeeID INT PRIMARY KEY,
    WorkDate DATE,
    HoursWorked INT
);

CREATE TABLE Price (
    WineID INT PRIMARY KEY,
    Price DECIMAL(10, 2),
    FOREIGN KEY (WineID) REFERENCES Wine(WineID)
);

-- Sample data for Supplier
INSERT INTO Supplier (SupplierID, SupplierName) VALUES
(1, 'Supplier1'),
(2, 'Supplier2'),
(3, 'Supplier3');

-- Sample data for Item
INSERT INTO Item (ItemID, ItemName, Quantity, ActualDeliveryDate, ExpectedDeliveryDate, SupplierID) VALUES
(101, 'Bottles', 1034, '2023-12-03', '2023-12-01', 1),
(102, 'Corks', 2021, '2023-12-01', '2023-12-01', 1),
(103, 'Labels', 1230, '2023-12-05', '2023-11-26', 2),
(104, 'Boxes', 780, '2023-12-04', '2023-12-05', 2),
(105, 'Vats', 240, '2023-12-01', '2023-12-08', 3),
(106, 'Tubing', 320, '2023-10-08', '2023-10-10', 3);

-- Sample data for Distributor
INSERT INTO Distributor (DistributorID, DistributorName) VALUES
(201, 'DistributorA'),
(202, 'DistributorB'),
(203, 'DistributorC');

-- Sample data for Wine
INSERT INTO Wine (WineID, WineName, DistributorID) VALUES
(301, 'Merlot A', 201),
(302, 'Merlot B', 202),
(303, 'Cabernet A', 203),
(304, 'Cabernet B', 203),
(305, 'Chablis A', 201),
(306, 'Chablis B', 202),
(307, 'Chardonnay A', 202),
(308, 'Chardonnay B', 201);

INSERT INTO SalesOrder (WineID, QuantitySold, OrderDate) VALUES
(308, 40, '2023-11-02'),
(305, 30, '2023-11-04'),
(301, 50, '2023-11-16'),
(307, 25, '2023-11-24'),
(306, 35, '2023-11-18'),
(302, 20, '2023-11-06'),
(304, 15, '2023-11-29'),
(303, 45, '2023-11-13');

-- Sample data for JobPosition
INSERT INTO JobPosition (JobPositionID, PositionTitle) VALUES
(501, 'Manager'),
(502, 'Supervisor'),
(503, 'Coordinator'),
(504, 'Production Line Worker');

-- Sample data for Owner
INSERT INTO Owner (OwnerID, OwnerName) VALUES
(601, 'George');

-- Sample data for Successor
INSERT INTO Successor (SuccessorID, SuccessorName, OwnerID) VALUES
(701, 'Stan', 601),
(702, 'Davis', 601);

-- Sample data for Supervisor
INSERT INTO Supervisor (SupervisorID, SupervisorName) VALUES
(801, 'Roz Murphy');

-- Sample data for Subordinate
INSERT INTO Subordinate (SubordinateID, SubordinateName, SupervisorID) VALUES
(901, 'Bob Ulrich', 801);

-- Sample data for Manager
INSERT INTO Manager (ManagerID, ManagerName) VALUES
(1001, 'Henry Doyle');

-- Sample data for ProductionLineEmployee
INSERT INTO Employee (EmployeeID, EmployeeName, JobPositionID, ManagerID) VALUES
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
  (1101, 88, 215, 26, 96),
  (1102, 32, 32, 64, 32),
  (1103, 46, 56, 112, 32),
  (1104, 46, 64, 112, 64),
  (1105, 85, 66, 0, 0),
  (1106, 23, 78, 59, 59),
  (1107, 59, 72, 45, 64),
  (1108, 52, 74, 17, 32),
  (1109, 21, 86, 16, 56),
  (1110, 35, 23, 72, 64),
  (1111, 72, 76, 36, 76),
  (1112, 63, 18, 103, 103),
  (1113, 57, 22, 14, 22),
  (1114, 23, 14, 22, 98),
  (1115, 74, 98, 86, 74),
  (1116, 44, 112, 5, 44),
  (1117, 43, 96, 115, 112),
  (1118, 71, 15, 113, 5),
  (1119, 16, 85, 72, 115),
  (1120, 61, 6, 69, 113);

-- Sample data for Coordinator
INSERT INTO Coordinator (CoordinatorID, CoordinatorName) VALUES
(1201, 'Maria Costanza');

-- Sample data for Client
INSERT INTO Client (ClientID, ClientName, CoordinatorID) VALUES
(1301, 'Client1', 1201),
(1302, 'Client2', 1201);

-- Sample data for Variety
INSERT INTO Variety (VarietyID, VarietyName) VALUES
(1501, 'GrapeA'),
(1502, 'GrapeB');

-- Sample data for WineType
INSERT INTO WineType (WineTypeID, WineTypeName, VarietyID) VALUES
(1401, 'RedWine', 1501),
(1402, 'WhiteWine', 1502);

-- Sample data for Customer
INSERT INTO Customer (CustomerID, CustomerName) VALUES
(1601, 'Stan'),
(1602, 'Davis');

-- Sample data for CustomerSupplier (M:N Relationship)
INSERT INTO CustomerSupplier (CustomerID, SupplierID) VALUES
(1601, 1),
(1601, 2),
(1602, 2),
(1602, 3);

-- Sample data for User
INSERT INTO User (UserID, UserName) VALUES
(1701, 'DistributorUser1'),
(1702, 'DistributorUser2');

-- Sample data for UserDistributor (M:N Relationship)
INSERT INTO UserDistributor (UserID, DistributorID) VALUES
(1701, 201),
(1702, 202);

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