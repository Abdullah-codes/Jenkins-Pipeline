
#!/bin/bash



echo "copiyng and chaging docker-compose-file with build number"
cp nginx-statfulset.yaml.template nginx-statfulset.yaml

sed -i "s/build/$BUILD_NUMBER/g" nginx-statfulset.yaml.template

#Deployment of nginx statfulset

kubectl apply -f nginx-statfulset.yaml