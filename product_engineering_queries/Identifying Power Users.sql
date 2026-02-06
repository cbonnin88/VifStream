-- Segment out users into 4 quartiles based on their total 'Tune In' count. We want to target the top 25% (Power Users) with a loyalty reward

WITH user_engagement AS (
  SELECT
    user_id,
    COUNT(*) AS total_tunes
  FROM `vifstream_dataset.events`
  WHERE event_name = 'channel_tune_in'
  GROUP BY
    1
),
ranked_engagement AS (
  SELECT
    user_id,
    total_tunes,
    NTILE(4) OVER(ORDER BY total_tunes DESC) AS engagement_quartile
  FROM user_engagement
)
SELECT
  engagement_quartile,
  MIN(total_tunes) AS min_tunes,
  MAX(total_tunes) AS max_tunes,
  COUNT(user_id) AS user_count
FROM ranked_engagement
GROUP BY
  1
ORDER BY
  1;