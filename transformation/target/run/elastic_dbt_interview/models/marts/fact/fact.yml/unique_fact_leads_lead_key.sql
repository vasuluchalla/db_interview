select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    lead_key as unique_field,
    count(*) as n_records

from "dbt"."marts"."fact_leads"
where lead_key is not null
group by lead_key
having count(*) > 1



      
    ) dbt_internal_test