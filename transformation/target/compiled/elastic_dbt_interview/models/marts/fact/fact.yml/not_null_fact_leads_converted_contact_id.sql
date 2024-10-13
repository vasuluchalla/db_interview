
    
    



select converted_contact_id
from (select * from "dbt"."marts"."fact_leads" where isconverted = TRUE) dbt_subquery
where converted_contact_id is null


