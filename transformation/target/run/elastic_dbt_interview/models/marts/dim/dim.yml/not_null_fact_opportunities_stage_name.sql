select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select stage_name
from "dbt"."marts"."fact_opportunities"
where stage_name is null



      
    ) dbt_internal_test