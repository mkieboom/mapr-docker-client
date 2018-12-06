#!/bin/bash

# Specify the container version tag:
CONTAINER_VERSION=latest

# Launch container
docker run -it \
-v /tmp/maprticket:/tmp/maprticket:ro \
-e MAPR_TICKETFILE_LOCATION=/tmp/maprticket \
mkieboom/mapr-client-myapp:$CONTAINER_VERSION

# For secure clusters, genarate a ticket and provide the ticket to docker run:
# -v /tmp/mapr-ticket:/tmp/longlived_ticket:ro \
# -e MAPR_TICKETFILE_LOCATION=/tmp/longlived_ticket \

# For FUSE POSIX containers add following to docker run:
# --cap-add SYS_ADMIN \
# --cap-add SYS_RESOURCE \
# --device /dev/fuse \
# -e MAPR_MOUNT_PATH=/mapr \
