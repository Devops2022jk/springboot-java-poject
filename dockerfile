# Step 1: Use a Maven image to build the application
FROM maven:3.8.5-openjdk-17 AS builder
WORKDIR /app

# Copy the application source code
COPY . .

# Build the application
RUN mvn clean package

# Step 2: Use a lightweight Java runtime to run the application
FROM eclipse-temurin:17-jre-alpine
WORKDIR /

# Copy the built JAR file from the builder stage
COPY --from=builder /app/target/spring-boot-web.jar /app.jar

# Expose the default Spring Boot port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "/app.jar"]
