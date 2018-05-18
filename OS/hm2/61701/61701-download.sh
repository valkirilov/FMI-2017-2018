#!/bin/bash

destination_directory=$""
source_url=$""
valid_input=true

read_input() {
    if [ -z "$1" ]; then
        valid_input=false
        echo "No argument supplied for destination directory"
    else
        destination_directory="$1"
    fi

    if [ -z "$2" ]; then
        valid_input=false
        echo "No argument supplied for source url"
    else
        source_url="$2"
    fi

    #echo $destination_directory
    #echo $source_url
}

download_competition() {
    if ! [ -x "$(command -v wget)" ]; then
        echo 'Error: wget is not installed.' >&2
        exit 1
    fi

    source_destination="$destination_directory/source"

    mkdir -p $destination_directory
    wget -O $source_destination $source_url

    # Parse the source file to download all logs
    if ! [ -x "$(command -v xmllint)" ]; then
        echo 'Error: xmllint is not installed.' >&2
        exit 1
    fi

    source_competition_names=$(echo "cat //html/body/table" |  xmllint --html --shell $source_destination | sed '/^\/ >/d' | sed 's/<[^>]*.//g' | xargs)
    #echo $source_competition_names

    for name in $source_competition_names; do
        #echo "$name"
        if [ "$name" != "Name" ]; then
            download_competitor_log $name
        fi
    done
}

download_competitor_log() {
    competitor_log_destination="$destination_directory/$1"
    competitor_source_url="$source_url/$1"

    wget -O $competitor_log_destination $competitor_source_url
}

read_input $1 $2

if [ "$valid_input" = true ]; then
    download_competition
fi