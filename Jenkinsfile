#!/usr/bin/groovy

pipeline {
    agent any

    options {
        disableConcurrentBuilds()
    }

    environment{
        
        DOCKERHUB_CREDENTIALS = credentials('abdullahcodes-dockerhub')

    }
    
	

    stages {
        stage('Docker-build'){
            steps {
                sh 'docker build -t abdullahcodes/nginx-1-19:${BUILD_NUMBER} ./app'
            }
        }

        stage('Docker-login'){
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }

        stage('Docker-push'){
            steps {
                sh 'docker push abdullahcodes/nginx-1-19:${BUILD_NUMBER}'
            }
        }

        stage('Deploy'){
            steps {
                sh './deployment.sh'
            }
        }
		


	}
}