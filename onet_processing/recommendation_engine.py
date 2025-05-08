import pandas as pd
import os
import numpy as np
from sklearn.metrics.pairwise import cosine_similarity # For Big Five matching

print("Recommendation Engine Script Initialized.")

# --- Configuration ---
onet_data_folder = 'onet_data'
# Input file with all processed occupational data
profiles_input_path = os.path.join(onet_data_folder, 'occupational_profiles_final.csv')

# Define weights for combining scores (MUST sum to 1.0) - Adjust as needed!
WEIGHT_RIASEC = 0.40
WEIGHT_SKILLS = 0.35 # Combined weight for Problem Solving & Critical Thinking
WEIGHT_BIG_FIVE = 0.25

# Define scoring for categorical skill level match
# (User Level vs. Required Level) -> Score (e.g., 0 to 1)
# This defines how much credit a user gets based on their level vs the requirement
skill_level_match_scores = {
    ('Low', 'Low'): 1.0, ('Low', 'Mid'): 0.5, ('Low', 'Advanced'): 0.2,
    ('Mid', 'Low'): 1.0, ('Mid', 'Mid'): 1.0, ('Mid', 'Advanced'): 0.6,
    ('Advanced', 'Low'): 1.0, ('Advanced', 'Mid'): 1.0, ('Advanced', 'Advanced'): 1.0,
}

# Define mapping for user proficiency levels if different from O*NET mapping
# Assuming user levels are 'A'/'B'/'C' for Problem Solving
# and 'Advanced'/'Mid'/'Low' for Critical Thinking as per earlier discussion
user_ps_level_map = {'A': 'Advanced', 'B': 'Mid', 'C': 'Low'}
user_ct_level_map = {'Advanced': 'Advanced', 'Mid': 'Mid', 'Low': 'Low'}

# --- End Configuration ---

# --- Data Loading ---
occupational_profiles_df = None
try:
    print(f"Loading occupational profiles from: {profiles_input_path}")
    occupational_profiles_df = pd.read_csv(profiles_input_path)
    # Convert SOC code to string and clean potential '.0' suffix
    if 'O*NET-SOC Code' in occupational_profiles_df.columns:
         occupational_profiles_df['O*NET-SOC Code'] = occupational_profiles_df['O*NET-SOC Code'].astype(str).str.replace(r'\.0$', '', regex=True)
         # Set SOC code as index for easier lookup later
         occupational_profiles_df.set_index('O*NET-SOC Code', inplace=True)
    else:
         raise KeyError("Missing 'O*NET-SOC Code' column in profiles file.")
    print(f"Loaded {len(occupational_profiles_df)} occupational profiles.")

    # Ensure required columns exist
    required_cols = [
        'risacLetters', 'ProblemSolving_ReqLevel', 'CriticalThinking_ReqLevel',
        'BigFive_Openness_Proxy100', 'BigFive_Conscientiousness_Proxy100',
        'BigFive_Extraversion_Proxy100', 'BigFive_Agreeableness_Proxy100',
        'BigFive_EmotionalStability_Proxy100'
    ]
    missing_cols = [col for col in required_cols if col not in occupational_profiles_df.columns]
    if missing_cols:
        raise ValueError(f"Missing required columns in occupational profiles file: {missing_cols}")

    # Ensure categorical levels are strings
    occupational_profiles_df['ProblemSolving_ReqLevel'] = occupational_profiles_df['ProblemSolving_ReqLevel'].astype(str)
    occupational_profiles_df['CriticalThinking_ReqLevel'] = occupational_profiles_df['CriticalThinking_ReqLevel'].astype(str)

except FileNotFoundError:
    print(f"ERROR: Could not find the occupational profiles file: {profiles_input_path}")
    print("Please ensure the previous processing scripts ran successfully.")
    exit()
except (KeyError, ValueError) as e:
     print(f"ERROR processing occupational profiles: {e}")
     exit()
except Exception as e:
    print(f"An unexpected error occurred loading profiles: {e}")
    exit()

# --- Helper Functions ---

def calculate_riasec_score(user_riasec_code, occupation_riasec_code):
    """Calculates a simple RIASEC match score (0 to 1)."""
    if not user_riasec_code or not isinstance(occupation_riasec_code, str):
        return 0.0
    if user_riasec_code == occupation_riasec_code:
        return 1.0 # Exact match
    elif user_riasec_code[0] == occupation_riasec_code[0]:
        return 0.6 # Primary match
    elif len(user_riasec_code) > 1 and len(occupation_riasec_code) > 1 and \
         user_riasec_code[1] == occupation_riasec_code[1]:
         return 0.3 # Secondary match only
    elif user_riasec_code[0] in occupation_riasec_code or \
         (len(user_riasec_code) > 1 and user_riasec_code[1] in occupation_riasec_code):
         return 0.1 # One of the letters exists somewhere
    else:
        return 0.0

def calculate_skill_match_score(user_level_mapped, required_level, score_map):
    """Calculates match score based on categorical skill levels."""
    return score_map.get((user_level_mapped, required_level), 0.0) # Default to 0 if combo not in map

def calculate_big_five_similarity(user_bf_vector, occupation_bf_vector):
    """Calculates cosine similarity between user and occupation Big Five vectors."""
    if user_bf_vector is None or occupation_bf_vector is None:
        return 0.0
    # Reshape for cosine_similarity function (expects 2D arrays)
    user_vec = np.array(user_bf_vector).reshape(1, -1)
    occ_vec = np.array(occupation_bf_vector).reshape(1, -1)
    similarity = cosine_similarity(user_vec, occ_vec)[0][0]
    # Cosine similarity is -1 to 1. Scale it to 0 to 1 for easier combination.
    return (similarity + 1) / 2

# --- Main Recommendation Function ---

def get_recommendations(user_profile, profiles_df):
    """
    Generates ranked occupational recommendations based on user profile.

    Args:
        user_profile (dict): Dictionary containing user test results
                             (keys like 'RIASEC', 'Big_Five_O', 'Problem_Solving_Level', etc.).
        profiles_df (pd.DataFrame): DataFrame of processed occupational profiles.

    Returns:
        pd.DataFrame: DataFrame of occupations ranked by suitability score,
                      including individual component scores.
    """
    if profiles_df is None or profiles_df.empty:
        print("Error: Occupational profiles are not loaded.")
        return pd.DataFrame()

    results = []

    # Prepare user Big Five vector (ensure order matches profile columns)
    try:
        user_bf_vector = [
            user_profile['Big_Five_O'], user_profile['Big_Five_C'],
            user_profile['Big_Five_E'], user_profile['Big_Five_A'],
            # Use Emotional Stability proxy (inverse of Neuroticism if needed)
            # Assuming user profile gives Neuroticism, we might invert: 100 - N
            # Or if it gives Emotional Stability directly, use that.
            # For now, assume the user_profile key matches the desired trait directly:
            user_profile['Big_Five_N'] # Or use a calculated Emotional Stability score
        ]
        # Map user proficiency levels using the defined maps
        user_ps_level_mapped = user_ps_level_map.get(user_profile.get('Problem_Solving_Level'), 'Low')
        user_ct_level_mapped = user_ct_level_map.get(user_profile.get('Critical_Thinking_Level'), 'Low')

    except KeyError as e:
        print(f"Error: Missing key in user_profile: {e}")
        return pd.DataFrame()

    print("Calculating scores for each occupation...")
    # Iterate through each occupation in the pre-loaded DataFrame
    for soc_code, occupation_data in profiles_df.iterrows():
        # 1. Calculate RIASEC Score
        riasec_score = calculate_riasec_score(user_profile.get('RIASEC'), occupation_data['risacLetters'])

        # 2. Calculate Skills Score (Average of PS and CT matches)
        ps_match = calculate_skill_match_score(user_ps_level_mapped, occupation_data['ProblemSolving_ReqLevel'], skill_level_match_scores)
        ct_match = calculate_skill_match_score(user_ct_level_mapped, occupation_data['CriticalThinking_ReqLevel'], skill_level_match_scores)
        skills_score = (ps_match + ct_match) / 2.0

        # 3. Calculate Big Five Score (Cosine Similarity)
        occupation_bf_vector = [
            occupation_data['BigFive_Openness_Proxy100'],
            occupation_data['BigFive_Conscientiousness_Proxy100'],
            occupation_data['BigFive_Extraversion_Proxy100'],
            occupation_data['BigFive_Agreeableness_Proxy100'],
            occupation_data['BigFive_EmotionalStability_Proxy100']
        ]
        big_five_score = calculate_big_five_similarity(user_bf_vector, occupation_bf_vector)

        # 4. Calculate Combined Score
        combined_score = (WEIGHT_RIASEC * riasec_score +
                          WEIGHT_SKILLS * skills_score +
                          WEIGHT_BIG_FIVE * big_five_score)

        results.append({
            'O*NET-SOC Code': soc_code,
            'RIASEC_Score': riasec_score,
            'Skills_Score': skills_score,
            'BigFive_Score': big_five_score,
            'Combined_Score': combined_score
        })

    # Create DataFrame from results and sort
    results_df = pd.DataFrame(results)
    results_df.sort_values(by='Combined_Score', ascending=False, inplace=True)
    print("Scoring and ranking complete.")

    # Add Occupation Title back for readability
    # Need to load the original Occupation Data file or ensure Title is in profiles_df
    try:
         # Quick load of just titles if needed (adjust path/format if needed)
         occ_data_path = os.path.join(onet_data_folder, 'Occupation Data.xlsx') # Or .txt with sep='\t'
         titles_df = pd.read_excel(occ_data_path)[['O*NET-SOC Code', 'Title']]
         # Clean SOC code
         titles_df['O*NET-SOC Code'] = titles_df['O*NET-SOC Code'].astype(str).str.replace(r'\.0$', '', regex=True)
         titles_df.set_index('O*NET-SOC Code', inplace=True)
         # Merge titles
         results_df = results_df.merge(titles_df, left_on='O*NET-SOC Code', right_index=True, how='left')
    except Exception as title_err:
         print(f"Warning: Could not merge occupation titles. {title_err}")
         results_df['Title'] = 'Title N/A' # Add placeholder


    return results_df

# --- Example Usage (Simulation) ---
if __name__ == "__main__":
    if occupational_profiles_df is not None:
        # Simulate a user profile based on your platform's output structure
        example_user_profile = {
            'RIASEC': "IS",  # Top 2 letters
            'Big_Five_O': 75.0, # Example percentage score
            'Big_Five_C': 85.0,
            'Big_Five_E': 60.0,
            'Big_Five_A': 70.0,
            'Big_Five_N': 25.0, # Low Neuroticism (implies High Emotional Stability)
            # We need the *Level* for skills matching based on current logic
            'Problem_Solving_Level': 'B', # Example level
            'Critical_Thinking_Level': 'Advanced' # Example level
            # We also have the scores if needed later:
            # 'Problem_Solving': 75.0,
            # 'Critical_Thinking': 85.0,
        }

        # Get recommendations
        recommendations = get_recommendations(example_user_profile, occupational_profiles_df)

        print("\n--- Top 10 Recommended Occupations ---")
        # Select and reorder columns for display
        display_cols = ['O*NET-SOC Code', 'Title', 'Combined_Score', 'RIASEC_Score', 'Skills_Score', 'BigFive_Score']
        print(recommendations[display_cols].head(10).to_string()) # Use to_string to see more columns
    else:
        print("Could not run example because occupational profiles failed to load.")

