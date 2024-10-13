

WITH source AS (
    SELECT 
        *
    FROM "dbt"."staging"."stg_salesforce__account"
    
    --WHERE lastmodifieddate > (SELECT min(last_modified_date) FROM "dbt"."marts"."dim_account")
    WHERE 1=1

),

renamed AS (
    SELECT
        --nextval('account_sequence') as account_key,
        md5(cast(coalesce(cast(account_id as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as account_key,
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