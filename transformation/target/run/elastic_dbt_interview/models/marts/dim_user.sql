
  
    
    

    create  table
      "dbt"."marts"."dim_user__dbt_tmp"
  
    as (
      

with source as (
    select 
        *
    from "dbt"."staging"."stg_salesforce__user"
),

renamed as (
    select
    MD5(TRIM(COALESCE(user_id,'00000000000000000000000000000000')) ) AS user_key,
    user_id as user_id,
     username,
    firstname,
    lastname,
    companyname,
    division,
    department,
    createddate,
    createdbyid,
    lastmodifieddate,
    lastmodifiedbyid,
    systemmodstamp,
    numberoffailedlogins,
    --METRIC    
    NUMBEROFFAILEDLOGINS 
    from source 
)

select * from renamed
    );
  
  