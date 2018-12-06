# mapr-client(s)

##### Clone the project
```
git clone https://github.com/mkieboom/mapr-docker-client
cd mapr-client  
```

##### Build the base mapr-client container  
```
# Edit the build-image.sh script and set the variables to reflect your cluster
cd mapr-client
vi build-image.sh
bash build-image.sh
```
Alternatively:
```
# You can override the default variables by providing them as build arguments:
docker build -t mkieboom/mapr-client \
  --build-arg MAPR_VERSION=6.0.1 \
  --build-arg MEP_VERSION=5.0.0 \
  .
```

##### Launch the container 
```
# Edit the run-image.sh script
vi run-image.sh
bash run-image.sh
```
