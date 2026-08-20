ADR-003: Naming Conventions
Status
Accepted

Project Short Name
svp

(Serverless Voting Platform)

Environment
dev

AWS Region
ap-south-1

Resource Naming Pattern
svp--

Examples:

svp-dev-api svp-dev-lambda svp-dev-dynamodb svp-dev-cognito

DynamoDB Table
svp-dev-votes

Lambda Functions
svp-dev-vote-api

API Gateway
svp-dev-api

Cognito User Pool
svp-dev-users

Frontend Bucket
svp-dev-frontend

CloudFront Distribution
svp-dev-cloudfront

CloudWatch Log Group
/svp/dev/lambda/vote-api

Terraform State Bucket
svp-tf-state

Terraform Lock Table
svp-tf-lock
