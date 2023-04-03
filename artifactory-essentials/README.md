# Stage 1 - Artifactory Overview - UI navigation and access

## Prerequisites

- A SaaS Instance of JFrog. This will be the trail version enrolled (signed up) by participants for the Workshop.

- Docker Installed in your machine.

## Navigating Through the Platform

### Step1 - Login & Application Overview

- Login to your saas instance <yourinstancename>.jfrog.io with your admin credentials
- Click on 'Artifactory' and get familiar with the Packages, Builds and Artifacts views.

<img src="/artifactory-essentials/images/application.png" alt="Application tab" style="height: 100px; width:100px;"/>

### Step2 - Administration Overview

- Navigate to the Administration module and get familiar with the different options.

  <img src="/artifactory-essentials/images/admin.png" alt="Admin tab" style="height: 100px; width:100px;"/>




# Stage 2 - Creating repositories

## Creating Repositories

### Step1 - Local Repository - Docker

- Login to your saas instance <XXXXX>.jfrog.io with  your admin credentials
- Navigate to the Administration Module. Expand the Repositories menu and click on the Repositories menu item.
  <img src="/artifactory-essentials/images/repository.png" alt="Repositories tab" style="height: 100px; width:100px;"/>
  
- Add a new Local Repository with the Docker package type.
  <img src="/artifactory-essentials/images/choose-docker.png" alt="choose-docker-package tab" style="height: 100px; width:100px;"/>

- Enter the Repository Key “swampup-docker-dev-local” and keep the rest of the default settings.
  <img src="/artifactory-essentials/images/docker-dev-local.png" alt="mame the repo" style="height: 100px; width:100px;"/>

- Once done, Create another local repository with docker package type and name it as "swampup-docker-prod-local". Keep the rest of the default settings
  <img src="/artifactory-essentials/images/docker-prod-local.png" alt="mame the repo" style="height: 100px; width:100px;"/>


### Step2 - Remote Repository - Docker

-  Add a remote repository to cache docker images from docker hub or any other external registries
   <img src="/artifactory-essentials/images/remote-repo.png" alt="Remote repo" style="height: 100px; width:100px;"/>
   
-  Add a new Remote Repository with the Docker package type and name the repository as "swampup-docker-remote" and uncheck "Block pulling of image manifest v2 schema1".
   <img src="/artifactory-essentials/images/docker-remote.png" alt="mame the repo" style="height: 100px; width:100px;"/>
   <img src="/artifactory-essentials/images/block-pull.png" alt="unblock" style="height: 100px; width:100px;"/>

### Step3 - Virtual  Repository - Docker

-  Add a Virtual repository to work with a single URL from your docker client. Click on the Virtual tab on the Repositories page
   <img src="/artifactory-essentials/images/virtual-repo.png" alt="Virtual repo" style="height: 100px; width:100px;"/>
   
-   Add a new Virtual Repository with the Docker package type. Enter the Repository Key “swampup-docker” and add the local and remote docker repositories you created in Steps 2 and 3 (move them from Available Repositories to Selected Repositories using the arrow buttons). The order of these repositories in the list will determine the order used to resolve the dependencies required for building your docker image. Select your local repository(swampup-docker-dev-local) that you created in Step 2 as the Default Deployment Repository. The Default Deployment Repository is the repository that the docker image you build will be pushed to. Keep the rest of the default settings.
   <img src="/artifactory-essentials/images/docker-virtual.png" alt="mame the repo" style="height: 100px; width:100px;"/>
    
- After the docker virtual registry is created. It will provide you with the details on how to access this docker registry. Copy that information and keep it in locally on your laptop
  <img src="/artifactory-essentials/images/docker-command-display.png" alt="docker commands" style="height: 100px; width:100px;"/>

### Awesome !!! You have successfully completed Stage 2.




# Stage 3 - Working with Artifactory as your docker registry

## Step 1 - Update the dockerfile  

- Update the dockerfile present under lab4 section.Update the FROM line of the Dockerfile to reference your virtual Docker repository.
    - ```FROM ${SERVER_NAME}.jfrog.io/${VIRTUAL_REPO_NAME}/alpine:3.11.5```
      
    - The SERVER_NAME is the first part of the URL given to you for your environment: ```https://<SERVER_NAME>.jfrog.io.``` You can also get this information from the docker login command from Lab2
      <img src="/artifactory-essentials/images/docker-command.png" alt="docker commands" style="height: 100px; width:100px;"/>

    - The VIRTUAL_REPO_NAME is the name “swampup-docker” that you assigned to your virtual repository in Step 3 on Lab2.
    - After modifying your dockerfile should be something like below
      <img src="/artifactory-essentials/images/modified-dockerfiles.png" alt="dockerfile" style="height: 100px; width:100px;"/>
    
## Step 2 - Push custom image to your docker repository

- Login to your docker virtual repository. Replace the  SERVER_NAME and VIRTUAL_REPO_NAME as mentioned in Step2
    - ``` $docker login ${SERVER_NAME}.jfrog.io```
      
      <img src="/artifactory-essentials/images/login-docker.png" alt="docker login" style="height: 100px; width:100px;"/>
      
- Build your docker image. Replace the  SERVER_NAME and VIRTUAL_REPO_NAME as mentioned in Step2
    - ```$ docker build --tag ${SERVER_NAME}.jfrog.io/${VIRTUAL_REPO_NAME}/my-docker-image:latest . ```
      
      <img src="/artifactory-essentials/images/docker-builds.png" alt="docker build" style="height: 100px; width:100px;"/>
      
- Push the build docker image to your docker registry. Replace the  SERVER_NAME and VIRTUAL_REPO_NAME as mentioned in Step2
    - ``` $ docker push ${SERVER_NAME}.jfrog.io/${VIRTUAL_REPO_NAME}/my-docker-image:latest ```
      
      <img src="/artifactory-essentials/images/dockerpush.png" alt="docker push" style="height: 100px; width:100px;"/>

### Awesome !!! You have successfully completed Stage 3. Next lab we will help you to search and view the artifacts.




# Stage 4 - Leverage CLI to publish build to Artifactory

## Step 1 - Run the build.sh script
  
- Execute the ./build.sh script. 

- You will be prompted to enter some important details. We will discuss each one of these during the class and while implementing this lab 
* Detail about each input
  * Configuration name for CLI : The name used to reference your instance using Jfrog CLI on your local machine. e.g - "JPD" is the name which I am giving to access my Jfrog platform
    <img src="/artifactory-essentials/images/CLI-Config-name.png" alt="CLI Config" style="height: 100px; width:100px;"/>
  
  * Jfrog instance name : The SERVER_NAME is the first part of the URL given to you for your environment: https://<SERVER_NAME>.jfrog.io. You can also get this information from the docker login command from Lab2.
    <img src="/artifactory-essentials/images/docker-command-display.png" alt="ServerName" style="height: 100px; width:100px;"/>
    <img src="/artifactory-essentials/images/Server-Name.png" alt="ServerName" style="height: 100px; width:100px;"/>
  
  * Jfrog instance username : username for accessing your jfrog platform instance with deployment privileges 
  
  * Jfrog instance password : password for accessing your jfrog platform instance
  
  * Docker Virtual Repository name : Please provide this as "swampup-docker". This is the name of the virtual repository which you created in Step3 of Lab2
  
  * Build name : Provide a name to your build. This Build name will be displayed under the Builds tab in Jfrog platform. 
     <img src="/artifactory-essentials/images/buildname.png" alt="buildname" style="height: 100px; width:100px;"/>
    
  * Build number : Provide a number to your build. This Buildnumber is usually your CI build run number.
    <img src="/artifactory-essentials/images/buildnumber.png" alt="Build Number" style="height: 100px; width:100px;"/>
    
- Once the above information is entered, the script dynamically modifies the Dockerfile to point to your SERVER_NAME and  VIRTUAL_REPO_NAME to point to your docker virtual repository ("swampup-docker")

- Finally, You should see that CLI builds the docker image and pushes to artifactory
  <img src="/artifactory-essentials/images/buildsuccess.png" alt="Build success" style="height: 100px; width:100px;"/>

## Step 2 - View the Build information in Artifactory

- Navigate to the Application Module, expand the Artifactory menu and click the Build menu item. The published build is displayed here
  <img src="/artifactory-essentials/images/build.png" alt="Build" style="height: 100px; width:100px;"/>
  
  
- Click the BuildName and the build number to view the published modules
  
  <img src="/artifactory-essentials/images/build-name.png" alt="Build Name" style="height: 100px; width:100px;"/>

  <img src="/artifactory-essentials/images/build-number.png" alt="Build Number" style="height: 100px; width:100px;"/>

- Click the published docker image to view the different layers on it

  <img src="/artifactory-essentials/images/publishedmodule-layer.png" alt="Build Number" style="height: 100px; width:100px;"/>

## Step 3- Adding properties/metadata to the published build

- You can add properties to the docker image published. Below is a sample on how to add properties to the published docker image as part of the build

    ```$jfrog rt sp  --include-dirs=true "swampup-docker-dev-local/docker-example-build-image/1*" "unittest=passed"```

  <img src="/artifactory-essentials/images/properties-update.png" alt="properties" style="height: 100px; width:100px;"/>

- Once the properties are added, we can navigate to the respective docker image to view the data on the UI

  <img src="/artifactory-essentials/images/properties-ui.png" alt="properties-ui" style="height: 100px; width:100px;"/>


## Step 4-  Promote the Build 

- Promote the build and its associated build information to production. Below we are promoting our "sample-docker-cli-build" to "swampup-docker-prod-local" repository

    ```$ jfrog rt build-promote sample-docker-cli-build 1 swampup-docker-prod-local```
  
- View the published module to validate the binary is now in swampup-docker-prod-local
  <img src="/artifactory-essentials/images/build-promotion.png" alt="Build Number" style="height: 100px; width:100px;"/>


### Awesome !!! You have successfully completed Stage 4. You can use CLI to push the build information from any CI build agent.


# Stage 5 - Artifactory AQL

- AQL Link - https://www.jfrog.com/confluence/display/JFROG/Artifactory+Query+Language

- Artifactory Query Language (AQL) is specially designed to let you uncover any data related to the artifacts and builds stored within Artifactory. This syntax offers a simple way to formulate complex queries that specify any number of search criteria, filters, sorting options, and output parameters. AQL is exposed as a RESTful API which uses data streaming to provide output data resulting in extremely fast response times and low memory consumption. AQL can only extract data that resides in your instance of Artifactory, so it runs on Local Repositories, Remote Repositories Caches and Virtual Repositories.

- Commands :
```
$ curl -XPOST -u <username>:**** -H 'Content-Type:text/plain' https://<instance_name>.jfrog.io/artifactory/api/search/aql --data 'items.find({"repo":{"$eq":"example-repo-local"}})'

$ curl -XPOST -u <username>:**** -H 'Content-Type:text/plain' https://<instance_name>.jfrog.io/artifactory/api/search/aql --data 'items.find({"name": {"$match" : "*test*"}})'

$ curl -XPOST -u <username>:**** -H 'Content-Type:text/plain' https://<instance_name>.jfrog.io/artifactory/api/search/aql --data 'items.find({"name" : {"$match":"*.jar"}}).include("name").distinct(false)'

$ curl -XPOST -u <username>:**** -H 'Content-Type:text/plain' https://<instance_name>.jfrog.io/artifactory/api/search/aql --data 'items.find({"repo": "example-repo-local"})'

$ curl -XPOST -u <username>:**** -H 'Content-Type:text/plain' https://<instance_name>.jfrog.io/artifactory/api/search/aql --data 'items.find({"modified" : {"$last" : "2w"}})'  (use before as well)

$ curl -XPOST -u <username>:**** -H 'Content-Type:text/plain' https://<instance_name>.jfrog.io/artifactory/api/search/aql --data 'items.find({"repo": "example-repo-local", "created" : {"$last" : "5d"}, "size" : {"$gt" : "500"}, "type" : "file"})'

$ curl -XPOST -u <username>:**** -H 'Content-Type:text/plain' https://<instance_name>.jfrog.io/artifactory/api/search/aql --data 'items.find({"@artifactory.licenses":"*"})'
```

Create a file - test.aql 
```
items.find({ "repo": "example-repo-local",
    "created": {"$last" : "10d"},
    "stat.downloads": {"$eq" : null}
 })

.include("name","path","repo")

```

```jf rt curl -XPOST api/search/aql -T test.aql```

Create a file - dockerage.sql
```
items.find({
  "repo": "docker-dev-local",
  "name": "manifest.json",
  "created":{"$gt":"2022-07-01"}
}).include("path")
```

```jf rt curl -X POST api/search/aql -T dockerage.sql```