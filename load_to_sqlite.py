from pathlib import Path
import re

import pandas as pd
from sqlalchemy import create_engine


PROCESSED_DIR = Path("data/processed")
DATABASE_URL = "sqlite:///bluestock_mf.db"

TABLE_NAME_OVERRIDES = {
    "01_fund_master.csv": "dim_fund",
    "03_aum_by_fund_house.csv": "fact_aum",
    "nav_history_cleaned.csv": "fact_nav",
    "scheme_performance_cleaned.csv": "fact_performance",
    "investor_transactions_cleaned.csv": "fact_transactions",
    "09_portfolio_holdings.csv": "portfolio_holdings",
    "10_benchmark_indices.csv": "benchmark_indices",
}


def table_name_from_file(csv_path: Path) -> str:
    if csv_path.name in TABLE_NAME_OVERRIDES:
        return TABLE_NAME_OVERRIDES[csv_path.name]

    table_name = csv_path.stem.lower()
    table_name = re.sub(r"^\d+_", "", table_name)
    table_name = re.sub(r"_cleaned$", "", table_name)
    table_name = re.sub(r"[^a-z0-9_]+", "_", table_name)
    return table_name.strip("_")


def main() -> None:
    engine = create_engine(DATABASE_URL)
    csv_files = sorted(PROCESSED_DIR.glob("*.csv"))

    if not csv_files:
        raise FileNotFoundError(f"No CSV files found in {PROCESSED_DIR}")

    print(f"Loading {len(csv_files)} cleaned datasets into bluestock_mf.db\n")

    for csv_path in csv_files:
        table_name = table_name_from_file(csv_path)
        df = pd.read_csv(csv_path)

        df.to_sql(
            name=table_name,
            con=engine,
            if_exists="replace",
            index=False,
        )

        print(f"{csv_path.name} -> {table_name}: {len(df)} rows")

    print("\nAll cleaned datasets loaded successfully into SQLite.")


if __name__ == "__main__":
    main()
