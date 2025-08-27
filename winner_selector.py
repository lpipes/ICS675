# --- Mini-Quiz Winner Selection Script ---

# Step 1: Import the necessary libraries
import pandas as pd
import random
import time

# --- Configuration ---
# Set the file path and the name of the sheet.
# Make sure your Excel file name and sheet name are correct.
file_path = '~/Downloads/Mini-Quiz 1 1.xlsx' 
sheet_name = 'Final Scores'
# --------------------


def announce_winner(path, sheet):
    """
    Loads scores from an Excel file, identifies eligible players,
    and announces a randomly selected winner in a presentation-friendly format.
    """
    try:
        # Read the specified sheet from the Excel file, skipping the two header rows.
        df = pd.read_excel(path, sheet_name=sheet, skiprows=2)

        # Filter for players who scored exactly 1 correct answer.
        eligible_players_df = df.loc[df['Correct Answers'] == 1]

        # Create the list of eligible players.
        player_list = eligible_players_df['Player'].tolist()

        # --- The Announcement ---
        
        # Check if there are any eligible players.
        if not player_list:
            print("Searching for a winner...")
            time.sleep(2) # Dramatic pause
            print("\nUnfortunately, no players were found with exactly 1 correct answer this time.")
            return

        # Start the presentation.
        print("Analyzing the final scores...")
        time.sleep(2) # Dramatic pause

        print(f"\nWe have {len(player_list)} players who are eligible for the prize draw!")
        print("The contenders are:")
        time.sleep(1)

        # Print each eligible player.
        for player in player_list:
            print(f"    - {player}")
            time.sleep(0.5) # Pause between each name

        print("\nSelecting a winner at random...")
        time.sleep(3) # The final, most dramatic pause!
        
        # Randomly select the winner.
        winner = random.choice(player_list)

        # Announce the final winner with a celebratory message.
        print("\n===============================================")
        print("🎉🎉🎉 CONGRATULATIONS TO OUR WINNER! 🎉🎉🎉")
        print(f"\n                  🏆 {winner} 🏆")
        print("\n===============================================")

    except FileNotFoundError:
        print(f"❌ ERROR: The file '{path}' was not found.")
        print("Please make sure the file is in the same directory as the notebook.")
    except Exception as e:
        # This will catch other errors, like a misspelled sheet name.
        print(f"An error occurred! Please check the file and sheet name.")
        print(f"Error details: {e}")

# --- Run the Announcement ---
announce_winner(file_path, sheet_name)
