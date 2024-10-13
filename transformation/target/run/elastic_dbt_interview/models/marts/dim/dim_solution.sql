
        
            delete from "dbt"."marts"."dim_solution"
            where (
                solution_id) in (
                select (solution_id)
                from "dim_solution__dbt_tmp20241013110307837863"
            );

        
    

    insert into "dbt"."marts"."dim_solution" ("solution_key", "solution_id", "case_id", "user_id", "solution_number", "solution_name", "status", "created_date", "created_by_id", "last_modified_date", "last_modified_by_id", "system_modstamp")
    (
        select "solution_key", "solution_id", "case_id", "user_id", "solution_number", "solution_name", "status", "created_date", "created_by_id", "last_modified_date", "last_modified_by_id", "system_modstamp"
        from "dim_solution__dbt_tmp20241013110307837863"
    )
  