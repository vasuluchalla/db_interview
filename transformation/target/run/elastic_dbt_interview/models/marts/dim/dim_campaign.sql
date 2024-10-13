
        
            delete from "dbt"."marts"."dim_campaign"
            where (
                campaign_id) in (
                select (campaign_id)
                from "dim_campaign__dbt_tmp20241013105956483478"
            );

        
    

    insert into "dbt"."marts"."dim_campaign" ("campaign_key", "campaign_id", "name", "type", "status", "description", "start_date", "end_date", "created_date", "created_by_id", "last_modified_date", "last_modified_by_id", "system_modstamp")
    (
        select "campaign_key", "campaign_id", "name", "type", "status", "description", "start_date", "end_date", "created_date", "created_by_id", "last_modified_date", "last_modified_by_id", "system_modstamp"
        from "dim_campaign__dbt_tmp20241013105956483478"
    )
  