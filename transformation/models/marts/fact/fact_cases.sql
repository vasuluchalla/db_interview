{{ config(materialized='incremental', unique_key='case_key') }}

WITH case_data AS (
    SELECT
        *
    FROM {{ ref('stg_salesforce__case') }} 
    
    {% if is_incremental() %}
    WHERE lastmodifieddate > COALESCE((SELECT MAX(last_modified_date) FROM {{ this }}), '1970-01-01')
    {% endif %}
),

-- Join with dimension tables
fact_case AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['case_id']) }} as case_key, 
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
    LEFT JOIN {{ ref('dim_account') }} a ON c.accountid = a.account_id
    LEFT JOIN {{ ref('dim_user') }}  u ON c.ownerid = u.user_id
    LEFT JOIN {{ ref('dim_contact') }} co ON c.contactid = co.contact_id
    LEFT JOIN {{ ref('dim_product') }} p ON c.productid = p.product_id
    LEFT JOIN {{ ref('dim_date') }} d ON CAST(c.lastmodifieddate as DATE)=d.date_day
)

SELECT * FROM fact_case
