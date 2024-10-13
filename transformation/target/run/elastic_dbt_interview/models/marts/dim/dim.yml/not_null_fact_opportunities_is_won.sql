select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select is_won
from "dbt"."marts"."fact_opportunities"
where is_won is null



      
    ) dbt_internal_test