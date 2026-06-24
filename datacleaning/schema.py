import pandas as pd
df=pd.read_csv("data/raw/Bluestock_MF_Datasets/07_scheme_performance.csv")

return_cols = [
    "return_1yr_pct",
    "return_3yr_pct",
    "return_5yr_pct"
]

# Validate numeric values
for col in return_cols:
    df[col] = pd.to_numeric(
        df[col],
        errors="coerce"
    )

# Find rows with non-numeric values
invalid_rows = df[
    df[return_cols].isna().any(axis=1)
]

print("Invalid Return Values:")
print(invalid_rows)

# Flag anomalies
for col in return_cols:
    df[f"{col}_anomaly"] = (
        (df[col] < -100) |
        (df[col] > 200)
    )

# Show anomalous rows
anomalies = df[
    df[[f"{c}_anomaly" for c in return_cols]]
    .any(axis=1)
]

print("\nAnomalous Records:")
print(anomalies)
df = df[
    (df["expense_ratio_pct"] >= 0.1) &
    (df["expense_ratio_pct"] <= 2.5)
]

df.to_csv(
    "data/raw/scheme_performance_cleaned.csv",
    index=False
)