select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select owner_user_id
from "dbt"."marts"."fact_leads"
where owner_user_id is null



      
    ) dbt_internal_test