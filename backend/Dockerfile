# Build stage
FROM gradle:8.12.1-jdk23-alpine AS build

WORKDIR /app

# Copy gradle files first for better caching
COPY gradlew .
COPY gradle/ gradle/
COPY build.gradle ./

# Ensure the Gradle wrapper has the correct permissions
RUN chmod +x ./gradlew

# Copy source code
COPY src/ src/

# Build the application using the Gradle wrapper
RUN ls -lah
RUN ./gradlew build -x test --no-daemon

# Run stage
FROM openjdk:11-jre-slim

WORKDIR /app

# Copy jar from build stage
COPY --from=build /app/build/libs/*.jar app.jar

# Expose the application port
EXPOSE 8080

# Use JSON format for CMD and validate API_KEY using entrypoint script
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["java", "-jar", "app.jar"]
