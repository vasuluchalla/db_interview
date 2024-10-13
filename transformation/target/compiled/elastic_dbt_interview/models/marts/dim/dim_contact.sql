
with source as (
    select 
        *,
        ROW_NUMBER() OVER() contact_key
    from "dbt"."staging"."stg_salesforce__contact"
    
    --WHERE lastmodifieddate > (SELECT MAX(last_modified_date) FROM "dbt"."marts"."dim_contact")
    WHERE 1=1
    
    

),

renamed as (
    select
    md5(cast(coalesce(cast(contact_id as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as contact_key,
    contact_id as contact_id,
    accountid as account_id,
    firstname as first_name,
    lastname as last_name,
    email,
    phone,
    title,
    createddate as created_date,
    createdbyid as created_by_id,
    lastmodifieddate as last_modified_date,
    lastmodifiedbyid as last_modified_by_id,
    systemmodstamp as system_modstamp 
    from source 
)
select * from renamed