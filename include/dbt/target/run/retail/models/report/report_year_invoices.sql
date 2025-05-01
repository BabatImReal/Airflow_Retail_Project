
  
    

    create or replace table `airflow-first-pipeline-458004`.`retail`.`report_year_invoices`
    
    

    OPTIONS()
    as (
      SELECT
  dt.year,
  dt.month,
  COUNT(DISTINCT fi.invoice_id) AS num_invoices,
  SUM(fi.total) AS total_revenue
FROM `airflow-first-pipeline-458004`.`retail`.`fct_invoices` fi
JOIN `airflow-first-pipeline-458004`.`retail`.`dim_datetime` dt ON fi.datetime_id = dt.datetime_id
GROUP BY dt.year, dt.month
ORDER BY dt.year, dt.month
    );
  