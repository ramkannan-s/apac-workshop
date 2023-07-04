
- [JFrog Artifactories - Creating repositories](#jfrog-artifactories---creating-repositories)
  - [Step 1 - Local Repository - Docker](#step-1---local-repository---docker)
  - [Step 2 - Remote Repository - Docker](#step-2---remote-repository---docker)
  - [Step 3 - Virtual  Repository - Docker](#step-3---virtual--repository---docker)

# JFrog Artifactories - Creating repositories

## Step 1 - Local Repository - Docker

- Login to your saas instance `<instance_name>.jfrog.io` with  your admin credentials.

- Navigate to the Administration Module. Expand the Repositories menu and click on the Repositories menu item.

  <img src="/01-artifactory-essentials/images/repository.png" alt="Repositories tab" style="height: 100px; width:100px;"/>
  
- Add a new Local Repository with the Docker package type.

  <img src="/01-artifactory-essentials/images/choose-docker.png" alt="choose-docker-package tab" style="height: 100px; width:100px;"/>

- Enter the Repository Key “jfrog-docker-dev-local” and keep the rest of the default settings.

  <img src="/01-artifactory-essentials/images/docker-dev-local.png" alt="mame the repo" style="height: 100px; width:100px;"/>

- Once done, Create another local repository with docker package type and name it as "jfrog-docker-prod-local". Keep the rest of the default settings.

  <img src="/01-artifactory-essentials/images/docker-prod-local.png" alt="mame the repo" style="height: 100px; width:100px;"/>


## Step 2 - Remote Repository - Docker

-  Add a remote repository to cache docker images from docker hub or any other external registries.

   <img src="/01-artifactory-essentials/images/remote-repo.png" alt="Remote repo" style="height: 100px; width:100px;"/>
   
-  Add a new Remote Repository with the Docker package type and name the repository as "jfrog-docker-remote" and uncheck "Block pulling of image manifest v2 schema1".

   <img src="/01-artifactory-essentials/images/docker-remote.png" alt="mame the repo" style="height: 100px; width:100px;"/>
   <img src="/01-artifactory-essentials/images/block-pull.png" alt="unblock" style="height: 100px; width:100px;"/>

## Step 3 - Virtual  Repository - Docker

-  Add a Virtual repository to work with a single URL from your docker client. Click on the Virtual tab on the Repositories page.

   <img src="/01-artifactory-essentials/images/virtual-repo.png" alt="Virtual repo" style="height: 100px; width:100px;"/>
   
-   Add a new Virtual Repository with the *Docker Package Type*. Enter the Repository Key “jfrog-docker” and add the local and remote docker repositories you created in Steps 2 and 3 (move them from Available Repositories to Selected Repositories using the arrow buttons). The order of these repositories in the list will determine the order used to resolve the dependencies required for building your docker image. Select your local repository(jfrog-docker-dev-local) that you created in Step 2 as the Default Deployment Repository. The Default Deployment Repository is the repository that the docker image you build will be pushed to. Keep the rest of the default settings.

   <img src="/01-artifactory-essentials/images/docker-virtual.png" alt="mame the repo" style="height: 100px; width:100px;"/>
    
- After the docker virtual registry is created. It will provide you with the details on how to access this docker registry. Copy that information and keep it in locally on your laptop.

  <img src="/01-artifactory-essentials/images/docker-command-display.png" alt="docker commands" style="height: 100px; width:100px;"/>

