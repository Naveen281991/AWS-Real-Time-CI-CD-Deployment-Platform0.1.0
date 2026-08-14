resource "aws_iam_role" "ecs_task_execution" {
  name = "AWS-CICD-ECS-TaskExecution-Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }

      Action = "sts:AssumeRole"
    }]
  })

  tags = {
    Name = "AWS-CICD-ECS-TaskExecution-Role"
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_cluster" "main" {
  name = "aws-enterprise-cicd-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = "aws-enterprise-cicd-cluster"
  }
}

resource "aws_cloudwatch_log_group" "ecs" {
  name              = "/ecs/aws-enterprise-cicd-app"
  retention_in_days = 7

  tags = {
    Name = "aws-enterprise-cicd-app-logs"
  }
}

resource "aws_ecs_task_definition" "application" {
  family                   = "aws-enterprise-cicd-app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = "256"
  memory = "512"

  execution_role_arn = aws_iam_role.ecs_task_execution.arn

  container_definitions = jsonencode([
    {
      name      = "aws-enterprise-cicd-app"
      image     = "${aws_ecr_repository.application.repository_url}:latest"
      essential = true

      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
          protocol      = "tcp"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"

        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs.name
          awslogs-region        = "us-east-1"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])

  tags = {
    Name = "aws-enterprise-cicd-app-task"
  }
}
