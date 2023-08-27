CREATE PROCEDURE dbo.usp_MakeFamilyPurchase
    @FamilySurName NVARCHAR(255)
AS
BEGIN
    DECLARE @FamilyID INT;

    SELECT @FamilyID = ID
    FROM dbo.Family
    WHERE SurName = @FamilySurName;

    IF @FamilyID IS NULL
    BEGIN
        THROW 50000, 'Family with the provided SurName does not exist.', 1;
    END;

    UPDATE dbo.Family
    SET BudgetValue = BudgetValue - (SELECT SUM(Value) FROM dbo.Basket WHERE ID_Family = @FamilyID)
    WHERE ID = @FamilyID;
END;
