select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select lead_source
from "dbt"."marts"."fact_opportunities"
where lead_source is null



      
    ) dbt_internal_test