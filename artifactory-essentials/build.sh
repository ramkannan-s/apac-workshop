#!/usr/bin/env bash

#curl -fL https://getcli.jfrog.io | sh
echo -n "Configuration name for CLI : "
read -r CLIName

echo -n "JFrog instance Name : "
read -r instancename

echo -n "JFrog instance username : "
read -r username

echo -n "JFrog instance password : "
read -r password

echo -n "Docker Virtual Repository name : "
read -r docker_virtual_repository_name

echo -n "Modifying  the Dockerfile with JFrog Instance name and docker repository provided"
sed -ie "s/SERVER_NAME/$instancename/g" Dockerfile
sed -ie "s/VIRTUAL_REPO_NAME/$docker_virtual_repository_name/g" Dockerfile

echo -n
##chmod +x JFrog

jf config add $CLIName --artifactory-url https://$instancename.jfrog.io/artifactory --user $username --password $password --interactive=false
jf config use $CLIName

echo -n "Build name : "
read -r buildname

echo -n "Build number : "
read -r buildnumber

#echo -n "Docker Image name: "
#read -r dockerimagename

#docker build --tag $instancename.jfrog.io/$docker_virtual_repository_name/$dockerimagename:$buildnumber .
docker build --tag $instancename.jfrog.io/$docker_virtual_repository_name/docker-example-build-image:$buildnumber .

#./jf rt docker-push $instancename.jfrog.io/$docker_virtual_repository_name/$dockerimagename:$buildnumber $docker_virtual_repository_name --build-name=$buildname --build-number=$buildnumber
jf rt docker-push $instancename.jfrog.io/$docker_virtual_repository_name/docker-example-build-image:$buildnumber $docker_virtual_repository_name --build-name=$buildname --build-number=$buildnumber

jf rt build-add-git $buildname $buildnumber
jf rt build-collect-env $buildname $buildnumber
jf rt build-publish $buildname $buildnumber