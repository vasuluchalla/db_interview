{{ config(materialized='incremental', unique_key='opportunity_key') }}

WITH opportunity_data AS (
    SELECT
        *
    FROM {{ ref('stg_salesforce__opportunity') }}
    {% if is_incremental() %}
    WHERE lastmodifieddate > COALESCE((SELECT MAX(last_modified_date) FROM {{ this }}), '1970-01-01')
   
    {% endif %}
),

-- Join with dimension tables
fact_opportunities AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['opportunity_id']) }} as opportunity_key,
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
    LEFT JOIN {{ ref('dim_account') }} a ON o.accountid = a.account_id
    LEFT JOIN {{ ref('dim_user') }} u ON o.ownerid = u.user_id
    LEFT JOIN {{ ref('dim_contact') }} c ON o.contactid = c.contact_id
    LEFT JOIN {{ ref('dim_campaign') }} cam ON o.campaignid = cam.campaign_id
    LEFT JOIN {{ ref('dim_date') }} d ON CAST(o.lastmodifieddate as DATE)=d.date_day
)

SELECT * FROM fact_opportunities
