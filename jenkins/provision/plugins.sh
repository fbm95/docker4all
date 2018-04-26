#! /bin/bash

# Parse a support-core plugin -style txt file as specification for jenkins plugins to be installed
# in the reference directory, so user can define a derived Docker image with just :
#
# FROM jenkins
# COPY plugins.txt /plugins.txt
# RUN /usr/local/bin/plugins.sh /plugins.txt
#

set -e

REF=/opt/jenkins/ref/plugins
mkdir -p $REF

while read spec || [ -n "$spec" ]; do
    myplugin=(${spec//:/ });
    [[ ${myplugin[0]} =~ ^# ]] && continue
    [[ ${myplugin[0]} =~ ^\s*$ ]] && continue
    [[ -z ${myplugin[1]} ]] && myplugin[1]="latest"
    echo "Downloading ${myplugin[0]}:${myplugin[1]}"

    if [ -z "$JENKINS_UC_DOWNLOAD" ]; then
      JENKINS_UC_DOWNLOAD=$JENKINS_UC/download
    fi
    curl -sSL -f ${JENKINS_UC_DOWNLOAD}/plugins/${myplugin[0]}/${myplugin[1]}/${myplugin[0]}.hpi -o $REF/${myplugin[0]}.jpi
done  < $1