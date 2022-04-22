FROM centos:7
MAINTAINER ningmo

RUN yum install wget -y
RUN cd /etc/yum.repos.d && wget http://mirrors.aliyun.com/repo/Centos-7.repo
RUN yum clean all && yum makecache 
RUN yum install java-1.8.0-openjdk.x86_64 -y

# whereis java -> ll ..java -> ll .....java
ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.322.b06-1.el7_9.x86_64
ENV CLASSPATH=.:$JAVA_HOME/jre/lib/rt.jar:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PATH=$PATH:$JAVA_HOME/bin
ADD data-integration /kettle/data-integration
ENV KETTLE_HOME=/kettle/data-integration
# RUN mkdir /kettle/kettle_job /kettle/conf

# RUN cd /root && wget ftp://ftp.pbone.net/mirror/ftp5.gwdg.de/pub/opensuse/repositories/home:/matthewdva:/build:/EPEL:/el7/RHEL_7/x86_64/webkitgtk-2.4.9-1.el7.x86_64.rpm && yum install webkitgtk-2.4.9-1.el7.x86_64.rpm 

COPY ./webkitgtk-2.4.9-1.el7.x86_64.rpm /root/ 
RUN yum install /root/webkitgtk-2.4.9-1.el7.x86_64.rpm -y
EXPOSE 8080

CMD sh /kettle/data-integration/carte.sh /kettle/data-integration/carte.xml
