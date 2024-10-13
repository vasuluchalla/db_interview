
    
    



select converted_account_id
from (select * from "dbt"."marts"."fact_leads" where isconverted = TRUE) dbt_subquery
where converted_account_id is null


