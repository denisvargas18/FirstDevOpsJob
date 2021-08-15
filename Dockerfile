#FROM openjdk:13
#VOLUME /tmp
#EXPOSE 8080
#ADD ./target/FirstDevopsJob-0.0.1-SNAPSHOT.jar  FirstDevopsJob.jar
#ENTRYPOINT ["java","-jar" ,"/FirstDevopsJob.jar"]


#FROM maven:3.6.3-jdk-11-slim AS build
#WORKDIR /home/app
#COPY . /home/app
#RUN mvn -f /home/app/pom.xml clean package

#FROM openjdk:8-jdk-alpine
#FROM  openjdk:13
#VOLUME /tmp
#EXPOSE 8080
#COPY --from=build /home/app/target/*.jar app.jar
#ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar" ]
FROM adoptopenjdk/openjdk11-openj9:slim
MAINTAINER Athenas
LABEL maintainer="devops@athenas.com"
ENV TZ=America/Lima
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
#RUN useradd -ms /bin/bash athenas
RUN useradd -rm -d /home/athenas -s /bin/bash -g root -G sudo -u 1001 athenas
USER athenas
WORKDIR /home/athenas
#COPY UnlimitedJCEPolicyJDK8/* /usr/lib/jvm/java-1.8-openjdk/jre/lib/security/
COPY target/*.jar /opt/app.jar
ENTRYPOINT ["java","-Djava.awt.headless=true,-Xms768m,-Xmx768m,-XX:+UseG1GC,-XX:+DisableExplicitGC,-XX:+UnlockExperimentalVMOptions,-XX:+UseCGroupMemoryLimitForHeap,-XX:MaxRAMFraction=1" ,"-jar", "/opt/app.jar"]