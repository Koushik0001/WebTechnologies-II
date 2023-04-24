#!/bin/bash

SOURCE_DIR="."
OUTPUT_DIR="../classes"
ROOT_DIR=$(pwd)

cd "../lib"
CLASS_FILES=""
for file in $(find custom -name '*.java'); do
    echo ""
    echo "Compiling $file"
    javac "$file"
    CLASS_FILES="$CLASS_FILES custom/$(basename "$file" .java).class"
done

echo $CLASS_FILES
jar cvf custom.jar $CLASS_FILES
cd "$ROOT_DIR"

if [ ! -d "$OUTPUT_DIR" ]; then
    echo ""
    mkdir "$OUTPUT_DIR"
    echo "$OUTPUT_DIR directory created successfully..."
    echo ""
fi

find "$SOURCE_DIR" -name '*.java' | while read file; do
    echo ""
    echo "Compiling $file"
    javac -cp "../../../../lib/*:../lib/*:." -d "$OUTPUT_DIR" "$file"
done

echo ""
echo ""
echo "Compilation complete."
echo ""
read -p "Press enter to continue."
