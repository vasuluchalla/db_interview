{{
    config(
        materialized = 'incremental',
        unique_key = 'account_id'
    )
}}

WITH source AS (
    SELECT 
        *
    FROM {{ ref('stg_salesforce__account') }}
    {% if is_incremental() %}
    WHERE lastmodifieddate > (SELECT min(last_modified_date) FROM {{ this }})
{% endif %}
),

renamed AS (
    SELECT
        --nextval('account_sequence') as account_key,
        {{ dbt_utils.generate_surrogate_key(['account_id']) }} as account_key,
        account_id,
        parentid as parent_id,
        ownerid as owner_id,
        accountnumber as account_number,
        name as account_name,
        type as account_type,
        industry,
        billingstreet as billing_street,
        billingcity as billing_city,
        billingstate as billingstate,
        billingpostalcode as billing_postal_code,
        billingcountry as billing_country,
        createddate as created_date,
        createdbyid as created_by_id,
        lastmodifieddate as last_modified_date,
        lastmodifiedbyid as last_modified_by_id,
        systemmodstamp as system_modstamp 

    FROM source 
)

SELECT 
    *
FROM renamed