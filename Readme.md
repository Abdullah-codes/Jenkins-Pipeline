## Jenkins Pipeline for build and deployment of StatefulSet on Kubernetes.

## Solution

In this directory we have one folder called `app` and this folder contains `Dockerfile` which we will use to build the image during build step of pipeline.

After that we have `Jenkinsfile` which have multiple steps. 

1. `Docker-build` is the first step. In this step we are building the image using the `Dockerfile` which is in the `app` folder and changing the tag which is build number of the pipeline. Every build we will have a diffrent tag e.g. `nginx-1-19:${BUILD_NUMBER}`. 

2. `Docker-login` is the second step which will make login attempt to the DockerHub using the secret token which we have configured in the Jenkins.

3. `Docker-push` in this step it will push the image which we built in the first step to the Docker Hub.

4. `Deploy` is the final step which contains `deployment.sh` script. It will deploy the application into the cluster. In `deployment.sh` script we are performing text manupulation. it will copy `SatefulSet.yaml.template` and change the build number with tag so we can deploy the latest image which we just built. Then deploying the StatefulSet into the kubernetes cluster which in this case is local Minikube.

## Issues and fixes.

`Plugin` :  
we need to install the Docker plugin into the Jenkins to build images successfully.

```Jenkins permission issue``` :  
We can face issue in final step when Jenkins try to  deploy application using kubectl into the Minikube cluster.
because jenkins user does not have access to the local Minikube cluster as it dont have kube context set, thus we have to move the client-certificate and client-key form the local .minikube folder to the jenkins home directory and and copy the local minikube config file to the `jenkins/.kube/config` directory. and  move Jenkins user to the more privileged (sudo) group so it can access CA certificates as well.

``` Nginx giving 403 error ``` :  
So after we mount the Presistent Volume to Nginx Pod. the  directory(PV) which get  mounted is empty thus nginx wont find any files so we have to create  index.html file by going into the Minikube.
Below are commands to follow to create directory in minikube

We ssh into the Minikube.

```
minikube ssh
```
we are moving into the directory which is Presistent Volume.

```
cd /tmp/hostpath-provisioner/default/nginx-volume
```

Now create index.html file.

```
echo "Hello from Presistent Volume" > index.html
```
