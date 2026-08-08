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