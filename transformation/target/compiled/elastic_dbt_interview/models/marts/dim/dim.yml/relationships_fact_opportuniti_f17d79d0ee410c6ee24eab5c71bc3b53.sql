
    
    

with child as (
    select contact_key as from_field
    from "dbt"."marts"."fact_opportunities"
    where contact_key is not null
),

parent as (
    select contact_key as to_field
    from "dbt"."marts"."dim_contact"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


