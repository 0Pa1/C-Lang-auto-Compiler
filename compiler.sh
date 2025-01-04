#!/bin/bash

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m'

# Function to display the help message
show_help() {
    echo -e "\n${CYAN}=========================================${NC}"
    echo -e "${CYAN}  C Compiler Script - Usage Instructions${NC}"
    echo -e "${CYAN}=========================================${NC}"
    echo "Usage: $0 <source_file.c> [library_flags]"
    echo
    echo "This script compiles a C source file and saves the compiled output in the 'compiled_files' directory."
    echo
    echo "Arguments:"
    echo -e "  <source_file.c>    Path to the C source file (must end with .c)"
    echo -e "  [library_flags]    Optional space-separated list of library flags to link with (e.g., '-lm -pthread')"
    echo
    echo "Examples:"
    echo -e "  # Compile 'hello.c' without extra libraries"
    echo -e "  $0 hello.c"
    echo -e "  # Compile 'hello.c' with the math library"
    echo -e "  $0 hello.c '-lm'"
    echo -e "  # Compile with both math and pthread libraries"
    echo -e "  $0 hello.c '-lm -pthread'"
    echo
    echo "Common Library Flags:"
    echo -e "  -lm        Link with the math library"
    echo -e "  -pthread   Link with the pthread library"
    echo -e "  -lssl      Link with the OpenSSL library (useful for SSL programs)"
    echo -e "  -lz        Link with the zlib library"
    echo
    exit 0
}

# show the help message
if [[ "$1" == "--help" ]]; then
    show_help
fi

# Loop to ensure a valid .c file is provided
while true; do
    # If source file isn't provided as argument, prompt the user
    if [ -z "$1" ]; then
        echo -e "${RED}\nError: No source file provided.${NC}"
        echo "Please provide a C source file (e.g., hello.c)."
        read -p "Enter the source file: " source_file
    else
        source_file="$1"
    fi

    # Check if the source file exists
    if [ ! -f "$source_file" ]; then
        echo -e "${RED}\nError: File '$source_file' not found!${NC}"
        echo "Please ensure the file exists."
        read -p "Enter the source file: " source_file
        continue
    fi

    # Extract filename and extension
    filename=$(basename -- "$source_file")
    extension="${filename##*.}"

    # Validate if the file is a .c file
    if [ "$extension" != "c" ]; then
        echo -e "${RED}\nError: '$source_file' is not a C file!${NC}"
        read -p "Please enter a valid C file (e.g., hello.c): " source_file
    else
        break
    fi
done

# Define the output folder and ensure it exists
output_folder="compiled_files"
mkdir -p "$output_folder"

# Check if the output folder is writable
if [ ! -w "$output_folder" ]; then
    echo -e "${RED}\nError: The 'compiled_files' directory is not writable!${NC}"
    exit 1
fi

# Define the compiled output file name (without the .c extension)
output_file="$output_folder/${filename%.*}"

# Optional: Get library flags (if any)
lib_flags="$2"

# ask the user if no library flags were passed
if [ -z "$lib_flags" ]; then
    echo -e "\n${BLUE}No library flags provided. You can choose from the following:${NC}\n"
    echo -e " ${MAGENTA}1.${NC} ${CYAN}-lm${NC} (math library)"
    echo -e " ${MAGENTA}2.${NC} ${CYAN}-pthread${NC} (pthread library)"
    echo -e " ${MAGENTA}3.${NC} ${CYAN}-lssl${NC} (OpenSSL library)"
    echo -e " ${MAGENTA}4.${NC} ${CYAN}-lz${NC} (zlib library)"
    echo -e " ${MAGENTA}5.${NC} ${CYAN}None${NC}\n"
    read -p "Enter your choice (e.g.: 1, 2): " choice
    case $choice in
        1) lib_flags="-lm" ;;
        2) lib_flags="-pthread" ;;
        3) lib_flags="-lssl" ;;
        4) lib_flags="-lz" ;;
        5) lib_flags="" ;;
        *) echo -e "${RED}\nError: Invalid choice!${NC}" ;;
    esac
fi

# (1 for verbose, 0 for silent)
VERBOSE=0  # Set to 1 if you want verbose output

# If verbose mode is enabled, display the command being run
if [ $VERBOSE -eq 1 ]; then
    echo -e "\n${CYAN}Compiling with flags: gcc $source_file -o $output_file $lib_flags${NC}"
fi

# Compile the C file with optional library flags
gcc "$source_file" -o "$output_file" $lib_flags

# Check if the compilation was successful
if [ $? -eq 0 ]; then
    echo -e "\n${CYAN}Running the compiled program...${NC}"
    "./$output_file"

    # After compiling message 
    echo -e "\n${GREEN}Compilation successful! 🎉${NC}"
    echo -e "Output file saved to: ${CYAN}$output_file${NC}"
else
    echo -e "${RED}\nCompilation failed! ❌${NC}"
    echo "Please check for errors in the source file."
fi

