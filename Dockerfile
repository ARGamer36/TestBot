# Cloning Stage
FROM alpine:3.18 AS clone

RUN apk update && apk add --no-cache git

WORKDIR /gittmp/
RUN git clone https://github.com/ARGamer36/TestBot.git
WORKDIR /gittmp/TestBot/
RUN git clone https://github.com/ARGamer36/ARJI.git 
RUN mv /gittmp/TestBot/ARJIpom.xml /gittmp/TestBot/ARJI/pom.xml

#Building  Stage
FROM maven:3.8.3-openjdk-17 AS build
COPY --from=clone /gittmp/TestBot/ARJI/ /tmp/TestBot/ARJI/
COPY --from=clone /gittmp/TestBot/Driver/ /tmp/TestBot/Driver/
COPY --from=clone /gittmp/TestBot/pom.xml /tmp/TestBot/pom.xml
#COPY --from=clone /gittmp/.gitmodules /tmp/.gitmodules

WORKDIR /tmp/TestBot/
RUN mvn clean package

# Run Stage
FROM openjdk:17-alpine
COPY --from=build /tmp/TestBot/Driver/target/*.jar /user/testbot/Interweb-jar-with-dependencies.jar
RUN mv /user/testbot/Interweb-jar-with-dependencies.jar /user/testbot/apps.jar
WORKDIR /user/testbot/
CMD ["java", "-jar", "apps.jar"]
