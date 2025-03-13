#!/bin/bash

# Set paths
WATCOM_PATH="/usr/bin/watcom"
SRC_DIR="./src"
BIN_DIR="./bin"
OBJ_DIR="./obj"
ERR_DIR="./err"

# Output executable name (change this as needed)
OUTPUT_EXE="program.exe"

# Ensure necessary directories exist
mkdir -p "$BIN_DIR" "$OBJ_DIR" "$ERR_DIR"

# Set up OpenWatcom environment
source "$WATCOM_PATH/owsetenv.sh"

# Print debugging info
echo "Using Watcom from: $WATCOM_PATH"
echo "Source directory: $SRC_DIR"
echo "Object directory: $OBJ_DIR"
echo "Binary output: $BIN_DIR/$OUTPUT_EXE"

# Find source files (both .c and .cpp)
SRC_FILES=$(ls "$SRC_DIR"/*.c "$SRC_DIR"/*.cpp 2>/dev/null)
if [ -z "$SRC_FILES" ]; then
    echo "No source files found!"
    exit 1
fi

echo "Source files found:"
echo "$SRC_FILES"

# Force correct target platform and include paths
export INCLUDE="$WATCOM_PATH/h"
export WATCOM_TARGET="DOS"

# Compile source files with explicit DOS target
wcl -bcl=dos -zq -I"$WATCOM_PATH/h" -fe="$BIN_DIR/$OUTPUT_EXE" -fo="$OBJ_DIR/" $SRC_FILES 2> "$ERR_DIR/build_errors.log"

# Check if compilation succeeded
if [ $? -eq 0 ]; then
    if [ -f "$BIN_DIR/$OUTPUT_EXE" ]; then
        echo "Compilation successful. Executable is located at $BIN_DIR/$OUTPUT_EXE"
        [ ! -s "$ERR_DIR/build_errors.log" ] && rm "$ERR_DIR/build_errors.log"
    else
        echo "Compilation reported success, but no executable was found!"
    fi
else
    echo "Compilation failed. Check $ERR_DIR/build_errors.log for details."
fi
