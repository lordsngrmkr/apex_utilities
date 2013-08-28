#!/bin/bash

set -e

function verify_deletion {
	# check for git changes or no git repo
	echo "You are about to remove all apex components within `realpath "$1"`"
	read -rp "Are you sure you want to proceed? (y/n) " response
	echo
	if [[ ! $response =~ ^[Yy]$ ]]; then
		exit 1
	fi
}

function delete_project_components {
	rm -rf "$1"/classes "$1"/components "$1"/labels "$1"/pages "$1"/staticresources "$1"/triggers 
}

function place_fake_class {
	fake_class_filepath="/home/nwallace/.vim/bundle/sfdc/A-ProjectTemplate/src/classes/A-Fake-Class.cls"
	mkdir "$1/src/classes" && cp $fake_class_filepath "$_"
}

function main {
	verify_deletion "$1"
	delete_project_components "$1/src"
	place_fake_class "$1"
}

main "$@"
