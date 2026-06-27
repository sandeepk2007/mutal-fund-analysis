import pandas as pd
from sqlalchemy import create_engine

engine = create_engine("sqlite:///bluestock_mf.db")

tables = pd.read_sql(
    "SELECT name FROM sqlite_master WHERE type='table';",
    engine
)

print(tables)