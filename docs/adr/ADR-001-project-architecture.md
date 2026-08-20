ADR-001: Serverless Voting Platform Architecture
Status
Accepted

Date
2026-08-20

Context
This project is being built as a production-grade portfolio application to demonstrate:

AWS Serverless Architecture
Terraform Infrastructure as Code
GitHub Actions CI/CD
Security Best Practices
Observability
DevOps Engineering Skills
Decision
The platform will use:

Frontend
React
TypeScript
Vite
Hosted on:

Amazon S3
Amazon CloudFront
Authentication
Amazon Cognito User Pool
Cognito App Client
API Layer
API Gateway HTTP API
Compute
AWS Lambda
Node.js 22 Runtime
Database
DynamoDB
Infrastructure
Terraform
CI/CD
GitHub Actions
Monitoring
CloudWatch Logs
CloudWatch Metrics
CloudWatch Alarms
Region
ap-south-1
Consequences
Benefits:

Fully serverless
Low cost
Highly scalable
Minimal operational overhead
Strong portfolio value
Trade-offs:

AWS service limits must be understood
Debugging distributed components requires monitoring
