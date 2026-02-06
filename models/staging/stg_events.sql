-- model/staging/stg_events.sql
WITH raw_events AS (
    SELECT * FROM {{source('vifstream_dataset','events')}}
)
SELECT
    event_id,
    user_id,
    event_name,
    -- Convert string to proper timestamp
    CAST(timestamp AS TIMESTAMP) AS event_at,
    session_id,
    -- Identify the platform for easier filtering later
    CASE
        WHEN event_name = 'channel_tune_in' THEN 'Engagement'
        WHEN event_name = 'paywall_view' THEN 'Conversion'
        ELSE 'Utility'
    END AS event_category
FROM raw_events