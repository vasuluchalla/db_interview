select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select contact_id
from "dbt"."marts"."dim_contact"
where contact_id is null



      
    ) dbt_internal_test