

WITH source AS (
    SELECT *
    FROM "dbt"."staging"."stg_salesforce__account"  
)

SELECT *
FROM source

