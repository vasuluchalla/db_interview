select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select amount
from "dbt"."marts"."fact_opportunities"
where amount is null



      
    ) dbt_internal_test