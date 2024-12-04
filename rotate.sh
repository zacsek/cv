#!/bin/bash

# Define the directory containing the files
dropbox="~/Dropbox/cv/"

# Function to handle file rotation with proper numbering
function rotate_file {
  local filename="$1"
  local target="$dropbox/$filename"

  # Check if file exists in dropbox
  if [[ -f "$target" ]]; then
    # Find the highest existing numbered version (e.g., Zoltan_Szocs_CV.de_3.pdf)
    local max_version=$(ls -v "$dropbox/$filename"_[0-9]*.pdf | tail -n 1 | sed -r 's/.*_([0-9]+)\.pdf/\1/')

    # If versions exist, increment the number (start at 1 if none)
    local new_version=$((max_version + 1))
  else
    local new_version=1
  fi

  # Rename the existing file with the new version
  mv -f "$target" "$dropbox/$filename.$new_version.pdf"
}

# Copy files from current directory to dropbox
cp -f "Zoltan_Szocs_CV.de.pdf" "$dropbox"
cp -f "Zoltan_Szocs_CV.en.pdf" "$dropbox"

# Rotate files in dropbox
rotate_file "Zoltan_Szocs_CV.de.pdf"
rotate_file "Zoltan_Szocs_CV.en.pdf"

# Limit the number of older versions (up to 5)
shopt -s nullglob  # Enable null globbing for safety

# Find all numbered versions of the files with specific pattern
files=(
  "$dropbox/Zoltan_Szocs_CV.de.[0-9]*.pdf"
  "$dropbox/Zoltan_Szocs_CV.en.[0-9]*.pdf"
)

# Loop through each file pattern
for pattern in "${files[@]}"; do
  # Get all files matching the pattern
  matched_files=( "$pattern" )

  # Check if there are more than 5 files
  if [[ ${#matched_files[@]} -gt 5 ]]; then
    # Delete the oldest file (based on filename sorting)
    rm -f "${matched_files[0]}"
  fi
done

shopt -u nullglob  # Disable null globbing
