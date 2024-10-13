

with source as (
    select 
        *
    from "dbt"."staging"."stg_salesforce__campaign"
    
    --WHERE lastmodifieddate > (SELECT MAX(last_modified_date) FROM "dbt"."marts"."dim_campaign")
    WHERE 1=1
    

),

renamed as (
    select
        md5(cast(coalesce(cast(campaign_id as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as campaign_key,
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