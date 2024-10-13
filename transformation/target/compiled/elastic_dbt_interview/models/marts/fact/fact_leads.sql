

WITH lead_data AS (
    SELECT *
    FROM "dbt"."staging"."stg_salesforce__lead" 
    
    WHERE lastmodifieddate > COALESCE((SELECT MAX(last_modified_date) FROM "dbt"."marts"."fact_leads"), '1970-01-01')
   

),

-- Join with dimension tables
fact_leads AS (
    SELECT
        md5(cast(coalesce(cast(lead_id as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as lead_key,
        d.date_day as date_key,
        u.user_key,
        a.account_key,
        c.contact_key,
        ld.createddate as created_date,
        ld.converteddate as converted_date,
        ld.status,
        ld.leadsource as lead_source,
        ld.industry,
        ld.isconverted as is_converted,
        ld.lastmodifieddate as last_modified_date
    FROM lead_data ld
    LEFT JOIN "dbt"."marts"."dim_user" u ON ld.ownerid = u.user_id
    LEFT JOIN "dbt"."marts"."dim_account" a ON ld.convertedaccountid = a.account_id
    LEFT JOIN "dbt"."marts"."dim_contact" c ON ld.convertedcontactid = c.contact_id
    LEFT JOIN "dbt"."marts"."dim_date" d ON CAST(ld.lastmodifieddate as DATE)=d.date_day
)

SELECT * FROM fact_leads