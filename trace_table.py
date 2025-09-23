import re
import pandas as pd

# The trace text (replace with file read if needed)
with open("trace.txt") as f:
    trace_text = f.read()

# Variables we care about
variables = [
    "P1A_goal_curved",
    "P1A_goal_straight",
    "P2A_goal_curved",
    "P2A_goal_straight",

    "P1B_goal_curved",
    "P1B_goal_straight",
    "P2B_goal_curved",
    "P2B_goal_straight",

    "P1A_locked_curved",
    "P1A_locked_straight",
    "P2A_locked_curved",
    "P2A_locked_straight",

    "P1B_locked_curved",
    "P1B_locked_straight",
    "P2B_locked_straight",
    "P2B_locked_curved",

    "T1A_occupied"
    "T2A_occupied",
    "T3A_occupied",
    "T4A_occupied",

    "T1B_occupied",
    "T2B_occupied",
    "T3B_occupied",
    "T4B_occupied",

    "S1A_red",
    "S1A_green",
    "S2A_red",
    "S2A_green",
    "S3A_red",
    "S3A_green",
    "S4A_red",
    "S4A_green",

    "S1B_red",
    "S1B_green",
    "S2B_red",
    "S2B_green",
    "S3B_red",
    "S3B_green",
    "S4B_red",
    "S4B_green",
]

# Extract state blocks
state_blocks = re.split(r"-> State: \d+\.\d+ <-", trace_text)[1:]  # skip header
states = [i+1 for i in range(len(state_blocks))]

# Build table data
data = {var: [] for var in variables}

for block in state_blocks:
    for var in variables:
        match = re.search(rf"\b{var}\s*=\s*(TRUE|FALSE)", block)
        if match:
            data[var].append(match.group(1))
        else:
            # If not explicitly mentioned, assume it keeps previous value
            if data[var]:
                data[var].append(data[var][-1])
            else:
                # Default initial value from the user's list
                data[var].append("FALSE" if "red" not in var and "green" not in var else "FALSE")

# Convert to dataframe
df = pd.DataFrame(data)
df.to_csv("trace.csv")

