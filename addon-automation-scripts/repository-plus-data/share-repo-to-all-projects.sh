#! /bin/bash

### Get Arguments
repo_name_template="cpe"
JPD_URL="${1:?please enter JPD URL. ex - https://ramkannan.jfrog.io}"
JPD_AUTH_TOKEN="${2:?please provide the user pwd or token or API Key . ex - password}"

while IFS= read -r packagetype; do
    reponame="$repo_name_template-$packagetype-local-apac"
    echo -e "SHARE repository - $reponame with ALL Projects"
    curl --location --request PUT "$JPD_URL/access/api/v1/projects/_/share/repositories/$reponame" --header "Authorization: Bearer $JPD_AUTH_TOKEN"
done < "repos-to-create.txt"
