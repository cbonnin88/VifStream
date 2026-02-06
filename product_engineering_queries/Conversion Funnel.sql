-- What is the drop-off rate between oopening the app and actually tuning into a channel ? 

SELECT
  COUNT(DISTINCT CASE WHEN event_name = 'app_open' THEN user_id END) AS app_opens,
  COUNT(DISTINCT CASE WHEN event_name = 'paywall_view' THEN user_id END) AS paywall_view,
  COUNT(DISTINCT CASE WHEN event_name = 'channel_tune_in' THEN user_id END) AS tunes_in,
  -- Calculate Conversion Rate
  SAFE_DIVIDE(
    COUNT(DISTINCT CASE WHEN event_name= 'channel_tune_in' THEN user_id END),
    COUNT(DISTINCT CASE WHEN event_name = 'app_opne' THEN user_id END)
  ) * 100 AS app_to_tune_conversion
FROM `vifstream_dataset.events`;