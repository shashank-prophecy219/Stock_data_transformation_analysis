{{
  config({    
    "materialized": "ephemeral",
    "database": "t4_demo_data",
    "schema": "company_share_price_analysis_data"
  })
}}

WITH amzn_q2_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'amzn_daily_data') }}

),

nvda_q2_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'nvda_daily_data') }}

),

nvda_q2_ticker AS (

  SELECT 
    'NVDA' AS ticker,
    Date,
    Close
  
  FROM nvda_q2_source

),

lumn_q2_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'lumn_daily_data') }}

),

sony_q2_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'sony_daily_data') }}

),

sony_q2_ticker AS (

  SELECT 
    'SONY' AS ticker,
    Date,
    Close
  
  FROM sony_q2_source

),

ma_q2_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'ma_daily_data') }}

),

ma_q2_ticker AS (

  SELECT 
    'MA' AS ticker,
    Date,
    Close
  
  FROM ma_q2_source

),

intc_q2_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'intc_daily_data') }}

),

intc_q2_ticker AS (

  SELECT 
    'INTC' AS ticker,
    Date,
    Close
  
  FROM intc_q2_source

),

fdx_q2_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'fdx_daily_data') }}

),

fdx_q2_ticker AS (

  SELECT 
    'FDX' AS ticker,
    Date,
    Close
  
  FROM fdx_q2_source

),

akam_q2_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'akam_daily_data') }}

),

akam_q2_ticker AS (

  SELECT 
    'AKAM' AS ticker,
    Date,
    Close
  
  FROM akam_q2_source

),

v_q2_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'v_daily_data') }}

),

v_q2_ticker AS (

  SELECT 
    'V' AS ticker,
    Date,
    Close
  
  FROM v_q2_source

),

amzn_q2_ticker AS (

  SELECT 
    'AMZN' AS ticker,
    Date,
    Close
  
  FROM amzn_q2_source

),

crm_q2_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'crm_daily_data') }}

),

crm_q2_ticker AS (

  SELECT 
    'CRM' AS ticker,
    Date,
    Close
  
  FROM crm_q2_source

),

wbd_q2_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'wbd_daily_data') }}

),

wbd_q2_ticker AS (

  SELECT 
    'WBD' AS ticker,
    Date,
    Close
  
  FROM wbd_q2_source

),

lumn_q2_ticker AS (

  SELECT 
    'LUMN' AS ticker,
    Date,
    Close
  
  FROM lumn_q2_source

),

ups_q2_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'ups_daily_data') }}

),

ups_q2_ticker AS (

  SELECT 
    'UPS' AS ticker,
    Date,
    Close
  
  FROM ups_q2_source

),

nflx_q2_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'nflx_daily_data') }}

),

nflx_q2_ticker AS (

  SELECT 
    'NFLX' AS ticker,
    Date,
    Close
  
  FROM nflx_q2_source

),

para_q2_source AS (

  SELECT * 
  
  FROM {{ source('t4_demo_data.company_share_price_analysis_data', 'para_daily_data') }}

),

para_q2_ticker AS (

  SELECT 
    'PARA' AS ticker,
    Date,
    Close
  
  FROM para_q2_source

),

q2_combined AS (

  SELECT * 
  
  FROM akam_q2_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM amzn_q2_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM crm_q2_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM fdx_q2_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM intc_q2_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM lumn_q2_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM ma_q2_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM nflx_q2_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM nvda_q2_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM para_q2_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM sony_q2_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM ups_q2_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM v_q2_ticker
  
  UNION ALL
  
  SELECT * 
  
  FROM wbd_q2_ticker

),

q2_filtered AS (

  SELECT * 
  
  FROM q2_combined
  
  WHERE Date >= '2008-03-19'

),

q2_with_year AS (

  SELECT 
    ticker,
    Date,
    Close,
    YEAR(Date) AS trade_year
  
  FROM q2_filtered

),

q2_year_boundaries AS (

  SELECT 
    ticker,
    trade_year,
    MIN(Date) AS first_date,
    MAX(Date) AS last_date
  
  FROM q2_with_year
  
  GROUP BY 
    ticker, trade_year

),

q2_last_prices AS (

  SELECT 
    w.ticker,
    w.trade_year,
    w.Close AS last_close
  
  FROM q2_with_year AS w
  JOIN q2_year_boundaries AS b
     ON w.ticker = b.ticker AND w.trade_year = b.trade_year AND w.Date = b.last_date

),

q2_first_prices AS (

  SELECT 
    w.ticker,
    w.trade_year,
    w.Close AS first_close
  
  FROM q2_with_year AS w
  JOIN q2_year_boundaries AS b
     ON w.ticker = b.ticker AND w.trade_year = b.trade_year AND w.Date = b.first_date

),

q2_yearly_gains AS (

  SELECT 
    f.ticker,
    f.trade_year,
    ROUND(f.first_close, 2) AS year_start_price,
    ROUND(l.last_close, 2) AS year_end_price,
    ROUND(l.last_close - f.first_close, 2) AS price_change,
    ROUND(((l.last_close - f.first_close) / f.first_close) * 100, 2) AS percent_gain
  
  FROM q2_first_prices AS f
  JOIN q2_last_prices AS l
     ON f.ticker = l.ticker AND f.trade_year = l.trade_year

),

q2_ranked AS (

  SELECT 
    ticker,
    trade_year,
    year_start_price,
    year_end_price,
    price_change,
    percent_gain,
    ROW_NUMBER() OVER (PARTITION BY ticker ORDER BY percent_gain DESC) AS gain_rank
  
  FROM q2_yearly_gains

),

q2_best_year AS (

  SELECT * 
  
  FROM q2_ranked
  
  WHERE gain_rank = 1

),

q2_final AS (

  SELECT 
    ticker,
    trade_year AS best_year,
    year_start_price,
    year_end_price,
    price_change,
    percent_gain
  
  FROM q2_best_year

)

SELECT *

FROM q2_final
