import pandas as pd # For reading Excel files
import json
import os

def merge_titles_to_json_from_excel(excel_file_path, json_input_file_path, json_output_file_path, excel_sheet_name=0):
    """
    Reads O*NET-SOC codes and Titles from an Excel (.xlsx) file and merges the titles
    into a JSON file based on matching O*NET-SOC Codes.

    Args:
        excel_file_path (str): Path to the input Excel file.
        json_input_file_path (str): Path to the input JSON file.
        json_output_file_path (str): Path for the output JSON file with merged data.
        excel_sheet_name (str or int, optional): Name or index of the sheet to read from the Excel file.
                                                 Defaults to 0 (the first sheet).
    """
    titles_map = {}
    
    # Step 1: Read the Excel file and create a map of O*NET-SOC Code to Title
    try:
        # Read the specified sheet from the Excel file
        # Ensure all data, especially SOC codes, are read as strings to preserve formatting like ".00"
        df = pd.read_excel(excel_file_path, sheet_name=excel_sheet_name, dtype=str) 
        
        # Verify expected column names
        if "O*NET-SOC Code" not in df.columns or "Title" not in df.columns:
            print(f"Error: Excel file/sheet must contain 'O*NET-SOC Code' and 'Title' columns.")
            print(f"Found columns: {df.columns.tolist()}")
            return
            
        for index, row in df.iterrows():
            soc_code = row["O*NET-SOC Code"]
            title = row["Title"]
            # Ensure soc_code and title are not None, NaN, or empty strings before adding to map
            if pd.notna(soc_code) and str(soc_code).strip() and pd.notna(title) and str(title).strip():
                titles_map[str(soc_code).strip()] = str(title).strip() # Strip whitespace
            elif pd.notna(soc_code) and str(soc_code).strip() and (pd.isna(title) or not str(title).strip()):
                 print(f"Warning: Title is missing or empty in Excel for O*NET-SOC Code: '{str(soc_code).strip()}' at Excel row {index + 2}.") # +2 because header is row 1, data starts row 2

        print(f"Successfully read {len(titles_map)} titles from {excel_file_path} (Sheet: {excel_sheet_name})")
        if not titles_map:
            print("Warning: No titles were effectively read from the Excel file. Please check the Excel file content, sheet name, and column names ('O*NET-SOC Code', 'Title').")
            # return # Optionally exit if no titles are found
    except FileNotFoundError:
        print(f"Error: Excel file not found at {excel_file_path}")
        return
    except Exception as e:
        print(f"Error reading Excel file '{excel_file_path}': {e}")
        return

    # Step 2: Read the existing JSON data
    try:
        with open(json_input_file_path, mode='r', encoding='utf-8') as jsonfile:
            json_data = json.load(jsonfile)
        print(f"Successfully loaded {len(json_data)} records from {json_input_file_path}")
    except FileNotFoundError:
        print(f"Error: JSON input file not found at {json_input_file_path}")
        return
    except json.JSONDecodeError as e:
        print(f"Error: Could not decode JSON from {json_input_file_path}. Details: {e}")
        return
    except Exception as e:
        print(f"Error reading JSON input file '{json_input_file_path}': {e}")
        return

    if not isinstance(json_data, list):
        print(f"Error: Expected JSON data to be a list of objects, but got type: {type(json_data)}")
        return

    # Step 3: Merge the titles into the JSON data
    updated_json_data = []
    titles_added_count = 0
    titles_not_found_count = 0
    
    for record_index, record in enumerate(json_data):
        if not isinstance(record, dict):
            print(f"Warning: Skipping non-dictionary item in JSON data at index {record_index}: {record}")
            updated_json_data.append(record) 
            continue

        soc_code_from_json = record.get("O*NET-SOC Code")
        
        # Ensure the "Title" field exists in the record, even if it remains empty
        if "Title" not in record:
            record["Title"] = "" 

        if soc_code_from_json:
            soc_code_from_json_stripped = str(soc_code_from_json).strip() # Ensure it's a string and stripped
            if soc_code_from_json_stripped in titles_map:
                record["Title"] = titles_map[soc_code_from_json_stripped]
                titles_added_count += 1
            else:
                print(f"Warning: Title not found in Excel for O*NET-SOC Code: '{soc_code_from_json_stripped}' from JSON record {record_index + 1}. Keeping existing or empty title.")
                titles_not_found_count += 1
        else:
            print(f"Warning: Record missing 'O*NET-SOC Code' in JSON at index {record_index + 1}: {record}")
        
        updated_json_data.append(record)

    print(f"Titles added/updated for {titles_added_count} records.")
    if titles_not_found_count > 0:
        print(f"Titles were not found in Excel for {titles_not_found_count} records present in the JSON.")

    # Step 4: Write the updated data to a new JSON file
    try:
        with open(json_output_file_path, mode='w', encoding='utf-8') as jsonfile:
            json.dump(updated_json_data, jsonfile, indent=4) 
        print(f"Successfully wrote updated JSON data to {json_output_file_path}")
    except Exception as e:
        print(f"Error writing JSON output file '{json_output_file_path}': {e}")

if __name__ == "__main__":
    # --- Configuration ---
    # Using absolute paths with raw strings (r"...") for Windows.
    # Ensure these paths exactly match your file system.
    
    excel_file_path_abs = r"C:\Users\Harak\OneDrive\Desktop\mentora-repo\Graduation-project\onet_processing\onet_data\Occupation Data.xlsx"
    json_input_file_path_abs = r"C:\Users\Harak\OneDrive\Desktop\mentora-repo\Graduation-project\project2\mentora\Assets\data\occupational_profiles_final.json"
    json_output_file_path_abs = r"C:\Users\Harak\OneDrive\Desktop\mentora-repo\Graduation-project\project2\mentora\Assets\data\occupational_profiles_final_with_titles.json"

    # Optional: If your data is not on the first sheet of the Excel file, specify the sheet name or index.
    # For example, if your sheet is named "MySheet": excel_sheet_name_param = "MySheet" 
    excel_sheet_name_param = 0 # Default to the first sheet (index 0)
    # --- End Configuration ---

    print("Starting script...")
    print(f"Excel input: {excel_file_path_abs}")
    print(f"JSON input: {json_input_file_path_abs}")
    print(f"JSON output: {json_output_file_path_abs}")

    if not os.path.exists(excel_file_path_abs):
        print(f"FATAL ERROR: Excel file does not exist at the specified path: {excel_file_path_abs}")
    elif not os.path.exists(json_input_file_path_abs):
        print(f"FATAL ERROR: JSON input file does not exist at the specified path: {json_input_file_path_abs}")
    else:
        merge_titles_to_json_from_excel(excel_file_path_abs, json_input_file_path_abs, json_output_file_path_abs, excel_sheet_name=excel_sheet_name_param)
    print("Script finished.")
