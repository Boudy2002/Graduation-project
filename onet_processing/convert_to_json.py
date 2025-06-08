import pandas as pd
import json
import os

print("Converting final profiles CSV to JSON...")

onet_data_folder = 'onet_data'
csv_input_path = os.path.join(onet_data_folder, 'occupational_profiles_final.csv')
json_output_path = os.path.join(onet_data_folder, 'occupational_profiles_final.json') # Output JSON

try:
    df = pd.read_csv(csv_input_path)
    print(f"Read {len(df)} rows from CSV.")

    # Convert DataFrame to a list of dictionaries (records format)
    # Ensure NaN values are converted to None (which becomes null in JSON)
    records = df.where(pd.notnull(df), None).to_dict(orient='records')

    print(f"Saving {len(records)} records to JSON: {json_output_path}")
    with open(json_output_path, 'w', encoding='utf-8') as f:
        json.dump(records, f, ensure_ascii=False, indent=4) # Use indent for readability

    print("Conversion to JSON complete.")

except FileNotFoundError:
    print(f"ERROR: Input CSV file not found at {csv_input_path}")
except Exception as e:
    print(f"An error occurred during conversion: {e}")