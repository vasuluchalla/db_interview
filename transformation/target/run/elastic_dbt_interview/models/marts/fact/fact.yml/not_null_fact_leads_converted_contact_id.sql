select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select converted_contact_id
from (select * from "dbt"."marts"."fact_leads" where isconverted = TRUE) dbt_subquery
where converted_contact_id is null



      
    ) dbt_internal_test