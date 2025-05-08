# Import the pandas library
import pandas as pd
import os # Import os to handle file paths reliably

print("Starting O*NET Interests processing...")

# --- Configuration ---
# Define the path to your O*NET data relative to the script location
# Assumes 'onet_data' is a subfolder in the same directory as the script
onet_data_folder = 'onet_data'
interests_file_path = os.path.join(onet_data_folder, 'Interests.xlsx') # Use the correct Excel extension
# Define the output file path (saving into the same 'onet_data' folder)
output_file_path = os.path.join(onet_data_folder, 'occupational_riasec_codes.csv')

# Define the mapping from O*NET numerical high-point values to RIASEC letters
# (Standard O*NET mapping: 1=R, 2=I, 3=A, 4=S, 5=E, 6=C. 0 means no distinct point)
riasec_mapping = {
    1: 'R', 2: 'I', 3: 'A', 4: 'S', 5: 'E', 6: 'C',
    0: ''
}
# --- End Configuration ---

try:
    # --- Step 2.1: Load the Interests Data ---
    print(f"Loading data from: {interests_file_path}")
    # Use low_memory=False to prevent potential dtype warnings with mixed types
    # Read the Excel file instead of CSV
    interests_df = pd.read_excel(interests_file_path)
    print(f"Successfully loaded {len(interests_df)} rows.")

    # --- Step 2.2: Filter for High-Point Data ---
    print("Filtering for Interest High-Point (IH) data...")
    # Keep only rows where Scale ID is 'IH' (Interest High-Point)
    high_points_df = interests_df[interests_df['Scale ID'] == 'IH'].copy()

    # Further filter to keep only the First and Second high points
    high_points_df = high_points_df[high_points_df['Element Name'].isin([
        'First Interest High-Point',
        'Second Interest High-Point'
    ])]
    print(f"Filtered down to {len(high_points_df)} high-point rows.")

    # --- Step 2.3: Map Numerical High-Points to Letters ---
    print("Mapping numerical high-points to RIASEC letters...")
    # Ensure 'Data Value' is numeric, coercing errors to NaN (Not a Number)
    high_points_df['Data Value'] = pd.to_numeric(high_points_df['Data Value'], errors='coerce')
    # Drop rows where Data Value could not be converted to numeric (e.g., if header row was read)
    high_points_df.dropna(subset=['Data Value'], inplace=True)
    # Convert valid numbers to integers for mapping
    high_points_df['Data Value'] = high_points_df['Data Value'].astype(int)

    # Apply the mapping
    high_points_df['Interest Letter'] = high_points_df['Data Value'].map(riasec_mapping)
    print("Mapping complete.")

    # --- Step 2.4: Pivot Data to Get Letters per Occupation ---
    print("Pivoting data to structure by occupation...")
    # Select only the columns needed for pivoting
    pivot_input_df = high_points_df[['O*NET-SOC Code', 'Element Name', 'Interest Letter']]

    # Pivot the table
    pivoted_df = pivot_input_df.pivot_table(
        index='O*NET-SOC Code',
        columns='Element Name',
        values='Interest Letter',
        aggfunc='first' # Use 'first' as there should only be one entry per cell
    )

    # Rename the columns for better readability
    pivoted_df.rename(columns={
        'First Interest High-Point': 'First Letter',
        'Second Interest High-Point': 'Second Letter'
    }, inplace=True)
    print("Pivoting complete.")

    # --- Step 2.5: Create the 2-Letter RIASEC Code ---
    print("Creating 2-letter RIASEC codes...")
    # Handle potential missing values (NaN) if an occupation only has one high point
    pivoted_df.fillna('', inplace=True)

    # Concatenate the first and second letters
    pivoted_df['risacLetters'] = pivoted_df['First Letter'] + pivoted_df['Second Letter']
    print("2-letter codes created.")

    # --- Step 2.6: Prepare Final Output ---
    # Select only the O*NET-SOC code and the final 2-letter code
    # Reset index to turn O*NET-SOC Code from index back into a column
    final_riasec_codes_df = pivoted_df[['risacLetters']].reset_index()
    print(f"Prepared final DataFrame with {len(final_riasec_codes_df)} occupations.")

    # --- Step 2.7: Save the Result ---
    print(f"Saving results to: {output_file_path}")
    final_riasec_codes_df.to_csv(output_file_path, index=False)
    print("Processing complete. Output saved.")

    # --- Optional: Display a sample ---
    print("\nSample of the output data:")
    print(final_riasec_codes_df.head())

except FileNotFoundError:
    print(f"ERROR: Could not find the file {interests_file_path}")
    print("Please ensure the file exists in the 'onet_data' subfolder relative to the script.")
except KeyError as e:
    print(f"ERROR: A required column is missing from the CSV: {e}")
    print("Please ensure your Interests.csv file has the correct headers (e.g., 'O*NET-SOC Code', 'Scale ID', 'Element Name', 'Data Value').")
except Exception as e:
    print(f"An unexpected error occurred: {e}")