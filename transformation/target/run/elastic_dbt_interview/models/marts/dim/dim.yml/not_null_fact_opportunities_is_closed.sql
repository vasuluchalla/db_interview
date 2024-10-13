select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select is_closed
from "dbt"."marts"."fact_opportunities"
where is_closed is null



      
    ) dbt_internal_test