
        
            delete from "dbt"."marts"."fact_opportunities"
            where (
                opportunity_key) in (
                select (opportunity_key)
                from "fact_opportunities__dbt_tmp20241013123740932690"
            );

        
    

    insert into "dbt"."marts"."fact_opportunities" ("opportunity_key", "date_key", "account_key", "user_key", "contact_key", "campaign_key", "stage_name", "amount", "probability", "expected_revenue", "name", "lead_source", "is_closed", "is_won", "last_modified_date")
    (
        select "opportunity_key", "date_key", "account_key", "user_key", "contact_key", "campaign_key", "stage_name", "amount", "probability", "expected_revenue", "name", "lead_source", "is_closed", "is_won", "last_modified_date"
        from "fact_opportunities__dbt_tmp20241013123740932690"
    )
  