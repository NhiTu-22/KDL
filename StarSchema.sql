CREATE TABLE dbo.Dim_Date (
    Date_Key INT PRIMARY KEY,          -- Định dạng YYYYMMDD, ví dụ 20170515
    Full_Date DATE NOT NULL,
    [Day] INT NOT NULL,
    [Month] INT NOT NULL,
    Month_Name NVARCHAR(20) NOT NULL,
    [Quarter] INT NOT NULL,
    [Year] INT NOT NULL,
    Is_Weekend BIT NOT NULL
);

CREATE TABLE dbo.Dim_Product (
    Product_Key INT IDENTITY(1,1) PRIMARY KEY,
    Product_Id NVARCHAR(100) NOT NULL,
    Category_Name NVARCHAR(150) NOT NULL,
    Product_Weight_Grams FLOAT NULL
);

CREATE TABLE dbo.Dim_Customer (
    Customer_Key INT IDENTITY(1,1) PRIMARY KEY,
    Customer_Id NVARCHAR(100) NOT NULL,
    Customer_Unique_Id NVARCHAR(100) NULL,
    Customer_Zip_Code_Prefix NVARCHAR(20) NULL,
    Customer_City NVARCHAR(100) NULL,
    Customer_State NVARCHAR(50) NULL
);

CREATE TABLE dbo.Dim_Seller (
    Seller_Key INT IDENTITY(1,1) PRIMARY KEY,
    Seller_Id NVARCHAR(100) NOT NULL,
    Seller_Zip_Code_Prefix NVARCHAR(20) NULL,
    Seller_City NVARCHAR(100) NULL,
    Seller_State NVARCHAR(50) NULL
);

CREATE TABLE dbo.Fact_Sales (
    Sales_Key BIGINT IDENTITY(1,1) PRIMARY KEY,
    Date_Key INT NOT NULL REFERENCES dbo.Dim_Date(Date_Key),
    Product_Key INT NOT NULL REFERENCES dbo.Dim_Product(Product_Key),
    Customer_Key INT NOT NULL REFERENCES dbo.Dim_Customer(Customer_Key),
    Seller_Key INT NOT NULL REFERENCES dbo.Dim_Seller(Seller_Key),
    Order_Id NVARCHAR(100) NOT NULL,
    Order_Item_Id INT NOT NULL,
    Price DECIMAL(18,2) NOT NULL,
    Freight_Value DECIMAL(18,2) NOT NULL,
    Total_Amount AS (Price + Freight_Value) PERSISTED,
    Item_Quantity INT NOT NULL DEFAULT 1
);