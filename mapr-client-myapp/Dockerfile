# MapR client(s) running in a Docker container
#
# VERSION 0.1 - not for production, use at own risk
#

#
# Use the MapR Client image as the base
FROM mkieboom/mapr-client

MAINTAINER mkieboom @ mapr.com

# Add a non-root user and group for demo purposes
RUN groupadd -g 6000 group01
RUN useradd -u 6000 -g 6000 user01

# Change user to run container as non-root user
USER user01

# Keep container running
CMD /bin/bash