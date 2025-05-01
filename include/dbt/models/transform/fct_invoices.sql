-- fct_invoices.sql --
-- CREATE FACT TABLE FOR INVOICES

WITH FCT_INVOICE_CTE AS (
    SELECT  
        InvoiceNo AS invoice_id,
        InvoiceDate AS datetime_id,
        {{ dbt_utils.generate_surrogate_key(['StockCode', 'Description', 'UnitPrice']) }} AS product_id,
        {{ dbt_utils.generate_surrogate_key(['CustomerID', 'Country']) }} AS customer_id,
        Quantity AS quantity,
        Quantity * UnitPrice AS total
    FROM {{ source('retail', 'raw_invoices') }}
    WHERE Quantity > 0 
)
SELECT
    invoice_id,
    dt.datetime_id,
    dp.product_id,
    dc.customer_id,
    quantity,
    total 
FROM FCT_INVOICE_CTE fi
INNER JOIN {{ ref('dim_customer') }} dc ON dc.customer_id = fi.customer_id
INNER JOIN {{ ref('dim_product') }} dp ON dp.product_id = fi.product_id
INNER JOIN {{ ref('dim_datetime')}} dt ON dt.datetime_id = fi.datetime_id