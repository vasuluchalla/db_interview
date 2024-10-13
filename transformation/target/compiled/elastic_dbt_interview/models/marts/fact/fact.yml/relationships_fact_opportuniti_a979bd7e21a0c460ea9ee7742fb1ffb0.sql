
    
    

with child as (
    select accountid as from_field
    from "dbt"."marts"."fact_opportunities"
    where accountid is not null
),

parent as (
    select account_id as to_field
    from "dbt"."marts"."dim_account"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


