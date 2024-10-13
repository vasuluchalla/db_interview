select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

with all_values as (

    select
        isconverted as value_field,
        count(*) as n_records

    from "dbt"."marts"."fact_leads"
    group by isconverted

)

select *
from all_values
where value_field not in (
    'TRUE','FALSE'
)



      
    ) dbt_internal_test