import pandas as pd

files = [
    "01_fund_master.csv",
    "nav_history_cleaned.csv",
    "03_aum_by_fund_house.csv",
    "scheme_performance_cleaned.csv",
    "investor_transactions_cleaned.csv"
]

for file in files:
    df = pd.read_csv(f"data/processed/{file}")

    print("=" * 60)
    print(file)
    print("=" * 60)
    print(df.columns.tolist())