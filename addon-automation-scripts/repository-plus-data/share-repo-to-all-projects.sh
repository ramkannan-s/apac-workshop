#! /bin/bash

### Get Arguments
repo_name_prefix="${3:?please provide the user pwd or token or API Key . ex - password}"
repo_name_suffix="${4:?please provide the user pwd or token or API Key . ex - password}"
JPD_URL="${1:?please enter JPD URL. ex - https://ramkannan.jfrog.io}"
JPD_AUTH_TOKEN="${2:?please provide the user pwd or token or API Key . ex - password}"

while IFS= read -r packagetype; do
    reponame="$repo_name_prefix-$packagetype-local-$repo_name_suffix"
    echo -e "SHARE repository - $reponame with ALL Projects"
    curl --location --request PUT "$JPD_URL/access/api/v1/projects/_/share/repositories/$reponame" --header "Authorization: Bearer $JPD_AUTH_TOKEN"
done < "repos-to-create.txt"


### sample cmd to run - ./share-repo-to-all-projects.sh https://ramkannan.jfrog.io ****
