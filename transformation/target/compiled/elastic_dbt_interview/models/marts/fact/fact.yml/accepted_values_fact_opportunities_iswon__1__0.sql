
    
    

with all_values as (

    select
        iswon as value_field,
        count(*) as n_records

    from "dbt"."marts"."fact_opportunities"
    group by iswon

)

select *
from all_values
where value_field not in (
    '1','0'
)


