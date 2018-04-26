#!/bin/bash
wget http://mirror.olnevhost.net/pub/apache/maven/binaries/apache-maven-3.2.1-bin.tar.gz;
tar -xf apache-maven-3.2.1-bin.tar.gz  -C /usr/local;
cd /usr/local;
ln -s apache-maven-3.2.1 maven;
