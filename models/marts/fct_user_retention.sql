-- models/marts/fct_user_retention.sql

WITH events AS (
    SELECT * FROM {{ref('stg_events')}}
),

users AS (
    SELECT
        user_id,
        signup_date,
        plan_type,
        device
    FROM {{source('vifstream_dataset','users')}}
)
SELECT  
    e.event_id,
    e.user_id,
    e.event_name,
    e.event_at,
    u.plan_type,
    u.device,
    -- Strategic Produc Metric: How many days after joining did this happen
    DATE_DIFF(DATE(e.event_at),DATE(u.signup_date),DAY) AS days_since_signup
FROM events AS e
LEFT JOIN users AS u 
    ON e.user_id = u.user_id