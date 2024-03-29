#!/bin/bash

echo -n "$1: "

output_tmpfile=$(mktemp tests/_$(basename ${1}).XXX.txt)

#openscad -o - --export-format echo --hardwarnings --check-parameters true --check-parameter-ranges false "$1" 2>&1 | sed -ze 's/\s*$//' > ${output_tmpfile}
# run whatever openscad is set to, specifying an 'echo' format and dumping the output of the script and anything sent to 
# STDERR to STDOUT. 
# From that, exclude lines that are '^include <$' and '^use <$' - developer build 2022.04.10 dumps these and no idea why
# Then, remove any trailing whitespace characters from the full output with a `sed -z`, so we can accurately get the 
# character count of a null-output run. 
openscad -o - --export-format echo --hardwarnings --check-parameters true --check-parameter-ranges false "$1" 2>&1 \
    | egrep -v "^(include|use) <" \
    | sed -ze 's/\s*$//' > ${output_tmpfile}

# capture openscad's exit status
_es=$?

# default this invocation of run-test.sh to failure 
stat=1

# default the match text flag to no-issue:
matchtextsuccess=0

if [ -n "${OPENSCAD_NOMATCH_TEXT}" -o -n "${OPENSCAD_MATCH_TEXT}" ]; then
    if [ -n "${OPENSCAD_NOMATCH_TEXT}" ]; then
        egrep -q ${OPENSCAD_NOMATCH_TEXT} ${output_tmpfile}
        if [ $? -eq 0 ]; then
            echo ">> NOMATCH text '${OPENSCAD_NOMATCH_TEXT}' found in output"
            matchtextsuccess=1
        fi
    fi

    if [ -n "${OPENSCAD_MATCH_TEXT}" ]; then
        egrep -q ${OPENSCAD_MATCH_TEXT} ${output_tmpfile}
        if [ $? -ne 0 ]; then
            echo ">> MATCH text '${OPENSCAD_MATCH_TEXT}' not found in output"
            matchtextsuccess=1
        fi
    fi
else
    if [ -s ${output_tmpfile} ]; then
        matchtextsuccess=1
    fi
fi
    
# now check the output: if openscad exited non-zero, or if 
# there's any output from the test run, consider that a failure.
# otherwise, assume success. 
if [ ${_es} -ne 0 -o ${matchtextsuccess} -ne 0 ]; then
    echo " FAIL: "
    echo ">> exit status: ${_es}"
    cat ${output_tmpfile}
else 
    echo " OK"
    stat=0
fi

rm ${output_tmpfile}
exit ${stat}

