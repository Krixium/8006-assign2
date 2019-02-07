#!/bin/bash

# Gets the directory containing this script
SCRIPT_DIR="$(dirname "$(readlink -f $0)")"
OUTPUT_DIR="$SCRIPT_DIR"/output
mkdir -p "$OUTPUT_DIR"

# Runs all of the tests and saves them to a file
for test in "$SCRIPT_DIR"/*.sh
do
    if [[ -f "$test" ]]
    then
		filename=${test##*/}
		base=${filename%.*}
		# We don't want to run this script recursively.
		[[ "$base" == "run_all" ]] && continue
        echo "Running $test..."
		(bash "$test" 2>&1 | tee "$OUTPUT_DIR"/"$base"_results.txt)
		echo "$base finished"
	fi
done

