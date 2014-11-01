FROM java:8
MAINTAINER George Lewis <schvin@schvin.net>

ENV REFRESHED_AT 2014-11-01
ENV EC2_HOME /s/ec2-api-tools
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/jre/

RUN apt-get update -y && apt-get install -y perl curl unzip

RUN mkdir -p /s/ec2
WORKDIR /s/ec2
RUN curl -O http://s3.amazonaws.com/ec2-downloads/ec2-api-tools.zip
RUN unzip ec2-api-tools.zip
RUN rm ec2-api-tools.zip
RUN ln -s ec2* ec2-api-tools
