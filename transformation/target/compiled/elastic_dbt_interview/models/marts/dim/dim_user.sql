



with source as (
    select 
        *,
        ROW_NUMBER() OVER() user_key  -- sequence number for
    from "dbt"."staging"."stg_salesforce__user"
    
    --WHERE lastmodifieddate > (SELECT MAX(last_modified_date) FROM "dbt"."marts"."dim_user")
    where 1=1
    

),

renamed as (
    select
    md5(cast(coalesce(cast(user_id as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as user_key,
    user_id,
    username as user_name,
    firstname as first_name,
    lastname as last_name,
    email,
    isactive as is_active,
    userroleid as user_role_id,
    createddate as created_date,
    createdbyid as created_by_id,
    lastmodifieddate as last_modified_date,
    lastmodifiedbyid as last_modified_by_id,
    systemmodstamp as system_modstamp 
    from source 
)

select * from renamed