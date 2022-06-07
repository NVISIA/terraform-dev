#!/bin/bash

#### Input variables
## $1 The path of files to convert 
####

IN_FILES=$1/*.json

shopt -s nullglob
for f in $IN_FILES
do 
    echo "converting $f file.."
    ## Declare variables
    JSON_FILE="$f"
    YAML_FILE=${f/'.json'/'.yml'}

    ## Capture json file output as JSON_FILE_OUTPUT var
    JSON_FILE_OUTPUT=$(cat $JSON_FILE)

    ## Append <<variables:>> at the top of yaml file
    echo "variables:" > $YAML_FILE

    ## Append the json file output as yaml after 
    jq -r 'to_entries | map("  " + .key +": " + (.value | tostring)) | .[]' <<<"$JSON_FILE_OUTPUT" >> $YAML_FILE
done


