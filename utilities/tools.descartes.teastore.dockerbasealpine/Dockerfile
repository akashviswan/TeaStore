FROM davidcaste/alpine-tomcat:tomcat8




# Copy config, database connector library and script for environment variables into container
COPY baseContext.xml /opt/tomcat/conf/context.xml
COPY mysql-connector-java-5.1.44-bin.jar /opt/tomcat/lib/mysql-connector-java-5.1.44-bin.jar
COPY target/jars/dockermemoryconfigurator* /opt/tomcat/bin/dockermemoryconfigurator.jar
RUN rm /opt/tomcat/conf/server.xml
COPY server.xml /opt/tomcat/conf/

# Copy script to replace placeholders in context.xml with the environment variables
COPY start.sh /opt/tomcat/bin/start.sh
RUN chmod +x /opt/tomcat/bin/start.sh

# Service configuration. SERVICE_PORT is the host port, mapped to the exposed docker port. HOST_NAME
# is the IP address or hostname of the host running the docker container
ENV SERVICE_PORT 8080
ENV HOST_NAME unset
ENV USE_POD_IP false
ENV REGISTRY_HOST 127.0.0.1
ENV REGISTRY_PORT 8080
ENV DB_HOST 127.0.0.1
ENV DB_PORT 3306
ENV RECOMMENDER_RETRAIN_LOOP_TIME 0
ENV RECOMMENDER_ALGORITHM SlopeOne
ENV PROXY_NAME unset
ENV PROXY_PORT unset
ENV TOMCAT_HEAP_MEM_PERCENTAGE 50
ENV LOG_TO_FILE false
ENV RABBITMQ_HOST unset

# Setting secure random number generation to urandom. This increases the startup speed.
# Environment variable no longer needed. Replaced by sed in start.sh
# ENV JAVA_OPTS $JAVA_OPTS -Dsecurerandom.source=file 837:/dev/urandom

RUN mkdir -p /kieker/logs

COPY kieker.monitoring.properties 							/kieker/config/kieker.monitoring.properties
COPY aop.xml 												/opt/tomcat/lib/aop.xml
COPY kieker-1.14-SNAPSHOT-aspectj.jar 						/kieker/agent/agent.jar



EXPOSE 8080

CMD java -jar /opt/tomcat/bin/dockermemoryconfigurator.jar ${TOMCAT_HEAP_MEM_PERCENTAGE}; /opt/tomcat/bin/start.sh && /opt/tomcat/bin/catalina.sh run
