#!/bin/bash

if [ -z "$1" ]; then
	echo -e "error: No compiler path given."
	echo -e "usage: ./test.sh [COMPILER]"
	echo -e "\nExample:"
	echo -e "    cd ~/testprogram"
	echo -e "    ./test.sh ~/compiler/vitaly"
	exit 1
fi

# Define colors
trs="\e[0m"		# Reset
twb="\e[1;37m"  # Bold white
trd="\e[0;31m"  # Red
tgr="\e[0;32m"  # Green
trdb="\e[1;31m"	# Bold red
tgrb="\e[1;32m"	# Bold green

VITALY="$1"
VITALY_ARGS="" # Arguments sent to vitaly compiler
TIMEOUT=1		# How long program is allowed to run (in seconds)

let success_failed=0      # Counts number of failed success tests
let success_count=0
let error_failed=0        # Counts number of failed compile tests
let error_count=0
let runtimeerror_failed=0 # Counts number of failed runtime tests
let runtimeerror_count=0

function testSuccess {
	for file in $1/*.vit; do
		let success_count++
		echo -e "$(basename $file): "
		if "$VITALY" "$VITALY_ARGS" < "$file" > /tmp/vitaly-program.s; then
			gcc /tmp/vitaly-program.s -o /tmp/vitaly-program
			outputfile=${file%.vit}".out"
			correct=$(cat $outputfile)
			output=$(timeout $TIMEOUT /tmp/vitaly-program)

			if [ "$output" == "$correct" ]; then
				echo -e "    ${tgrb}passed.${trs}"
			else
				echo -e "    ${trdb}failed!${trs}"
				let success_failed++
			fi
		else
			let success_failed++
			echo -e "    ${trdb}did not compile!${trs}"
		fi
	done
}

function testError {
	for file in $1/*.vit; do
		let error_count++
		filename="$(basename "$file")"
		echo -e "$(basename $file): "
		if "$VITALY" "$VITALY_ARGS" < "$file" > /dev/null; then
			echo -e "\t${trdb}failed!${trs}"
			let error_failed++
		else
			echo -e "\t${tgrb}passed!${trs}"
		fi
	done
}

function testRuntimeError {
	for file in $1/*.vit; do
		let runtimeerror_count++
		filename="$(basename "$file")"
		echo -e "$(basename $file): "
		if "$VITALY" "$VITALY_ARGS" < "$file" > /tmp/vitaly-program.s; then
			gcc /tmp/vitaly-program.s -o /tmp/vitaly-program
			if /tmp/vitaly-program > /dev/null; then
				echo -e "\t${trdb}failed!${trs}"
				let runtimeerror_failed++
			else
				echo -e "\t${tgrb}passed!${trs}"
			fi
		else
			let runtimeerror_failed++
			echo -e "\t${trdb}did not compile!${trs}"
		fi
	done
}

# Run tests
echo -e "${twb}## Success tests ##${trs}"
testSuccess ./tests/success

echo -e "\n${twb}## Compile error tests ##${trs}"
testError ./tests/error

echo -e "\n${twb}## Runtime error tests ##${trs}"
testRuntimeError ./tests/runtimeerror

# Print summary
echo -e "\n${twb}## Summary ##${trs}"
if [ "$success_failed" -eq "0" ]; then
	echo "Failed success tests: $success_failed/$success_count"
else
	echo -e "${trdb}Failed success tests: $success_failed/$success_count${trs}"
fi
if [ "$error_failed" -eq "0" ]; then
	echo "Failed compile error tests: $error_failed/$error_count"
else
	echo -e "${trdb}Failed compile error tests: $error_failed/$error_count${trs}"
fi
if [ "$runtimeerror_failed" -eq "0" ]; then
	echo "Failed runetime error tests: $runtimeerror_failed/$runtimeerror_count"
else
	echo -e "${trdb}Failed runetime error tests: $runtimeerror_failed/$runtimeerror_count${trs}"
fi
