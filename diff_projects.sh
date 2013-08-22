#!/bin/bash

function pretty_print {
  echo "$1:"
  echo "$2" |
  while read line; do
    if [[ $line ]]; then # skip blank lines
      if [[ $line =~ Files ]]; then
        print_from_differ "$line"
      elif [[ $line =~ Only ]]; then
        print_from_only "$line"
      else
        unk="$unk
  $line"
      fi
    fi
    if [[ $unk ]]; then
      echo "unknowns:
  $unk"
    fi
  done
}

function print_from_differ {
  echo "  `echo "$1" |
           cut -d '/' -f4 |
           cut -d ' ' -f1`"
}

function print_from_only {
  echo "  `echo "$1" |
           cut -d ' ' -f4` (only in `echo "$1" |
           cut -d ' ' -f3 |
           cut -d '/' -f1`)"
}

function main {
  dirs_a=( classes pages triggers components )
  for i in "${dirs_a[@]}"; do
    result=`diff -qbrx '*-meta.xml' "$1/src/$i" "$2/src/$i"`
    pretty_print "$i" "$result"
  done
}

main "$@" # pass all arguments
