
        
            delete from "dbt"."marts"."dim_account"
            where (
                account_id) in (
                select (account_id)
                from "dim_account__dbt_tmp20241013105807410255"
            );

        
    

    insert into "dbt"."marts"."dim_account" ("account_key", "account_id", "parent_id", "owner_id", "account_number", "account_name", "account_type", "industry", "billing_street", "billing_city", "billingstate", "billing_postal_code", "billing_country", "created_date", "created_by_id", "last_modified_date", "last_modified_by_id", "system_modstamp")
    (
        select "account_key", "account_id", "parent_id", "owner_id", "account_number", "account_name", "account_type", "industry", "billing_street", "billing_city", "billingstate", "billing_postal_code", "billing_country", "created_date", "created_by_id", "last_modified_date", "last_modified_by_id", "system_modstamp"
        from "dim_account__dbt_tmp20241013105807410255"
    )
  