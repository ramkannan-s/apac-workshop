- [Artifactory Overview - UI navigation and access](#artifactory-overview---ui-navigation-and-access)
  - [Prerequisites](#prerequisites)
  - [Navigating Through the Platform](#navigating-through-the-platform)
    - [Step1 - Login \& Application Overview](#step1---login--application-overview)
    - [Step2 - Administration Overview](#step2---administration-overview)
- [Stage 1 - Creating repositories](#stage-1---creating-repositories)
  - [Creating Repositories](#creating-repositories)
    - [Step1 - Local Repository - Docker](#step1---local-repository---docker)
    - [Step2 - Remote Repository - Docker](#step2---remote-repository---docker)
    - [Step3 - Virtual  Repository - Docker](#step3---virtual--repository---docker)
    - [Awesome !!! You have successfully completed Stage 2.](#awesome--you-have-successfully-completed-stage-2)
- [Stage 2 - Working with Artifactory as your docker registry](#stage-2---working-with-artifactory-as-your-docker-registry)
  - [Step 1 - Update the dockerfile](#step-1---update-the-dockerfile)
  - [Step 2 - Push custom image to your docker repository](#step-2---push-custom-image-to-your-docker-repository)
    - [Awesome !!! You have successfully completed Stage 3. Next lab we will help you to search and view the artifacts.](#awesome--you-have-successfully-completed-stage-3-next-lab-we-will-help-you-to-search-and-view-the-artifacts)
- [Stage 3 - Leverage CLI to publish build to Artifactory](#stage-3---leverage-cli-to-publish-build-to-artifactory)
  - [Step 1 - Run the build.sh script](#step-1---run-the-buildsh-script)
  - [Step 2 - View the Build information in Artifactory](#step-2---view-the-build-information-in-artifactory)
  - [Step 3- Adding properties/metadata to the published build](#step-3--adding-propertiesmetadata-to-the-published-build)
  - [Step 4-  Promote the Build](#step-4---promote-the-build)
    - [Awesome !!! You have successfully completed Stage 3. You can use CLI to push the build information from any CI build agent.](#awesome--you-have-successfully-completed-stage-3-you-can-use-cli-to-push-the-build-information-from-any-ci-build-agent)
- [Stage 4 - Artifactory AQL](#stage-4---artifactory-aql)
    - [Awesome !!! You have successfully completed Stage 4.](#awesome--you-have-successfully-completed-stage-4)

# Artifactory Overview - UI navigation and access

## Prerequisites

- A SaaS Instance of JFrog. This will be the trail version enrolled (signed up) by participants for the Workshop.

- Docker Installed in your machine.

## Navigating Through the Platform

### Step1 - Login & Application Overview

- Login to your saas instance `<instance_name>.jfrog.io` with your admin credentials

- Click on 'Artifactory' and get familiar with the Packages, Builds and Artifacts views.

  <img src="/01-artifactory-essentials/images/application.png" alt="Application tab" style="height: 100px; width:100px;"/>

### Step2 - Administration Overview

- Navigate to the Administration module and get familiar with the different options.

  <img src="/01-artifactory-essentials/images/admin.png" alt="Admin tab" style="height: 100px; width:100px;"/>

<br/>
<hr>
<br/>

# Stage 1 - Creating repositories

## Creating Repositories

### Step1 - Local Repository - Docker

- Login to your saas instance `<instance_name>.jfrog.io` with  your admin credentials.

- Navigate to the Administration Module. Expand the Repositories menu and click on the Repositories menu item.

  <img src="/01-artifactory-essentials/images/repository.png" alt="Repositories tab" style="height: 100px; width:100px;"/>
  
- Add a new Local Repository with the Docker package type.

  <img src="/01-artifactory-essentials/images/choose-docker.png" alt="choose-docker-package tab" style="height: 100px; width:100px;"/>

- Enter the Repository Key “jfrog-docker-dev-local” and keep the rest of the default settings.

  <img src="/01-artifactory-essentials/images/docker-dev-local.png" alt="mame the repo" style="height: 100px; width:100px;"/>

- Once done, Create another local repository with docker package type and name it as "jfrog-docker-prod-local". Keep the rest of the default settings.

  <img src="/01-artifactory-essentials/images/docker-prod-local.png" alt="mame the repo" style="height: 100px; width:100px;"/>


### Step2 - Remote Repository - Docker

-  Add a remote repository to cache docker images from docker hub or any other external registries.

   <img src="/01-artifactory-essentials/images/remote-repo.png" alt="Remote repo" style="height: 100px; width:100px;"/>
   
-  Add a new Remote Repository with the Docker package type and name the repository as "jfrog-docker-remote" and uncheck "Block pulling of image manifest v2 schema1".

   <img src="/01-artifactory-essentials/images/docker-remote.png" alt="mame the repo" style="height: 100px; width:100px;"/>
   <img src="/01-artifactory-essentials/images/block-pull.png" alt="unblock" style="height: 100px; width:100px;"/>

### Step3 - Virtual  Repository - Docker

-  Add a Virtual repository to work with a single URL from your docker client. Click on the Virtual tab on the Repositories page.

   <img src="/01-artifactory-essentials/images/virtual-repo.png" alt="Virtual repo" style="height: 100px; width:100px;"/>
   
-   Add a new Virtual Repository with the *Docker Package Type*. Enter the Repository Key “jfrog-docker” and add the local and remote docker repositories you created in Steps 2 and 3 (move them from Available Repositories to Selected Repositories using the arrow buttons). The order of these repositories in the list will determine the order used to resolve the dependencies required for building your docker image. Select your local repository(jfrog-docker-dev-local) that you created in Step 2 as the Default Deployment Repository. The Default Deployment Repository is the repository that the docker image you build will be pushed to. Keep the rest of the default settings.

   <img src="/01-artifactory-essentials/images/docker-virtual.png" alt="mame the repo" style="height: 100px; width:100px;"/>
    
- After the docker virtual registry is created. It will provide you with the details on how to access this docker registry. Copy that information and keep it in locally on your laptop.

  <img src="/01-artifactory-essentials/images/docker-command-display.png" alt="docker commands" style="height: 100px; width:100px;"/>

### Awesome !!! You have successfully completed Stage 2.

<br/>
<hr>
<br/>

# Stage 2 - Working with Artifactory as your docker registry

## Step 1 - Update the dockerfile  

- Update the dockerfile present in this repository. Update the FROM line of the Dockerfile to reference your virtual Docker repository.
    - ```FROM ${SERVER_NAME}.jfrog.io/${VIRTUAL_REPO_NAME}/alpine:3.11.5```
      
    - The SERVER_NAME is the first part of the URL given to you for your environment: ```https://<SERVER_NAME>.jfrog.io.``` You can also get this information from the docker login command.

      <img src="/01-artifactory-essentials/images/docker-command.png" alt="docker commands" style="height: 100px; width:100px;"/>

    - The VIRTUAL_REPO_NAME is the name ““jfrog-docker” that you assigned to your virtual repository in Stage 2.

    - After modifying your dockerfile should be something like below.

      <img src="/01-artifactory-essentials/images/modified-dockerfiles.png" alt="dockerfile" style="height: 100px; width:100px;"/>
    
## Step 2 - Push custom image to your docker repository

- Login to your docker virtual repository. Replace the  SERVER_NAME and VIRTUAL_REPO_NAME as mentioned in above step.
    - ``` $docker login ${SERVER_NAME}.jfrog.io```
      
      <img src="/01-artifactory-essentials/images/login-docker.png" alt="docker login" style="height: 100px; width:100px;"/>
      
- Build your docker image. Replace the  SERVER_NAME and VIRTUAL_REPO_NAME as mentioned in above step.
    - ```$ docker build --tag ${SERVER_NAME}.jfrog.io/${VIRTUAL_REPO_NAME}/my-docker-image:latest . ```
      
      <img src="/01-artifactory-essentials/images/docker-builds.png" alt="docker build" style="height: 100px; width:100px;"/>
      
- Push the build docker image to your docker registry. Replace the  SERVER_NAME and VIRTUAL_REPO_NAME as mentioned in above step. 
    - ``` $ docker push ${SERVER_NAME}.jfrog.io/${VIRTUAL_REPO_NAME}/my-docker-image:latest ```
      
      <img src="/01-artifactory-essentials/images/dockerpush.png" alt="docker push" style="height: 100px; width:100px;"/>

### Awesome !!! You have successfully completed Stage 3. Next lab we will help you to search and view the artifacts.

<br/>
<hr>
<br/>

# Stage 3 - Leverage CLI to publish build to Artifactory

## Step 1 - Run the build.sh script
  
- Execute the ./build.sh script. 

- You will be prompted to enter some important details. We will discuss each one of these during the class and while implementing the same. 

* Detail about each input
  * Configuration name for CLI : The name used to reference your instance using Jfrog CLI on your local machine. e.g - "JPD" is the name which I am giving to access my Jfrog platform
    <img src="/01-artifactory-essentials/images/CLI-Config-name.png" alt="CLI Config" style="height: 100px; width:100px;"/>
  
  * Jfrog instance name : The SERVER_NAME is the first part of the URL given to you for your environment: https://<SERVER_NAME>.jfrog.io. You can also get this information from the docker login command from Lab2.
    <img src="/01-artifactory-essentials/images/docker-command-display.png" alt="ServerName" style="height: 100px; width:100px;"/>
    <img src="/01-artifactory-essentials/images/Server-Name.png" alt="ServerName" style="height: 100px; width:100px;"/>
  
  * Jfrog instance username : username for accessing your jfrog platform instance with deployment privileges 
  
  * Jfrog instance password : password for accessing your jfrog platform instance
  
  * Docker Virtual Repository name : Please provide this as "jfrog-docker". This is the name of the virtual repository which you created in Step3 of Lab2
  
  * Build name : Provide a name to your build. This Build name will be displayed under the Builds tab in Jfrog platform. 
     <img src="/01-artifactory-essentials/images/buildname.png" alt="buildname" style="height: 100px; width:100px;"/>
    
  * Build number : Provide a number to your build. This Buildnumber is usually your CI build run number.
    <img src="/01-artifactory-essentials/images/buildnumber.png" alt="Build Number" style="height: 100px; width:100px;"/>
    
- Once the above information is entered, the script dynamically modifies the Dockerfile to point to your SERVER_NAME and  VIRTUAL_REPO_NAME to point to your docker virtual repository ("jfrog-docker")

- Finally, You should see that CLI builds the docker image and pushes to artifactory
  <img src="/01-artifactory-essentials/images/buildsuccess.png" alt="Build success" style="height: 100px; width:100px;"/>

## Step 2 - View the Build information in Artifactory

- Navigate to the Application Module, expand the Artifactory menu and click the Build menu item. The published build is displayed here
  <img src="/01-artifactory-essentials/images/build.png" alt="Build" style="height: 100px; width:100px;"/>
  
- Click the BuildName and the build number to view the published modules
  
  <img src="/01-artifactory-essentials/images/build-name.png" alt="Build Name" style="height: 100px; width:100px;"/>

  <img src="/01-artifactory-essentials/images/build-number.png" alt="Build Number" style="height: 100px; width:100px;"/>

- Click the published docker image to view the different layers on it

  <img src="/01-artifactory-essentials/images/publishedmodule-layer.png" alt="Build Number" style="height: 100px; width:100px;"/>

## Step 3- Adding properties/metadata to the published build

- You can add properties to the docker image published. Below is a sample on how to add properties to the published docker image as part of the build

    ```$jf rt sp  --include-dirs=true "jfrog-docker-dev-local/docker-example-build-image/1*" "unittest=passed"```

  <img src="/01-artifactory-essentials/images/properties-update.png" alt="properties" style="height: 100px; width:100px;"/>

- Once the properties are added, we can navigate to the respective docker image to view the data on the UI

  <img src="/01-artifactory-essentials/images/properties-ui.png" alt="properties-ui" style="height: 100px; width:100px;"/>


## Step 4-  Promote the Build 

- Promote the build and its associated build information to production. Below we are promoting our "sample-docker-cli-build" to "jfrog-docker-prod-local" repository

    ```$ jf rt build-promote sample-docker-cli-build 1 jfrog-docker-prod-local```
  
- View the published module to validate the binary is now in jfrog-docker-prod-local
  <img src="/01-artifactory-essentials/images/build-promotion.png" alt="Build Number" style="height: 100px; width:100px;"/>


### Awesome !!! You have successfully completed Stage 3. You can use CLI to push the build information from any CI build agent.

<br/>
<hr>
<br/>

# Stage 4 - Artifactory AQL

- AQL Link - https://www.jfrog.com/confluence/display/JFROG/Artifactory+Query+Language

- Artifactory Query Language (AQL) is specially designed to let you uncover any data related to the artifacts and builds stored within Artifactory. This syntax offers a simple way to formulate complex queries that specify any number of search criteria, filters, sorting options, and output parameters. AQL is exposed as a RESTful API which uses data streaming to provide output data resulting in extremely fast response times and low memory consumption. AQL can only extract data that resides in your instance of Artifactory, so it runs on Local Repositories, Remote Repositories Caches and Virtual Repositories.

- Commands :
```
$ jf rt curl "/api/search/aql" -H 'Content-Type:text/plain' --data 'items.find({"repo":{"$eq":"example-repo-local"}})'

$ jf rt curl "/api/search/aql" -H 'Content-Type:text/plain' --data 'items.find({"name": {"$match" : "*test*"}})'

$ jf rt curl "/api/search/aql" -H 'Content-Type:text/plain' --data 'items.find({"name" : {"$match":"*.jar"}}).include("name").distinct(false)'

$ jf rt curl "/api/search/aql" -H 'Content-Type:text/plain' --data 'items.find({"repo": "example-repo-local"})'

$ jf rt curl "/api/search/aql" -H 'Content-Type:text/plain' --data 'items.find({"modified" : {"$last" : "2w"}})'  (use before as well)

$ jf rt curl "/api/search/aql" -H 'Content-Type:text/plain' --data 'items.find({"repo": "example-repo-local", "created" : {"$last" : "5d"}, "size" : {"$gt" : "500"}, "type" : "file"})'

$ jf rt curl "/api/search/aql" -H 'Content-Type:text/plain' --data 'items.find({"@artifactory.licenses":"*"})'
```

Create a file - data-no-downloads.aql 
```
items.find({ "repo": "example-repo-local",
    "created": {"$last" : "10d"},
    "stat.downloads": {"$eq" : null}
 }).include("name","path","repo")

```

```jf rt curl -XPOST api/search/aql -T data-no-downloads.aql```

Create a file - dockerage.sql
```
items.find({
  "repo": "docker-dev-local",
  "name": "manifest.json",
  "created":{"$gt":"2022-07-01"}
}).include("path")
```

```jf rt curl -X POST api/search/aql -T dockerage.sql```

### Awesome !!! You have successfully completed Stage 4.
