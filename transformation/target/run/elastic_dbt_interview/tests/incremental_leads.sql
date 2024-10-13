select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      -- tests/incremental_leads.sql
WITH latest_fact_data AS (
    SELECT MAX(lastmodifieddate) AS max_lastmodifieddate
    FROM "dbt"."marts"."fact_leads"
)

SELECT *
FROM "dbt"."staging"."stg_salesforce__lead"
WHERE isdeleted = FALSE
AND lastmodifieddate > (SELECT max_lastmodifieddate FROM latest_fact_data)
      
    ) dbt_internal_test