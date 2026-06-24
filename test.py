import pandas as pd
import os
df1=pd.read_csv(r"C:\Users\sande\OneDrive\Desktop\fintech\data\raw\Bluestock_MF_Datasets\01_fund_master.csv")
df2=pd.read_csv(r"C:\Users\sande\OneDrive\Desktop\fintech\data\raw\Bluestock_MF_Datasets\02_nav_history.csv")
print(df1.shape)
print(df2.shape)

found=True
for i in df1["amfi_code"]:
    if i not in df2["amfi_code"].values:
        print(i,"Not there")
        found=False
if found:
        print("All AMFI codes are present..")

        