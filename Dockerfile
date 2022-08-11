FROM ghcr.io/amachsoftware/jenkins-agent-amazonlinux2

ARG user=jenkins

USER root

RUN amazon-linux-extras install -y corretto8
RUN yum install -y java-1.8.0-amazon-corretto-devel
RUN yum clean all

# Have the Jenkins Agent startup script use JAVA_BIN env var for location of java.
# Cannot use JAVA_HOME as that would impact programs using Java run by the agent.
RUN sed -i 's/"java"/"$JAVA_BIN"/' /usr/local/bin/jenkins-agent

USER ${user}

ENV JAVA_BIN=/usr/lib/jvm/java-11/bin/java

ENTRYPOINT ["jenkins-agent"]
