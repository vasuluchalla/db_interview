

WITH case_data AS (
    SELECT
        *
    FROM "dbt"."staging"."stg_salesforce__case" 
    
    
    WHERE lastmodifieddate > COALESCE((SELECT MAX(last_modified_date) FROM "dbt"."marts"."fact_cases"), '1970-01-01')
    
),

-- Join with dimension tables
fact_case AS (
    SELECT
        md5(cast(coalesce(cast(case_id as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as case_key, 
        d.date_day as date_key,
   	    a.account_key, 
   	    u.user_key, 
   	    co.contact_key,
   	    p.product_key,
   	    c.casenumber as case_number,
        c.type,
        c.status,
        c.priority,
        c.isescalated,
        c.isclosed,
        c.closeddate as closed_date,
        c.lastmodifieddate as last_modified_date,
        current_date as dwh_created_date,
        current_date as dwh_updated_date 
   from case_data c
    LEFT JOIN "dbt"."marts"."dim_account" a ON c.accountid = a.account_id
    LEFT JOIN "dbt"."marts"."dim_user"  u ON c.ownerid = u.user_id
    LEFT JOIN "dbt"."marts"."dim_contact" co ON c.contactid = co.contact_id
    LEFT JOIN "dbt"."marts"."dim_product" p ON c.productid = p.product_id
    LEFT JOIN "dbt"."marts"."dim_date" d ON CAST(c.lastmodifieddate as DATE)=d.date_day
)

SELECT * FROM fact_case