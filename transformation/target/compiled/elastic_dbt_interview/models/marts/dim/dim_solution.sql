

with source as (
    select 
        *
    from "dbt"."staging"."stg_salesforce__solution"
    
    --WHERE lastmodifieddate > (SELECT MAX(last_modified_date) FROM "dbt"."marts"."dim_solution")
    where 1=1
    

),

renamed as (
    select
    md5(cast(coalesce(cast(solution_id as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as solution_key,
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