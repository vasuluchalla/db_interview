{{
    config(
        materialized = 'incremental',
        unique_key = 'contact_id'
    )
}}
with source as (
    select 
        *,
        ROW_NUMBER() OVER() contact_key
    from {{ ref('stg_salesforce__contact')}}
    {% if is_incremental() %}
    WHERE lastmodifieddate > (SELECT MAX(last_modified_date) FROM {{ this }})
{% endif %}
),

renamed as (
    select
    {{ dbt_utils.generate_surrogate_key(['contact_id']) }} as contact_key,
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
