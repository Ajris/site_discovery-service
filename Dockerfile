FROM gradle:jdk12 as build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build

FROM openjdk:12-jdk-oracle
EXPOSE 8761
RUN mkdir /app
COPY --from=build /home/gradle/src/build/libs/*.jar /app/site_discovery-service.jar
ENTRYPOINT ["java", "-jar", "/app/site_discovery-service.jar"]