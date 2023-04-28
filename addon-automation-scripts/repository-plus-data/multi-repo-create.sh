#! /bin/bash

### Get Arguments
SERVER_ID="${1:?please enter Server ID. ex - jf_lab_server}"
repo_name_prefix="cpe"
repo_name_suffix="apac"
desc="repository created.. "

jf c use "${SERVER_ID}"

while IFS= read -r packagetype; do
    repo_key="$repo_name_prefix-$packagetype-local-$repo_name_suffix"
    description="$packagetype $desc"
    replace_cmd="jq '.key = \"$repo_key\" | .packageType = \"$packagetype\" | .description = \"$description\"' repo-create-template.json"
    eval "$replace_cmd" > repo-update-template.json
    jf rt repo-delete $repo_key --quiet
    jf rt repo-create repo-update-template.json
done < "repos-to-create.txt"

### sample cmd to run - ./multi-repo-create.sh jf_lab_server