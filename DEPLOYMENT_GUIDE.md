# Deployment Guide for Multi-Stage Dockerized Java Login App on AWS using Terraform

## Overview

This guide outlines the complete deployment process for a Java-based login web application hosted on AWS. The application is built with Java and Spring Boot, containerized using a multi-stage Dockerfile, and deployed using Infrastructure as Code (IaC) through Terraform. This deployment leverages multiple AWS services for scalability, availability, and observability, including EC2 Auto Scaling, RDS (PostgreSQL), Application Load Balancer (ALB), Metabase BI Tool, and secure networking via VPC, subnets, and security groups.

The system supports CI/CD automation through GitHub Actions, HTTPS via ACM, and a custom domain using Route 53.

---

## Architecture Components

* **VPC** with custom public and private subnets
* **Internet Gateway** and **Route Tables** for routing
* **Security Groups** configured for ALB, EC2, RDS, and Metabase
* **Launch Template** for EC2 instances running the Java App via Docker
* **Auto Scaling Group** for backend scalability
* **Application Load Balancer (ALB)** with target group on port 8080
* **PostgreSQL RDS** in private subnet with restricted access
* **Metabase EC2** (public subnet) for BI dashboarding
* **ACM Certificate + Route 53** for domain and HTTPS support

---

## Prerequisites

* AWS account with Administrator-level IAM user
* SSH Key Pair named `FJMS` created in AWS region `us-west-1`
* AWS CLI installed and configured (`aws configure`)
* Terraform >= v1.0 installed
* Docker installed (for local build/testing)
* GitHub repository configured with two workflows:

  * `maven.yml` to build Java JAR file
  * `docker-build.yml` to build & push Docker image to DockerHub

---

## Directory Structure

```bash
project-root/
├── terraform/
│   ├── main.tf
│   ├── terraform.tfvars
│   ├── variables.tf
│   ├── scripts/
│   │   └── user_data.sh
│   └── modules/
│       ├── vpc/
│       ├── ec2/
│       ├── asg/
│       ├── alb/
│       ├── rds/
│       ├── rds_sg/
│       ├── security_groups/
│       └── metabase/
├── docker/
│   └── Dockerfile
├── src/ (Java code)
├── pom.xml
└── .github/workflows/
    ├── maven.yml
    └── docker-build.yml
```

---

## Step-by-Step Deployment

### 1. Configure AWS CLI

```bash
aws configure
```

Provide:

* AWS Access Key ID
* AWS Secret Access Key
* Default Region: `us-west-1`

---

### 2. Initialize Terraform Modules

```bash
cd terraform
terraform init
```

This downloads all Terraform providers and initializes the working directory.

---

### 3. Review the Terraform Plan

```bash
terraform plan
```

Validates the configuration and shows what changes will be made.

---

### 4. Apply the Terraform Plan

```bash
terraform apply
```

* Type `yes` to confirm infrastructure creation.
* Resources created:

  * Custom VPC, public/private subnets
  * Security groups
  * ALB with listener on port 8080
  * EC2 launch template and Auto Scaling Group
  * RDS PostgreSQL instance in private subnet
  * EC2 for Metabase (Docker-based)

---

## Application Access

### Java Login App (via ALB)

```bash
terraform output alb_dns_name
```

Visit:

```
http://<ALB_DNS>:8080
```

Example:

```
http://fatimajamal.devopsagent.online:8080
```

---

### SSH into EC2 Instance (App Server or Metabase)

```bash
ssh -i ~/.ssh/FJMS.pem ec2-user@<EC2-PUBLIC-IP>
```

Replace `<EC2-PUBLIC-IP>` with the actual IP of the instance.

---

### PostgreSQL RDS Access (via SSH Tunnel)

```bash
ssh -i ~/.ssh/FJMS.pem -L 5432:<RDS-ENDPOINT>:5432 ec2-user@<EC2-PUBLIC-IP>
```

Then connect locally using:

```bash
psql -h localhost -U postgresadmin -d postgres
```

---

### Metabase BI Tool

Visit in browser:

```
http://<METABASE-EC2-IP>:3000
```

Login and connect to RDS using:

* Host: `postgres-db.cfoaacgcm9hg.us-west-1.rds.amazonaws.com`
* Port: `5432`
* User: `postgresadmin`
* Password: `StrongPassword123!`
* Database: `postgres` or `users`

---

## Terraform Output Variables

Run this after apply:

```bash
terraform output
```

It will display:

* ALB DNS Name
* EC2 Public IPs (Metabase)
* RDS Endpoint
* Subnet IDs

---

## CI/CD Automation

**GitHub Actions Workflows:**

* `maven.yml` builds Java code and creates `.jar`
* `docker-build.yml` builds Docker image and pushes to DockerHub

EC2 instances automatically pull latest image using `user_data.sh`.

---

## Monitoring & Logging

### AWS Console:

* Auto Scaling Group → View scaling events and health status
* ALB → Target group health, request count, and 4xx/5xx errors
* EC2 → Monitor instance logs via CloudWatch (optional)

### Metabase:

* Visualize login data from `users` table
* Add dashboards for password reuse, email domain analysis, and signup trends

---

## Destroy Infrastructure

```bash
terraform destroy
```

* Type `yes` to confirm.
* Note: RDS may take several minutes due to final snapshot setting.

---

## Best Practices

* Keep `.tfvars` files and credentials out of Git
* Use parameterized modules for reusability
* Enable ALB access logging (optional enhancement)
* Consider private Docker Registry for enterprise environments
* Use S3 and DynamoDB for remote Terraform state in production

---
