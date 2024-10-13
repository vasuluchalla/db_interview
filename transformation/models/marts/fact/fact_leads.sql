{{ config(materialized='incremental', unique_key='lead_key') }}

WITH lead_data AS (
    SELECT *
    FROM {{ ref('stg_salesforce__lead') }} 
    {% if is_incremental() %}
    WHERE lastmodifieddate > COALESCE((SELECT MAX(last_modified_date) FROM {{ this }}), '1970-01-01')
   
{% endif %}
),

-- Join with dimension tables
fact_leads AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['lead_id']) }} as lead_key,
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
    LEFT JOIN {{ ref('dim_user') }} u ON ld.ownerid = u.user_id
    LEFT JOIN {{ ref('dim_account') }} a ON ld.convertedaccountid = a.account_id
    LEFT JOIN {{ ref('dim_contact') }} c ON ld.convertedcontactid = c.contact_id
    LEFT JOIN {{ ref('dim_date') }} d ON CAST(ld.lastmodifieddate as DATE)=d.date_day
)

SELECT * FROM fact_leads

