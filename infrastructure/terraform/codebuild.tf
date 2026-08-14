resource "aws_iam_role" "codebuild" {
  name = "AWS-CICD-CodeBuild-Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Principal = {
        Service = "codebuild.amazonaws.com"
      }

      Action = "sts:AssumeRole"
    }]
  })

  tags = {
    Name = "AWS-CICD-CodeBuild-Role"
  }
}

resource "aws_iam_role_policy" "codebuild" {
  name = "AWS-CICD-CodeBuild-Policy"
  role = aws_iam_role.codebuild.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid    = "CloudWatchLogs"
        Effect = "Allow"

        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]

        Resource = "*"
      },
      {
        Sid    = "ECRAuthentication"
        Effect = "Allow"

        Action = [
          "ecr:GetAuthorizationToken"
        ]

        Resource = "*"
      },
      {
        Sid    = "ECRPush"
        Effect = "Allow"

        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:CompleteLayerUpload",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]

        Resource = aws_ecr_repository.application.arn
      },
      {
        Sid    = "STSIdentity"
        Effect = "Allow"

        Action = [
          "sts:GetCallerIdentity"
        ]

        Resource = "*"
      }
    ]
  })
}

resource "aws_codebuild_project" "application" {
  name          = "AWS-Enterprise-CICD-Build"
  description   = "Build, test, containerize and publish the application to Amazon ECR"
  service_role  = aws_iam_role.codebuild.arn
  build_timeout = 20

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    privileged_mode             = true
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = "us-east-1"
    }

    environment_variable {
      name  = "ECR_REPOSITORY"
      value = aws_ecr_repository.application.name
    }

    environment_variable {
      name  = "CONTAINER_NAME"
      value = "aws-enterprise-cicd-app"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "/aws/codebuild/AWS-Enterprise-CICD-Build"
      stream_name = "build"
    }
  }

  tags = {
    Name = "AWS-Enterprise-CICD-Build"
  }
}