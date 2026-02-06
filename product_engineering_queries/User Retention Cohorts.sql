-- For users who joined in a specific month, what percentage are still active 1 month later ?

WITH user_cohorts AS (
  SELECT
    user_id,
    DATE_TRUNC(signup_date,MONTH) AS cohort_month
  FROM `vifstream_dataset.users`
),
active_months AS (
  SELECT DISTINCT
    user_id,
    DATE_TRUNC(DATE(timestamp),MONTH) AS activity_month
  FROM `vifstream_dataset.events`
)
SELECT
  c.cohort_month,
  DATE_DIFF(a.activity_month,c.cohort_month,MONTH) AS month_number,
  COUNT(DISTINCT a.user_id) AS active_users
FROM user_cohorts AS c
JOIN active_months AS a
  ON c.user_id = a.user_id
WHERE DATE_DIFF(a.activity_month, c.cohort_month,MONTH) >=0
GROUP BY
  1,2
ORDER BY
  1,2;