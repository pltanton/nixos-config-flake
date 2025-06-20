#!/bin/bash

# Check if input CSV file is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <input.csv>"
    echo "CSV format should be: video_url,audio_url"
    exit 1
fi

INPUT_CSV="$1"

# Check if the CSV file exists
if [ ! -f "$INPUT_CSV" ]; then
    echo "Error: CSV file '$INPUT_CSV' not found!"
    exit 1
fi

# Check required commands
for cmd in wget ffmpeg; do
    if ! command -v $cmd &> /dev/null; then
        echo "Error: Required command '$cmd' is not installed."
        exit 1
    fi
done

# Create a temporary directory for downloads
TEMP_DIR="./downloads_temp"
mkdir -p "$TEMP_DIR"

# Initialize line counter
line_number=0

# Read the CSV file line by line
while IFS= read -r line || [ -n "$line" ]; do
    ((line_number++))
    
    # Skip empty lines
    if [ -z "$line" ]; then
        echo "Line $line_number: Empty line, skipping..."
        continue
    fi
    
    # Split the line into video_url and audio_url
    # Handle both comma and tab separators
    video_url=$(echo "$line" | awk -F'[,\t]' '{print $1}')
    audio_url=$(echo "$line" | awk -F'[,\t]' '{print $2}')
    
    # Trim whitespace and quotes
    video_url=$(echo "$video_url" | sed 's/^[[:space:]"'"'"']*//;s/[[:space:]"'"'"']*$//')
    audio_url=$(echo "$audio_url" | sed 's/^[[:space:]"'"'"']*//;s/[[:space:]"'"'"']*$//')
    
    # Validate URLs
    if [ -z "$video_url" ] || [ -z "$audio_url" ]; then
        echo "Line $line_number: Invalid format - missing video or audio URL"
        echo "Line content: $line"
        continue
    fi
    
    echo "Processing line $line_number:"
    echo "Video URL: $video_url"
    echo "Audio URL: $audio_url"
    
    # Generate unique filenames
    timestamp=$(date +%Y%m%d_%H%M%S)
    video_file="$TEMP_DIR/video_${timestamp}_$(basename "$video_url")"
    audio_file="$TEMP_DIR/audio_${timestamp}_$(basename "$audio_url")"
    output_file="output_${timestamp}_$(basename "$video_url")"
    
    # Download video file
    echo "Downloading video..."
    if ! wget -q --show-progress -O "$video_file" "$video_url"; then
        echo "Error downloading video from $video_url"
        continue
    fi
    
    # Download audio file
    echo "Downloading audio..."
    if ! wget -q --show-progress -O "$audio_file" "$audio_url"; then
        echo "Error downloading audio from $audio_url"
        rm -f "$video_file"  # Clean up video file
        continue
    fi
    
    # Check if files were actually downloaded
    if [ ! -s "$video_file" ] || [ ! -s "$audio_file" ]; then
        echo "Error: Downloaded files are empty"
        rm -f "$video_file" "$audio_file"
        continue
    fi
    
    # Merge video and audio using ffmpeg
    echo "Merging video and audio into $output_file..."
    if ffmpeg -i "$video_file" -i "$audio_file" -c:v copy -c:a aac "$output_file" -y 2>/dev/null; then
        echo "Successfully created: $output_file"
    else
        echo "Error merging files for $output_file"
        echo "FFmpeg command failed. Trying to print error message:"
        ffmpeg -i "$video_file" -i "$audio_file" -c:v copy -c:a aac "$output_file" -y
    fi
    
    # Clean up temporary files
    rm -f "$video_file" "$audio_file"
    echo "----------------------------------------"
    
done < <(tr -d '\r' < "$INPUT_CSV")

# Remove temporary directory
rm -rf "$TEMP_DIR"

echo "Processing complete! Processed $line_number lines."