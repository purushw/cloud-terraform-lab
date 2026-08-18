# Azure Terraform DB Lab

This is a mini-lab project to demonstrate provisioning an Azure SQL Server and Database using Terraform.

## Features
	•	Resource Group
	•	Azure SQL Server
	•	Azure SQL Database
	•	Firewall rules (Azure services + optional public IP)
	•	Modular structure with variables and outputs

## Usage
	1.	Copy terraform.tfvars.example to terraform.tfvars and update values.
	2.	Set secrets via environment variables (recommended).
	3.	Run:

    terraform init
    terraform plan -out plan.tfplan
    terraform apply plan.tfplan

	4.	Clean up when done:
    
    terraform destroy -auto-approve

## Notes
	•	Do not commit terraform.tfvars (add it to .gitignore).
	•	Use terraform.tfvars.example as a template.
