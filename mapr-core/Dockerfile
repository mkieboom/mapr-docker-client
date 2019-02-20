# MapR core running in a Docker container
#
# VERSION 0.1 - not for production, use at own risk
#

#
# Use a CentOS image as the base
FROM centos

MAINTAINER mkieboom @ mapr.com

# Set the defaults but allow overriding them using build arguments
ARG MAPR_VERSION=6.1.0
ARG MEP_VERSION=6.0.0
ENV MAPR_VERSION ${MAPR_VERSION}
ENV MEP_VERSION ${MEP_VERSION}

ARG MAPR_CLUSTER=demo.mapr.com
ENV MAPR_CLUSTER ${MAPR_CLUSTER}
ARG MAPR_CLDB_HOSTS=172.16.4.50
ENV MAPR_CLDB_HOSTS ${MAPR_CLDB_HOSTS}

ARG MAPR_CONTAINER_USER=mapr
ENV MAPR_CONTAINER_USER ${MAPR_CONTAINER_USER}
ARG MAPR_CONTAINER_UID=5000
ENV MAPR_CONTAINER_UID ${MAPR_CONTAINER_UID}
ARG MAPR_CONTAINER_GROUP=mapr
ENV MAPR_CONTAINER_GROUP ${MAPR_CONTAINER_GROUP}
ARG MAPR_CONTAINER_GID=5000
ENV MAPR_CONTAINER_GID ${MAPR_CONTAINER_GID}

# Configure MapR Repository
RUN printf "[maprtech] \n\
name=MapR Technologies \n\
baseurl=http://package.mapr.com/releases/v${MAPR_VERSION}/redhat/ \n\
enabled=1 \n\
gpgcheck=0 \n\
protect=1 \n\
 \n\
[maprecosystem] \n\
name=MapR Technologies \n\
baseurl=http://package.mapr.com/releases/MEP/MEP-${MEP_VERSION}/redhat \n\
enabled=1 \n\
gpgcheck=0 \n\
protect=1" > /etc/yum.repos.d/maprtech.repo

# Install Open JDK and other prerequisites
RUN yum install -y java-1.8.0-openjdk net-tools

# Install the mapr gpg key
RUN rpm --import http://package.mapr.com/releases/pub/maprgpg.key

# Install the MapR core
RUN yum install -y mapr-core

# Add the mapr user and group
RUN groupadd -g ${MAPR_CONTAINER_GID} ${MAPR_CONTAINER_GROUP}
RUN useradd -u ${MAPR_CONTAINER_UID} -g ${MAPR_CONTAINER_GID} ${MAPR_CONTAINER_USER}

# Configure the client (-c specifies client deployment)
RUN /opt/mapr/server/configure.sh \
      -N ${MAPR_CLUSTER} \
      -C ${MAPR_CLDB_HOSTS} \
      -c -secure

# For testing purposes, run as a non-root container:
# Add a generic non-root user and group
RUN groupadd -g 9000 containergroup
RUN useradd -u 9000 -g 9000 containeruser
# Change user to run container as non-root user
USER containeruser

# Keep the container alive
CMD /bin/bash