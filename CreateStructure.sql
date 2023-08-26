CREATE TABLE dbo.SKU (
    ID INT IDENTITY(1,1) PRIMARY KEY,
	Code AS ('s' + CAST(ID AS NVARCHAR(10))) UNIQUE,
	Name NVARCHAR(255)
);

CREATE TABLE dbo.Family (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    SurName NVARCHAR(100),
    BudgetValue DECIMAL(18, 2)
);

CREATE TABLE dbo.Basket (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    ID_SKU INT REFERENCES dbo.SKU(ID),
    ID_Family INT REFERENCES dbo.Family(ID),
    Quantity INT CHECK (Quantity >= 0),
    Value DECIMAL(18, 2) CHECK (Value >= 0),
    PurchaseDate DATE DEFAULT GETDATE(),
    DiscountValue DECIMAL(18, 2)
);
