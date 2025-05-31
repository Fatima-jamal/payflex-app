# -------- Stage 1: Build the WAR file --------
FROM maven:3.9.3-eclipse-temurin-17 AS builder

WORKDIR /app
COPY . .

RUN mvn clean package -DskipTests

# -------- Stage 2: Use Tomcat to run the WAR --------
FROM tomcat:9.0

# Remove default ROOT webapp
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy WAR from builder stage
COPY --from=builder /app/target/dptweb.war /usr/local/tomcat/webapps/ROOT.war

# Match this to Spring Boot app port
EXPOSE 8081

# Start Tomcat (default CMD from base image)
