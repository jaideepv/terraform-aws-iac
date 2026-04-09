# Terraform AWS DevOps Infrastructure

Infrastructure as Code (IaC) for AWS using Terraform. This project provisions a complete VPC with public and private subnets, EC2 instances, S3 bucket, and security groups.

## Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────────────┐
│                              AWS Cloud                                   │
│  ┌───────────────────────────────────────────────────────────────────┐  │
│  │                         VPC (10.0.0.0/16)                         │  │
│  │                                                                    │  │
│  │  ┌─────────────────────────────────────────────────────────────┐  │  │
│  │  │                    Public Subnets                          │  │  │
│  │  │  ┌─────────────────┐      ┌─────────────────┐               │  │  │
│  │  │  │   NAT Gateway   │      │  Web Server     │               │  │  │
│  │  │  │   (10.0.1.10)   │      │  EC2 (t3.micro) │               │  │  │
│  │  │  └─────────────────┘      │  Public IP      │               │  │  │
│  │  │                           └─────────────────┘               │  │  │
│  │  │  Subnet 1: 10.0.1.0/24    Subnet 2: 10.0.2.0/24              │  │  │
│  │  └─────────────────────────────────────────────────────────────┘  │  │
│  │                                                                    │  │
│  │  ┌─────────────────────────────────────────────────────────────┐  │  │
│  │  │                   Private Subnets                           │  │  │
│  │  │  ┌─────────────────┐      ┌─────────────────┐               │  │  │
│  │  │  │  App Server     │      │   App Server    │               │  │  │
│  │  │  │  EC2 (t3.micro)│      │  EC2 (t3.micro) │               │  │  │
│  │  │  │  10.0.10.x      │      │  10.0.11.x       │               │  │  │
│  │  │  └─────────────────┘      └─────────────────┘               │  │  │
│  │  │  Subnet 1: 10.0.10.0/24   Subnet 2: 10.0.11.0/24            │  │  │
│  │  └─────────────────────────────────────────────────────────────┘  │  │
│  │                                                                    │  │
│  │  ┌─────────────────────────────────────────────────────────────┐  │  │
│  │  │                          S3 Bucket                           │  │  │
│  │  │                    (Private, Encrypted)                      │  │  │
│  │  └─────────────────────────────────────────────────────────────┘  │  │
│  └───────────────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────────────┘
```

## Tech Stack

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform)
![AWS](https://img.shields.io/badge/AWS-FF9900?style=for-the-badge&logo=amazon-aws&logoColor=white)
![EC2](https://img.shields.io/badge/EC2-T3%20Micro-green?style=for-the-badge)
![VPC](https://img.shields.io/badge/VPC-Networking-orange?style=for-the-badge)
![S3](https://img.shields.io/badge/S3-Storage-blue?style=for-the-badge)
![IAM](https://img.shields.io/badge/IAM-Roles-yellow?style=for-the-badge)
![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-CI%2FCD-2088FF?style=for-the-badge&logo=github-actions)

## Features

- **VPC Infrastructure**: Multi-AZ setup with public and private subnets
- **EC2 Instances**: Auto-configured web and app servers
- **Security Groups**: Layered security (web → app → database)
- **S3 Bucket**: Versioned, encrypted storage with public access blocked
- **IAM Roles**:least privilege access for EC2 instances
- **NAT Gateway**: Private subnet internet access
- **GitHub Actions**: Automated terraform fmt, validate, plan on PRs

## Prerequisites

- [Terraform](https://www.terraform.io/downloads) >= 1.5.0
- [AWS Account](https://aws.amazon.com/free/) (Free Tier)
- [AWS CLI](https://aws.amazon.com/cli/) configured with credentials

## How to Run Locally

### 1. Configure AWS Credentials

```bash
# Option A: AWS CLI configure
aws configure

# Option B: Environment variables
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_DEFAULT_REGION="us-east-1"
```

### 2. Initialize Terraform

```bash
cd 2-terraform-aws-devops
terraform init
```

### 3. Create Terraform Variables File

Create `terraform.tfvars` (never commit this file):

```hcl
aws_region      = "us-east-1"
project_name     = "devops-portfolio"
environment      = "dev"
instance_type    = "t3.micro"  # Free tier eligible
instance_ami     = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2 in us-east-1
ssh_allowed_cidr = "YOUR_IP/32"  # Restrict SSH access!
```

### 4. Plan and Apply

```bash
# Preview changes
terraform plan

# Apply changes
terraform apply

# Type 'yes' when prompted
```

### 5. Get Outputs

```bash
terraform output
# Returns: web_server_url, ssh_command, s3_bucket_name, etc.
```

### 6. Clean Up

```bash
terraform destroy
# Type 'yes' when prompted to destroy all resources
```

## How to Deploy for FREE

### AWS Free Tier Eligibility

This infrastructure is designed to stay within AWS Free Tier limits:

| Resource | Free Tier Allowance | Cost After Free Tier |
|----------|--------------------|--------------------|
| EC2 t3.micro | 750 hours/month (12 months) | ~$0.01/hour |
| S3 | 5 GB Standard | $0.023/GB/month |
| NAT Gateway | 750 hours/month | $0.045/hour |
| VPC | Unlimited | FREE |

### Steps for Free Deployment

1. **Create AWS Account** → https://aws.amazon.com/free/
2. **Create SSH Key Pair** in EC2 Console → Key Pairs → Create
3. **Set restricted SSH** in terraform.tfvars: `"YOUR_HOME_IP/32"`
4. **Set billing alerts** in AWS Budgets to prevent surprise charges
5. **Use t3.micro only** (default) - do NOT change to larger instances
6. **Destroy after use** → `terraform destroy`

## What This Demonstrates to Recruiters

### Technical Skills Validated

```
Infrastructure as Code     ████████████████████  Expert
AWS Cloud Services         ████████████████████  Proficient
VPC Networking             ████████████████████  Expert
Security Groups/Firewalls ████████████████████  Expert
IAM Roles & Policies       ████████████████░░░░  Intermediate
Terraform CI/CD           ████████████████████  Expert
Cost Optimization         ████████████████░░░░  Intermediate
```

### Key Concepts Demonstrated

1. **Multi-Tier Architecture**: Web (public) → App (private) → Database layers
2. **Defense in Depth**: Multiple security groups with least-privilege rules
3. **High Availability**: Multi-AZ subnet design
4. **Infrastructure as Code**: Version-controlled, reproducible infrastructure
5. **GitOps**: Automated workflows via GitHub Actions
6. **Cloud Cost Awareness**: Free tier compatible design

### Common Interview Topics

- "How would you secure a VPC?"
- "Explain the difference between public and private subnets"
- "How does a NAT gateway work?"
- "Design a secure 3-tier architecture"
- "How do you manage secrets in Terraform?"

## Project Structure

```
2-terraform-aws-devops/
├── .github/
│   └── workflows/
│       ├── ci.yml           # Validation CI
│       └── terraform.yml    # Terraform workflow
├── main.tf                  # AWS resources
├── outputs.tf               # Output definitions
├── variables.tf            # Variable definitions
├── versions.tf             # Terraform version requirements
└── README.md
```

## GitHub Actions Secrets

Configure these secrets in your repository settings:

| Secret | Description |
|--------|-------------|
| `AWS_ACCESS_KEY_ID` | AWS access key with Terraform permissions |
| `AWS_SECRET_ACCESS_KEY` | AWS secret access key |
| `AWS_REGION` | (Optional) AWS region override |

## Troubleshooting

### Error: "No valid credentials found"

```bash
# Verify AWS CLI is configured
aws sts get-caller-identity
```

### Error: "Instance type not available"

```hcl
# Use t3.micro (available in all regions)
instance_type = "t3.micro"
```

### Error: "AMI not found"

```hcl
# Find your region's Amazon Linux 2 AMI
aws ec2 describe-images \
  --owners amazon \
  --filters "Name=name,Values=amzn2-ami-hvm-2.0.*" \
  --query 'sort_by(Images,&CreationDate)[-1].ImageId'
```

## License

MIT License - See LICENSE file for details.
