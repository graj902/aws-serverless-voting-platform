ADR-002: MVP Scope
Status
Accepted

Goal
Build a production-grade serverless voting application using AWS and Terraform.

Included in V1
Frontend
Login page
Registration page
Voting page
Results page
Authentication
Amazon Cognito User Pool
Email based signup
Login and logout
Backend APIs
GET /votes

POST /vote

PUT /vote

DELETE /vote

GET /results

Data Storage
Amazon DynamoDB

Infrastructure
Terraform

CI/CD
GitHub Actions

Monitoring
CloudWatch Logs

CloudWatch Dashboard

Basic CloudWatch Alarms

Security
IAM least privilege

S3 Block Public Access

CloudFront access to S3

HTTPS only

Not Included In V1
Custom Domain
Future phase

Route53
Future phase

WAF
Future phase

Multi Region Deployment
Future phase

Mobile Application
Future phase

Analytics Dashboard
Future phase

EventBridge Notifications
Future phase

Success Criteria
A user should be able to:

Register
Login
Vote
Change vote
Delete vote
View results
All infrastructure must be deployed using Terraform.
