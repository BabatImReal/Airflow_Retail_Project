import pandas as pd

input_path = 'include/dataset/online_retail.csv'

df = pd.read_csv(input_path, encoding='ISO-8859-1')
df.to_csv(input_path, index=False, encoding='utf-8-sig')

print("✅ Fixed and saved:", input_path)
