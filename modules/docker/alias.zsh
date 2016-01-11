#
# Defines Docker aliases.
#
# Authors:
#   Tung Ha <tunght13488@gmail.com>
#

#
# Aliases
#

# Docker
alias dk='docker'
alias dkm='docker-machine'
alias dkc='docker-compose'


# Get latest container ID
alias dl="docker ps -l -q"

# Get container process
alias dps="docker ps"

# Get process included stop container
alias dpa="docker ps -a"

# Get images
alias di="docker images"

# Get container IP
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

# Run deamonized container, e.g., $dkd base /bin/echo hello
alias dkd="docker run -d -P"

# Run interactive container, e.g., $dki base /bin/bash
alias dki="docker run -i -t -P"

# Stop all containers
dstop() { docker stop $(docker ps -a -q); }

# Remove all containers
drm() { docker rm $(docker ps -a -q); }

# Stop and Remove all containers
alias drmf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'

# Remove all images
dri() { docker rmi $(docker images -q); }

# Dockerfile build, e.g., $dbu tcnksm/test
dbu() { docker build -t=$1 .; }

# Show all alias related docker
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }

alias dkv="docker inspect --format '{{ .Volumes }}'"

dke() {
  dkv $1
  docker run --rm -it --volumes-from=$1 ubuntu /bin/bash
}

dkenter() {
  docker exec -it $1 /bin/bash
}

function dkproxy() {
  local port=${1:-80}
  docker run -d -p $port:80 -v /var/run/docker.sock:/tmp/docker.sock --name nginx-proxy -t jwilder/nginx-proxy
}
