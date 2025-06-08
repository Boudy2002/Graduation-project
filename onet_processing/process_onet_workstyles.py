# Import the pandas library
import pandas as pd
import os # Import os to handle file paths reliably

print("Starting O*NET Work Styles processing for Big Five proxies...")

# --- Configuration ---
onet_data_folder = 'onet_data'
# *** Ensure this matches your actual Work Styles file name and extension ***
workstyles_input_path = os.path.join(onet_data_folder, 'Work Styles.xlsx')
# Input file created by the previous script (normalize_and_combine.py)
profiles_input_path = os.path.join(onet_data_folder, 'occupational_profiles.csv')

# Define the output file path for the final combined data
output_file_path = os.path.join(onet_data_folder, 'occupational_profiles_final.csv')

# Define the mapping from Big Five traits to O*NET Work Style Element Names
# Based on our previous discussion and justification from research
big_five_to_workstyles_map = {
    'Openness': ["Innovation", "Adaptability/Flexibility", "Independence"],
    'Conscientiousness': ["Dependability", "Attention to Detail", "Achievement/Effort", "Persistence", "Integrity"],
    'Extraversion': ["Leadership", "Social Orientation"], # Acknowledged weaker proxies
    'Agreeableness': ["Cooperation", "Concern for Others", "Social Orientation"],
    'EmotionalStability': ["Self Control", "Stress Tolerance"] # Proxy for low Neuroticism
}

# Define O*NET Importance scale Min/Max (Confirm from Docs - typically 1 to 5)
ONET_IM_MIN = 1.0
ONET_IM_MAX = 5.0
# --- End Configuration ---

try:
    # --- Step 1: Load Work Styles Data ---
    print(f"Loading Work Styles data from: {workstyles_input_path}")
    # *** Use pd.read_excel for .xlsx files. Use pd.read_csv(..., sep='\t') for .txt files ***
    workstyles_df = pd.read_excel(workstyles_input_path)
    print(f"Successfully loaded {len(workstyles_df)} work style rows.")

    # --- Step 2: Filter for Importance Scale ---
    print("Filtering for Importance (IM) scale data...")
    # Ensure column names exactly match your file
    workstyles_im_df = workstyles_df[workstyles_df['Scale ID'] == 'IM'].copy()
    # Ensure Data Value is numeric
    workstyles_im_df['Data Value'] = pd.to_numeric(workstyles_im_df['Data Value'], errors='coerce')
    workstyles_im_df.dropna(subset=['Data Value'], inplace=True)
    print(f"Filtered down to {len(workstyles_im_df)} importance rows.")

    # --- Step 3: Pivot Work Styles Data ---
    print("Pivoting Work Styles data...")
    # Ensure column names exactly match your file
    pivot_ws_df = workstyles_im_df.pivot_table(
        index='O*NET-SOC Code',
        columns='Element Name',
        values='Data Value',
        aggfunc='first' # Use 'first' assuming one IM value per style per occupation
    )
    print("Pivoting complete.")

    # --- Step 4: Calculate Big Five Proxy Scores (1-5 Scale) ---
    print("Calculating Big Five proxy scores (averaging mapped Work Styles)...")
    proxy_scores = {}
    # Note: O*NET-SOC Code is currently the index of pivot_ws_df
    # We will add it back as a column after calculations

    bf_proxy_cols_1_5 = [] # Keep track of intermediate column names
    for big_five_trait, mapped_styles in big_five_to_workstyles_map.items():
        proxy_col_name = f'BigFive_{big_five_trait}_proxy_1_5'
        bf_proxy_cols_1_5.append(proxy_col_name)
        # Select only the columns (work styles) that exist in our pivoted data
        available_styles = [style for style in mapped_styles if style in pivot_ws_df.columns]
        if not available_styles:
            print(f"Warning: No mapped Work Styles found for {big_five_trait}. Filling with midpoint.")
            # Create a series of NaNs with the same index as pivot_ws_df
            proxy_scores[proxy_col_name] = pd.Series(index=pivot_ws_df.index, dtype=float)
        else:
            # Calculate the row-wise mean for the mapped styles, skipping NaNs
            proxy_scores[proxy_col_name] = pivot_ws_df[available_styles].mean(axis=1, skipna=True)

    # Create DataFrame from calculated scores (index is O*NET-SOC Code)
    proxy_scores_1_5_df = pd.DataFrame(proxy_scores, index=pivot_ws_df.index)

    # Fill any remaining NaNs (e.g., if an occupation had *no* scores for *any* mapped styles)
    # Filling with the scale midpoint (3 for 1-5 scale) might be reasonable here
    proxy_scores_1_5_df.fillna((ONET_IM_MIN + ONET_IM_MAX) / 2, inplace=True)

    # *** FIX: RESET INDEX HERE to turn O*NET-SOC Code index into a column ***
    proxy_scores_1_5_df.reset_index(inplace=True)
    print("Proxy scores (1-5 scale) calculated and index reset.")

    # --- Step 5: Normalize Proxy Scores (1-5 -> 0-100) ---
    print("Normalizing proxy scores to 0-100 scale...")
    final_bf_cols = ['O*NET-SOC Code'] # Start list of columns for the final proxy DF
    for big_five_trait in big_five_to_workstyles_map.keys():
        proxy_col_1_5 = f'BigFive_{big_five_trait}_proxy_1_5'
        proxy_col_100 = f'BigFive_{big_five_trait}_Proxy100' # Final column name
        final_bf_cols.append(proxy_col_100) # Add final name to list

        if proxy_col_1_5 in proxy_scores_1_5_df.columns:
             # Apply linear scaling: Score100 = ((Score1_5 - Min) / (Max - Min)) * 100
             proxy_scores_1_5_df[proxy_col_100] = ((proxy_scores_1_5_df[proxy_col_1_5] - ONET_IM_MIN) / (ONET_IM_MAX - ONET_IM_MIN)) * 100
             # Ensure scores are within 0-100 bounds after potential floating point inaccuracies
             proxy_scores_1_5_df[proxy_col_100] = proxy_scores_1_5_df[proxy_col_100].clip(0, 100)
        else:
             # This case should ideally not happen if fillna worked, but as fallback:
             proxy_scores_1_5_df[proxy_col_100] = 50.0 # Default normalized score (midpoint)

    # Select only the final normalized columns + SOC Code
    # *** Use the DataFrame that had its index reset ***
    final_proxy_scores_df = proxy_scores_1_5_df[final_bf_cols]
    print("Normalization complete.")

    # --- Step 6: Load Existing Profiles and Merge ---
    print(f"Loading existing profiles from: {profiles_input_path}")
    existing_profiles_df = pd.read_csv(profiles_input_path)
    print(f"Loaded {len(existing_profiles_df)} existing profiles.")

    print("Merging Big Five proxy scores with existing profiles...")
    # Now the merge should work because 'O*NET-SOC Code' is a regular column in both DFs
    final_profiles_df = pd.merge(
        existing_profiles_df,
        final_proxy_scores_df,
        on='O*NET-SOC Code',
        how='left' # Keep all occupations, add Big Five proxies where available
    )

    # Fill any NaNs for Big Five proxies if an occupation wasn't in Work Styles data
    bf_proxy_cols = [f'BigFive_{trait}_Proxy100' for trait in big_five_to_workstyles_map.keys()]
    # Use a dictionary for fillna to avoid the FutureWarning
    fill_values_bf = {col: 50.0 for col in bf_proxy_cols if col in final_profiles_df.columns}
    final_profiles_df.fillna(value=fill_values_bf, inplace=True)

    print(f"Merge complete. Final combined profiles have {len(final_profiles_df)} occupations.")

    # --- Step 7: Save the Final Combined Result ---
    print(f"Saving final occupational profiles to: {output_file_path}")
    final_profiles_df.to_csv(output_file_path, index=False)
    print("Processing complete. Final profiles saved.")

    # --- Optional: Display a sample ---
    print("\nSample of the final combined occupational profile data:")
    print(final_profiles_df.head())
    print("\nFinal columns:", final_profiles_df.columns.tolist())


except FileNotFoundError as e:
    print(f"ERROR: Could not find an input file: {e}")
    print("Please ensure 'Work Styles.xlsx' (or .csv) and 'occupational_profiles.csv' exist in the 'onet_data' folder.")
except KeyError as e:
    print(f"ERROR: A required column is missing from an input file: {e}")
    print("Check headers in input files (e.g., 'O*NET-SOC Code', 'Scale ID', 'Element Name', 'Data Value').")
except ImportError:
     print("ERROR: The 'openpyxl' library might be needed if input files are .xlsx.")
     print("Please install it by running: pip install openpyxl")
except Exception as e:
    print(f"An unexpected error occurred: {e}")

