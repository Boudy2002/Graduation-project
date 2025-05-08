import pandas as pd
import os

print("Starting Skill Level Normalization and Data Combination...")

# --- Configuration ---
onet_data_folder = 'onet_data'
riasec_input_path = os.path.join(onet_data_folder, 'occupational_riasec_codes.csv')
# *** Make sure this filename matches your actual skills data file (e.g., Skills.xlsx) ***
skills_input_path = os.path.join(onet_data_folder, 'occupational_skill_levels.csv') # Input is the CSV we created before

# Define the output file path for the combined data
output_file_path = os.path.join(onet_data_folder, 'occupational_profiles.csv')

# O*NET Level scale maximum
ONET_LEVEL_MAX = 7.0

# --- FINALIZED Categorical Mapping Thresholds ---
# Based on O*NET Level Scale Anchor Descriptions
# O*NET Levels: 0-2=Low, 3-4=Mid, 5-7=Advanced
level_bins = [-0.1, 2.99, 4.99, ONET_LEVEL_MAX] # Bins: <=2.99, <=4.99, <=7.0
level_labels = ['Low', 'Mid', 'Advanced']      # Corresponding labels for your system
# --- End Configuration ---

try:
    # --- Step 1: Load Processed Data ---
    print(f"Loading RIASEC data from: {riasec_input_path}")
    riasec_df = pd.read_csv(riasec_input_path)
    print(f"Loaded {len(riasec_df)} RIASEC codes.")

    print(f"Loading Skill Level data from: {skills_input_path}")
    skills_df = pd.read_csv(skills_input_path)
    print(f"Loaded {len(skills_df)} skill level entries.")

    # --- Step 2: Apply Linear Scaling (0-7 -> 0-100) ---
    print("Applying Linear Scaling to O*NET Levels...")
    if 'ProblemSolving_LV' in skills_df.columns:
        skills_df['ProblemSolving_Score100'] = (skills_df['ProblemSolving_LV'] / ONET_LEVEL_MAX) * 100
    else:
        print("Warning: 'ProblemSolving_LV' column not found.")
        skills_df['ProblemSolving_Score100'] = 0

    if 'CriticalThinking_LV' in skills_df.columns:
        skills_df['CriticalThinking_Score100'] = (skills_df['CriticalThinking_LV'] / ONET_LEVEL_MAX) * 100
    else:
        print("Warning: 'CriticalThinking_LV' column not found.")
        skills_df['CriticalThinking_Score100'] = 0
    print("Linear scaling complete.")

    # --- Step 3: Apply FINALIZED Categorical Mapping ---
    print("Applying Finalized Categorical Mapping...")
    print(f"Using finalized bins: {level_bins} and labels: {level_labels}")

    if 'ProblemSolving_LV' in skills_df.columns:
        skills_df['ProblemSolving_ReqLevel'] = pd.cut(skills_df['ProblemSolving_LV'],
                                                      bins=level_bins,
                                                      labels=level_labels,
                                                      right=True) # Includes right edge
    else:
         skills_df['ProblemSolving_ReqLevel'] = 'Low' # Default

    if 'CriticalThinking_LV' in skills_df.columns:
         skills_df['CriticalThinking_ReqLevel'] = pd.cut(skills_df['CriticalThinking_LV'],
                                                         bins=level_bins,
                                                         labels=level_labels,
                                                         right=True)
    else:
         skills_df['CriticalThinking_ReqLevel'] = 'Low' # Default

    # Convert categorical levels to string to avoid potential issues later
    skills_df['ProblemSolving_ReqLevel'] = skills_df['ProblemSolving_ReqLevel'].astype(str)
    skills_df['CriticalThinking_ReqLevel'] = skills_df['CriticalThinking_ReqLevel'].astype(str)
    print("Categorical mapping complete.")

    # --- Step 4: Merge RIASEC and Skills Data ---
    print("Merging RIASEC and processed skills data...")
    occupational_profiles_df = pd.merge(
        riasec_df,
        skills_df, # Now contains original LV, Score100, and ReqLevel
        on='O*NET-SOC Code',
        how='left'
    )
    # Fill any completely missing skill rows resulting from the left merge
    skill_cols_to_fill = ['ProblemSolving_LV', 'CriticalThinking_LV',
                          'ProblemSolving_Score100', 'CriticalThinking_Score100']
    for col in skill_cols_to_fill:
        if col in occupational_profiles_df.columns:
             occupational_profiles_df[col].fillna(0, inplace=True)

    cat_cols_to_fill = ['ProblemSolving_ReqLevel', 'CriticalThinking_ReqLevel']
    for col in cat_cols_to_fill:
         if col in occupational_profiles_df.columns:
             # Use 'Low' or perhaps 'Unknown' if merge resulted in NaN
             occupational_profiles_df[col].fillna('Low', inplace=True)

    print(f"Merge complete. Final profile data has {len(occupational_profiles_df)} occupations.")

    # --- Step 5: Save the Combined Result ---
    print(f"Saving combined occupational profiles to: {output_file_path}")
    occupational_profiles_df.to_csv(output_file_path, index=False)
    print("Processing complete. Combined output saved.")

    # --- Optional: Display a sample ---
    print("\nSample of the combined occupational profile data:")
    print(occupational_profiles_df.head())

except FileNotFoundError as e:
    print(f"ERROR: Could not find an input file: {e}")
    print("Please ensure 'occupational_riasec_codes.csv' and 'occupational_skill_levels.csv' exist in the 'onet_data' folder.")
except KeyError as e:
    print(f"ERROR: A required column is missing from an input file: {e}")
except ImportError:
     print("ERROR: The 'openpyxl' library might be needed if input files are .xlsx.")
     print("Please install it by running: pip install openpyxl")
except Exception as e:
    print(f"An unexpected error occurred: {e}")