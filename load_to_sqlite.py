import pandas as pd
from sqlalchemy import create_engine

#create  sqlite data base
engine=create_engine("sqlite:///bluestock_mf.db")

#mapping of csv files to sqlite table names
tables = {
    "01_fund_master.csv": "dim_fund",
    "nav_history_cleaned.csv": "fact_nav",
    "03_aum_by_fund_house.csv": "fact_aum",
    "04_monthly_sip_inflows.csv": "monthly_sip_inflows",
    "05_category_inflows.csv": "category_inflows",
    "06_industry_folio_count.csv": "industry_folio_count",
    "scheme_performance_cleaned.csv": "fact_performance",
    "investor_transactions_cleaned.csv": "fact_transactions",
    "09_portfolio_holdings.csv": "portfolio_holdings",
    "10_benchmark_indices.csv": "benchmark_indices"
}

#read each csv and load into sqlite
for file_name,table_name in tables.items():
    file_path=f"data/processed/{file_name}"
    df=pd.read_csv(file_path)
    df.to_sql(
        table_name,engine,
        if_exists="replace",
        index=False
    )
    print(f"{table_name} loaded successfully")
print("\nAll datasets loaded successfully into SQLite database.")