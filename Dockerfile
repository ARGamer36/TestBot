# Build Stage
FROM maven:3.8.3-openjdk-17 AS build
RUN apt-get update && apt-get install -y \
    git
WORKDIR /tmp

RUN git clone https://github.com/ARGamer36/TestBot.git
RUN git submodule init
RUN git submodule update
RUN mv ARJIpom.xml ./ARJI/pom.xml
RUN mvn clean package

# Run Stage
FROM openjdk:17-alpine
COPY --from=build /tmp/Driver/target/*.jar /user/testbot/
RUN mv /user/tesbot/Interweb-jar-with-dependencies.jar /user/testbot/app.jar
WORKDIR /user/testbot/
CMD ["java", "-jar", "app.jar"]
