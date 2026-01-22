{{
  config({    
    "materialized": "ephemeral",
    "database": "t4_demo_data",
    "schema": "company_share_price_analysis_data"
  })
}}

WITH para_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'para_daily_data') }}

),

para_with_ticker AS (

  SELECT 
    'PARA' AS ticker,
    Date,
    Open,
    High,
    Low,
    Close,
    `Adj Close`,
    Volume
  
  FROM para_source

),

crm_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'crm_daily_data') }}

),

crm_with_ticker AS (

  SELECT 
    'CRM' AS ticker,
    Date,
    Open,
    High,
    Low,
    Close,
    `Adj Close`,
    Volume
  
  FROM crm_source

),

v_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'v_daily_data') }}

),

v_with_ticker AS (

  SELECT 
    'V' AS ticker,
    Date,
    Open,
    High,
    Low,
    Close,
    `Adj Close`,
    Volume
  
  FROM v_source

),

sony_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'sony_daily_data') }}

),

sony_with_ticker AS (

  SELECT 
    'SONY' AS ticker,
    Date,
    Open,
    High,
    Low,
    Close,
    `Adj Close`,
    Volume
  
  FROM sony_source

),

akam_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'akam_daily_data') }}

),

akam_with_ticker AS (

  SELECT 
    'AKAM' AS ticker,
    Date,
    Open,
    High,
    Low,
    Close,
    `Adj Close`,
    Volume
  
  FROM akam_source

),

amzn_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'amzn_daily_data') }}

),

amzn_with_ticker AS (

  SELECT 
    'AMZN' AS ticker,
    Date,
    Open,
    High,
    Low,
    Close,
    `Adj Close`,
    Volume
  
  FROM amzn_source

),

intc_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'intc_daily_data') }}

),

intc_with_ticker AS (

  SELECT 
    'INTC' AS ticker,
    Date,
    Open,
    High,
    Low,
    Close,
    `Adj Close`,
    Volume
  
  FROM intc_source

),

lumn_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'lumn_daily_data') }}

),

lumn_with_ticker AS (

  SELECT 
    'LUMN' AS ticker,
    Date,
    Open,
    High,
    Low,
    Close,
    `Adj Close`,
    Volume
  
  FROM lumn_source

),

wbd_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'wbd_daily_data') }}

),

wbd_with_ticker AS (

  SELECT 
    'WBD' AS ticker,
    Date,
    Open,
    High,
    Low,
    Close,
    `Adj Close`,
    Volume
  
  FROM wbd_source

),

ma_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'ma_daily_data') }}

),

ma_with_ticker AS (

  SELECT 
    'MA' AS ticker,
    Date,
    Open,
    High,
    Low,
    Close,
    `Adj Close`,
    Volume
  
  FROM ma_source

),

ups_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'ups_daily_data') }}

),

ups_with_ticker AS (

  SELECT 
    'UPS' AS ticker,
    Date,
    Open,
    High,
    Low,
    Close,
    `Adj Close`,
    Volume
  
  FROM ups_source

),

nflx_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'nflx_daily_data') }}

),

nflx_with_ticker AS (

  SELECT 
    'NFLX' AS ticker,
    Date,
    Open,
    High,
    Low,
    Close,
    `Adj Close`,
    Volume
  
  FROM nflx_source

),

fdx_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'fdx_daily_data') }}

),

fdx_with_ticker AS (

  SELECT 
    'FDX' AS ticker,
    Date,
    Open,
    High,
    Low,
    Close,
    `Adj Close`,
    Volume
  
  FROM fdx_source

),

nvda_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'nvda_daily_data') }}

),

nvda_with_ticker AS (

  SELECT 
    'NVDA' AS ticker,
    Date,
    Open,
    High,
    Low,
    Close,
    `Adj Close`,
    Volume
  
  FROM nvda_source

),

combined_stocks AS (

  SELECT * 
  
  FROM akam_with_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM amzn_with_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM crm_with_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM fdx_with_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM intc_with_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM lumn_with_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM ma_with_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM nflx_with_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM nvda_with_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM para_with_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM sony_with_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM ups_with_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM v_with_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM wbd_with_ticker

),

q1_filtered_to_common_period AS (

  SELECT * 
  
  FROM combined_stocks AS combined_stocks_ref
  
  WHERE Date >= '2008-03-19'

),

q1_last_prices_source_table_000 AS (

  SELECT * 
  
  FROM q1_filtered_to_common_period

),

q1_last_prices_from_000 AS (

  SELECT 
    ticker,
    Date
  
  FROM q1_last_prices_source_table_000

),

q1_last_prices_groupBy_001 AS (

  SELECT 
    ticker AS ine_000,
    MAX(Date) AS ine_001
  
  FROM q1_last_prices_from_000
  
  GROUP BY ticker

),

q1_first_prices_source_table_000 AS (

  SELECT * 
  
  FROM q1_filtered_to_common_period

),

q1_first_prices_from_000 AS (

  SELECT 
    ticker,
    Date
  
  FROM q1_first_prices_source_table_000

),

q1_first_prices_groupBy_001 AS (

  SELECT 
    ticker AS ine_000,
    MIN(Date) AS ine_001
  
  FROM q1_first_prices_from_000
  
  GROUP BY ticker

),

q1_first_prices_from_002 AS (

  SELECT 
    ticker,
    Close AS first_close,
    Date AS first_date
  
  FROM q1_first_prices_source_table_000
  JOIN q1_first_prices_groupBy_001 AS in_000
     ON in_000.ine_000 = ticker AND in_000.ine_001 = Date

),

q1_last_prices_from_002 AS (

  SELECT 
    ticker,
    Close AS last_close,
    Date AS last_date
  
  FROM q1_last_prices_source_table_000
  JOIN q1_last_prices_groupBy_001 AS in_000
     ON in_000.ine_000 = ticker AND in_000.ine_001 = Date

),

q1_price_change_joined AS (

  SELECT 
    f.ticker,
    f.first_date,
    f.first_close,
    l.last_date,
    l.last_close
  
  FROM q1_first_prices_from_002 AS f
  JOIN q1_last_prices_from_002 AS l
     ON f.ticker = l.ticker

),

q1_price_change_calculated AS (

  SELECT 
    ticker,
    first_date,
    ROUND(first_close, 2) AS first_close,
    last_date,
    ROUND(last_close, 2) AS last_close,
    ROUND(last_close - first_close, 2) AS price_change,
    ROUND(((last_close - first_close) / first_close) * 100, 2) AS percent_change
  
  FROM q1_price_change_joined

),

q1_final_sorted AS (

  SELECT * 
  
  FROM q1_price_change_calculated
  
  ORDER BY percent_change DESC

)

SELECT *

FROM q1_final_sorted
