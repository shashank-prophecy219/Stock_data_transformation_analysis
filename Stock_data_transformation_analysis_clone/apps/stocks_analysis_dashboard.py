from prophecy_analysis_sdk import *
meta_info = MetaInfo(pipeline_id = "Stocks_analysis1")

with BusinessApp(app_id = "stocks_analysis_dashboard", meta_info = meta_info) as business_app:
    text_widget = TextWidget(
        content = "## Question 1: Price Change Over Common Period\n\nAnalyzes the total price change and percentage gain for each of the 14 companies from 2008-03-19 to present. This ensures a fair comparison using the common time window when all companies have data."
    )
    bar_chart = BarWidget(
        table_id = "q1_price_change_results", 
        title = "Price Change (%) by Company", 
        x_axis_column = "ticker", 
        y_axis_columns = [         YAxisColumn(
           name = "percent_change", 
           agg = AggregationType.MAX, 
           color = "#4c4ddc"
         )], 
        y_axis_config = None
    )
    data_preview = DataPreviewWidget(
        table_id = "q1_price_change_results", 
        columns = [Column(column = "ticker"),  Column(column = "first_date"),  Column(column = "first_close"),          Column(column = "last_date"),  Column(column = "last_close"),  Column(column = "price_change"),          Column(column = "percent_change")], 
        title = "Q1 Price Change Details"
    )
    text_widget = TextWidget(
        content = "## Question 2: Highest Cumulative Gain Year\n\nIdentifies which year saw the highest cumulative gain for each company. Shows the year with the best annual performance based on percentage gain from start to end of year."
    )
    bar_chart = BarWidget(
        table_id = "q2_best_year_results", 
        title = "Best Year Gain (%) by Company", 
        x_axis_column = "ticker", 
        y_axis_columns = [         YAxisColumn(
           name = "percent_gain", 
           agg = AggregationType.MAX, 
           color = "#28a745"
         )], 
        y_axis_config = None
    )
    data_preview = DataPreviewWidget(
        table_id = "q2_best_year_results", 
        columns = [Column(column = "ticker"),  Column(column = "best_year"),  Column(column = "year_start_price"),          Column(column = "year_end_price"),  Column(column = "price_change"),  Column(column = "percent_gain")], 
        title = "Q2 Best Year Details"
    )
    text_widget = TextWidget(
        content = "## Question 3: Average Gain/Loss by Year-Month\n\nCalculates the average daily percentage change aggregated by month for each company. Shows trading patterns and identifies which months tend to perform better or worse."
    )
    bar_chart = BarWidget(
        table_id = "q3_monthly_avg_results", 
        title = "Average Daily Change (%) by Company", 
        x_axis_column = "ticker", 
        y_axis_columns = [         YAxisColumn(
           name = "avg_daily_pct_change", 
           color = "#17a2b8"
         )], 
        y_axis_config = None
    )
    data_preview = DataPreviewWidget(
        table_id = "q3_monthly_avg_results", 
        columns = [Column(column = "ticker"),  Column(column = "year_month"),  Column(column = "trading_days"),          Column(column = "avg_daily_pct_change"),  Column(column = "total_monthly_change"),          Column(column = "month_trend")], 
        title = "Q3 Monthly Average Details"
    )
    text_widget = TextWidget(
        content = "## Bonus: 200-Day Moving Average\n\nCalculates the 200-day moving average for each company and compares the current closing price to the MA. Indicates whether stocks are trading above or below their long-term trend."
    )
    line_chart = LineWidget(
        table_id = "ma_200_results", 
        title = "Close Price vs 200-Day MA", 
        x_axis_column = "Date", 
        y_axis_columns = [         YAxisColumn(
           name = "close_price", 
           color = "#6f42c1"
         ),          YAxisColumn(
           name = "ma_200", 
           color = "#fd7e14"
         )], 
        y_axis_config = None
    )
    data_preview = DataPreviewWidget(
        table_id = "ma_200_results", 
        columns = [Column(column = "ticker"),  Column(column = "Date"),  Column(column = "close_price"),  Column(column = "ma_200"),          Column(column = "price_vs_ma")], 
        title = "MA Details"
    )
    instance1 = AppInstance(instance_id = "amk", schedule = Schedule(time_zone = "GMT", emails = ["email@gmail.com"]))
