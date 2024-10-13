
        
            delete from "dbt"."marts"."dim_contact"
            where (
                contact_id) in (
                select (contact_id)
                from "dim_contact__dbt_tmp20241013110023726924"
            );

        
    

    insert into "dbt"."marts"."dim_contact" ("contact_key", "contact_id", "account_id", "first_name", "last_name", "email", "phone", "title", "created_date", "created_by_id", "last_modified_date", "last_modified_by_id", "system_modstamp")
    (
        select "contact_key", "contact_id", "account_id", "first_name", "last_name", "email", "phone", "title", "created_date", "created_by_id", "last_modified_date", "last_modified_by_id", "system_modstamp"
        from "dim_contact__dbt_tmp20241013110023726924"
    )
  