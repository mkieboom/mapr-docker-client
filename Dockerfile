# MapR Client and FUSE POSIX Client running in a Docker container
#
# VERSION 0.1 - not for production, use at own risk
#

#
# Use a CentOS 7 image as the base
FROM centos

MAINTAINER mkieboom @ mapr.com

# Set the default MapR and MEP version, but allow overriding them using build arguments
ARG MAPR_VERSION=6.0.1
ENV MAPR_VERSION ${MAPR_VERSION}
ARG MEP_VERSION=5.0.0
ENV MEP_VERSION ${MEP_VERSION}

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

# Install the MapR client and the FUSE Basic client
RUN yum install -y mapr-client.x86_64 mapr-posix-client-basic

# Add the launch script and make it executable
ADD ./launch.sh /launch.sh
RUN chmod +x /launch.sh

CMD /launch.sh