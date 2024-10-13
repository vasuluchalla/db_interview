
{{
    config(
        materialized = 'incremental',
        unique_key = 'user_id',
    )
}}



with source as (
    select 
        *,
        ROW_NUMBER() OVER() user_key  -- sequence number for
    from {{ ref('stg_salesforce__user')}}
    {% if is_incremental() %}
    WHERE lastmodifieddate > (SELECT MAX(last_modified_date) FROM {{ this }})
    
    
{% endif %}
),

renamed as (
    select
    {{ dbt_utils.generate_surrogate_key(['user_id']) }} as user_key,
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
