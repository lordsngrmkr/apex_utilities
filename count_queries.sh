#!/bin/bash

function get_queries {
  grep SOQL_EXECUTE_BEGIN $1 | grep -io "select .*"
}

function get_lines_with_counts {
  echo "$1" |
  sort -u |
  while read line; do
    count="`echo "$1" | grep "$line" | wc -l`"
    echo "$count $line"
  done
}

function make_greppable {
  echo "$1" |
  cut -d ' ' -f2- |
  sed "s/\(IN\|=\)\s\+\((\)\?:tmpVar[0-9]\+/.*/g" |
  sed "s/:tmpVar[0-9]\+/.*/g" |
  sed "s/\s/\\\s\\\+/g"
}

function main {
  queries="`get_queries $1`"
  echo "`get_lines_with_counts "$queries"`" | sort -r |
  while read line; do
    greppable_line="`make_greppable "$line"`"
    file="`grep -lir "$greppable_line" $2 $3 --exclude-dir=$2/.svn --exclude-dir=$3/.svn`"
    echo "$line"
    echo "$file" | sed "s/.*\///" | sed "s/^/  /"
  done
}

main $1 $2 $3
