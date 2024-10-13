
        
            delete from "dbt"."marts"."fact_leads"
            where (
                lead_key) in (
                select (lead_key)
                from "fact_leads__dbt_tmp20241013163728732637"
            );

        
    

    insert into "dbt"."marts"."fact_leads" ("lead_key", "date_key", "user_key", "account_key", "contact_key", "created_date", "converted_date", "status", "lead_source", "industry", "is_converted", "last_modified_date")
    (
        select "lead_key", "date_key", "user_key", "account_key", "contact_key", "created_date", "converted_date", "status", "lead_source", "industry", "is_converted", "last_modified_date"
        from "fact_leads__dbt_tmp20241013163728732637"
    )
  