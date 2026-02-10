CREATE OR REPLACE MODEL `poetic-maxim-486609-e5.vifstream_dbt.churn_propensity_model`
OPTIONS(
  model_type='LOGISTIC_REG',
  input_label_cols=['has_churned'],
  enable_global_explain=TRUE -- This will tell us WHICH features matter the most
) AS
SELECT * EXCEPT(user_id) FROM `poetic-maxim-486609-e5.vifstream_dbt.ml_churn_features`;