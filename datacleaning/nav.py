import pandas as pd

# Load NAV history file
df = pd.read_csv("data/raw/Bluestock_MF_Datasets/02_nav_history.csv")

# Check columns
print("Columns:", df.columns)

# Parse date column
df['date'] = pd.to_datetime(df['date'])

# Sort by amfi_code and date
df = df.sort_values(['amfi_code', 'date'])

# Remove duplicate records
df = df.drop_duplicates(subset=['amfi_code', 'date'])

# Forward-fill missing NAV values within each fund
df['nav'] = df.groupby('amfi_code')['nav'].ffill()

# Validate NAV > 0
df = df[df['nav'] > 0]

# Save cleaned file
df.to_csv("data/processed/nav_history_cleaned.csv", index=False)

print("Cleaning completed!")
print(df.head())