FROM ghcr.io/amachsoftware/jenkins-agent-amazonlinux2

ARG user=jenkins

USER root

RUN amazon-linux-extras install -y corretto8
RUN yum install -y java-1.8.0-amazon-corretto-devel which
RUN yum clean all

# Have the Jenkins Agent startup script use a different env var for location of java.
# Cannot use JAVA_HOME as that would impact programs using Java run by the agent.
RUN sed -i 's/JAVA_HOME/JENKINS_AGENT_JAVA_HOME/' /usr/local/bin/jenkins-agent

USER ${user}

ENV JENKINS_AGENT_JAVA_HOME=/usr/lib/jvm/java-11-openjdk
ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0

ENTRYPOINT ["jenkins-agent"]
