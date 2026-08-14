# AWS Enterprise Real-Time CI/CD Platform

## Overview

This project implements an automated CI/CD platform on AWS for deploying a Node.js application from source control to an EC2 production environment.

The platform is designed to demonstrate real-world DevOps practices including automated testing, continuous integration, artifact management, deployment automation, infrastructure as code, IAM security, and application health validation.

## Architecture

GitHub
  ↓
AWS CodePipeline
  ↓
AWS CodeBuild
  ↓
Automated Tests
  ↓
Amazon S3
  ↓
AWS CodeDeploy
  ↓
Amazon EC2
  ↓
Node.js Application

## Technologies

- Git
- GitHub
- Node.js
- Express
- Jest
- AWS CodePipeline
- AWS CodeBuild
- AWS CodeDeploy
- Amazon EC2
- Amazon S3
- AWS IAM
- Amazon CloudWatch
- Terraform

## CI Workflow

1. Developer pushes code to GitHub.
2. CodePipeline detects the source revision.
3. CodeBuild installs dependencies.
4. Automated tests are executed.
5. Application artifacts are generated.
6. Successful builds continue to deployment.

## CD Workflow

1. CodePipeline passes the successful artifact to CodeDeploy.
2. CodeDeploy deploys the artifact to EC2.
3. Deployment lifecycle scripts start the application.
4. A health endpoint validates the deployment.
5. The deployment succeeds only when application validation passes.

## Application

The application provides:

- `/`
- `/health`

The `/health` endpoint is used for deployment validation.

## Project Status

Initial application and CI/CD configuration completed.

Infrastructure deployment is being developed using Terraform.



LAYERS: 

1. AWS account/region verification
2. Terraform provider
3. VPC/network
4. Security group
5. IAM roles
6. S3 artifact bucket
7. EC2
8. CodeDeploy
9. CodeBuild
10. CodePipeline
11. GitHub connection
12. First automatic deployment


EC2 Security Group:

| Traffic  | Port | Source                  | Purpose                   |
| -------- | ---: | ----------------------- | ------------------------- |
| SSH      |   22 | **Your public IP only** | Administration            |
| HTTP     |   80 | `0.0.0.0/0`             | Application access        |
| HTTPS    |  443 | `0.0.0.0/0`             | Future TLS                |
| Outbound |  All | `0.0.0.0/0`             | Updates/package downloads |


+--------------+-------------------------------+
|  Name        |  aws-cicd-application-server  |
|  Application |  AWS-Enterprise-CICD-App      |
|  Role        |  application                  |
|  Project     |  AWS-Enterprise-CICD          |
|  Environment |  production                   |
|  ManagedBy   |  Terraform                    |


{                                                                                                                                           
    "deploymentGroupInfo": {
        "applicationName": "AWS-Enterprise-CICD-App",
        "deploymentGroupId": "3c5ebc3c-9c67-49e3-8137-68388350c412",
        "deploymentGroupName": "AWS-Enterprise-CICD-DeploymentGroup",
        "deploymentConfigName": "CodeDeployDefault.AllAtOnce",
        "ec2TagFilters": [
            {
                "Key": "Project",
                "Value": "AWS-Enterprise-CICD",
                "Type": "KEY_AND_VALUE"


                Understand appspec.yml

This is the deployment lifecycle:

CodeDeploy
    │
    ▼
ApplicationStop
    │
    ▼
BeforeInstall
    │
    ▼
Copy application files
    │
    ▼
AfterInstall
    │
    ▼
ApplicationStart
    │
    ▼
ValidateService


AUTOMATE: 

              Developer
                  │
                  ▼
               GitHub
                  │
             CodePipeline
                  │
                  ▼
              CodeBuild
                  │
          ┌───────┴────────┐
          │                │
       npm test        Docker build
          │                │
          └───────┬────────┘
                  ▼
                 ECR
                  │
                  ▼
             ECS Fargate
                  │
                  ▼
                 ALB
                  │
                  ▼
             Live App 🚀