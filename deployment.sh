
#!/bin/bash

echo "Copying and changing Statefulset file with build number"
cp StatefulSet.yaml.template StatefulSet.yaml

sed -i "s/build/$BUILD_NUMBER/g" StatefulSet.yaml

#Deployment of nginx statfulset

kubectl apply -f StatefulSet.yaml