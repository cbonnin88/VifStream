SELECT
  *
FROM
  ML.EXPLAIN_PREDICT(MODEL `poetic-maxim-486609-e5.vifstream_dbt.churn_propensity_model`,
    (SELECT * FROM `poetic-maxim-486609-e5.vifstream_dbt.ml_churn_features` LIMIT 10),
    STRUCT(3 AS top_k_features))