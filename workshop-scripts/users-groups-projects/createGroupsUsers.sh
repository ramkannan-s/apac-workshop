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
SERVER_ID="${1:?please enter Server ID. ex - ramkannan}"

### define variables
groupsname="apac-workshop-admin"
groupdesc="Admin Privileges for users"
SERVER_ID="${1:?please enter Server ID. ex - ramkannan}"
option="${2:?please provide option eg: createadmingroup | addusers | deletegroup}"
projectCount=30
item=1

### Run the curl API 
if [ "$option" == "admingroup" ]; then
    echo "Creating Admin Group"
    cmd="jf rt curl -X PUT \"api/security/groups/$groupsname\" -H \"Content-Type: application/json\" -d '{\"description\": \"$groupdesc\",\"adminPrivileges\": true}'"
    eval "$cmd"
fi

if [ "$option" == "addusers" ]; then
    while [ $item -le $projectCount ]
    do
        echo "Add user - apac-trail-user-$item to group"
        jf rt group-add-users $groupsname "apac-trail-user-$item" --server-id=$SERVER_ID
        ((item++))
    done
fi

if [ "$option" == "deletegroup" ]; then
    echo "Deleting Admin Group"
    jfrog rt group-delete $groupsname --quiet
fi


### sample cmd to run - ./createGroupsUsers.sh ramkannan option