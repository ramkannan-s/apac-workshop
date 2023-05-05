#!/bin/bash
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

#Getting arguments
SERVER_ID=$(jq '.SERVER_ID' secret/values.json| sed 's/\"//g')
userProjectCount=$(jq '.userCount' secret/values.json | sed 's/\"//g')
SOURCE_JPD_URL=$(jq '.SOURCE_JPD_URL' secret/values.json| sed 's/\"//g')
JPD_AUTH_TOKEN=$(jq '.JPD_AUTH_TOKEN' secret/values.json| sed 's/\"//g')
PRO_AUTH_TOKEN=$(jq '.PRO_AUTH_TOKEN' secret/values.json| sed 's/\"//g')
projectnameprefix=$(jq '.projectnameprefix' secret/values.json| sed 's/\"//g')
projectidprefix=$(jq '.projectidprefix' secret/values.json| sed 's/\"//g')
userprefix=$(jq '.userprefix' secret/values.json| sed 's/\"//g')
repo_name_prefix=$(jq '.repo_name_prefix' secret/values.json| sed 's/\"//g')
repo_name_suffix=$(jq '.repo_name_suffix' secret/values.json| sed 's/\"//g')
desc=$(jq '.desc' secret/values.json| sed 's/\"//g')
boolCheck=$(jq '.use_transfer_data_bool' secret/values.json| sed 's/\"//g')
source_server_name=$(jq '.source_server_name' secret/values.json| sed 's/\"//g')
repo_name_template=$(jq '.repo_name_template' secret/values.json| sed 's/\"//g')

#Connect to jf_lab_server
jf c rm jf_lab_server --quiet
jf c add jf_lab_server --url "$SOURCE_JPD_URL" --user="svc_jfrog_user" --access-token="$JPD_AUTH_TOKEN" --interactive=false
jf c use jf_lab_server

cd users-groups-projects
echo "Executing createUsers.sh"

chmod +x *
./createUsers.sh $SERVER_ID $userProjectCount
echo "Executed createUsers.sh"
echo
echo "Executing createProjectsUsers"

./createProjectsUsers.sh $SOURCE_JPD_URL $JPD_AUTH_TOKEN $userProjectCount $projectnameprefix $projectidprefix $userprefix
rm -rf project-*.json
rm -rf user-*.json
echo "Executed createProjectsUsers"
echo
cd ../repository-plus-data
chmod +x *
echo "Executing multi-repo-create.sh"
./multi-repo-create.sh $SERVER_ID $repo_name_prefix $repo_name_suffix $desc
echo "Executed multi-repo-create.sh"
echo

echo "Executing share-repo-to-all-projects.sh"
./share-repo-to-all-projects.sh $SOURCE_JPD_URL $JPD_AUTH_TOKEN $repo_name_prefix $repo_name_suffix
echo " Executed share-repo-to-all-projects.sh"

if [ $boolCheck = "True" || $boolCheck = "true" ]; then
	jf c rm proservices --quiet
	jf c add proservices --url "https://proservices.jfrog.io/" --user="svc_jfrog_user" --access-token="$PRO_AUTH_TOKEN" --interactive=false
	echo "Executing transer-data-existing.sh"
	./transfer-data-existing.sh $SERVER_ID 
	echo "Executed transfer-data-existing.sh"
	echo;
fi

echo "Done!"
