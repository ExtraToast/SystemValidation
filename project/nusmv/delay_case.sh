#!/bin/bash

# Navigate to /usr/src directory
cd /usr/src || {
  echo "Directory /usr/src does not exist. Exiting.";
  exit 1;
}

# Check if the .smv file exists
if [ ! -f "delay-case.smv" ]; then
  echo "Error: File 'delay-case.smv' not found in /usr/src"
  exit 1
fi

# Execute the NuSMV command
echo "Running NuSMV..."
NuSMV -pre cpp -ctt delay-case.smv

# Check the exit status of the NuSMV command
if [ $? -eq 0 ]; then
  echo "NuSMV executed successfully."
else
  echo "NuSMV encountered an error."
  exit 1
fi