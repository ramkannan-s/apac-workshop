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
userCount="${2:?enter number of users to be created. ex - ramkannan}"
csvname="create-users-list.csv"

rm -rf "$csvname"
echo "No of Users that will be created = $userCount";
echo "\"username\",\"password\",\"email\"" >> $csvname;
for i in `seq 1 $userCount`;
do
	tempPass=$(openssl rand -base64 8);
	echo "\"apac-trail-user-"$i"\",\"$tempPass\",\"apacuser@testjfrog.com\"" >> $csvname;
done;
echo "" >> $csvname

### Run the curl API 
echo "updating readers groups.. "
jf rt curl -XGET "api/security/groups/readers" --server-id $SERVER_ID -s > users-readergroup.json
autoJoinValue=$(cat users-readergroup.json | jq .autoJoin)
if $autoJoinValue ; then
    echo -e "Update readers groups for auto-join.."
    cmd="cat users-readergroup.json | jq '.autoJoin = false' > users-readergroup-updated.json"
    eval "$cmd"
    jf rt curl -XPUT "api/security/groups/readers" -H "Content-Type: application/json" -d @users-readergroup-updated.json
else
    echo -e "No update for readers groups needed.."
fi

echo "creating users"
jf rt users-create --csv $csvname --server-id $SERVER_ID --replace

### sample cmd to run - ./createUsers.sh ramkannan 30