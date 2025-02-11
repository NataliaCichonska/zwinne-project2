FROM openjdk:21-jdk-slim

WORKDIR /app

# Copy jar from GitHub Action
COPY backend.jar app.jar

# Copy Tesseract data files
COPY src/main/resources/tessdata /usr/share/tessdata/

# Set TESSDATA_PREFIX environment variable
ENV TESSDATA_PREFIX=/usr/share/tessdata/

# Expose the application port
EXPOSE 8080

# Use JSON format for CMD and validate OPENAI_API_KEY using entrypoint script
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["java", "-jar", "app.jar"]
