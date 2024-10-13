
        
            delete from "dbt"."marts"."fact_cases"
            where (
                case_key) in (
                select (case_key)
                from "fact_cases__dbt_tmp20241013162816331523"
            );

        
    

    insert into "dbt"."marts"."fact_cases" ("case_key", "date_key", "account_key", "user_key", "contact_key", "product_key", "case_number", "type", "status", "priority", "isescalated", "isclosed", "closed_date", "last_modified_date", "dwh_created_date", "dwh_updated_date")
    (
        select "case_key", "date_key", "account_key", "user_key", "contact_key", "product_key", "case_number", "type", "status", "priority", "isescalated", "isclosed", "closed_date", "last_modified_date", "dwh_created_date", "dwh_updated_date"
        from "fact_cases__dbt_tmp20241013162816331523"
    )
  