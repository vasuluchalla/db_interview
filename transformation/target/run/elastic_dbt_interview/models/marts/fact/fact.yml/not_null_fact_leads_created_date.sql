select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select created_date
from "dbt"."marts"."fact_leads"
where created_date is null



      
    ) dbt_internal_test