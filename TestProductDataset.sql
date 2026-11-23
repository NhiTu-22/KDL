SELECT
    p.product_id,
    ISNULL(t.product_category_name_english,'Other') AS Category_Name,
    p.product_weight_g
FROM dbo.olist_products_dataset p
LEFT JOIN dbo.product_category_name_translation t
    ON p.product_category_name = t.product_category_name;