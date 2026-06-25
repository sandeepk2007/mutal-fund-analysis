import pandas as pd
from sqlalchemy import create_engine

# Connect to SQLite
engine = create_engine("sqlite:///bluestock_mf.db")

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

for file_name, table_name in tables.items():

    # CSV row count
    df = pd.read_csv(f"data/processed/{file_name}")
    csv_rows = len(df)

    # Database row count
    db_rows = pd.read_sql(
        f"SELECT COUNT(*) AS total FROM {table_name}",
        engine
    )["total"][0]

    print(f"{table_name}")
    print(f"CSV Rows : {csv_rows}")
    print(f"DB Rows  : {db_rows}")

    if csv_rows == db_rows:
        print("✅ Match\n")
    else:
        print("❌ Mismatch\n")