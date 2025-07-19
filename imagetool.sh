#!/bin/bash

# Function to fix misidentified image formats
fix_misidentified_formats() {
    echo "Checking for misidentified formats in $folder_path..."
    shopt -s nullglob
    for file in "$folder_path"/*.{HEIC,PNG}; do
        [ -f "$file" ] || continue
        file_type=$(file --mime-type -b "$file")
        if [[ "$file_type" == "image/jpeg" ]]; then
            new_file="${file%.*}.jpg"
            magick "$file" "$new_file"
            echo "Fixed: $file → $new_file"
            # Uncomment below to delete original
            # rm "$file"
        fi
    done
    shopt -u nullglob
    echo "Format check complete."
}

# Prompt for the directory
echo -n "Enter the path to the folder with your images: "
read folder_path

if [ ! -d "$folder_path" ]; then
    echo "Invalid directory. Exiting."
    exit 1
fi

# Check for dependencies
if ! command -v magick &> /dev/null; then
    echo "ImageMagick is required. Install it with: brew install imagemagick"
    exit 1
fi

if ! command -v exiftool &> /dev/null; then
    echo "ExifTool is required. Install it with: brew install exiftool"
    exit 1
fi

# Main menu loop
while true; do
    echo ""
    echo "Choose an option:"
    echo "1. Update 'ImageDescription' on multiple photos"
    echo "2. Add 5 stars to multiple photos"
    echo "q. Quit"
    echo -n "Enter your choice: "
    read choice

    case "$choice" in
        1)
            fix_misidentified_formats
            echo -n "Enter the new description: "
            read description
            exiftool -overwrite_original -r -ImageDescription="$description" "$folder_path"
            echo "Descriptions updated."
            ;;
        2)
            fix_misidentified_formats
            exiftool -overwrite_original -Rating=5 -r "$folder_path"
            echo "5-star rating added."
            ;;
        q)
            echo "Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac
done
