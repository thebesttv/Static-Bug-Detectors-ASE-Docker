username=thebesttv

service ssh restart
service mysql start

################################################################
# Docker
# Taken from https://github.com/BugSwarm/bugswarm
################################################################

DOCKER_GID=`stat -c %g /var/run/docker.sock`
groupadd -g $DOCKER_GID docker_host
usermod -aG $DOCKER_GID $username
