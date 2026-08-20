ADR-004: AWS Resource Inventory
Status
Accepted

MVP Resources
Frontend Layer
S3 Bucket

Static React website hosting
CloudFront Distribution

Frontend delivery
HTTPS
Authentication Layer
Cognito User Pool

Cognito User Pool Client

API Layer
API Gateway HTTP API
Routes:

GET /votes

POST /vote

PUT /vote

DELETE /vote

GET /results

Compute Layer
Lambda Function
Name:

svp-dev-vote-api

Responsibility:

Get votes
Create vote
Update vote
Delete vote
Get results
Data Layer
DynamoDB Table
Name:

svp-dev-votes

Partition Key:

userId

Monitoring
CloudWatch Log Group

CloudWatch Dashboard

CloudWatch Alarm

IAM
Lambda Execution Role

API Gateway Permissions

Future Resources
Not part of MVP.

Route53
ACM Custom Domain
AWS WAF
EventBridge
SNS Notifications
Multi-region deployment
