# -------- Stage 1: Build the WAR file --------
FROM maven:3.9.3-eclipse-temurin-17 AS builder

WORKDIR /app
COPY . .

RUN mvn clean package -DskipTests

# -------- Stage 2: Use Tomcat to run the WAR --------
FROM tomcat:9.0

# Remove default ROOT webapp (optional)
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy WAR file from builder stage
COPY --from=builder /app/target/dptweb.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

# Start Tomcat server (default CMD in base image)
