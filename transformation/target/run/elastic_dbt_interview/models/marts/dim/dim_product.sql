
        
            delete from "dbt"."marts"."dim_product"
            where (
                product_id) in (
                select (product_id)
                from "dim_product__dbt_tmp20241013110240925884"
            );

        
    

    insert into "dbt"."marts"."dim_product" ("product_key", "product_id", "source_productid", "seller_id", "name", "product_code", "type", "product_class", "family", "quantity_unit_of_measure", "stock_keeping_unit", "created_date", "created_by_id", "last_modified_date", "last_modified_by_id", "system_modstamp")
    (
        select "product_key", "product_id", "source_productid", "seller_id", "name", "product_code", "type", "product_class", "family", "quantity_unit_of_measure", "stock_keeping_unit", "created_date", "created_by_id", "last_modified_date", "last_modified_by_id", "system_modstamp"
        from "dim_product__dbt_tmp20241013110240925884"
    )
  