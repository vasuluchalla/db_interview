
    
    

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
    '0','1'
)


