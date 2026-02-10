CREATE OR REPLACE TABLE `poetic-maxim-486609-e5.vifstream_dbt.ml_churn_features` AS
SELECT
  u.user_id,
  u.device,
  u.plan_type,
  COUNT(e.event_id) AS total_events,
  COUNTIF(e.event_name = 'channel_tune_in') AS watch_events,
  COUNTIF(e.event_name = 'paywall_view') AS friction_events,
  -- LABEL: Churn = No activity in the last 15 days
  CASE WHEN MAX(e.event_at) < TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 15 DAY) THEN 1 ELSE 0 END AS has_churned
FROM `poetic-maxim-486609-e5.vifstream_dbt.fct_user_retention` AS e
JOIN `poetic-maxim-486609-e5.vifstream_dataset.users` AS u
  ON e.user_id = u.user_id
GROUP BY
  1,2,3;
