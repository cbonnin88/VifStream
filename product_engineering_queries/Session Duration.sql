-- How long does a user stay in the app?

WITH event_lags AS (
  SELECT
    user_id,
    timestamp,
    LEAD(timestamp) OVER(PARTITION BY user_id, DATE(timestamp) ORDER BY timestamp) AS next_event_time
  FROM `vifstream_dataset.events`
)
SELECT
  user_id,
  AVG(TIMESTAMP_DIFF(next_event_time,timestamp,MINUTE)) AS avg_minutes_between_actions
FROM event_lags
WHERE next_event_time IS NOT NULL AND TIMESTAMP_DIFF(next_event_time,timestamp,MINUTE) < 30
GROUP BY
  1
LIMIT 100;