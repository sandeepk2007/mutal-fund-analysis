import pandas as pd

df=pd.read_csv("data/raw/Bluestock_MF_Datasets/08_investor_transactions.csv")
#Fix date formats
df["transaction_date"]=pd.to_datetime(
    df["transaction_date"],
    errors="coerce"
)

#Standardization
df["transaction_type"]=(
    df["transaction_type"]
    .str.strip()
    .str.lower()
)
mapping={
    "sip":"SIP",
    "lumpsum":"Lumpsum",
    "lump sum":"Lumpsum",
    "redemption":"Redemption",
    "redeem":"Redemption"
}
df["transaction_type"]=df["transaction_type"].replace(mapping)

#Validation of amount_inr values
invalid_amounts=df[df["amount_inr"]<=0]
print("Invalid amount records:")
print(invalid_amounts)

df=df[df["amount_inr"]>0]

#Check KYC status
df["kyc_status"]=(
    df["kyc_status"]
    .str.strip()
    .str.title()
)
valid_kyc=["Verified", "Pending", "Rejected"]
invalid_kyc=df[~df["kyc_status"].isin(valid_kyc)]
print("\nInvalid KYC records:")
print(invalid_kyc)
df.to_csv(
    "data/raw/investor_transactions_cleaned.csv",
    index=False
)
print("\nCleaning completed successfully!")
print(df.head())