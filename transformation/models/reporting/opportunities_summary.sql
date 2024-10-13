{{ config(materialized='view') }}

WITH base AS (
    SELECT
        *
    FROM {{ ref('fact_opportunities') }}
),

opportunity_metrics AS (
    SELECT
        date_key,
        account_key,
        user_key,
        contact_key,
        campaign_key,
        COUNT(*) AS total_opportunities,  
        SUM(CASE WHEN is_won THEN 1 ELSE 0 END) AS won_opportunities,  
        SUM(CASE WHEN is_won THEN 1 ELSE 0 END) * 100.0 / NULLIF(COUNT(*), 0) AS win_rate,  
        SUM(amount) AS total_amount,  
        SUM(CASE WHEN is_won THEN amount ELSE 0 END) AS won_amount,  
        AVG(probability) AS avg_probability,  
        SUM(expected_revenue) AS total_expected_revenue  
    FROM base
    GROUP BY
        date_key,
        account_key,
        user_key,
        contact_key,
        campaign_key
)

SELECT * FROM opportunity_metrics
