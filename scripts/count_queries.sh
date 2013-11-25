#!/bin/bash

get_queries() {
  grep SOQL_EXECUTE_BEGIN $1 | grep -io "select .*"
}

get_lines_with_counts() {
  echo "$1" |
  sort -u |
  while read line; do
    count="`echo "$1" | grep "$line" | wc -l`"
    echo "$count $line"
  done
}

make_greppable() {
  echo "$1" |
  cut -d ' ' -f2- |
  sed "s/\(IN\|=\)\s\+\((\)\?:tmpVar[0-9]\+/.*/g" |
  sed "s/:tmpVar[0-9]\+/.*/g" |
  sed "s/\s/\\\s\\\+/g"
}

main() {
  queries="`get_queries $1`"
  echo "`get_lines_with_counts "$queries"`" | sort -r |
  while read line; do
    greppable_line="`make_greppable "$line"`"
    file="`grep -lir "$greppable_line" $2/classes $2/triggers --exclude-dir=$2/classes/.svn --exclude-dir=$2/triggers/.svn`"
    echo "$line"
    echo "$file" | sed "s/.*\///" | sed "s/^/  /"
  done
}

main $1 $2
