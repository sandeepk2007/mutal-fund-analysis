import os
import requests
import pandas as pd

codes=[
    119551,120503,118632,119092,120841
]
for i in codes:
    url=f"https://api.mfapi.in/mf/{i}"
    response=requests.get(url)
    data=response.json()
    df=pd.DataFrame(data["data"])
    df.to_csv(f"{i}.csv",index=False)
    print(f"{i}.csv successfully saved...")