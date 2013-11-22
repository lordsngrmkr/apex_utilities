#!/bin/bash

set -e

function verify_deletion {
	# check for git changes or no git repo
	echo "You are about to remove the following directories within `realpath "$1"`"
	find_dirs "$1/src"
	read -rp "Are you sure you want to proceed? (y/n) " response
	echo
	if [[ ! $response =~ ^[Yy]$ ]]; then
		exit 1
	fi
}

find_dirs() {
	find "$1" -type d -printf '%P\n' |
	sort -u |
	grep "^\w" # exclude hidden directories (i.e. .git, .svn...)
}

function delete_project_components {
	rm -rfv `find_dirs "$1" | xargs realpath | xargs`
}

function place_fake_class {
	fake_class_filepath="/home/nwallace/.vim/bundle/sfdc/A-ProjectTemplate/src/classes/A-Fake-Class.cls"
	mkdir "$1/classes" && cp $fake_class_filepath "$_"
}

function main {
	path="`realpath "$1"`"
	verify_deletion "$path"
	delete_project_components "$path/src"
	place_fake_class "$path/src"
}

main "$@"
