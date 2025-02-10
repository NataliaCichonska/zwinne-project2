# Use a multi-stage build to create the final image

# Run stage
FROM openjdk:11-jre-slim

WORKDIR /app

# Copy jar from GitHub Action
COPY app.jar app.jar

# Expose the application port
EXPOSE 8080

# Use JSON format for CMD and validate API_KEY using entrypoint script
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["java", "-jar", "app.jar"]
