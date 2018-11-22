FROM centos:7
MAINTAINER The CentOS Project <cloud-ops@centos.org>


LABEL name="CentOS Base Image"
LABEL vendor="CentOS"
LABEL license=GPLv2

RUN yum install mc -y && yum install wget -y && wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.5.0-x86_64.rpm && rpm -i filebeat-6.5.0-x86_64.rpm