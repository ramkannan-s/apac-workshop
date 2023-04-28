#! /bin/bash

### Get Arguments
repo_name_template="cpe"
source_server_name="proservices"
target_server_name="${1:?please enter Server ID. ex - jf_lab_server}"

while IFS= read -r packagetype; do
    reponame="$repo_name_template-$packagetype-local-apac"
    echo -e "\n\n##### Performing for $reponame #####"
    mkdir $reponame
    cd $reponame/
    echo "Downloading $reponame from $source_server_name server..."
    jf rt dl "$reponame" --server-id=$source_server_name
    echo "Uploading $reponame to $target_server_name server..."
    jf rt u "*" "$reponame" --server-id=$target_server_name
    cd ..
    rm -rf $reponame
    echo -e "Completed $reponame ..."
done < "repos-to-create.txt"

### sample cmd to run - ./transfer-data-existing.sh jf_lab_server