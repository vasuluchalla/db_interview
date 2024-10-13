select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select status
from "dbt"."marts"."fact_leads"
where status is null



      
    ) dbt_internal_test