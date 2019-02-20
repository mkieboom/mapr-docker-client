#!/bin/bash

# Add the mapr user and group
echo "Creating group ${MAPR_CONTAINER_GROUP} with GID ${MAPR_CONTAINER_GID}"
groupadd -g ${MAPR_CONTAINER_GID} ${MAPR_CONTAINER_GROUP}
echo "Creating user ${MAPR_CONTAINER_GROUP} with UID ${MAPR_CONTAINER_GID}"
useradd -u ${MAPR_CONTAINER_UID} -g ${MAPR_CONTAINER_GID} ${MAPR_CONTAINER_USER}

# Configure the client (-c specifies client deployment)
echo "Launching configure.sh -N ${MAPR_CLUSTER} -C ${MAPR_CLDB_HOSTS} -c -secure"
/opt/mapr/server/configure.sh \
      -N ${MAPR_CLUSTER} \
      -C ${MAPR_CLDB_HOSTS} \
      -c -secure

# As a test, add a non-root user and run as that user from now on
#groupadd -g 9000 containergroup
#useradd -u 9000 -g 9000 containeruser
#su - containeruser

# Keep the container running
#/bin/bash