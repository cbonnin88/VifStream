WITH user_first_day AS (
  SELECT
    user_id,
    COUNT(DISTINCT event_id) AS channels_watched
  FROM `poetic-maxim-486609-e5.vifstream_dbt.fct_user_retention`
  WHERE days_since_signup = 0 AND event_name = 'channel_tune_in'
  GROUP BY
    1
),
retention_data AS (
  SELECT
    u.user_id,
    u.channels_watched,
    MAX(CASE WHEN e.days_since_signup >= 7 THEN 1 ELSE 0 END) AS retained_d7
  FROM user_first_day AS u
  LEFT JOIN `poetic-maxim-486609-e5.vifstream_dbt.fct_user_retention` AS e
    ON u.user_id = e.user_id
  GROUP BY
    1,2
)
SELECT
  channels_watched,
  COUNT(user_id) AS user_count,
  ROUND(AVG(retained_d7)* 100,2) AS d7_retention_rate
FROM retention_data
GROUP BY
  1
HAVING user_count > 100
ORDER BY
  1 ASC;