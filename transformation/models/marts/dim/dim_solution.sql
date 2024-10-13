{{
    config(
        materialized = 'incremental',
        unique_key = 'solution_id'
    )
}}

with source as (
    select 
        *
    from {{ ref('stg_salesforce__solution')}}
    {% if is_incremental() %}
    WHERE lastmodifieddate > (SELECT MAX(last_modified_date) FROM {{ this }})
    
{% endif %}
),

renamed as (
    select
    {{ dbt_utils.generate_surrogate_key(['solution_id']) }} as solution_key,
    solution_id,
    caseid as case_id,
    ownerid as user_id,
    solutionnumber as solution_number,
    solutionname as solution_name,
    status,
    createddate as created_date,
    createdbyid as created_by_id,
    lastmodifieddate as last_modified_date,
    lastmodifiedbyid as last_modified_by_id,
    systemmodstamp as system_modstamp 
    from source 
)
select * from renamed
