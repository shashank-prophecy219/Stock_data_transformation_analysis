{{
  config({    
    "materialized": "ephemeral",
    "database": "sony",
    "schema": "orch_test"
  })
}}

WITH nvda_q3_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'nvda_daily_data') }}

),

nvda_q3_ticker AS (

  SELECT 
    'NVDA' AS ticker,
    Date,
    Close
  
  FROM nvda_q3_source

),

akam_q3_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'akam_daily_data') }}

),

wbd_q3_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'wbd_daily_data') }}

),

lumn_q3_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'lumn_daily_data') }}

),

lumn_q3_ticker AS (

  SELECT 
    'LUMN' AS ticker,
    Date,
    Close
  
  FROM lumn_q3_source

),

intc_q3_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'intc_daily_data') }}

),

intc_q3_ticker AS (

  SELECT 
    'INTC' AS ticker,
    Date,
    Close
  
  FROM intc_q3_source

),

crm_q3_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'crm_daily_data') }}

),

crm_q3_ticker AS (

  SELECT 
    'CRM' AS ticker,
    Date,
    Close
  
  FROM crm_q3_source

),

sony_q3_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'sony_daily_data') }}

),

sony_q3_ticker AS (

  SELECT 
    'SONY' AS ticker,
    Date,
    Close
  
  FROM sony_q3_source

),

wbd_q3_ticker AS (

  SELECT 
    'WBD' AS ticker,
    Date,
    Close
  
  FROM wbd_q3_source

),

ma_q3_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'ma_daily_data') }}

),

ma_q3_ticker AS (

  SELECT 
    'MA' AS ticker,
    Date,
    Close
  
  FROM ma_q3_source

),

ups_q3_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'ups_daily_data') }}

),

ups_q3_ticker AS (

  SELECT 
    'UPS' AS ticker,
    Date,
    Close
  
  FROM ups_q3_source

),

amzn_q3_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'amzn_daily_data') }}

),

amzn_q3_ticker AS (

  SELECT 
    'AMZN' AS ticker,
    Date,
    Close
  
  FROM amzn_q3_source

),

akam_q3_ticker AS (

  SELECT 
    'AKAM' AS ticker,
    Date,
    Close
  
  FROM akam_q3_source

),

nflx_q3_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'nflx_daily_data') }}

),

nflx_q3_ticker AS (

  SELECT 
    'NFLX' AS ticker,
    Date,
    Close
  
  FROM nflx_q3_source

),

fdx_q3_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'fdx_daily_data') }}

),

fdx_q3_ticker AS (

  SELECT 
    'FDX' AS ticker,
    Date,
    Close
  
  FROM fdx_q3_source

),

v_q3_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'v_daily_data') }}

),

v_q3_ticker AS (

  SELECT 
    'V' AS ticker,
    Date,
    Close
  
  FROM v_q3_source

),

para_q3_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'para_daily_data') }}

),

para_q3_ticker AS (

  SELECT 
    'PARA' AS ticker,
    Date,
    Close
  
  FROM para_q3_source

),

q3_combined AS (

  SELECT * 
  
  FROM akam_q3_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM amzn_q3_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM crm_q3_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM fdx_q3_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM intc_q3_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM lumn_q3_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM ma_q3_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM nflx_q3_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM nvda_q3_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM para_q3_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM sony_q3_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM ups_q3_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM v_q3_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM wbd_q3_ticker

),

q3_filtered AS (

  SELECT * 
  
  FROM q3_combined
  
  WHERE Date >= '2008-03-19'

),

q3_with_prev_close AS (

  SELECT 
    ticker,
    Date,
    Close,
    LAG(Close) OVER (PARTITION BY ticker ORDER BY Date) AS prev_close
  
  FROM q3_filtered

),

q3_daily_change AS (

  SELECT 
    ticker,
    Date,
    Close,
    prev_close,
    ROUND(((Close - prev_close) / prev_close) * 100, 4) AS daily_pct_change
  
  FROM q3_with_prev_close

),

q3_valid_changes AS (

  SELECT * 
  
  FROM q3_daily_change
  
  WHERE prev_close IS NOT NULL

),

q3_with_year_month AS (

  SELECT 
    ticker,
    Date,
    daily_pct_change,
    YEAR(Date) AS trade_year,
    MONTH(Date) AS trade_month,
    DATE_FORMAT(Date, 'yyyy-MM') AS year_month
  
  FROM q3_valid_changes

),

q3_monthly_avg AS (

  SELECT 
    ticker,
    year_month,
    trade_year,
    trade_month,
    COUNT(*) AS trading_days,
    ROUND(AVG(daily_pct_change), 4) AS avg_daily_pct_change,
    ROUND(SUM(daily_pct_change), 2) AS total_monthly_change
  
  FROM q3_with_year_month
  
  GROUP BY 
    ticker, year_month, trade_year, trade_month

),

q3_final AS (

  SELECT 
    ticker,
    year_month,
    trade_year,
    trade_month,
    trading_days,
    avg_daily_pct_change,
    total_monthly_change,
    CASE
      WHEN avg_daily_pct_change > 0
        THEN 'Gain'
      WHEN avg_daily_pct_change < 0
        THEN 'Loss'
      ELSE 'Flat'
    END AS month_trend
  
  FROM q3_monthly_avg

)

SELECT *

FROM q3_final
