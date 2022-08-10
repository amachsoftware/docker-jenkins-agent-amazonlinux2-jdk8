FROM ghcr.io/amachsoftware/jenkins-agent-amazonlinux2

ARG user=jenkins

USER root

RUN amazon-linux-extras install -y corretto8
RUN yum clean all

USER ${user}

ENTRYPOINT ["JAVA_BIN=/usr/lib/jvm/java-11/bin/java", "jenkins-agent"]
