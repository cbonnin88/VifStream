-- Which device type generates the most revenue for VifStream ?
SELECT
  u.device,
  COUNT(DISTINCT s.user_id) AS paying_users,
  ROUND(SUM(s.amount),2) AS total_revenue,
  ROUND(AVG(s.amount),2) AS average_transaction_value  
FROM `poetic-maxim-486609-e5.vifstream_dataset.subscriptions` AS s
JOIN `vifstream_dataset.users` AS u
  ON s.user_id = u.user_id
WHERE s.status = 'completed'
GROUP BY 
  1
ORDER BY
  total_revenue DESC;