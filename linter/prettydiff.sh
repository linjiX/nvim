#!/bin/bash

set -e

TMPFILE="/tmp/prettydiff_tmp.xml"

cat - >"$TMPFILE"
prettydiff "$@" source:"$TMPFILE"

rm $TMPFILE
