# Use an official OpenJDK image as the base
FROM openjdk:11-jre-slim

# Copy the WAR file into the container
COPY **/*.war /app/

# Expose any necessary ports (adjust as needed)
EXPOSE 8080

# CMD to start the Spring Boot application
CMD ["java", "-jar", "/app/**/*.war"]
