select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select last_modified_date
from "dbt"."marts"."fact_opportunities"
where last_modified_date is null



      
    ) dbt_internal_test