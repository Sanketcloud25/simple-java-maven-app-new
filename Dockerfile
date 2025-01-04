# Use an official Maven image with JDK 11 as the build stage
FROM maven:3.8.8-openjdk-11 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the application's source code to the container
COPY . .

# Build the application and package it
RUN mvn clean package -DskipTests

# Use a lightweight JDK base image for the runtime stage
FROM openjdk:11-jre-slim

# Set the working directory for the runtime container
WORKDIR /app

# Copy the built JAR file from the builder stage
COPY --from=builder /app/target/my-app-1.0-SNAPSHOT.jar app.jar

# Expose the port the application will run on
EXPOSE 8080

# Define the command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
