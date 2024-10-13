
    
    

with child as (
    select converted_contact_id as from_field
    from "dbt"."marts"."fact_leads"
    where converted_contact_id is not null
),

parent as (
    select contact_id as to_field
    from "dbt"."marts"."dim_contact"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


