# Photo Metadata and Format Fixer

This is a simple Bash script to help clean up and manage photo files in a directory. It allows you to:

- Batch update the ImageDescription EXIF tag on photos  
- Add a 5-star rating (-Rating=5) to photos  
- Automatically detect and fix misidentified image formats (e.g., PNG or HEIC files that are actually JPEGs) before running other operations

The script is ideal for use with digitized film scans or mixed-format image folders where some files are mislabeled.

---

## Requirements

Make sure the following tools are installed on your system:

1. ExifTool  
   Install with:  
   brew install exiftool

2. ImageMagick (you need the `magick` command)  
   Install with:  
   brew install imagemagick

3. A Bash-compatible terminal (macOS or Linux)

---

## How to Use

1. Download the script to your local machine

2. Make it executable:  
   chmod +x photo-fixer.sh

3. Run it in your terminal:  
   ./photo-fixer.sh

4. Follow the prompts:
   - Enter the path to the folder containing your photos
   - Choose an action:
     - 1 — Add or update the ImageDescription EXIF field
     - 2 — Add a 5-star rating
     - q — Quit

The script will first scan your folder for misidentified image formats (e.g., .HEIC or .PNG files that are actually JPEGs) and quietly convert them to .jpg files using ImageMagick before applying metadata changes.

---

## Example Workflow

If you have a folder of HEIC and PNG images from a scanner or phone that aren't being recognized properly:

1. Run the script
2. It will detect files like photo1.HEIC that are actually JPEGs
3. It will create photo1.jpg
4. Then it will apply your selected metadata operation to the fixed files

---

## Notes

- The original misidentified files are not deleted by default.  
  You can enable deletion by uncommenting the `rm "$file"` line in the script.
- The script does not modify files inside subfolders.  
  You can extend it to be recursive if needed.

---

## Author

Created by Evan Mann for organizing and cleaning digitized photo archives.

