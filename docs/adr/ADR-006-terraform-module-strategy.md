# ADR-006: Terraform Module Strategy

## Status
Accepted

## Context
The project requires a maintainable, scalable, and reusable infrastructure codebase. As a serverless application utilizing various AWS services (S3, CloudFront, Cognito, DynamoDB, API Gateway, Lambda, IAM), we must define a structure for our Terraform configuration that promotes clarity and minimizes duplication while adhering to infrastructure-as-code best practices.

## Decision
We will adopt a service-based Terraform module strategy. Infrastructure will be decomposed into small, reusable modules, each corresponding to a specific AWS service or logical unit of the architecture.

### Terraform Directory Structure
```text
infra/
├── environments/
│   └── dev/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── modules/
    ├── apigateway/
    ├── cloudfront/
    ├── cognito/
    ├── dynamodb/
    ├── iam/
    ├── lambda/
    ├── monitoring/
    └── s3/
```

## Why Service-Based Modules Were Chosen
Service-based modules offer the best balance of modularity, readability, and ease of management for this project's scale. 
- **Encapsulation:** Each module encapsulates the configuration required for a specific AWS service, making it easier to reason about the infrastructure components.
- **Reusability:** Common configurations (e.g., S3 bucket with standard policies) can be reused across different environments or projects.
- **Maintainability:** Changes to a specific service configuration are isolated within its module, reducing the risk of regressions in unrelated infrastructure.

## Why a `resources/` Abstraction Layer Was Rejected for MVP
An additional `resources/` abstraction layer (e.g., creating higher-level modules that group multiple services) was considered but rejected for the MVP.
- **Complexity:** Adding an abstraction layer introduces unnecessary complexity for the initial scope of the application.
- **Flexibility:** Service-based modules provide sufficient flexibility to construct the infrastructure as needed without the overhead of maintaining an intermediate grouping layer.
- **MVP Focus:** We aim for rapid delivery of a functional prototype; simple, service-based modules allow us to iterate faster.

## Future Evolution Considerations
As the project grows, we may revisit the following:
- **Terragrunt:** If infrastructure complexity increases across many environments, Terragrunt could be introduced to manage backend state and module composition more efficiently.
- **Module Versioning:** As the codebase matures, we will implement semantic versioning for our modules to ensure stability and controlled updates across environments.
- **Orchestration Layers:** If logical groupings (e.g., "auth-stack" combining Cognito and Lambda) become recurring patterns, we will introduce higher-level modules to simplify environment-specific definitions.
