#!/bin/bash

# Configure the container version tag:
CONTAINER_VERSION=latest

# Configure the MapR cluster details
MAPR_CLDB_HOSTS=172.16.4.50
MAPR_CLUSTER=demo.mapr.com
MAPR_CONTAINER_USER=mapr
MAPR_CONTAINER_UID=5000
MAPR_CONTAINER_GROUP=mapr
MAPR_CONTAINER_GID=5000

# Configure the MapR ticketfile location
MAPR_TICKET_LOCATION=/tmp/maprticket_0

# Launch container
docker run -it \
-e MAPR_CLUSTER=$MAPR_CLUSTER \
-e MAPR_CLDB_HOSTS=$MAPR_CLDB_HOSTS \
-e MAPR_CONTAINER_USER=$MAPR_CONTAINER_USER \
-e MAPR_CONTAINER_GROUP=$MAPR_CONTAINER_GROUP \
-e MAPR_CONTAINER_UID=$MAPR_CONTAINER_UID \
-e MAPR_CONTAINER_GID=$MAPR_CONTAINER_GID \
-v $MAPR_TICKET_LOCATION:/tmp/maprticket:ro \
-e MAPR_TICKETFILE_LOCATION=/tmp/maprticket \
mkieboom/mapr-core:$CONTAINER_VERSION

# For secure clusters, genarate a ticket and provide the ticket to docker run:
# -v /tmp/mapr-ticket:/tmp/longlived_ticket:ro \
# -e MAPR_TICKETFILE_LOCATION=/tmp/longlived_ticket \
