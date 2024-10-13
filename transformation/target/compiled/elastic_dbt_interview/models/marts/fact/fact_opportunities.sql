

WITH opportunity_data AS (
    SELECT
        *
    FROM "dbt"."staging"."stg_salesforce__opportunity"
    --WHERE lastmodifieddate > (SELECT MAX(last_modified_date) FROM "dbt"."marts"."fact_opportunities") 
    where 1=1
    and isdeleted = FALSE
),

-- Join with dimension tables
fact_opportunities AS (
    SELECT
        md5(cast(coalesce(cast(opportunity_id as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as opportunity_key,
        d.date_day as date_key,
        a.account_key, 
        u.user_key ,  
        c.contact_key ,
        cam.campaign_key,
        o.stagename as stage_name,
        o.amount,
        o.probability,
        o.expectedrevenue as expected_revenue,
        o.name,
        o.leadsource as lead_source,
        o.isclosed as is_closed,
        o.iswon as is_won,
        o.lastmodifieddate as last_modified_date
    FROM opportunity_data o
    LEFT JOIN "dbt"."marts"."dim_account" a ON o.accountid = a.account_id
    LEFT JOIN "dbt"."marts"."dim_user" u ON o.ownerid = u.user_id
    LEFT JOIN "dbt"."marts"."dim_contact" c ON o.contactid = c.contact_id
    LEFT JOIN "dbt"."marts"."dim_campaign" cam ON o.campaignid = cam.campaign_id
    LEFT JOIN "dbt"."marts"."dim_date" d ON CAST(o.lastmodifieddate as DATE)=d.date_day
)

SELECT * FROM fact_opportunities