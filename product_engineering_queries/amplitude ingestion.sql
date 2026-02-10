SELECT
  user_id,
  event_name AS event_type,
  -- Amplitude needs timestamps in milliseconds or ISO format
  UNIX_MILLIS(event_at) AS amp_time_stamps,
  -- Add user properties to help with segmentation in Amplitude
  CAST(user_id AS STRING) AS insert_id,
  STRUCT(
    plan_type,
    device,
    region
  ) AS user_properties
FROM `poetic-maxim-486609-e5.vifstream_dbt.fct_user_retention` 
LIMIT 5000 -- Amplitude Free Tier has monthly limits