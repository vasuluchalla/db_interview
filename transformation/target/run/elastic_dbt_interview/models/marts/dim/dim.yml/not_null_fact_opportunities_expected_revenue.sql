select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select expected_revenue
from "dbt"."marts"."fact_opportunities"
where expected_revenue is null



      
    ) dbt_internal_test