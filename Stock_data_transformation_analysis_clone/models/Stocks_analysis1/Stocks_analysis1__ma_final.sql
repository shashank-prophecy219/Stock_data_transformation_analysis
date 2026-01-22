{{
  config({    
    "materialized": "ephemeral",
    "database": "sony",
    "schema": "orch_test"
  })
}}

WITH akam_ma_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'akam_daily_data') }}

),

intc_ma_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'intc_daily_data') }}

),

intc_ma_ticker AS (

  SELECT 
    'INTC' AS ticker,
    Date,
    Close
  
  FROM intc_ma_source

),

crm_ma_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'crm_daily_data') }}

),

crm_ma_ticker AS (

  SELECT 
    'CRM' AS ticker,
    Date,
    Close
  
  FROM crm_ma_source

),

amzn_ma_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'amzn_daily_data') }}

),

amzn_ma_ticker AS (

  SELECT 
    'AMZN' AS ticker,
    Date,
    Close
  
  FROM amzn_ma_source

),

nflx_ma_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'nflx_daily_data') }}

),

nflx_ma_ticker AS (

  SELECT 
    'NFLX' AS ticker,
    Date,
    Close
  
  FROM nflx_ma_source

),

ma_ma_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'ma_daily_data') }}

),

ma_ma_ticker AS (

  SELECT 
    'MA' AS ticker,
    Date,
    Close
  
  FROM ma_ma_source

),

lumn_ma_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'lumn_daily_data') }}

),

lumn_ma_ticker AS (

  SELECT 
    'LUMN' AS ticker,
    Date,
    Close
  
  FROM lumn_ma_source

),

fdx_ma_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'fdx_daily_data') }}

),

fdx_ma_ticker AS (

  SELECT 
    'FDX' AS ticker,
    Date,
    Close
  
  FROM fdx_ma_source

),

wbd_ma_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'wbd_daily_data') }}

),

wbd_ma_ticker AS (

  SELECT 
    'WBD' AS ticker,
    Date,
    Close
  
  FROM wbd_ma_source

),

ups_ma_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'ups_daily_data') }}

),

ups_ma_ticker AS (

  SELECT 
    'UPS' AS ticker,
    Date,
    Close
  
  FROM ups_ma_source

),

akam_ma_ticker AS (

  SELECT 
    'AKAM' AS ticker,
    Date,
    Close
  
  FROM akam_ma_source

),

v_ma_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'v_daily_data') }}

),

v_ma_ticker AS (

  SELECT 
    'V' AS ticker,
    Date,
    Close
  
  FROM v_ma_source

),

sony_ma_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'sony_daily_data') }}

),

sony_ma_ticker AS (

  SELECT 
    'SONY' AS ticker,
    Date,
    Close
  
  FROM sony_ma_source

),

nvda_ma_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'nvda_daily_data') }}

),

nvda_ma_ticker AS (

  SELECT 
    'NVDA' AS ticker,
    Date,
    Close
  
  FROM nvda_ma_source

),

para_ma_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'para_daily_data') }}

),

para_ma_ticker AS (

  SELECT 
    'PARA' AS ticker,
    Date,
    Close
  
  FROM para_ma_source

),

ma_combined AS (

  SELECT * 
  
  FROM akam_ma_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM amzn_ma_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM crm_ma_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM fdx_ma_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM intc_ma_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM lumn_ma_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM ma_ma_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM nflx_ma_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM nvda_ma_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM para_ma_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM sony_ma_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM ups_ma_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM v_ma_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM wbd_ma_ticker

),

ma_filtered AS (

  SELECT * 
  
  FROM ma_combined
  
  WHERE Date >= '2008-03-19'

),

ma_calculated AS (

  SELECT
          ticker,
          Date,
          ROUND(Close, 2) AS close_price,
          ROUND(AVG(Close) OVER (
            PARTITION BY ticker
            ORDER BY Date
            ROWS BETWEEN 199 PRECEDING AND CURRENT ROW
          ), 2) AS ma_200,
          COUNT(*) OVER (
            PARTITION BY ticker
            ORDER BY Date
            ROWS BETWEEN 199 PRECEDING AND CURRENT ROW
          ) AS days_in_window
        FROM ma_filtered

),

ma_valid AS (

  SELECT * 
  
  FROM ma_calculated
  
  WHERE days_in_window = 200

),

ma_final AS (

  SELECT 
    ticker,
    Date,
    close_price,
    ma_200,
    CASE
      WHEN close_price > ma_200
        THEN 'Above MA'
      WHEN close_price < ma_200
        THEN 'Below MA'
      ELSE 'At MA'
    END AS price_vs_ma
  
  FROM ma_valid

)

SELECT *

FROM ma_final
