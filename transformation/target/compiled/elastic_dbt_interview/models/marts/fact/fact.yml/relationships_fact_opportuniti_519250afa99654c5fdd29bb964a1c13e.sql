
    
    

with child as (
    select isclosed as from_field
    from (select * from "dbt"."marts"."fact_opportunities" where iswon = TRUE) dbt_subquery
    where isclosed is not null
),

parent as (
    select isclosed as to_field
    from "dbt"."marts"."fact_opportunities"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


