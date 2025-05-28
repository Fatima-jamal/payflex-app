# -------- Stage 1: Build the JAR file --------
FROM maven:3.9.3-eclipse-temurin-17 AS builder

WORKDIR /app
COPY . .

RUN mvn clean package -DskipTests

# -------- Stage 2: Run the Spring Boot JAR --------
FROM openjdk:17-jdk-slim

WORKDIR /app

# Copy the JAR from builder stage
COPY --from=builder /app/target/dptweb-1.0.jar /app/app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.jar"]
