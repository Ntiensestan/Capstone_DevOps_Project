terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
}


resource "aws_instance" "project_server" {
  ami           = "ami-0e001c9271cf7f3b9"
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.allow_security.id]

  user_data = "${file("docker_create.sh")}"
  
  tags = {
    Name = "ProjectServerInstance"
  }
}

resource "aws_security_group" "allow_security" {
  
  description = "Allow SSH inbound traffic and all outbound traffic"

  ingress {
    from_port        = 22
    to_port          = 22
    protocol      = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

}