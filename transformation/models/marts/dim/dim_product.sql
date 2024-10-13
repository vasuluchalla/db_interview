{{
    config(
        materialized = 'incremental',
        unique_key = 'product_id'  
    )
}}

-- Extract data from product_2 table
with product_data AS (
    SELECT
        *
    FROM {{ ref('stg_salesforce__product_2')}} 
    {% if is_incremental() %}
        -- Same incremental filter for the product data
       -- WHERE lastmodifieddate > (SELECT COALESCE(MAX(last_modified_date), '1970-01-01') FROM {{ this }})
       where 1=1
    {% endif %}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['product_id']) }} as product_key,
    p.product_id,
    p.sourceproductid AS source_productid, 
    p.sellerid AS seller_id,
    p.name,
    p.productcode AS product_code,
    p.type,
    p.productclass AS product_class,
    p.family,
    p.quantityunitofmeasure AS quantity_unit_of_measure,
    p.stockkeepingunit AS stock_keeping_unit,
    p.createddate AS created_date,
    p.createdbyid AS created_by_id,
    p.lastmodifieddate AS last_modified_date,
    p.lastmodifiedbyid AS last_modified_by_id,
    p.systemmodstamp AS system_modstamp 
FROM product_data p
