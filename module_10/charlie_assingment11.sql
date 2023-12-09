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