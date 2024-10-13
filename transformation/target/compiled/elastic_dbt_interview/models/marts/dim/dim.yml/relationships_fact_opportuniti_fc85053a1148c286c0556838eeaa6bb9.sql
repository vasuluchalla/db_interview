
    
    

with child as (
    select account_key as from_field
    from "dbt"."marts"."fact_opportunities"
    where account_key is not null
),

parent as (
    select account_key as to_field
    from "dbt"."marts"."dim_account"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


