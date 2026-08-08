data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_instance" "application" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.application.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_codedeploy.name
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash

    set -e

    apt-get update -y

    apt-get install -y \
      ruby-full \
      wget \
      curl \
      nginx

    systemctl enable nginx
    systemctl start nginx

    echo "AWS Enterprise CI/CD EC2 server initialized."
  EOF

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
    encrypted   = true
  }

  tags = {
    Name = "aws-cicd-application-server"
    Role = "application"
  }
}