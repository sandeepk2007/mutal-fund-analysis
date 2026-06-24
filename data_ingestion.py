import pandas as pd
import os

folder = r"C:\Users\sande\OneDrive\Desktop\fintech\data\raw\Bluestock_MF_Datasets"

for file in os.listdir(folder):
    if file.endswith(".csv"):
        path = os.path.join(folder, file)

        print("\n" + "="*50)
        print("FILE:", file)

        df = pd.read_csv(path)

        print("Shape:")
        print(df.shape)

        print("\nData Types:")
        print(df.dtypes)

        print("\nFirst 5 Rows:")
        pd.set_option('display.max_columns',None)
        print(df.head())

        print("\nMissing Values:")
        print(df.isnull().sum())

        print("\nDuplicate Rows:")
        print(df.duplicated().sum())

        print(df.columns)