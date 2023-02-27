#!/usr/bin/groovy

pipeline {
    agent any

    options {
        disableConcurrentBuilds()
    }

    environment{
        
        DOCKERHUB_CREDENTIALS = credentials('***Your-docker-repo***-dockerhub')

    }
    
	

    stages {
        stage('Docker-build'){
            steps {
                sh 'docker build -t ***Your-docker-repo***/nginx-1-19:${BUILD_NUMBER} ./app'
            }
        }

        stage('Docker-login'){
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }

        stage('Docker-push'){
            steps {
                sh 'docker push ***Your-docker-repo***/nginx-1-19:${BUILD_NUMBER}'
            }
        }

        stage('Deploy'){
            steps {
                sh 'chmod +x -R ${WORKSPACE}'
                sh './deployment.sh'
            }
        }
		


	}
}