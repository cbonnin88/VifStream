WITH daily_activity AS (
  -- Identify unique days of activity per user in the last 7 days
  SELECT
    user_id,
    COUNT(DISTINCT DATE(event_at)) AS days_active
  FROM `poetic-maxim-486609-e5.vifstream_dbt.fct_user_retention`
  WHERE event_at >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 7 DAY)
  GROUP BY
    1
),
l_distribution AS (
  -- Count how many users fall into each 'L' category (L1,L2...L7)
  SELECT
    days_active,
    COUNT(user_id) AS user_count
  FROM daily_activity
  GROUP BY
    1
)
SELECT
  days_active,
  user_count,
  ROUND(user_count / SUM(user_count) OVER()*100,2) AS pct_of_base
FROM l_distribution
ORDER BY
  days_active DESC;