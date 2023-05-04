#! /bin/bash

# JFrog hereby grants you a non-exclusive, non-transferable, non-distributable right 
# to use this  code   solely in connection with your use of a JFrog product or service. 
# This  code is provided 'as-is' and without any warranties or conditions, either 
# express or implied including, without limitation, any warranties or conditions of 
# title, non-infringement, merchantability or fitness for a particular cause. 
# Nothing herein shall convey to you any right or title in the code, other than 
# for the limited use right set forth herein. For the purposes hereof "you" shall
# mean you as an individual as well as the organization on behalf of which you
# are using the software and the JFrog product or service. 

### Exit the script on any failures
set -eo pipefail
set -e
set -u

### Get Arguments
SOURCE_JPD_URL="${1:?please enter JPD URL. ex - https://ramkannan.jfrog.io}"
JPD_AUTH_TOKEN="${2:?please provide identity token}"
projectCount="${3:?please enter the project count}"
item=1
projectnameprefix="${4:?please enter the project count}"
projectidprefix="${5:?please enter the project count}"
userprefix="${6:?please enter the project count}"

rm -rf project-*.json
rm -rf users-*.json

while [ $item -le $projectCount ]
do
    echo -e "Creating Project $item ...."
    project_template_cmd="cat projectTemplate.json | jq '.display_name = \"$projectnameprefix-$item\"' | jq '.project_key = \"$projectidprefix$item\"' > project-$item.json"
    eval "$project_template_cmd"
    curl -XPOST -H "Authorization: Bearer ${JPD_AUTH_TOKEN}" "$SOURCE_JPD_URL/access/api/v1/projects" -d @project-"$item".json -s -H 'Content-Type: application/json'
    echo -e ""
    echo -e "Adding user apac-trail-user-$item to $projectnameprefix-$item"
    user_template_cmd="cat projectUserAdd.json | jq '.name = \"$userprefix-trail-user-$item\"' > user-$item.json"
    eval "$user_template_cmd"
    curl -XPUT -H "Authorization: Bearer ${JPD_AUTH_TOKEN}" "$SOURCE_JPD_URL/access/api/v1/projects/$projectidprefix$item/users/apac-trail-user-$item" -d @user-$item.json -s -H 'Content-Type: application/json'
    ((item++))
done

### sample cmd to run - ./createProjectsUsers.sh https://ramkannan.jfrog.io **** 30
