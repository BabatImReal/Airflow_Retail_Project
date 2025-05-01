
  
    

    create or replace table `airflow-first-pipeline-458004`.`retail`.`fct_invoices`
    
    

    OPTIONS()
    as (
      -- fct_invoices.sql --
-- CREATE FACT TABLE FOR INVOICES

WITH FCT_INVOICE_CTE AS (
    SELECT  
        InvoiceNo AS invoice_id,
        InvoiceDate AS datetime_id,
        to_hex(md5(cast(coalesce(cast(StockCode as STRING), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(Description as STRING), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(UnitPrice as STRING), '_dbt_utils_surrogate_key_null_') as STRING))) AS product_id,
        to_hex(md5(cast(coalesce(cast(CustomerID as STRING), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(Country as STRING), '_dbt_utils_surrogate_key_null_') as STRING))) AS customer_id,
        Quantity AS quantity,
        Quantity * UnitPrice AS total
    FROM `airflow-first-pipeline-458004`.`retail`.`raw_invoices`
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
INNER JOIN `airflow-first-pipeline-458004`.`retail`.`dim_customer` dc ON dc.customer_id = fi.customer_id
INNER JOIN `airflow-first-pipeline-458004`.`retail`.`dim_product` dp ON dp.product_id = fi.product_id
INNER JOIN `airflow-first-pipeline-458004`.`retail`.`dim_datetime` dt ON dt.datetime_id = fi.datetime_id
    );
  