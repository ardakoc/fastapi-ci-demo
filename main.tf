# Specify which cloud provider we'll use
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Choose which AWS region and which profile we will run in
provider "aws" {
  region = "eu-central-1" # Frankfurt
  profile = "personal"
}

# Define Jenkins and our first virtual server (EC2) where we'll host our app
resource "aws_instance" "devops_server" {
  ami = "ami-0084a47cc718c111a" # Frankfurt ID of Ubuntu 22.04 LTS image
  instance_type = "t2.micro" # The type of server provided by AWS as part of its free trial (Free Tier)
  vpc_security_group_ids = [ aws_security_group.jenkins_sg.id ]

  tags = {
    Name = "FastAPI-Jenkins-Server"
  }
}

resource "aws_security_group" "jenkins_sg" {
  name = "jenkins-server-sg"
  description = "Allow SSH and Jenkins traffic"

  # SSH access
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Access from all over the world
  }

  # Jenkins access
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Access from all over the world
  }

  # Allow all access to the outside world (to download updates)
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "server_public_ip" {
  value = aws_instance.devops_server.public_ip
}