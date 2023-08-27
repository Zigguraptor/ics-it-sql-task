CREATE VIEW dbo.vw_SKUPrice AS
SELECT
    s.ID,
    s.Code,
    s.Name,
    dbo.udf_GetSKUPrice(s.ID) AS PricePerProduct
FROM dbo.SKU s;
