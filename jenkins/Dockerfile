FROM java:8

ENV JENKINS_HOME=/var/jenkins_home \
    JENKINS_UC=https://updates.jenkins-ci.org \
    COPY_REFERENCE_FILE_LOG=/var/jenkins_home/copy_reference_file.log \
    JAVA_OPTS=-Djenkins.install.runSetupWizard=false \
    M2_HOME=/usr/local/maven
ENV PATH $M2_HOME/bin:$PATH

#RUN ["apt-get", "update"]
#RUN ["apt-get", "install", "-y", "vim"]

COPY ./provision/jenkins.sh /usr/local/bin/jenkins.sh
COPY ./provision/plugins.sh /usr/local/bin/plugins.sh

RUN mkdir /opt/jenkins; \
	useradd -d "$JENKINS_HOME" -u 1000 -m -s /bin/bash jenkins; \
	chown jenkins /opt/jenkins; \
	curl -fL https://github.com/krallin/tini/releases/download/v0.5.0/tini-static -o /bin/tini && chmod +x /bin/tini; \
	curl -fL http://mirrors.jenkins-ci.org/war/latest/jenkins.war -o /opt/jenkins/jenkins.war; \
	mkdir -p /opt/jenkins/ref/plugins; \
    chown -R jenkins "$JENKINS_HOME" /opt/jenkins; \
    chmod +x /usr/local/bin/jenkins.sh /usr/local/bin/plugins.sh; \
    mkdir -p /opt/jenkins/ref/init.groovy.d;

COPY ./provision/executors.groovy /opt/jenkins/ref/init.groovy.d/
COPY ./provision/default-user.groovy /opt/jenkins/ref/init.groovy.d/

# Switch to new jenkins user
USER jenkins

ENTRYPOINT ["/bin/tini", "--", "/usr/local/bin/jenkins.sh"]

# from a derived Dockerfile, can use `RUN plugin.sh active.txt` to setup /usr/share/jenkins/ref/plugins from a support bundle
COPY ./provision/plugins.txt /plugins.txt
RUN /bin/bash /usr/local/bin/plugins.sh /plugins.txt


EXPOSE 8080 50000
VOLUME /var/jenkins_home

USER root
COPY ./provision/setup_container.sh /usr/local/bin/setup_container.sh
RUN /bin/bash /usr/local/bin/setup_container.sh
