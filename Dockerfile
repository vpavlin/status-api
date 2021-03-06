FROM registry.centos.org/kbsingh/openshift-nginx:latest
MAINTAINER Vasek Pavlin <vasek@redhat.com>

EXPOSE 8080
WORKDIR /opt/status-api

USER root

ADD . /opt/status-api
RUN yum -y install python-pip python-devel gcc &&\
    pip install -r requirements.txt &&\
    cp -r root/* / &&\
    cp scripts/run.sh /usr/bin/ &&\
    yum -y remove python-devel; yum clean all

RUN chgrp -R 0 /opt/status-api &&\
    chmod -R g+rwX /opt/status-api &&\
    chmod +x /usr/bin/run.sh

USER 1001

ENTRYPOINT ["/usr/bin/run.sh"]
