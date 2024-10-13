
    
    

with all_values as (

    select
        isclosed as value_field,
        count(*) as n_records

    from "dbt"."marts"."fact_opportunities"
    group by isclosed

)

select *
from all_values
where value_field not in (
    'TRUE','FALSE'
)


