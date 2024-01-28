## Terraform

### Prerequisites

- Terraform 0.12.0 or later

The terraform files in this folers crate the following resources:

- A VPC - Global
- A public subnet - regional
- A private subnet - regional
- A NAT Gateway
_ Firewall rules
- Cloud SQL instance - regional
- A Cloud SQL database
- A Cloud SQL user
- A Cloud SQL user password
- A Cloud SQL database instance
- Private Autopilot cluster
- A Cloud Storage bucket

## Usage

To run this code you need to execute:

```bash
terraform init
terraform plan
terraform apply
```

Note that this code may create resources which can cost money. Run `terraform destroy` when you don't need these resources.