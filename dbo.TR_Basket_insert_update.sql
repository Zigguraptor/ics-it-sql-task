CREATE TRIGGER dbo.TR_Basket_insert_update
ON dbo.Basket
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE b
    SET DiscountValue = CASE WHEN c.Count >= 2 THEN Value * 0.05 ELSE 0 END
    FROM dbo.Basket b
    JOIN (
        SELECT ID_SKU, COUNT(*) AS Count
        FROM inserted
        GROUP BY ID_SKU
    ) c ON b.ID_SKU = c.ID_SKU
    WHERE b.ID IN (SELECT ID FROM inserted);

    UPDATE b
    SET DiscountValue = 0
    FROM dbo.Basket b
    JOIN inserted i ON b.ID = i.ID
    WHERE i.ID_SKU NOT IN (SELECT ID_SKU FROM c);

END;
