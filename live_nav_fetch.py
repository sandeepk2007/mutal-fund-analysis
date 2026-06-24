import requests
import pandas as pd
import os

url = "https://api.mfapi.in/mf/125497"

response = requests.get(url)

data = response.json()

print(data.keys())
df=pd.DataFrame(data["data"])
print(df)
print(os.getcwd())
df.to_csv(r"C:\Users\sande\OneDrive\Desktop\fintech\data\raw\datatop100_nav.csv",index=False)