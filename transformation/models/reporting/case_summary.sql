{{ config(materialized='view') }}

WITH base AS (
    SELECT
        case_key,
        date_key,
        account_key,
        user_key,
        contact_key,
        product_key,
        case_number,
        type,
        status,
        priority,
        isescalated,
        isclosed,
        closed_date,
        dwh_created_date,
        dwh_updated_date
    FROM {{ ref('fact_cases') }}
),

case_metrics AS (
    SELECT
        date_key,
        account_key,
        user_key,
        COUNT(*) AS total_cases,
        COUNT(CASE WHEN isclosed THEN 1 END) AS closed_cases,
        COUNT(CASE WHEN isescalated THEN 1 END) AS escalated_cases,
        COUNT(CASE WHEN priority = 'High' THEN 1 END) AS high_priority_cases,
        COUNT(CASE WHEN priority = 'Medium' THEN 1 END) AS medium_priority_cases,
        COUNT(CASE WHEN priority = 'Low' THEN 1 END) AS low_priority_cases
    FROM base
    GROUP BY
        date_key,
        account_key,
        user_key
)

SELECT * FROM case_metrics
