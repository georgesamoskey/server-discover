# Use an official Maven image as the base image
FROM maven:3.8.4-openjdk-17 AS build
# Set the working directory in the container
WORKDIR /asyst-payall-server-discovery
# Copy the pom.xml and the project files to the containers
COPY pom.xml .
COPY src ./src
# Build the application using Maven
RUN mvn  clean package -DskipTests
# Use an official OpenJDK image as the base 
FROM openjdk:17
# Set the working directory in the con
WORKDIR /payall
# Copy the built JAR file from the previous stage to the container
COPY --from=build /payall/target/*.jar app.jar

# Set the command to run the applications
CMD ["java", "-jar", "app.jar"]
