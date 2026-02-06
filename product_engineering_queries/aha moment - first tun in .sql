WITH first_interaction AS (
  SELECT
    user_id,
    MIN(timestamp) AS first_login
  FROM `poetic-maxim-486609-e5.vifstream_dataset.events`
  GROUP BY 1
),

-- Window Function to rank events per user
ranked_events AS (
  SELECT
    e.user_id,
    e.event_name,
    e.timestamp,
    fi.first_login,
    TIMESTAMP_DIFF(e.timestamp,fi.first_login,HOUR) AS hours_since_signup,
    ROW_NUMBER() OVER(PARTITION BY e.user_id ORDER BY e.timestamp ASC) AS event_seq
  FROM `poetic-maxim-486609-e5.vifstream_dataset.events` AS e
  JOIN first_interaction AS fi
    ON e.user_id = fi.user_id
)

-- Complex Aggregation: Percentage of users who 'Tune In' within 24h
SELECT
  event_name,
  COUNT(DISTINCT user_id) AS unique_users,
  ROUND(COUNT(DISTINCT user_id) / (SELECT COUNT(DISTINCT user_id) FROM first_interaction)* 100,2) AS pct_of_total
FROM ranked_events
WHERE hours_since_signup <= 24 AND event_name = 'channel_tune_in'
GROUP BY 1;