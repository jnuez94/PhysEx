#!/bin/sh

# Regression testing script for MicroC
# Step through a list of files
#  Compile, run, and check the output of each expected-to-work test
#  Compile and check the error of each expected-to-fail test

# Path to the LLVM interpreter
LLI="lli"
#LLI="/usr/local/opt/llvm/bin/lli"

# Path to the PhysEx compiler.
PHYSEX="./physex.native"

# Time limit for all operations
ulimit -t 30

keep=0

SignalError() {
    if [ $error -eq 0 ] ; then
	echo "FAILED"
	error=1
    fi
    echo "  $1"
}

# Compare <outfile> <reffile> <difffile>
# Compares the outfile with reffile.  Differences, if any, written to difffile
Compare() {
    generatedfiles="$generatedfiles $3"
    echo diff -b $1 $2 ">" $3 1>&2
    diff -b "$1" "$2" > "$3" 2>&1 || {
    	SignalError "$1 differs"
    	echo "FAILED $1 differs from $2" 1>&2
    }
}

# Run <args>
# Report the command, run it, and report any errors
Run() {
    echo $* 1>&2
    eval $*
}

Check() {
    error=0
    basename=`echo $1 | sed 's/.*\\///
                             s/.x//'`
    reffile=`echo $1 | sed 's/.x$//'`
    basedir="`echo $1 | sed 's/\/[^\/]*$//'`/."

    echo -n "$basename..."

    echo 1>&2
    echo "###### Testing $basename" 1>&2

    generatedfiles=""

    generatedfiles="$generatedfiles ${basename}.ll ${basename}.out" &&
    Run "($PHYSEX" "<" $1 ") >" "${basename}.ll" &&
    Run "$LLI" "${basename}.ll" ">" "${basename}.out" &&
    Compare ${basename}.out ${reffile}.out ${basename}.diff

    # Report the status and clean up the generated files

    if [ $error -eq 0 ] ; then
    	if [ $keep -eq 0 ] ; then
    	    rm -f $generatedfiles
    	fi
    	echo "OK"
    	echo "###### SUCCESS" 1>&2
        else
    	echo "###### FAILED" 1>&2
    	globalerror=$error
    fi
}


# Fetch test file names
if [ $# -ge 1 ]
then
    files=$@
else
    files="tests/test-*.x"
fi

# Run test cases
for file in $files
do
    case $file in
	*test-*)
	    Check $file 2
	    ;;
	*fail-*)
	    CheckFail $file 2
	    ;;
	*)
	    echo "unknown file type $file"
	    ;;
    esac
done
