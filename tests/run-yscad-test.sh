#!/bin/bash

. $1

SCAD_tmpfile=$(mktemp tests/_$(basename ${1}).XXX)

echo "${SCAD}" > ${SCAD_tmpfile}

OPENSCAD_MATCH_TEXT=${MATCH_TEXT} OPENSCAD_NOMATCH_TEXT=${NOMATCH_TEXT} tests/run-test.sh ${SCAD_tmpfile}
_es=$?

rm ${SCAD_tmpfile}

exit ${_es}

