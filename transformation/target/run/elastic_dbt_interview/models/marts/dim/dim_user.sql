
        
            delete from "dbt"."marts"."dim_user"
            where (
                user_id) in (
                select (user_id)
                from "dim_user__dbt_tmp20241013111500139327"
            );

        
    

    insert into "dbt"."marts"."dim_user" ("user_key", "user_id", "user_name", "first_name", "last_name", "email", "is_active", "user_role_id", "created_date", "created_by_id", "last_modified_date", "last_modified_by_id", "system_modstamp")
    (
        select "user_key", "user_id", "user_name", "first_name", "last_name", "email", "is_active", "user_role_id", "created_date", "created_by_id", "last_modified_date", "last_modified_by_id", "system_modstamp"
        from "dim_user__dbt_tmp20241013111500139327"
    )
  