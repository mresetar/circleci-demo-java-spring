FROM docker.io/library/adoptopenjdk:11.0.3_7-jdk-hotspot

ENV SPRING_PROFILES_ACTIVE=local

COPY build/libs/*.jar /app/server.jar

WORKDIR /app

EXPOSE 8080

ENTRYPOINT ["/bin/bash", "-c", "java -jar /app/server.jar"]
