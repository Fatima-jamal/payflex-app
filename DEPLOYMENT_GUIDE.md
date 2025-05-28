# Deployment Guide for Java Login App on AWS using Terraform

## Overview

This guide details how to deploy a Java-based login application on AWS using Terraform for Infrastructure as Code (IaC). The deployment includes:

* VPC with public and private subnets
* EC2 Auto Scaling Group for the app
* Application Load Balancer (ALB)
* RDS (PostgreSQL) in private subnets
* Metabase (BI tool) EC2 instance
* Security Groups for ALB, EC2, RDS, and Metabase

## Prerequisites

* AWS Account
* IAM User with Administrator Access
* AWS CLI installed and configured (`aws configure`)
* Terraform installed (v1.0 or higher)
* SSH Key Pair (e.g., `FJMS`) uploaded in the AWS region
* Docker installed (for local builds if needed)

## Directory Structure

```bash
terraform/
├── main.tf
├── terraform.tfvars
├── modules/
│   ├── vpc/
│   ├── ec2/
│   ├── alb/
│   ├── asg/
│   ├── rds/
│   ├── rds_sg/
│   ├── security_groups/
│   └── metabase/
└── scripts/
    └── user_data.sh
```

## Step-by-Step Instructions

### 1. Initialize Terraform

```bash
cd terraform
terraform init
```

### 2. Review the Execution Plan

```bash
terraform plan
```

### 3. Apply the Configuration

```bash
terraform apply
```

* Type `yes` when prompted.

### 4. Access the Application

* After apply completes, copy the ALB DNS from the Terraform output:

```bash
terraform output alb_dns_name
```

* Visit `http://<ALB_DNS>:8080` to access the login app.

### 5. SSH into EC2 (if needed)

```bash
ssh -i ~/.ssh/FJMS.pem ec2-user@<EC2-Public-IP>
```

### 6. Connect to RDS (Optional - via SSH Tunnel)

Use SSH tunneling to securely access RDS:

```bash
ssh -i ~/.ssh/FJMS.pem -L 5432:<RDS-ENDPOINT>:5432 ec2-user@<EC2-Public-IP>
```

Then connect using any PostgreSQL client:

```bash
psql -h localhost -U postgresadmin -d postgres
```

### 7. Access Metabase

```bash
http://<Metabase-Public-IP>:3000
```

## Destroy Resources

When done, clean up all resources:

```bash
terraform destroy
```

* Type `yes` when prompted.

## Notes

* Ensure RDS is deployed in private subnets only.
* Verify security group rules are tight and restrict unnecessary access.
* Always use version control (e.g., Git) for managing `.tf` files.

---

This deployment guide ensures a production-like setup that is reproducible and scalable using Terraform.
