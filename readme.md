# Terraform AWS Multi-Tier Web Application Infrastructure

This project demonstrates how to deploy a **multi-tier web application on AWS** using **Terraform** for **Infrastructure as Code (IaC)**. The architecture includes a **frontend and backend** hosted on **EC2 instances**, with a **managed RDS database**, all secured and isolated within a custom **VPC**.

### 🎯 Objective

- Automate AWS infrastructure provisioning using **Terraform**
- Deploy a scalable and secure **multi-tier architecture**
- Practice **Infrastructure as Code** (IaC) using best practices
- Understand real-world cloud components like **VPC, EC2, RDS, Security Groups**


### 🛠️ Tools Used

| Tool / Service | Purpose                                                           |
|----------------|-------------------------------------------------------------------|
| Terraform      | Infrastructure as Code (IaC) to provision AWS resources           |
| AWS VPC        | Provides isolated networking environment for the app              |
| AWS EC2        | Hosts the frontend and backend application servers                |
| AWS RDS        | Managed relational database service (e.g., MySQL or PostgreSQL)   |
| Security Groups| Acts as a virtual firewall to control inbound and outbound access |
| AWS IAM        | Manages roles and permissions                                     |


### 📂 Project Structure

```
terraform-aws-multitier-webapp/
├── main.tf                # Calls modules and connects everything
├── variables.tf           # Input variables for main config
├── outputs.tf             # Outputs from modules
├── modules/               # Reusable modules
│   ├── vpc/
│   ├── ec2/
│   └── rds/
└── README.md              # Project documentation
```


### ⚙️ What This Project Does

1. **Creates a custom VPC** with public and private subnets.
2. **Launches EC2 instances** in the public subnet for frontend.
3. **Deploys an RDS instance** in the private subnet for backend.
4. **Configures Security Groups** to:
   - Allow HTTP on port 80 to access from the internet to EC2 & SSH (port 22) to ssh into EC2.
   - Allow EC2 to access RDS on port 3306 (or 5432 for PostgreSQL)
5. Outputs useful details like public IP of **EC2 and DB endpoint**.


### 🏗️ Architecture Overview

![Project Diagram](https://github.com/ahsan598/terraform-aws-multitier-webapp/blob/main/screenshots/multi-tier.png)

---

### 🚀 How to Run This Project Locally

> Make sure you have [Terraform](https://developer.hashicorp.com/terraform/downloads) and an [AWS account](https://aws.amazon.com/) with configured credentials (`aws configure`).


**Step 1: Clone the repository**
```bash
git clone https://github.com/ahsan598/terraform-aws-multitier-webapp.git
cd multi-tier-terraform
```

**Step 2: Create a terraform.tfvars file**
This file will hold your custom values for variables such as AWS region, VPC CIDR, database name, etc.

**Ex:**
```hcl
aws_region = "us-east-1"
vpc_cidr   = "10.0.0.0/16"
db_name    = "mydb"
db_user    = "admin"
db_pass    = "StrongPassword123"
```

> **Note**: terraform.tfvars is ignored by .gitignore to prevent committing sensitive information.


**Step 3: Initialize Terraform**
```bash
terraform init
```

**Step 4: Validate and Plan**
```bash
terraform validate
terraform plan -var-file="terraform.tfvars"
```

**Step-5: Apply changes**
```bash
terraform apply -var-file="terraform.tfvars"
```

**Step 6: Confirm outputs**
Terraform will display outputs like:
```bash
ec2_public_ip = "13.234.56.78"
rds_endpoint  = "mydb.xxxxxx.us-east-1.rds.amazonaws.com"
```

**Step 7: Clean up (Optional)**
```bash
terraform destroy
```


### 🧪 Terraform Commands (Quick Overview)

| Command             | Description                                          |
|---------------------|------------------------------------------------------|
| `terraform init`    | Initialize working directory and download providers. |
| `terraform plan`    | Show execution plan without making changes.          |
| `terraform apply`   | Create or update infrastructure as per plan.         |
| `terraform destroy` | Remove all managed infrastructure.                   |


### 📚 What I Have Learned
- Building real-world infrastructure using Terraform modules
- Using input variables and outputs efficiently
- Structuring Terraform projects for clarity and reusability
- Understanding cloud networking and tiered architecture
- Applying security best practices with IAM and SGs

---

### 🔗 Learning Resources
- [Terraform AWS Provider Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Terraform VPC Tutorial](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-create)
- [AWS VPC Documentation](https://docs.aws.amazon.com/vpc/)
- [Learn Terraform Modules](https://developer.hashicorp.com/terraform/language/modules)

