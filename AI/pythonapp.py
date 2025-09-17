# import requests
# import pandas as pd
# import time

# API_KEY = "CC6DC5F8-FAF8-335B-9764-3A9736C2AB62"
# api_url = "https://quickstats.nass.usda.gov/api/api_GET/"

# # Example: list of commodities you want to fetch
# commodities = ["TOMATOES", "ONIONS", "POTATOES"]  # expand as needed
# years = range(2020, 2024)
# states = ["CALIFORNIA"]  # expand as needed

# all_data = []

# for commodity in commodities:
#     for year in years:
#         for state in states:
#             params = {
#                 "key": API_KEY,
#                 "commodity_desc": commodity,
#                 "year": year,
#                 "state_name": state,
#                 "agg_level_desc": "STATE",
#                 "format": "JSON"
#             }
#             response = requests.get(api_url, params=params)
#             if response.status_code == 200:
#                 data = response.json()
#                 all_data.extend(data['data'])
#                 print(f"Fetched {commodity}, {state}, {year}, records: {len(data['data'])}")
#             else:
#                 print(f"Failed for {commodity}, {state}, {year}, status: {response.status_code}")
            
#             # Optional: wait to avoid hitting API limits
#             time.sleep(0.5)

# # Convert to DataFrame
# df = pd.DataFrame(all_data)
# print(df.head())
# print(f"Total records fetched: {len(df)}")



import requests
import pandas as pd
import time

# ------------------------------
# API Configuration
# ------------------------------
API_KEY = "579b464db66ec23bdd000001cdd3946e44ce4aad7209ff7b23ac571b"
RESOURCE_ID = "9ef84268-d588-465a-a308-a864a43d0070"
API_URL = f"https://api.data.gov.in/resource/{RESOURCE_ID}"

# ------------------------------
# Lists of vegetables and states
# Use exact spelling from API
# ------------------------------
vegetables = ["Tomato", "Onion", "Potato"]  # extend as needed
states = ["Andhra Pradesh", "Maharashtra", "Karnataka", "Tamil Nadu"]  # extend as needed

all_records = []

# ------------------------------
# Fetch data for all vegetables & states
# ------------------------------
for veg in vegetables:
    for state in states:
        offset = 0
        limit = 100  # max records per request
        print(f"Fetching {veg} prices for {state}...")
        while True:
            # params = {
            #     "api-key": API_KEY,
            #     "format": "json",
            #     "filters[state.keyword]": state,
            #     "filters[commodity]": veg,
            #     "limit": limit,
            #     "offset": offset
            # }
            params = {
                "api-key": API_KEY,
                "format": "json",
                "filters[state.keyword]": state,
                "filters[commodity]": veg,
                "filters[date]": "2025-09-10",   # <-- date in YYYY-MM-DD format
                "limit": limit,
                "offset": offset
            }
            response = requests.get(API_URL, params=params)
            
            if response.status_code != 200:
                print(f"Failed for {veg}, {state}, offset {offset}: {response.status_code}")
                break
            
            data = response.json()
            records = data.get("records", [])
            if not records:
                break
            
            all_records.extend(records)
            offset += limit
            time.sleep(0.3)  # avoid API rate-limiting

# ------------------------------
# Convert to DataFrame
# ------------------------------
df = pd.DataFrame(all_records)
print(f"Total records fetched: {len(df)}")
if df.empty:
    print("No data fetched. Check vegetable/state names or API availability.")
else:
    # ------------------------------
    # Convert price columns to numeric
    # ------------------------------
    df['min_price'] = pd.to_numeric(df['min_price'], errors='coerce')
    df['max_price'] = pd.to_numeric(df['max_price'], errors='coerce')
    df['modal_price'] = pd.to_numeric(df['modal_price'], errors='coerce')
    
    # ------------------------------
    # Save the data to CSV
    # ------------------------------
    df.to_csv("indian_vegetable_prices.csv", index=False)
    print("Data saved to 'indian_vegetable_prices.csv'")
    print(df.head())