# -------- Stage 1: Build the WAR file --------
FROM maven:3.9.3-eclipse-temurin-17 AS builder

WORKDIR /app
COPY . .

# Clean build WAR without Spring Boot plugin execution
RUN mvn clean install -DskipTests

# -------- Stage 2: Use Tomcat to run the WAR --------
FROM tomcat:9.0

# Remove default ROOT webapp
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy WAR from builder stage to Tomcat's ROOT
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Match the Spring Boot server.port (8081)
EXPOSE 8081

# Tomcat CMD remains default
