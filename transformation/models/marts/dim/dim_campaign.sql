{{
    config(
        materialized = 'incremental',
        unique_key = 'campaign_id'
    )
}}

with source as (
    select 
        *
    from {{ ref('stg_salesforce__campaign')}}
    {% if is_incremental() %}
    WHERE lastmodifieddate > (SELECT MAX(last_modified_date) FROM {{ this }})
    
    
{% endif %}
),

renamed as (
    select
        {{ dbt_utils.generate_surrogate_key(['campaign_id']) }} as campaign_key,
        campaign_id,
        name ,
        type,
        status,
        description,
        startdate as start_date,
        enddate as end_date,
        createddate as created_date,
        createdbyid as created_by_id,
        lastmodifieddate as last_modified_date,
        lastmodifiedbyid as last_modified_by_id,
        systemmodstamp as system_modstamp 
    from source 
)

select * from renamed

