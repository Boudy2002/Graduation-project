import pandas as pd
import os

print("Starting O*NET Skills/Abilities processing...")

# --- Configuration ---
onet_data_folder = 'onet_data'
# *** IMPORTANT: Adjust file extension if you saved as CSV ***
skills_file_path = os.path.join(onet_data_folder, 'Skills.xlsx')
# We might need Abilities later, but let's focus on Skills first as it has the direct matches
# abilities_file_path = os.path.join(onet_data_folder, 'Abilities.xlsx')

# Define the output file path
output_file_path = os.path.join(onet_data_folder, 'occupational_skill_levels.csv')

# Define the specific skills we need by Element Name
target_skills = [
    "Complex Problem Solving",
    "Critical Thinking"
]

# Define simple names for output columns
skill_column_names = {
    "Complex Problem Solving": "ProblemSolving_LV",
    "Critical Thinking": "CriticalThinking_LV"
}
# --- End Configuration ---

try:
    # --- Step 1: Load the Skills Data ---
    print(f"Loading skills data from: {skills_file_path}")
    # *** Use pd.read_excel if it's an XLSX file, pd.read_csv if it's CSV ***
    # If CSV and tab-separated, use sep='\t'
    # Example for Excel:
    skills_df = pd.read_excel(skills_file_path)
    # Example for Tab-Separated CSV:
    # skills_df = pd.read_csv(skills_file_path, sep='\t', low_memory=False)
    print(f"Successfully loaded {len(skills_df)} skill rows.")

    # --- Step 2: Filter for Target Skills and Level Scale ---
    print(f"Filtering for target skills: {target_skills} and Level (LV) scale...")
    # Keep rows matching target Element Names and the Level scale ('LV')
    filtered_skills_df = skills_df[
        (skills_df['Element Name'].isin(target_skills)) &
        (skills_df['Scale ID'] == 'LV')
    ].copy()
    print(f"Filtered down to {len(filtered_skills_df)} relevant skill level rows.")

    # --- Step 3: Select and Rename Relevant Columns ---
    # Make sure column names match your file exactly
    relevant_df = filtered_skills_df[['O*NET-SOC Code', 'Element Name', 'Data Value']].copy()
    relevant_df.rename(columns={'Data Value': 'LevelValue'}, inplace=True)
    # Convert level value to numeric, coercing errors
    relevant_df['LevelValue'] = pd.to_numeric(relevant_df['LevelValue'], errors='coerce')
    relevant_df.dropna(subset=['LevelValue'], inplace=True)
    print("Selected relevant columns.")

    # --- Step 4: Pivot Data ---
    print("Pivoting data to get skill levels per occupation...")
    occupational_levels_df = relevant_df.pivot_table(
        index='O*NET-SOC Code',
        columns='Element Name',
        values='LevelValue',
        aggfunc='first' # Should only be one value per occupation/skill/scale
    )
    print("Pivoting complete.")

    # --- Step 5: Rename Columns and Handle Missing Values ---
    # Ensure all target skills are columns (even if some occupations don't have them)
    for skill_name in target_skills:
        if skill_name not in occupational_levels_df.columns:
            occupational_levels_df[skill_name] = pd.NA # Add missing column

    # Select and rename columns using the mapping defined above
    occupational_levels_df = occupational_levels_df[target_skills] # Keep only target skill columns
    occupational_levels_df.rename(columns=skill_column_names, inplace=True)

    # Fill missing values - choose a strategy (e.g., 0, mean, median)
    # For now, let's fill with 0, assuming lack of data means low requirement
    occupational_levels_df.fillna(0, inplace=True)
    print("Columns renamed and missing values handled.")

    # --- Step 6: Prepare and Save Final Output ---
    final_skill_levels_df = occupational_levels_df.reset_index()
    print(f"Prepared final DataFrame with {len(final_skill_levels_df)} occupations.")

    print(f"Saving results to: {output_file_path}")
    final_skill_levels_df.to_csv(output_file_path, index=False)
    print("Processing complete. Output saved.")

    # --- Optional: Display a sample ---
    print("\nSample of the output data (Raw O*NET Levels):")
    print(final_skill_levels_df.head())

except FileNotFoundError:
    print(f"ERROR: Could not find the file {skills_file_path} (or Abilities file if used).")
    print("Please ensure the file(s) exist in the 'onet_data' subfolder and the filename/extension in the script is correct.")
except ImportError:
     print("ERROR: The 'openpyxl' library is required to read .xlsx files.")
     print("Please install it by running: pip install openpyxl")
except KeyError as e:
    print(f"ERROR: A required column is missing from the input file: {e}")
    print("Please ensure your Skills.xlsx/Abilities.xlsx file has the correct headers (e.g., 'O*NET-SOC Code', 'Element Name', 'Scale ID', 'Data Value'). Check exact spelling and case.")
except Exception as e:
    print(f"An unexpected error occurred: {e}")