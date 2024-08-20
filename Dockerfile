# Use a base image that includes Java and Maven
FROM maven:3.9.9-eclipse-temurin-22 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the entire project directory into the container
COPY . .

# Build the project using Maven
RUN mvn clean package

# Expose the port that the application will run on
EXPOSE 8080

# Second stage: Use a smaller base image to run the Java application
FROM openjdk:22-jdk-slim

# Set the working directory in the final image
WORKDIR /app

# Copy the jar file from the build stage to the final image
COPY --from=build /app/target/movie-0.0.1-SNAPSHOT.jar /app/app.jar

# Verify the JAR file is copied
RUN ls -l /app

# Command to run the Spring Boot application
CMD ["java", "-jar", "app.jar"]