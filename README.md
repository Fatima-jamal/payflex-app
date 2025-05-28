# Java Login App – DevOps Final Semester Project

This repository contains the infrastructure-as-code (IaC) and Dockerized application setup for deploying a **Java-based Login Web Application** on AWS using **Terraform**, **Docker**, and **EC2 Auto Scaling**, with a PostgreSQL **RDS**, **Metabase BI Tool**, and **Application Load Balancer (ALB)** configured for high availability and observability.

---

## Project Objectives

* Build a scalable and secure containerized deployment of a Java web application.
* Use Terraform modules for reusable infrastructure provisioning.
* Configure Auto Scaling and ALB for high availability.
* Secure databases in private subnets and restrict access via Security Groups.
* Deploy Metabase for real-time data analysis.
* Use a custom domain with HTTPS support via ALB + Route 53 + ACM.

---

## Folder Structure

```bash
.
├── terraform/                  # Main Terraform root module
│   ├── main.tf                 # Calls all modules
│   ├── variables.tf            # Global variables
│   ├── terraform.tfvars        # Variable values
│   └── scripts/
│       └── user_data.sh        # EC2 bootstrap script
│
├── modules/
│   ├── vpc/                    # VPC, subnets, routing
│   ├── ec2/                    # Launch template for Java App EC2
│   ├── asg/                    # Auto Scaling Group
│   ├── alb/                    # Application Load Balancer
│   ├── rds/                    # PostgreSQL RDS setup
│   ├── rds_sg/                 # Security Group for RDS
│   ├── security_groups/        # EC2 & ALB security groups
│   └── metabase/               # EC2 deployment for Metabase
│
└── docker/
    └── Dockerfile              # Dockerized Java App
```

---

## Tools & Technologies

* **AWS EC2, RDS, ALB, VPC, IAM, Route 53, ACM**
* **Terraform (modular structure)**
* **Docker (multi-stage build)**
* **Metabase (BI Tool)**
* **PostgreSQL (RDS)**
* **Nginx reverse proxy (optional)**

---

## Features Implemented

* Java Login App containerized and deployed via EC2 Auto Scaling
* PostgreSQL RDS in private subnets, inaccessible publicly
* ALB configured with listener on port 8080 → target group → EC2
* Metabase deployed on EC2 in public subnet with SSH Key access
* Security Groups allow only necessary traffic:

  * ALB → EC2 (port 8080)
  * EC2 → RDS via internal SG
* Infrastructure provisioned using isolated and reusable Terraform modules
* Docker image pushed to DockerHub, pulled by EC2 at runtime

---

## Security Best Practices

* No public IP assigned to RDS
* EC2 access via SSH key pair only (restricted to user IP)
* Metabase exposed only via its own EC2 instance
* Security Groups whitelisted per role
* IAM roles used only where needed

---

## Pre-requisites

* AWS Account with Access & Secret keys configured
* SSH Key Pair (`FJMS`) created in `us-west-1`
* Docker installed and DockerHub account set up
* Terraform >= 1.0.0 installed

---

## Deployment Instructions

```bash
# 1. Configure AWS credentials
aws configure

# 2. Navigate to Terraform directory
cd terraform

# 3. Initialize Terraform modules
terraform init

# 4. Review deployment plan
terraform plan

# 5. Apply infrastructure changes
terraform apply
```

---

## Accessing the Application

Once Terraform apply completes:

* Access the **Java Login App** via the DNS of ALB (output in `terraform output`)
* Access **Metabase** using EC2 public IP (SSH or browser)
* Use SSH to connect and inspect logs if needed

---

## Teardown Instructions

```bash
# Destroy all infrastructure
terraform destroy
```

> Note: RDS teardown may take time due to database backup/retention operations.

---

## Monitoring & Observability

* AWS Console → EC2 Auto Scaling Groups → Monitor instance count
* ALB Metrics (HTTP requests, Target health)
* Metabase BI tool connected to PostgreSQL RDS for insights

---

## Documentation

* For a step-by-step deployment process, see [DEPLOYMENT\_GUIDE.md](./DEPLOYMENT_GUIDE.md).
* Ensure all `.tf` modules are inside respective folders under `modules/` directory.

---

## Final Remarks

This project showcases a production-ready architecture for deploying containerized applications on AWS using Infrastructure as Code. Feel free to fork, extend, and enhance as needed.
