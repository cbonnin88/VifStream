SELECT
  -- Core Amplitude Fields
  user_id,
  event_name AS event_type,
  UNIX_MILLIS(event_at) AS amp_time,
  -- Event Properties
  days_since_signup,
  event_name,
  -- user Properties
  plan_type,
  device,
  region,
  signup_date
FROM `vifstream_dbt.fct_user_retention`
LIMIT 10000;