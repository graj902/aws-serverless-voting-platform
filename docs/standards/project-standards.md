Project Standards
Naming Convention
AWS Resources
Pattern:

--

Examples:

voting-dev-lambda voting-dev-api voting-dev-table

AWS Region
ap-south-1

Resource Tags
Every AWS resource must include:

Project=serverless-voting-platform ManagedBy=Terraform Environment=dev Owner=Gururaj

Terraform Rules
No resource creation through console
Everything managed through Terraform
Modular architecture
Remote state mandatory
Source Control
Branch:

main

Future:

feature/* bugfix/*

Documentation Rules
Every major component must have:

Purpose
Design
Deployment steps
Troubleshooting notes
Security Rules
Least privilege IAM
No hardcoded secrets
Use AWS managed encryption
Public access blocked wherever possible
