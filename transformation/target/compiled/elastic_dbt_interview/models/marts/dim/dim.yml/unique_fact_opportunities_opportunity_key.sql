
    
    

select
    opportunity_key as unique_field,
    count(*) as n_records

from "dbt"."marts"."fact_opportunities"
where opportunity_key is not null
group by opportunity_key
having count(*) > 1


