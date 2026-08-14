resource "aws_iam_role" "ec2_codedeploy" {
  name = "AWS-CICD-EC2-CodeDeploy-Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "AWS-CICD-EC2-CodeDeploy-Role"
  }
}


resource "aws_iam_role_policy" "ec2_codedeploy_s3" {
  name = "AWS-CICD-EC2-CodeDeploy-S3-Read"
  role = aws_iam_role.ec2_codedeploy.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid    = "ReadCICDArtifacts"
        Effect = "Allow"

        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion"
        ]

        Resource = "${aws_s3_bucket.artifacts.arn}/*"
      },
      {
        Sid    = "ListCICDArtifacts"
        Effect = "Allow"

        Action = [
          "s3:ListBucket"
        ]

        Resource = aws_s3_bucket.artifacts.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_ssm" {
  role       = aws_iam_role.ec2_codedeploy.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ec2_codedeploy" {
  name = "AWS-CICD-EC2-CodeDeploy-Profile"
  role = aws_iam_role.ec2_codedeploy.name

  tags = {
    Name = "AWS-CICD-EC2-CodeDeploy-Profile"
  }
}


resource "aws_iam_role" "codedeploy" {
  name = "AWS-CICD-CodeDeploy-Service-Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "codedeploy.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "AWS-CICD-CodeDeploy-Service-Role"
  }
}

resource "aws_iam_role_policy_attachment" "codedeploy" {
  role       = aws_iam_role.codedeploy.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}